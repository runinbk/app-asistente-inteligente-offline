## Documento 1: Definición del Problema

### Título:
**Desafío del funcionamiento offline de una aplicación móvil de consulta inteligente basada en documentos**

### Contexto:
Se está desarrollando una aplicación móvil que permite a los usuarios interactuar con un modelo de inteligencia artificial (IA) para realizar consultas sobre documentos cargados previamente. Esta aplicación, que inicialmente se concebía con un enfoque cliente-servidor, ya cuenta con un servidor funcional que almacena documentos, genera embeddings, realiza indexación en una base vectorial, y responde a consultas utilizando un modelo de lenguaje.

Sin embargo, se ha identificado una limitación importante: **la dependencia del servidor y de una conexión a internet**. En escenarios sin conectividad, la aplicación pierde funcionalidad, lo cual es inaceptable para el caso de uso previsto.

### Problema principal:
**Se requiere que la aplicación funcione de manera completamente offline**, permitiendo:
- Carga y procesamiento local de documentos.
- Segmentación detallada de textos (chunks pequeños, granulares).
- Indexación semántica local para consultas.
- Capacidad de generar respuestas naturales basadas en los documentos, el contexto de la conversación y la consulta del usuario.

### Retos técnicos:
- Ejecutar un sistema de vector search localmente en dispositivos con recursos limitados.
- Usar un modelo de lenguaje pequeño, eficiente y embebible que permita generar respuestas naturales.
- Mantener contexto de conversación localmente (historial de mensajes, memoria de contexto).
- Todo esto sin sacrificar la experiencia de usuario, tiempos de respuesta o calidad de las respuestas.

### Requisitos de desarrollo:
- Desarrollo ágil con entregas rápidas.
- Buenas prácticas de arquitectura de software sin sobreingeniería.
- Modularidad, escalabilidad y mantenibilidad en el código fuente.
