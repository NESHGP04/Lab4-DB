-- Tabla de Continentes
CREATE TABLE continentes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Regiones
CREATE TABLE regiones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Países (Base)
CREATE TABLE paises (
    id INTEGER PRIMARY KEY, 
    nombre VARCHAR(100) NOT NULL,
    capital VARCHAR(100)
);

-- Tabla: pais_poblacion
CREATE TABLE pais_poblacion (
    id_mongo VARCHAR(50) PRIMARY KEY, 
    pais_id INTEGER REFERENCES paises(id),
    continente_id INTEGER REFERENCES continentes(id),
    poblacion BIGINT,
    costo_bajo_hospedaje DECIMAL(10,2),
    costo_promedio_comida DECIMAL(10,2),
    costo_bajo_transporte DECIMAL(10,2),
    costo_promedio_entretenimiento DECIMAL(10,2)
);

-- Tabla: pais_envejecimiento
CREATE TABLE pais_envejecimiento (
    id SERIAL PRIMARY KEY,
    pais_id INTEGER REFERENCES paises(id),
    continente_id INTEGER REFERENCES continentes(id),
    region_id INTEGER REFERENCES regiones(id),
    poblacion_referencia BIGINT,
    tasa_envejecimiento DECIMAL(5,2)
);