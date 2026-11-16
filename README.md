# 🎨 Colorist

**Colorist** es una aplicación multiplataforma desarrollada en **Flutter** impulsada por **Google Gemini** a través de **Firebase AI Logic** (`firebase_ai`). La app actúa como un asistente experto en teoría y psicología del color capaz de interpretar descripciones en lenguaje natural (ej. *"un naranja atardecer"* o *"el azul de un océano tropical"*) y convertirlas en valores RGB exactos en tiempo real mediante **Function Calling (Tool Calling)**.

---

## 🚀 Características Principales

* **Interpretación de Color en Lenguaje Natural:** Describe colores de forma cotidiana o poética y Gemini calculará las componentes de color precisas (rojo, verde, azul normalizados entre `0.0` y `1.0`) y su código hexadecimal.
* **Function Calling (Tool Calling):** Integración directa con herramientas del LLM mediante la función `set_color`, permitiendo que el modelo ejecute acciones sobre la interfaz gráfica de forma estructurada.
* **Streaming en Tiempo Real:** Respuestas de texto fluidas y visualización inmediata de los cambios de color mientras el modelo genera contenido.
* **Historial Interactivo con Contexto LLM:** Registro visual de los últimos colores generados. Al pulsar sobre cualquier color del historial, se sincroniza el contexto con la sesión de chat para continuar explorando variantes.
* **Panel de Diagnóstico y Logs:** Vista dedicada para inspeccionar las llamadas a funciones, argumentos, respuestas de herramientas y eventos de usuario en tiempo real.
* **Diseño Responsivo Multiplataforma:** Interfaz adaptable con soporte para:
  * **Desktop / Web:** Disposición en pantalla dividida (*split-screen*) con panel de interacción y consola de logs simultánea.
  * **Mobile:** Navegación por pestañas (*Chat* y *Log*) mediante `NavigationBar` y `IndexedStack`.

---

## 🛠️ Tecnologías Utilizadas

| Categoría | Tecnología / Paquete | Descripción |
| :--- | :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev) | SDK multiplataforma (Web, Android, iOS, Desktop) |
| **Inteligencia Artificial** | [firebase_ai](https://pub.dev/packages/firebase_ai) | SDK cliente de Firebase AI Logic para consultar modelos Gemini |
| **Modelo LLM** | `gemini-3.1-flash-lite` | Modelo multimodal de baja latencia optimizado para herramientas y respuestas rápidas |
| **Backend & Cloud** | [Firebase](https://firebase.google.com) (`firebase_core`) | Autenticación, configuración y backend seguro de IA |
| **Gestión de Estado** | [Riverpod](https://riverpod.dev) (`flutter_riverpod`, `riverpod_annotation`) | Manejo reactivo del estado y dependencias con generación de código |
| **UI Kit & Material** | [colorist_ui](https://pub.dev/packages/colorist_ui), [material_ui](https://pub.dev/packages/material_ui) | Componentes visuales desacoplados con especificación Material 3 |
| **Generación de Código** | `build_runner`, `riverpod_generator` | Generación de proveedores y serialización en tiempo de compilación |

---

## 📂 Estructura del Proyecto

```text
colorist/
├── assets/
│   └── system_prompt.md           # Definición del rol, capacidades y formato de respuesta del LLM
├── lib/
│   ├── main.dart                  # Inicialización de Firebase, ProviderScope y punto de entrada
│   ├── firebase_options.dart      # Opciones de conexión por plataforma (generado por FlutterFire CLI)
│   ├── providers/
│   │   ├── gemini.dart            # Providers de FirebaseApp, GenerativeModel y ChatSession
│   │   └── system_prompt.dart     # Carga asíncrona del prompt del sistema desde assets
│   └── services/
│       ├── gemini_chat_service.dart # Gestión de mensajes de usuario, streaming y control de estados
│       └── gemini_tools.dart      # Declaración de herramientas (set_color) y ejecución de function calls
├── web/                           # Archivos de soporte y configuración para Flutter Web
├── pubspec.yaml                   # Definición de dependencias y recursos del proyecto
└── README.md                      # Documentación del repositorio
```

---

## ⚙️ Requisitos Previos

* **Flutter SDK:** Versión `>=3.13.7` (o canal estable reciente compatible con Dart `>=3.13`).
* **Cuenta de Google / Firebase:** Un proyecto activo en [Firebase Console](https://console.firebase.google.com/) con **Firebase AI Logic** habilitado.
* **FlutterFire CLI:** Herramienta de línea de comandos para vincular Firebase con Flutter:
  ```bash
  dart pub global activate flutterfire_cli
  ```

---

## 📦 Instalación y Configuración

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/colorist.git
   cd colorist
   ```

2. **Instalar dependencias de Flutter:**
   ```bash
   flutter pub get
   ```

3. **Generar código de proveedores (Riverpod):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Configurar Firebase (Opcional si reconfiguras tu propio proyecto):**
   Si deseas enlazar la aplicación a tu propio proyecto de Firebase:
   ```bash
   flutterfire configure
   ```
   Esto generará o actualizará `lib/firebase_options.dart`.

---

## 💻 Ejecución de la Aplicación

### En el Navegador (Flutter Web):
```bash
flutter run -d chrome
```

### En Dispositivos Móviles / Emuladores (Android / iOS):
```bash
flutter run
```

### En Escritorio (Linux / macOS / Windows):
```bash
flutter run -d linux # o macos / windows
```

---

## 🧩 Flujo de Function Calling (`set_color`)

1. **Entrada del usuario:** El usuario escribe: *"Quiero un verde menta suave"*.
2. **Evaluación de Gemini:** El modelo recibe el prompt junto con la definición de la herramienta `set_color` (parámetros `red`, `green`, `blue`).
3. **Petición de llamada:** Gemini responde solicitando ejecutar la función `set_color` con los valores aproximados (ej. `red: 0.6`, `green: 0.95`, `blue: 0.8`).
4. **Ejecución local en Flutter:** `GeminiTools.handleFunctionCall` intercepta la solicitud, actualiza el estado del widget `ColorDisplay` en la UI y añade la muestra al historial.
5. **Respuesta a Gemini:** Se envía a la sesión de chat el resultado `{ success: true, current_color: ... }`.
6. **Cierre de conversación:** Gemini finaliza explicando la elección cromática y sus propiedades estéticas.

---

## 🛡️ Solución de Problemas Frecuentes

* **Error: `Firebase App Check token is invalid`:**
  * En proyectos nuevos, Firebase AI Logic puede tener aplicada de forma predeterminada la verificación de **App Check**.
  * Para desarrollo local (`localhost` o emulador), ve a **Firebase Console > App Check > APIs > Firebase AI Logic** y configúralo temporalmente como **No aplicado (Unenforced)**, o añade un **Debug Token** para tu entorno Web en *Administrar tokens de depuración*.

* **Error: `No MaterialLocalizations found`:**
  * Asegúrate de que [lib/main.dart](file:///media/sdb1/Proyectos/colorist/lib/main.dart) importe `package:material_ui/material_ui.dart` y no `package:flutter/material.dart`, garantizando la compatibilidad con los componentes de `colorist_ui`.

---

## 📄 Licencia

Este proyecto se distribuye bajo los términos de la licencia especificada en el repositorio. Consulta el archivo `LICENSE` para más información.
