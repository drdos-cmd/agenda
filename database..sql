-- Crear la base de datos
CREATE DATABASE agendamiento_citas;
\c agendamiento_citas;

-- Tabla de Clientes
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    documento VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Profesionales
CREATE TABLE profesionales (
    id_profesional SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Servicios
CREATE TABLE servicios (
    id_servicio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    duracion_minutos INT NOT NULL CHECK (duracion_minutos > 0),
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0)
);

-- Tabla Principal de Citas
CREATE TABLE citas (
    id_cita SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id_cliente) ON DELETE RESTRICT,
    id_profesional INT NOT NULL REFERENCES profesionales(id_profesional) ON DELETE RESTRICT,
    id_servicio INT NOT NULL REFERENCES servicios(id_servicio) ON DELETE RESTRICT,
    fecha_hora_inicio TIMESTAMP NOT NULL,
    fecha_hora_fin TIMESTAMP NOT NULL,
    estado VARCHAR(20) DEFAULT 'PROGRAMADA' 
        CHECK (estado IN ('PROGRAMADA', 'CONFIRMADA', 'CANCELADA', 'COMPLETADA')),
    notas TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_profesional_horario UNIQUE (id_profesional, fecha_hora_inicio),
    CONSTRAINT chk_fechas_validas CHECK (fecha_hora_fin > fecha_hora_inicio)
);

-- Índices de rendimiento
CREATE INDEX idx_citas_fecha ON citas(fecha_hora_inicio);
CREATE INDEX idx_citas_profesional ON citas(id_profesional);

-- Datos de prueba
INSERT INTO clientes (documento, nombre, telefono, correo) VALUES
('1020304050', 'Camila Rojas', '3001234567', 'camila@correo.com'),
('1098765432', 'Andrés Gómez', '3109876543', 'andres@correo.com');

INSERT INTO profesionales (nombre, especialidad) VALUES
('Dr. Carlos Mendoza', 'Odontología General'),
('Dra. Laura Torres', 'Ortodoncia');

INSERT INTO servicios (nombre, duracion_minutos, precio) VALUES
('Valoración Inicial', 30, 50000.00),
('Limpieza Dental', 45, 120000.00);

INSERT INTO citas (id_cliente, id_profesional, id_servicio, fecha_hora_inicio, fecha_hora_fin, notas)
VALUES (1, 1, 2, '2026-11-20 09:00:00', '2026-11-20 09:45:00', 'Paciente con sensibilidad');