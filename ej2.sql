---------- EJERCICIO 2

-- 2.1
CREATE TABLE pais_envejecimiento (
    id_pais INT,
    nombre_pais VARCHAR(100),
    capital VARCHAR(100),
    continente  VARCHAR(100),
    region VARCHAR(100),
    poblacion FLOAT,
    tasa_de_envejecimiento FLOAT
);

CREATE TABLE pais_poblacion (
    _id VARCHAR(50),
    continente VARCHAR(100),
    pais VARCHAR(100),
    poblacion BIGINT,
    costo_bajo_hospedaje FLOAT,
    costo_promedio_comida FLOAT,
    costo_bajo_transporte FLOAT,
    costo_promedio_entretenimiento FLOAT
);

SELECT nombre_pais FROM pais_envejecimiento LIMIT 10;

-- 2.2
SELECT * FROM dw_paises LIMIT 10;

-- 2.3
-- 1.Relación entre la tasa de envejecimiento y el precio del Big Mac
SELECT 
    CORR(tasa_de_envejecimiento, precio_big_mac_usd) AS correlacion
FROM dw_paises
WHERE precio_big_mac_usd IS NOT NULL;

SELECT 
    nombre_pais,
    tasa_de_envejecimiento,
    precio_big_mac_usd
FROM dw_paises
WHERE precio_big_mac_usd IS NOT NULL
ORDER BY tasa_de_envejecimiento DESC
LIMIT 10;

-- 2.Regiones con los precio más altos y bajos del Big Mac
SELECT 
    region,
    AVG(precio_big_mac_usd) AS precio_promedio_big_mac
FROM dw_paises
WHERE precio_big_mac_usd IS NOT NULL
GROUP BY region
ORDER BY precio_promedio_big_mac DESC;

-- 3.Relación entre el número de población y la tasa de envejecimiento
SELECT 
    CORR(poblacion, tasa_de_envejecimiento) AS correlacion
FROM dw_paises;

SELECT 
    nombre_pais,
    poblacion,
    tasa_de_envejecimiento
FROM dw_paises
ORDER BY poblacion DESC
LIMIT 10;