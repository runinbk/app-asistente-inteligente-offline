# Diagramas Detallados para la App Móvil con IA Offline

## 1. Diagrama de Arquitectura Detallado

```mermaid
graph TD
    User([Usuario]) --> UI[Interfaz de Usuario]
    
    subgraph "Capa de Presentación"
        UI --> HomeP[Página Principal]
        UI --> ChatP[Página de Chat]
        UI --> DocP[Gestor de Documentos]
        UI --> SettingsP[Configuración]
        
        HomeP & ChatP & DocP & SettingsP --- Providers[Providers Riverpod]
    end
    
    subgraph "Capa de Dominio"
        Providers --> UseCases[Casos de Uso]
        
        subgraph "Casos de Uso"
            UC1[Procesar Documento]
            UC2[Gestionar Chat]
            UC3[Realizar Consulta]
            UC4[Generar Respuesta]
        end
        
        UseCases --> Repositories[Interfaces de Repositorios]
    end
    
    subgraph "Capa de Datos"
        Repositories --> RepoImpl[Implementación de Repositorios]
        RepoImpl --> LocalDS[Fuentes de Datos Locales]
        
        subgraph "Fuentes de Datos"
            DB[Isar DB]
            FS[Sistema de Archivos]
        end
        
        LocalDS --> DB
        LocalDS --> FS
    end
    
    subgraph "Módulos ML/IA (FFI)"
        ML1[Segmentador de Documentos]
        ML2[Motor de Embeddings]
        ML3["Índice Vectorial (FAISS)"]
        ML4[LLM Embebido]
        
        ML1 --> ML2
        ML2 --> ML3
        ML3 & UC3 --> ML4
        ML4 --> UC4
    end
    
    RepoImpl <--> ML1
    RepoImpl <--> ML2
    RepoImpl <--> ML3
    RepoImpl <--> ML4
```

## 2. Diagrama de Componentes

```mermaid
graph TB
    subgraph "Flutter App"
        UI[Interfaz de Usuario]
        StateManagement[Gestión de Estado<br>Riverpod]
        DomainLayer[Capa de Dominio]
        DataLayer[Capa de Datos]
        
        UI <--> StateManagement
        StateManagement <--> DomainLayer
        DomainLayer <--> DataLayer
    end
    
    subgraph "Componentes Nativos (FFI)"
        DocProcessing[Procesamiento<br>de Documentos]
        EmbeddingEngine[Motor de<br>Embeddings]
        VectorSearch[Búsqueda<br>Vectorial]
        LLMEngine[Motor LLM]
        
        DocProcessing -- "Texto procesado" --> EmbeddingEngine
        EmbeddingEngine -- "Vectores" --> VectorSearch
        VectorSearch -- "Chunks relevantes" --> LLMEngine
    end
    
    subgraph "Almacenamiento"
        IsarDB[(Isar DB)]
        FileSystem[(Sistema de<br>Archivos)]
    end
    
    DataLayer <--> DocProcessing
    DataLayer <--> EmbeddingEngine
    DataLayer <--> VectorSearch
    DataLayer <--> LLMEngine
    
    DataLayer <--> IsarDB
    DataLayer <--> FileSystem
```

## 3. Diagrama de Secuencia: Procesar Documento y Consultar

```mermaid
sequenceDiagram
    actor Usuario
    participant UI as UI Flutter
    participant Provider as Riverpod Provider
    participant UC as Caso de Uso
    participant Repo as Repositorio
    participant DP as Procesador Doc
    participant EM as Motor Embeddings
    participant VS as Búsqueda Vectorial
    participant DB as Isar DB
    
    %% Carga de documento
    Usuario->>UI: Cargar documento
    UI->>Provider: uploadDocument(file)
    Provider->>UC: processDocument(file)
    UC->>Repo: saveDocument(document)
    Repo->>DP: splitDocument(document)
    
    loop Por cada segmento
        DP->>DP: Extraer texto
        DP->>EM: generateEmbedding(texto)
        EM-->>DP: vector embedding
        DP->>VS: indexVector(embedding)
        VS->>DB: saveChunk(chunk, embedding)
    end
    
    DB-->>Repo: confirmación
    Repo-->>UC: documento guardado
    UC-->>Provider: proceso completo
    Provider-->>UI: actualizar estado
    UI-->>Usuario: documento procesado
    
    %% Consulta del usuario
    Usuario->>UI: Enviar consulta
    UI->>Provider: sendQuery(text)
    Provider->>UC: performQuery(text)
    UC->>EM: generateEmbedding(query)
    EM-->>UC: query vector
    UC->>VS: searchSimilar(vector)
    VS->>DB: buscar chunks relevantes
    DB-->>VS: chunks encontrados
    VS-->>UC: documentos relevantes
    
    UC->>Repo: getLLMResponse(query, chunks)
    Repo->>Repo: construir prompt
    Repo->>Repo: añadir contexto de chat
    Repo->>LLM: generateResponse(prompt)
    LLM-->>Repo: respuesta generada
    
    Repo-->>UC: respuesta formateada
    UC-->>Provider: actualizar chat
    Provider-->>UI: mostrar respuesta
    UI-->>Usuario: ver respuesta
```

## 4. Diagrama de Entidad-Relación

```mermaid
erDiagram
    DOCUMENT ||--o{ DOCUMENT_CHUNK : contains
    DOCUMENT {
        int id PK
        string title
        string filename
        string path
        datetime createdAt
        int totalChunks
        string metadata
        string documentType
    }
    
    DOCUMENT_CHUNK {
        int id PK
        int documentId FK
        string text
        int chunkIndex
        byte[] embedding
        int tokenCount
    }
    
    CHAT ||--o{ MESSAGE : contains
    CHAT {
        int id PK
        string title
        datetime createdAt
        datetime lastUpdated
        string summary
    }
    
    MESSAGE {
        int id PK
        int chatId FK
        string content
        boolean isUser
        datetime timestamp
        string metadata
    }
    
    MESSAGE }o--o{ DOCUMENT_CHUNK : references
    
    EMBEDDING_MODEL {
        int id PK
        string name
        string version
        string path
        int dimensions
    }
    
    LLM_MODEL {
        int id PK
        string name
        string version
        string path
        int contextSize
        int quantizationLevel
    }
    
    APP_SETTINGS {
        int id PK
        int chunkSize
        int overlapSize
        int retrievalCount
        int maxTokens
        int embeddingModelId FK
        int llmModelId FK
    }
    
    APP_SETTINGS }o--|| EMBEDDING_MODEL : uses
    APP_SETTINGS }o--|| LLM_MODEL : uses
```

## 5. Diagrama de Flujo de Datos

```mermaid
graph TD
    D1[Documento PDF/DOCX] --> P1[Procesador de Documentos]
    P1 --> D2[Texto extraído]
    D2 --> P2[Segmentador de Texto]
    P2 --> D3[Chunks de texto]
    D3 --> P3[Generador de Embeddings]
    P3 --> D4[Vectors]
    D4 --> DS1[(Base Vectorial)]
    
    D5[Consulta del usuario] --> P4[Análisis de consulta]
    P4 --> D6[Consulta procesada]
    D6 --> P5[Vectorización de consulta]
    P5 --> D7[Vector de consulta]
    D7 --> P6[Búsqueda por similitud]
    DS1 --> P6
    P6 --> D8[Chunks relevantes]
    
    D9[Historial de conversación] --> P7[Generación de contexto]
    D8 --> P7
    P7 --> D10[Prompt completo]
    D10 --> P8[LLM Embebido]
    P8 --> D11[Respuesta generada]
    D11 --> P9[Formateador de respuesta]
    P9 --> D12[Respuesta final]
    D12 --> DS2[(Historial de chat)]
```

## 6. Diagrama de Despliegue

```mermaid
graph TD
    subgraph "Dispositivo Móvil"
        App[Aplicación Flutter]
        
        subgraph "Componentes Locales"
            Files[Sistema de Archivos]
            DB[(Base de Datos Isar)]
            VectorDB[(Índice Vectorial)]
            
            Native1[Módulo de<br>Procesamiento]
            Native2[Módulo de<br>Embeddings]
            Native3[Módulo LLM]
        end
        
        subgraph "Recursos"
            Assets1[Modelo Embeddings<br>~50MB]
            Assets2[Modelo LLM<br>~200MB]
        end
        
        App --> Files
        App --> DB
        App --> VectorDB
        App --> Native1
        App --> Native2
        App --> Native3
        
        Native1 & Native2 & Native3 --> Assets1
        Native3 --> Assets2
    end
```

## 7. Diagrama de Estados (Chat)

```mermaid
stateDiagram-v2
    [*] --> Idle: Inicio de App
    
    Idle --> DocumentProcessing: Cargar Documento
    DocumentProcessing --> DocumentReady: Procesamiento Completo
    DocumentProcessing --> Error: Error de Procesamiento
    Error --> Idle: Reintentar
    
    Idle --> QueryProcessing: Enviar Consulta
    DocumentReady --> QueryProcessing: Enviar Consulta
    
    QueryProcessing --> GeneratingResponse: Búsqueda Completa
    QueryProcessing --> Error: Error de Búsqueda
    
    GeneratingResponse --> ResponseReady: Respuesta Generada
    GeneratingResponse --> Error: Error de Generación
    
    ResponseReady --> Idle: Nueva Consulta
    
    state DocumentProcessing {
        [*] --> Reading
        Reading --> Chunking
        Chunking --> Embedding
        Embedding --> Indexing
        Indexing --> [*]
    }
    
    state QueryProcessing {
        [*] --> VectorizingQuery
        VectorizingQuery --> SearchingSimilar
        SearchingSimilar --> RetrievingContext
        RetrievingContext --> [*]
    }
```