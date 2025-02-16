
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
- `Data`: Almacenamiento de datos estáticos de rutas y puntos

## Dificultades Encontradas

### Principales Desafíos
1. Comprensión e implementación del algoritmo Dijkstra
   - Entender la lógica detrás del algoritmo
   - Adaptarlo a las necesidades específicas del proyecto
   - Manejar las estructuras de datos necesarias (Set, Dictionary)

2. Manejo de Arquitectura
   - Implementación del patrón Singleton
   - Organización de servicios y modelos
   - Separación de responsabilidades

3. Validaciones y Manejo de Errores
   - Implementación de closures para success/failure
   - Validación de inputs antes de procesar
   - Manejo de casos edge


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


---

# 🔄 The Good Stuff I'm Taking Away 🔄

> ### 🏗️ *Patrones y Estructuras*
> - Organización de código en servicios
> - Sistema de validación centralizado
> - Manejo de usuarios y autenticación
> - Sistema de logging para desarrollo

> ### 📐 *Arquitectura*
> - Separación de datos y lógica
> - Patrones de diseño (Singleton)
> - Manejo de menús y navegación
> - Estructura modular y escalable

> ### ✅ *Validaciones*
> - Sistema robusto de verificación de inputs
> - Manejo de errores con feedback claro
> - Validaciones previas a operaciones

---
