# Catbreeds App

Aplicación móvil desarrollada en Flutter como parte de una prueba técnica para el cargo de Desarrollador Mobile Flutter.

La aplicación consume **The Cat API**, permite consultar y buscar razas de gatos y visualizar información detallada de cada una.

## Funcionalidades

* Splash screen.
* Consulta de razas desde The Cat API.
* Búsqueda por nombre.
* Listado con imagen, nombre, origen y temperamento.
* Detalle de cada raza.
* Información de descripción, origen, esperanza de vida, grupo, peso, altura, temperamento e historia.
* Manejo de razas sin imagen.
* Caché de imágenes mediante `Image.network`.
* Manejo de errores de red, timeout, autorización, permisos y servidor.
* Pruebas unitarias de las principales capas.

## Tecnologías

* **Flutter:** 3.41.8
* **Dart:** 3.11.5
* **Dio:** consumo de API REST.
* **Provider:** manejo de estado.
* **Mocktail:** mocks para pruebas.
* **Flutter Test:** pruebas unitarias.

## Arquitectura

Se utilizó una estructura basada en **Clean Architecture**, separando las responsabilidades entre datos, dominio y presentación.

```text
lib/
├── core/
│   ├── error/
│   │   └── app_exception.dart
│   ├── network/
│   │   └── dio_client.dart
│   └── theme/
│       ├── app_colors.dart
│       └── app_theme.dart
├── features/
│   └── catbreeds/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── cat_breed_remote_datasource.dart
│       │   ├── models/
│       │   │   └── cat_breed_model.dart
│       │   └── repositories/
│       │       └── cat_breed_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── cat_breed.dart
│       │   ├── repositories/
│       │   │   └── cat_breed_repository.dart
│       │   └── usecases/
│       │       └── get_cat_breeds.dart
│       └── presentation/
│           ├── providers/
│           │   └── cat_breeds_provider.dart
│           ├── screens/
│           │   ├── detail_screen.dart
│           │   ├── home_screen.dart
│           │   └── splash_screen.dart
│           └── widgets/
│               └── cat_breed_card.dart
├ 
└── main.dart
```

### Flujo de datos

```text
The Cat API
    ↓
Remote DataSource
    ↓
CatBreedModel
    ↓
Repository
    ↓
CatBreed
    ↓
Use Case
    ↓
Provider
    ↓
UI
```

El `CatBreedModel` representa la respuesta de la API, mientras que `CatBreed` representa la entidad utilizada por el dominio. Esto permite mantener desacoplada la capa de dominio de la estructura específica de la API.

## API

Endpoint utilizado:

```text
GET https://api.thecatapi.com/v1/breeds
```

Documentación:

https://developers.thecatapi.com/

### API Key

La API key no está almacenada en el código fuente. Se proporciona mediante `--dart-define`.

Ejecutar:

```bash
flutter run --dart-define=CAT_API_KEY=TU_API_KEY
```

Generar APK:

```bash
flutter build apk --release --dart-define=CAT_API_KEY=TU_API_KEY
```

Generar Android App Bundle:

```bash
flutter build appbundle --release --dart-define=CAT_API_KEY=TU_API_KEY
```

> La API key utilizada para ejecutar la aplicación no debe incluirse en el repositorio público.

## Instalación

### Requisitos

* Flutter 3.41.8 o compatible.
* Dart 3.11.5 o compatible.
* Dispositivo Android o emulador.
* API key válida de The Cat API.

### Clonar el proyecto

```bash
git clone https://github.com/juan849/cat_breed_app
cd cat_breed_app
flutter pub get
```

Ejecutar:

```bash
flutter run --dart-define=CAT_API_KEY=TU_API_KEY
```

## Pruebas

Para ejecutar las pruebas:

```bash
flutter test
```

Actualmente existen **7 pruebas**, todas pasando correctamente:

1. Conversión de JSON a `CatBreedModel`.
2. Manejo de razas sin imagen.
3. Conversión de modelos a entidades en el Repository.
4. Conversión de la respuesta HTTP a modelos en el DataSource.
5. Carga de razas mediante Provider.
6. Filtrado por nombre.
7. Manejo de respuesta HTTP `401`.

## Decisiones técnicas

### Provider

Se utilizó Provider porque el estado requerido por la aplicación es sencillo. Se encarga de la carga de datos, búsqueda, estado de carga y errores.

### Dio

Permite centralizar la configuración HTTP, incluyendo la URL base y los headers requeridos por The Cat API.

### Repository

Separa el acceso a datos del dominio. El DataSource trabaja con `CatBreedModel` y el dominio con `CatBreed`.

### Inyección de dependencias

Las dependencias se construyen desde `main.dart`:

```text
Dio
 ↓
Remote DataSource
 ↓
Repository
 ↓
Use Case
 ↓
Provider
```

Esto facilita reemplazar dependencias por mocks durante las pruebas.

### Caché de imágenes

Las imágenes utilizan `Image.network` junto con el sistema de caché de imágenes de Flutter. También se utiliza `cacheWidth` para reducir el tamaño de decodificación y el consumo de memoria.

### Tema

Los colores se centralizaron en `AppColors` y el tema Material 3 en `AppTheme`, permitiendo modificar la identidad visual desde un único lugar.

### Manejo de errores

La aplicación diferencia internamente errores de conexión, timeout, autorización, permisos, recurso no encontrado, servidor y respuestas inesperadas. La interfaz presenta un estado de error controlado en lugar de permitir que la aplicación falle.

## Consideraciones sobre la API

Durante el desarrollo se verificó que la respuesta disponible de The Cat API no incluía los campos numéricos `intelligence` y `adaptability` mencionados en la descripción original de la prueba.

Por este motivo, la aplicación muestra únicamente información proporcionada por la API, como:

* Nombre.
* Origen.
* Temperamento.
* Descripción.
* Esperanza de vida.
* Grupo de raza.
* Peso.
* Altura.
* Historia.
* Imagen cuando está disponible.

También se contempla el caso de razas sin imagen.

## Validación

La aplicación fue validada funcionalmente en **Android mediante un dispositivo físico**.

Se verificaron los principales flujos:

* Splash.
* Consumo de API.
* Listado.
* Búsqueda.
* Búsqueda sin resultados.
* Manejo de errores.
* Navegación al detalle.
* Carga y caché de imágenes.
* Scroll del detalle.
* Razas sin imagen.

## Alcance

La implementación prioriza una separación clara de responsabilidades, facilidad de prueba y una estructura preparada para crecer sin agregar complejidad innecesaria.