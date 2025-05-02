# Asistente de Tránsito: App Móvil con IA Offline

![Asistente de Tránsito Logo](assets/images/logo.png)

## 📱 Visión General

Asistente de Tránsito es una aplicación móvil que permite a los usuarios interactuar con documentos mediante inteligencia artificial, **sin necesidad de conexión a internet**. La aplicación procesa documentos localmente, construye índices semánticos, y responde consultas utilizando modelos de IA embebidos en el dispositivo.

### Características Principales

- ✅ **Funcionamiento 100% offline**: Sin dependencia de servidores remotos o conexión a internet
- 📄 **Procesamiento de documentos**: PDF, DOCX, TXT y otros formatos comunes
- 🔍 **Búsqueda semántica**: Encuentra información relevante incluso con consultas en lenguaje natural
- 💬 **Respuestas generativas**: Respuestas fluidas y naturales basadas en el contenido de los documentos
- 🧠 **Contexto conversacional**: Mantiene el hilo de la conversación para consultas de seguimiento
- 🚀 **Optimizado para móvil**: Diseñado para funcionar eficientemente en dispositivos con recursos limitados

## 🏗️ Arquitectura

El proyecto sigue los principios de Clean Architecture, separando claramente las responsabilidades:

```
┌─────────────────────┐
│  UI (Presentación)  │
└─────────┬───────────┘
          │
┌─────────▼───────────┐
│ Dominio (Casos Uso) │
└─────────┬───────────┘
          │
┌─────────▼───────────┐
│  Datos (Repos/BD)   │
└─────────┬───────────┘
          │
┌─────────▼───────────┐
│     Módulos IA      │
│   (FFI/Nativo)      │
└─────────────────────┘
```

### Componentes Clave:

- **Flutter UI**: Interfaz de usuario fluida y responsive
- **Riverpod**: Gestión de estado y dependencias
- **Isar DB**: Base de datos local de alto rendimiento
- **FAISS/Vector Search**: Búsqueda de similitud vectorial
- **LLM Embebido**: Modelo de lenguaje pequeño y optimizado
- **FFI Bridge**: Interfaz con código nativo para operaciones intensivas

## 📁 Estructura de Carpetas

```
ia_docs_app/
│
├── lib/
│   ├── main.dart                       # Punto de entrada de la aplicación
│   ├── app.dart                        # Configuración inicial de la app
│   │
│   ├── presentation/                   # Capa de presentación (UI)
│   │   ├── pages/                      # Pantallas principales
│   │   │   ├── home_page.dart          # Página principal
│   │   │   ├── chat_page.dart          # Interfaz de chat
│   │   │   ├── document_upload_page.dart  # Carga de documentos
│   │   │   ├── document_list_page.dart # Lista de documentos cargados
│   │   │   └── settings_page.dart      # Configuración
│   │   │
│   │   ├── widgets/                    # Componentes reutilizables
│   │   │   ├── chat/
│   │   │   │   ├── chat_bubble.dart    # Mensaje individual
│   │   │   │   ├── chat_input.dart     # Campo de entrada
│   │   │   │   └── message_list.dart   # Lista de mensajes
│   │   │   │
│   │   │   ├── documents/
│   │   │   │   ├── document_card.dart  # Tarjeta de documento
│   │   │   │   └── upload_button.dart  # Botón para subir documentos
│   │   │   │
│   │   │   └── common/
│   │   │       ├── loading_indicator.dart # Indicador de carga
│   │   │       └── error_view.dart     # Vista de error
│   │   │
│   │   └── providers/                  # Providers Riverpod para UI
│   │       ├── chat_providers.dart     # Estado del chat
│   │       ├── document_providers.dart # Estado de documentos
│   │       └── app_state_provider.dart # Estado general de la app
│   │
│   ├── domain/                         # Capa de dominio (Lógica de negocio)
│   │   ├── entities/                   # Modelos de dominio
│   │   │   ├── document.dart           # Entidad de documento 
│   │   │   ├── document_chunk.dart     # Segmento de documento
│   │   │   ├── chat.dart               # Entidad de chat
│   │   │   └── message.dart            # Entidad de mensaje
│   │   │
│   │   ├── repositories/               # Interfaces de repositorios
│   │   │   ├── document_repository.dart  # Repo de documentos
│   │   │   ├── chat_repository.dart    # Repo de chats
│   │   │   └── vector_repository.dart  # Repo de búsqueda vectorial
│   │   │
│   │   └── usecases/                   # Casos de uso
│   │       ├── document_usecases.dart  # Procesamiento de documentos
│   │       ├── chat_usecases.dart      # Gestión de chats
│   │       └── query_usecases.dart     # Consultas semánticas
│   │
│   ├── data/                           # Capa de datos
│   │   ├── repositories/               # Implementaciones de repositorios
│   │   │   ├── document_repository_impl.dart
│   │   │   ├── chat_repository_impl.dart
│   │   │   └── vector_repository_impl.dart
│   │   │
│   │   ├── datasources/                # Fuentes de datos
│   │   │   ├── local/
│   │   │   │   ├── isar_database.dart  # Configuración de Isar
│   │   │   │   └── models/             # Modelos para Isar
│   │   │   │       ├── document_model.dart
│   │   │   │       ├── chunk_model.dart
│   │   │   │       ├── chat_model.dart
│   │   │   │       └── message_model.dart
│   │   │   │
│   │   │   └── file/
│   │   │       ├── file_handler.dart   # Manejo de archivos
│   │   │       └── document_parser.dart # Parseo de PDF/DOCX
│   │   │
│   │   └── mappers/                    # Conversión entre modelos
│   │       ├── document_mapper.dart
│   │       └── chat_mapper.dart
│   │
│   ├── core/                           # Código común y utilidades
│   │   ├── errors/
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   │
│   │   ├── utils/
│   │   │   ├── constants.dart
│   │   │   └── extensions.dart
│   │   │
│   │   └── services/
│   │       └── logging_service.dart
│   │
│   └── ml/                             # Módulos de ML/IA
│       ├── document_processing/
│       │   ├── document_splitter.dart  # Segmentación de textos
│       │   └── text_cleaner.dart       # Limpieza de textos
│       │
│       ├── embeddings/
│       │   ├── embedding_service.dart  # Interfaz para embeddings
│       │   └── embedding_service_impl.dart # Implementación
│       │
│       ├── vector_search/
│       │   ├── vector_index.dart       # Índice vectorial
│       │   └── search_service.dart     # Servicio de búsqueda
│       │
│       └── llm/
│           ├── llm_service.dart        # Interfaz para LLM
│           ├── llm_service_impl.dart   # Implementación
│           └── prompt_templates.dart   # Plantillas de prompts
│
├── native/                             # Código nativo (C/C++)
│   ├── embeddings/                     # Implementación de embeddings
│   │   ├── CMakeLists.txt
│   │   └── embedding_bridge.cpp
│   │
│   ├── vector_search/                  # FAISS o similar
│   │   ├── CMakeLists.txt
│   │   └── faiss_bridge.cpp
│   │
│   └── llm/                            # LLM (llama.cpp u otro)
│       ├── CMakeLists.txt
│       └── llm_bridge.cpp
│
├── assets/                             # Recursos estáticos
│   ├── models/                         # Modelos pre-entrenados
│   │   ├── embedding/                  # Modelo de embeddings
│   │   └── llm/                        # Modelo LLM cuantizado
│   │
│   └── images/                         # Imágenes
│
├── test/                               # Pruebas
│   ├── unit/                           # Pruebas unitarias
│   ├── integration/                    # Pruebas de integración
│   └── widget/                         # Pruebas de widgets
│
├── ios/                                # Configuración específica iOS
├── android/                            # Configuración específica Android
├── pubspec.yaml                        # Dependencias Flutter
└── README.md                           # Documentación
```

Para una descripción más detallada de cada carpeta, consulte la [documentación de arquitectura](docs/architecture.md).

## 🚀 Comenzando

### Prerrequisitos

- Flutter 3.10.0 o superior
- Dart 3.0.0 o superior
- Android Studio / XCode para desarrollo móvil
- CMake para compilación de componentes nativos
- Python 3.8+ para scripts de procesamiento de modelos

### Configuración del Entorno

1. **Clonar el repositorio**

```bash
git clone https://github.com/yourusername/ia-docs-app.git
cd ia-docs-app
```

2. **Instalar dependencias**

```bash
flutter pub get
```

3. **Compilar componentes nativos**

```bash
cd native
./build_native_libs.sh  # O build_native_libs.bat en Windows
cd ..
```

4. **Descargar modelos preentrenados**

```bash
python scripts/download_models.py
```

5. **Ejecutar la aplicación**

```bash
flutter run
```

### Modelos Compatibles

#### Embeddings:
- MiniLM (recomendado, 33MB)
- MobileBERT (25MB)
- Universal Sentence Encoder Lite (20MB)

#### LLM:
- Phi-2 cuantizado (recomendado para calidad, 1.5GB)
- TinyLlama-1.1B-Chat (recomendado para velocidad, 600MB)
- Mistral-7B-Instruct GGUF 4-bit (mayor capacidad, 3.5GB)

## 🛠️ Desarrollo

### Tecnologías Principales

- **UI/UX**: Flutter, Riverpod, Material Design 3
- **Almacenamiento**: Isar DB, File System
- **ML/IA**: ONNX Runtime, llama.cpp, FAISS
- **Interoperabilidad**: Dart FFI, C/C++

### Flujo de Trabajo

1. **Procesamiento de documentos**:
   - Extracción de texto de PDF/DOCX/TXT
   - Segmentación en chunks pequeños
   - Generación de embeddings
   - Indexación en base vectorial local

2. **Consulta y respuesta**:
   - Vectorización de la consulta
   - Recuperación de fragmentos relevantes
   - Generación de respuesta con LLM + contexto
   - Actualización del historial conversacional

### Pautas de Código

- Seguir principios SOLID
- Documentar clases y métodos públicos
- Escribir pruebas unitarias para lógica crítica
- Asegurar compatibilidad con Android 6.0+ y iOS 12.0+

## 📊 Rendimiento

| Operación | Tiempo Estimado | Uso de Memoria |
|-----------|-----------------|----------------|
| Carga inicial de la app | 2-3 segundos | 50-100 MB |
| Procesamiento de documento (10 páginas) | 20-40 segundos | 100-200 MB |
| Consulta y respuesta | 3-8 segundos | 200-500 MB |

_Nota: Valores medidos en dispositivo de gama media (Snapdragon 765G)_

## 🧪 Pruebas

```bash
# Ejecutar todas las pruebas
flutter test

# Ejecutar pruebas de un directorio específico
flutter test test/unit/

# Ejecutar pruebas de integración
flutter test integration_test/
```

## 📚 Documentación Adicional

- [Arquitectura detallada](docs/architecture.md)
- [Integración de modelos ML](docs/ml_models.md)
- [Guía de FFI y código nativo](docs/ffi_guide.md)
- [Optimización de rendimiento](docs/performance.md)
- [Diagramas técnicos](docs/diagrams.md)

## 🤝 Contribución

1. Fork del repositorio
2. Crear rama feature (`git checkout -b feature/amazing-feature`)
3. Commit de cambios (`git commit -m 'Add amazing feature'`)
4. Push a la rama (`git push origin feature/amazing-feature`)
5. Abrir Pull Request

## 📄 Licencia

Este proyecto está licenciado bajo los términos de la licencia MIT. Consulte el archivo [LICENSE](LICENSE) para más detalles.

## 📞 Contacto

Nombre del Proyecto - [@ia_docs_app](https://twitter.com/ia_docs_app)

Link del Proyecto: [https://github.com/yourusername/ia-docs-app](https://github.com/yourusername/ia-docs-app)