
# SnowTrails

SnowTrails es una aplicación de consola que permite a los usuarios acceder a información sobre rutas de montaña de manera fácil y rápida. Los senderistas pueden visualizar rutas y encontrar la manera de combinarlas para llegar de un punto a otro.

## Especificaciones

- **Usuarios por defecto**:
  - Admin:
    - Email: adminuser@keepcoding.es
    - Password: Adminuser1
  - Usuario Regular:
    - Email: regularuser@keepcoding.es
    - Password: Regularuser1

- **Validaciones**:
  - Email: formato xxxxx@xxxxx.zz donde zz es .es o .com
  - Nombre de usuario: entre 8 y 24 caracteres alfanuméricos

## Requisitos Completados

### Funcionalidades Básicas ✅
- Sistema de login con roles (admin/usuario)
- Visualización de rutas
- Gestión de usuarios
- Cálculo de distancias

### Funcionalidades Avanzadas ✅
- Cálculo de ruta más corta entre dos puntos
- Añadir puntos a rutas existentes
- Sistema de logging para desarrollo
- Validaciones de entrada de datos

### Arquitectura ✅
- Separación en capas (Servicios, Modelos, Menús)
- Sistema de manejo de errores
- Implementación de closures para success/failure
- Validaciones centralizadas

## Consideraciones y Comentarios

### Arquitectura del Proyecto
El proyecto está organizado en las siguientes carpetas:
- `Models`: Definiciones de datos básicas
- `Services`: Lógica de negocio
- `Menus`: Interfaces de usuario
- `Utils`: Utilidades como el sistema de logging
- `Validators`: Sistema de validación

### Dificultades Encontradas
1. Implementación del algoritmo de la ruta más corta
2. Gestión de validaciones antes de solicitar contraseña
3. Organización de la arquitectura en capas


## Instrucciones de Uso

1. Ejecutar la aplicación
2. Seleccionar tipo de usuario (normal o administrador)
3. Introducir credenciales
4. Navegar por el menú correspondiente

### Menú de Usuario
- Ver todas las rutas
- Calcular ruta más corta
- Cerrar sesión

### Menú de Administrador
- Ver usuarios
- Añadir usuario
- Eliminar usuario
- Añadir punto a ruta
- Cerrar sesión
