import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
from pymongo import MongoClient
import os

# ----------------------------
# Cargar variables de entorno
# ----------------------------
load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
CLIENT=os.getenv("CLIENT")

try:
    # ----------------------------
    # Crear engine con SQLAlchemy
    # ----------------------------
    engine = create_engine(
        DATABASE_URL,
        connect_args={"sslmode": "require"}
    )

    # Probar conexión
    with engine.connect() as conn:
        result = conn.execute(text("SELECT NOW();"))
        print("Connection successful!")
        print("Current Time:", result.fetchone())

    # ----------------------------
    # Extraer tabla SQL
    # ----------------------------
    query = "SELECT * FROM pais_envejecimiento;"
    df_sql = pd.read_sql(query, engine)

    print("\nDatos SQL:")
    print(df_sql.head())

    # ----------------------------
    # MONGO
    # ----------------------------
    client = MongoClient(CLIENT)
    db = client["lab4"]

    # Extraer Big Mac
    bigmac_data = list(db.paises_mundo_big_mac.find())
    df_bigmac = pd.json_normalize(bigmac_data)

    df_bigmac = df_bigmac.rename(columns={"país": "nombre_pais"})
    df_bigmac = df_bigmac[["nombre_pais", "precio_big_mac_usd"]]

    print("\nDatos Mongo Big Mac:")
    print(df_bigmac.head())

    # ----------------------------
    # LIMPIEZA DE DATOS
    # ----------------------------

    #Normalizar nombres
    df_sql["nombre_pais"] = df_sql["nombre_pais"].str.strip()
    df_bigmac["nombre_pais"] = df_bigmac["nombre_pais"].str.strip()

    df_sql = df_sql.fillna(0)

    # ----------------------------
    # Integrar en memoria
    # ----------------------------
    df_integrado = df_sql.merge(df_bigmac, on="nombre_pais", how="left")

    print("\nDatos integrados:")
    print(df_integrado.head())

    # ----------------------------
    # Tabla DW
    # ----------------------------
    with engine.connect() as conn:
        conn.execute(text("""
            CREATE TABLE IF NOT EXISTS dw_paises (
                id_pais INT,
                nombre_pais VARCHAR(100),
                capital VARCHAR(100),
                continente VARCHAR(100),
                region VARCHAR(100),
                poblacion FLOAT,
                tasa_de_envejecimiento FLOAT,
                precio_big_mac_usd FLOAT
            );
        """))
        conn.commit()

    df_integrado.to_sql("dw_paises", engine, if_exists="replace", index=False)
    print("\nDatos cargados al Data Warehouse")

    print("\nProceso completado correctamente!!")

except Exception as e:
    print(f"Failed to connect: {e}")