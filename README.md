# Laboratorio 4 – Integración SQL + NoSQL + Data Warehouse

## 📌 Descripción

Este laboratorio tiene como objetivo integrar datos provenientes de una base de datos relacional (PostgreSQL en Supabase) y una base de datos no relacional (MongoDB Atlas), utilizando un proceso ETL implementado en Python.

Los datos integrados se cargan en una base de datos que cumple el rol de **Data Warehouse**, permitiendo generar insights analíticos a partir de la información consolidada.

---

# 🏗 Arquitectura del Proyecto

PostgreSQL (Supabase)
MongoDB Atlas
⬇
Python ETL (Extract – Transform – Load)
⬇
PostgreSQL (Data Warehouse)

---

# 🗂 Estructura del Proyecto

```
lab4/
│
├── ej2.py              # Conexión y prueba de PostgreSQL y Script principal de integración
├── tablas.sql          # Queries para crear tablas de CSV
├── data.sql            # Queries para ingresar data de CSV
├── ej2.sql             # Queries para ejercicio el 2
├── .env                # Variables de entorno (NO subir a GitHub)
└── README.md
```

---

# ⚙️ Requisitos

Instalar dependencias:

```bash
pip install pandas sqlalchemy psycopg2-binary pymongo python-dotenv
```

---

# 🔐 Configuración del Archivo `.env`

Crear un archivo llamado `.env` en la raíz del proyecto con el siguiente contenido:

```
DATABASE_URL=postgresql://[USER]:[PASSWORD]@[HOST]:[PORT]/[DB]

CLIENT=mongodb+srv://[USER]:[PASSWORD]@lab4.p8jo6kd.mongodb.net/
```

### 📌 Ejemplo real (formato):

```
DATABASE_URL=postgresql://postgres:mi_password@aws-0-us-east-1.pooler.supabase.com:6543/postgres

CLIENT=mongodb+srv://usuario:password@lab4.p8jo6kd.mongodb.net/
```

⚠️ **Importante:**

* No subir el archivo `.env` al repositorio.
* Asegurarse de usar el endpoint de *Connection Pooling* en Supabase (puerto 6543).
* MongoDB Atlas requiere conexión SSL automáticamente.

---

# 🧩 Ejercicio 2 – Integración con Python

## 2.1 Ingesta de Datos Relacionales

Se extraen datos desde la tabla `pais_envejecimiento` en Supabase usando SQLAlchemy.

Se validan:

* Valores nulos
* Consistencia en nombres de país

---

## 2.2 Ingesta de Datos No Relacionales

Se extraen datos desde MongoDB Atlas:

* `paises_mundo_big_mac`

Se utiliza `pandas.json_normalize()` para estructurar los documentos JSON.

---

## 2.3 Integración en Memoria

Los datos se integran utilizando `pandas.merge()` con la columna común `nombre_pais`.

Se realiza limpieza previa:

* Eliminación de espacios en nombres
* Manejo de valores faltantes

---

## 2.4 Carga al Data Warehouse

El resultado final se carga en la tabla:

```
dw_paises
```

La tabla incluye:

* nombre_pais
* continente
* poblacion
* tasa_de_envejecimiento
* region
* precio_big_mac_usd

---

# 📊 Insights Generados

### Insight 1

Relación entre tasa de envejecimiento y precio del Big Mac.

Se calculó la correlación estadística para evaluar la relación entre desarrollo económico y envejecimiento poblacional.

---

### Insight 2

Regiones con mayor y menor precio promedio del Big Mac.

Se identificaron diferencias económicas entre regiones geográficas.

---

### Insight 3

Relación entre población total y envejecimiento.

Se analizó si el tamaño poblacional influye en la estructura demográfica.

---

# 🧠 Tecnologías Utilizadas

* PostgreSQL (Supabase)
* MongoDB Atlas
* Python
* Pandas
* SQLAlchemy
* PyMongo

---

# 🚀 Cómo Ejecutar el ETL

```bash
python ej2.py
```

Esto:

1. Extrae datos de PostgreSQL
2. Extrae datos de MongoDB
3. Integra los datos en memoria
4. Carga los datos al Data Warehouse

---

# 📌 Conclusión

La integración de datos relacionales y no relacionales permitió generar análisis multidimensionales combinando indicadores demográficos y económicos. El proceso ETL implementado garantiza reproducibilidad y automatización en la carga del Data Warehouse.

---

# 👩‍💻 Autores
Camila Richter 23183 
Marinés García 23391 
Carlos Alburez 231311 

Laboratorio 4 – Base de Datos 2
Universidad del Valle de Guatemala
