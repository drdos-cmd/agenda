# Sistema de Agendamiento de Citas (Red Hat)

Proyecto de gestión y agendamiento de citas médicas/profesionales diseñado para desplegarse en entornos **Red Hat Enterprise Linux (RHEL)** y **PostgreSQL**.

## Estructura del Repositorio
* `database.sql`: Script DDL y DML con el modelo relacional, validación de solapamientos de horarios y datos iniciales.
* `config.yaml`: Archivo de configuración de entorno, puertos y credenciales de base de datos.
* `index.html`: Interfaz web frontend construida con HTML5 y Tailwind CSS.

## Despliegue rápido en Red Hat
1. Ejecutar el script `database.sql` en el motor PostgreSQL.
2. Configurar las variables de entorno según `config.yaml`.
3. Servir `index.html` mediante Nginx o desplegar el contenedor en OpenShift.