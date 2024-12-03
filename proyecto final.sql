CREATE DATABASE IF NOT EXISTS EspejoInteligenteConstruccion;
USE EspejoInteligenteConstruccion;

-- Tabla de proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    proveedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100) UNIQUE,
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de materiales
CREATE TABLE IF NOT EXISTS Almacen (
    material_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(50) NOT NULL, -- Ej: Vidrio, LED, cámara, etc.
    caracteristicas TEXT,
    proveedor_id INT,
    costo_unitario DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

-- Tabla de ensamblajes
CREATE TABLE IF NOT EXISTS Ensamblajes (
    ensamblaje_id INT PRIMARY KEY AUTO_INCREMENT,
    ensamblajeCorrecto ENUM('si', 'no') NOT NULL,
    fecha_ensamblaje DATE NOT NULL
);

-- Tabla de ensamblajes diarios
CREATE TABLE IF NOT EXISTS Ensamblaje_Diario (
    fecha DATETIME PRIMARY KEY,
    equipos_ensamblados INT NOT NULL
);

-- Tabla de clientes
CREATE TABLE IF NOT EXISTS Clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(50),
    telefono VARCHAR(20),
    correo VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    cantidad INT NOT NULL,
    costo_de_venta DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)
);

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL, -- Cambiar a VARCHAR(255) para mayor seguridad.
    preferencias TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de mantenimiento
CREATE TABLE IF NOT EXISTS Mantenimiento (
    mantenimiento_id INT PRIMARY KEY AUTO_INCREMENT,
    pertenencia ENUM('Ensamblado', 'Usuario') NOT NULL,
    usuario_id INT,
    ensamblaje_id INT,
    descripcion VARCHAR(200),
    fecha_programada DATE NOT NULL,
    fecha_realizacion DATE,
    costo DECIMAL(10, 2),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (ensamblaje_id) REFERENCES Ensamblajes(ensamblaje_id)
);

-- Inserciones
-- Tabla de proveedores
INSERT INTO Proveedores (nombre, contacto, telefono, correo, direccion) VALUES
    ('Proveedor LED S.A.', 'Juan Pérez', '555-1234', 'contacto@proveedorled.com', 'Calle Falsa 123'),
    ('Cristalería Cristal SA', 'Ana López', '555-5678', 'ventas@cristal.com', 'Avenida Principal 456'),
    ('Microfono Shure', 'Jose Miguel', '5368-0146', 'Microfonos@Ventas.com', 'Zarco 188, Guerrero'),
    ('CamarasSamsung', 'Luis Arturo', '5348-2346', 'Camarasx@Ventas.com', 'Boulevard del Valle 789'),
    ('Placabase', 'Juan Pablo', '4348-2446', 'Placa@Ventas.com', 'Avenida de la Reforma 1010');

-- Tabla de materiales
INSERT INTO Almacen (tipo, caracteristicas, proveedor_id, costo_unitario, stock) VALUES
    ('Vidrio', 'Vidrio templado de alta resistencia', 2, 50.00, 100),
    ('LED', 'Tira LED de luz blanca', 1, 10.00, 200),
    ('Cámara', 'Cámara HD con micrófono integrado', 4, 75.00, 50),
    ('Micrófono', 'Micrófono de condensador de alta calidad', 3, 60.00, 80),
    ('Placa base', 'Placa base con soporte para múltiples procesadores', 5, 120.00, 40);

-- Tabla de ensamblajes
INSERT INTO Ensamblajes (ensamblajeCorrecto, fecha_ensamblaje) VALUES
    ('si', '2024-12-01'),
    ('si', '2024-12-01'),
    ('si', '2024-12-01'),
    ('si', '2024-12-01'),
    ('si', '2024-12-01'),
    ('no', '2024-12-01'),
    ('si', '2024-12-01'),
    ('si', '2024-12-01'),
    ('si', '2024-12-01'),
    ('no', '2024-12-01'),
    ('si', '2024-12-01'),
    ('si', '2024-12-02');

-- Tabla de ensamblajes diarios
INSERT INTO Ensamblaje_Diario (fecha, equipos_ensamblados) VALUES
    ('2024-12-01 10:00:00', 5),
    ('2024-12-02 10:00:00', 7);

-- Tabla de clientes
INSERT INTO Clientes (nombre, contacto, telefono, correo) VALUES
    ('Carlos Gómez', 'Cliente frecuente', '123-4567', 'carlos@gmail.com'),
    ('María Pérez', 'Empresaria', '987-6543', 'maria@gmail.com');

-- Tabla de pedidos
INSERT INTO Pedidos (cliente_id, cantidad, costo_de_venta) VALUES
    (1, 2, 6000.00),
    (2, 1, 3000.00);

-- Tabla de usuarios
INSERT INTO Usuarios (nombre, telefono, correo, contrasena, preferencias) VALUES
    ('Juan Herrera', '543-7654', 'juan.herrera@gmail.com', 'password123', 'Favoritos: tenis, pantalones'),
    ('Lucía Torres', '987-4321', 'lucia.torres@gmail.com', 'securepass', 'Favoritos: perfumes, pendientes'),
    ('Carlos Martínez', '321-6547', 'carlos.martinez@gmail.com', 'mypassword', 'Favoritos: relojes, zapatos'), 
    ('Elena Gutiérrez', '765-1234', 'elena.gutierrez@gmail.com', 'secure123', 'Favoritos: libros, música'), 
    ('Miguel Sánchez', '654-7890', 'miguel.sanchez@gmail.com', 'passw0rd', 'Favoritos: videojuegos, gadgets'), 
    ('Ana Beltrán', '123-9876', 'ana.beltran@gmail.com', 'password!', 'Favoritos: ropa, accesorios'),
    ('Martín Rodríguez', '111-2233', 'martin.rodriguez@gmail.com', 'pass123', 'Favoritos: bicicletas, mochilas'), 
    ('Sofía Jiménez', '222-3344', 'sofia.jimenez@gmail.com', 'sofipass', 'Favoritos: joyería, relojes'), 
    ('Roberto Pérez', '333-4455', 'roberto.perez@gmail.com', 'rober123', 'Favoritos: cámaras, lentes'), 
    ('Patricia Díaz', '444-5566', 'patricia.diaz@gmail.com', 'patty456', 'Favoritos: maquillaje, fragancias');
    
-- Tabla de mantenimiento
INSERT INTO Mantenimiento (pertenencia, usuario_id, ensamblaje_id, descripcion, fecha_programada, fecha_realizacion, costo) VALUES
    ('Ensamblado', NULL, 6, 'Revisión general del ensamblaje', '2024-12-05', '2024-12-06', 25.00),
    ('Ensamblado', NULL, 10, 'Cambio de LED defectuoso', '2024-12-07', NULL, 15.00),
	('Usuario', 8, 6, 'Rayon en el cristal', '2024-12-05', '2024-12-10', 25.00),
    ('Usuario', 11, 10, 'Mal funcionamiento del sistema', '2024-12-20', NULL, 15.00);

