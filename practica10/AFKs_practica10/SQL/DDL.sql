-- *** TABLA R1: CLIENTES ***
CREATE TABLE Clientes (
    id_cliente INT GENERATED ALWAYS AS IDENTITY,
    nombre_cliente VARCHAR(100) NOT NULL,
    direccion_cliente VARCHAR(150),
    email VARCHAR(100) UNIQUE, -- Restricción UNIQUE
    
    -- Restricción PK
    CONSTRAINT pk_clientes PRIMARY KEY (id_cliente)
);

-- Comentarios
COMMENT ON TABLE Clientes IS 'Información general de los clientes.';
COMMENT ON COLUMN Clientes.id_cliente IS 'Identificador único del cliente (Llave Primaria).';
COMMENT ON COLUMN Clientes.email IS 'Correo electrónico único del cliente.';
COMMENT ON CONSTRAINT pk_clientes ON Clientes IS 'Restricción de llave primaria para Clientes.';
COMMENT ON CONSTRAINT clientes_email_key ON Clientes IS 'Restricción de unicidad para el email del cliente.';


-- *** TABLA R2: PRODUCTOS ***
CREATE TABLE Productos (
    id_producto INT GENERATED ALWAYS AS IDENTITY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    
    -- Restricción CHECK
    CONSTRAINT check_precio_positivo CHECK (precio_unitario >= 0),
    
    -- Restricción PK
    CONSTRAINT pk_productos PRIMARY KEY (id_producto),
    
    -- Restricción UNIQUE (para evitar productos con el mismo nombre)
    CONSTRAINT uq_nombre_producto UNIQUE (nombre_producto)
);

-- Comentarios
COMMENT ON TABLE Productos IS 'Catálogo de productos disponibles para la venta.';
COMMENT ON COLUMN Productos.id_producto IS 'Identificador único del producto (Llave Primaria).';
COMMENT ON COLUMN Productos.precio_unitario IS 'Precio de venta unitario del producto.';
COMMENT ON CONSTRAINT check_precio_positivo ON Productos IS 'Restricción que asegura que el precio unitario sea no negativo.';
COMMENT ON CONSTRAINT uq_nombre_producto ON Productos IS 'Restricción de unicidad para el nombre del producto.';


-- *** TABLA R3: PEDIDOS ***
CREATE TABLE Pedidos (
    id_pedido INT GENERATED ALWAYS AS IDENTITY,
    fecha_pedido DATE NOT NULL,
    id_cliente INT NOT NULL,
    total_pedido DECIMAL(10, 2) NOT NULL,
    estado_pedido VARCHAR(20) DEFAULT 'Pendiente', -- Restricción NOT NULL (implícita)
    
    -- Restricción CHECK
    CONSTRAINT check_total_no_negativo CHECK (total_pedido >= 0),
    
    -- Restricción PK
    CONSTRAINT pk_pedidos PRIMARY KEY (id_pedido),
    
    -- Restricción FK
    CONSTRAINT fk_pedidos_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente)
);

-- Comentarios
COMMENT ON TABLE Pedidos IS 'Cabecera de los pedidos realizados por los clientes.';
COMMENT ON COLUMN Pedidos.id_pedido IS 'Identificador único del pedido (Llave Primaria).';
COMMENT ON COLUMN Pedidos.id_cliente IS 'Identificador del cliente que realizó el pedido (Llave Foránea).';
COMMENT ON CONSTRAINT fk_pedidos_cliente ON Pedidos IS 'Restricción de llave foránea a la tabla Clientes.';
COMMENT ON CONSTRAINT check_total_no_negativo ON Pedidos IS 'Restricción que asegura que el total del pedido sea no negativo.';


-- *** TABLA R4: PEDIDOS_DETALLE ***
CREATE TABLE Pedidos_Detalle (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    
    -- Restricción CHECK
    CONSTRAINT check_cantidad_positiva CHECK (cantidad > 0),
    
    -- Restricción PK (Llave compuesta)
    CONSTRAINT pk_pedidos_detalle PRIMARY KEY (id_pedido, id_producto),
    
    -- Restricciones FK
    CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido) REFERENCES Pedidos (id_pedido),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES Productos (id_producto)
);

-- Comentarios
COMMENT ON TABLE Pedidos_Detalle IS 'Detalle de los productos incluidos en cada pedido.';
COMMENT ON COLUMN Pedidos_Detalle.cantidad IS 'Cantidad de unidades del producto solicitado en el pedido.';
COMMENT ON COLUMN Pedidos_Detalle.subtotal IS 'Cálculo de la cantidad por el precio unitario en el momento de la compra.';
COMMENT ON CONSTRAINT pk_pedidos_detalle ON Pedidos_Detalle IS 'Restricción de llave primaria compuesta para Pedidos_Detalle.';
COMMENT ON CONSTRAINT fk_detalle_pedido ON Pedidos_Detalle IS 'Restricción de llave foránea a la tabla Pedidos.';
COMMENT ON CONSTRAINT fk_detalle_producto ON Pedidos_Detalle IS 'Restricción de llave foránea a la tabla Productos.';
COMMENT ON CONSTRAINT check_cantidad_positiva ON Pedidos_Detalle IS 'Restricción que asegura que la cantidad de producto sea mayor a cero.';

-- ========================================
-- 1. INSERTAR 35 REGISTROS EN CLIENTE
-- ========================================

INSERT INTO Clientes (nombre_cliente, direccion_cliente, email) VALUES
('Ana García', 'Calle Falsa 123, Ciudad A', 'ana.garcia@email.com'),
('Luis Pérez', 'Avenida Siempre Viva 456, Ciudad B', 'luis.perez@email.com'),
('Marta López', 'Plaza Central 789, Ciudad C', 'marta.lopez@email.com'),
('Javier Ruiz', 'Bulevar Tecnológico 101, Ciudad D', 'javier.ruiz@email.com'),
('Sofía Martín', 'Ronda del Mar 202, Ciudad E', 'sofia.martin@email.com'),
('David Gómez', 'Camino Real 303, Ciudad F', 'david.gomez@email.com'),
('Elena Sanz', 'Paseo de la Montaña 404, Ciudad G', 'elena.sanz@email.com'),
('Pablo Cruz', 'Vía Láctea 505, Ciudad H', 'pablo.cruz@email.com'),
('Carmen Moya', 'Calle del Sol 606, Ciudad I', 'carmen.moya@email.com'),
('Ricardo Vidal', 'Avenida de la Luna 707, Ciudad J', 'ricardo.vidal@email.com'),
('Beatriz Cano', 'Callejón del Gato 808, Ciudad K', 'beatriz.cano@email.com'),
('Fernando Diez', 'Carrera Estelar 909, Ciudad L', 'fernando.diez@email.com'),
('Laura Gil', 'Boulevard de las Rosas 110, Ciudad M', 'laura.gil@email.com'),
('Sergio Ramos', 'Sendero del Bosque 220, Ciudad N', 'sergio.ramos@email.com'),
('Isabel Vega', 'Ruta del Desierto 330, Ciudad O', 'isabel.vega@email.com'),
('Jorge Flores', 'Puerta del Cielo 440, Ciudad P', 'jorge.flores@email.com'),
('Natalia Soto', 'Esquina de la Paz 550, Ciudad Q', 'natalia.soto@email.com'),
('Andrés Reyes', 'Mirador del Valle 660, Ciudad R', 'andres.reyes@email.com'),
('Vanesa Torres', 'Torreón Dorado 770, Ciudad S', 'vanesa.torres@email.com'),
('Miguel Herrera', 'Puente Viejo 880, Ciudad T', 'miguel.herrera@email.com'),
('Clara Muñoz', 'Río Tranquilo 990, Ciudad U', 'clara.munoz@email.com'),
('Héctor León', 'Bosque Encantado 111, Ciudad V', 'hector.leon@email.com'),
('Rosa Bravo', 'Pradera Verde 222, Ciudad W', 'rosa.bravo@email.com'),
('Ángel Castro', 'Lago Azul 333, Ciudad X', 'angel.castro@email.com'),
('Diana Nuñez', 'Cueva Oscura 444, Ciudad Y', 'diana.nunez@email.com'),
('Felipe Roca', 'Volcán Activo 555, Ciudad Z', 'felipe.roca@email.com'),
('Gema Cuesta', 'Montaña Rusa 666, Ciudad A1', 'gema.cuesta@email.com'),
('Iván Marín', 'Playa Sol 777, Ciudad B1', 'ivan.marin@email.com'),
('Julia Mora', 'Desierto Arena 888, Ciudad C1', 'julia.mora@email.com'),
('Kike Soler', 'Isla Perdida 999, Ciudad D1', 'kike.soler@email.com'),
('Lía Puente', 'Catarata Fuerte 100, Ciudad E1', 'lia.puente@email.com'),
('Marcos Peña', 'Glaciar Frío 200, Ciudad F1', 'marcos.pena@email.com'),
('Nuria Rioja', 'Selva Húmeda 300, Ciudad G1', 'nuria.rioja@email.com'),
('Óscar Valls', 'Templo Antiguo 400, Ciudad H1', 'oscar.valls@email.com'),
('Pilar Rico', 'Ruinas Viejas 500, Ciudad I1', 'pilar.rico@email.com');

-- ========================================
-- 2. INSERTAR 35 REGISTROS EN PRODUCTOS
-- ========================================
INSERT INTO Productos (nombre_producto, categoria, precio_unitario) VALUES
('Laptop Pro X', 'Electrónica', 1200.00),
('Teclado Mecánico RGB', 'Electrónica', 85.50),
('Ratón Ergonómico', 'Electrónica', 35.99),
('Monitor 4K 27"', 'Electrónica', 450.00),
('Disco Duro SSD 1TB', 'Electrónica', 99.99),
('Silla de Oficina Gaming', 'Mobiliario', 180.00),
('Escritorio Ajustable', 'Mobiliario', 250.00),
('Libro: El Quijote', 'Libros', 15.75),
('Libro: Cien Años de Soledad', 'Libros', 18.50),
('Pluma Estilográfica', 'Papelería', 45.00),
('Cuaderno A4 premium', 'Papelería', 8.20),
('Taza de Café Programador', 'Hogar', 12.99),
('Vaso Termo Acero', 'Hogar', 22.50),
('Cafetera Express', 'Electrodomésticos', 110.00),
('Tostadora Vintage', 'Electrodomésticos', 40.00),
('Licuadora Industrial', 'Electrodomésticos', 95.00),
('Bicicleta de Montaña', 'Deportes', 550.00),
('Set de Pesas 10kg', 'Deportes', 75.00),
('Zapatillas Running XL', 'Deportes', 65.90),
('Chaqueta Impermeable', 'Ropa', 55.50),
('Pantalón Casual', 'Ropa', 30.00),
('Gorra de Béisbol', 'Ropa', 10.99),
('Set de Brochas de Maquillaje', 'Belleza', 25.00),
('Perfume Floral 100ml', 'Belleza', 60.00),
('Crema Hidratante Facial', 'Belleza', 19.99),
('Sierra Eléctrica Circular', 'Herramientas', 150.00),
('Taladro Percutor', 'Herramientas', 80.00),
('Caja de Herramientas Completa', 'Herramientas', 120.00),
('Cámara Réflex Digital', 'Fotografía', 800.00),
('Trípode Profesional', 'Fotografía', 45.00),
('Mochila de Viaje 50L', 'Viajes', 70.00),
('Almohada de Viaje Ergonómica', 'Viajes', 18.00),
('Juego de Mesa Estrategia', 'Juegos', 40.00),
('Puzzle 1000 piezas', 'Juegos', 15.00),
('Robot Aspirador Inteligente', 'Electrodomésticos', 350.00);


-- ========================================
-- 1. INSERTAR 35 REGISTROS EN PEDIDOS
-- ========================================
INSERT INTO Pedidos (fecha_pedido, id_cliente, total_pedido) VALUES
('2025-10-01', 1, 1200.00), -- Cliente 1
('2025-10-01', 2, 85.50),  -- Cliente 2
('2025-10-02', 3, 35.99),  -- Cliente 3
('2025-10-02', 4, 450.00), -- Cliente 4
('2025-10-03', 5, 99.99),  -- Cliente 5
('2025-10-03', 6, 180.00), -- Cliente 6
('2025-10-04', 7, 250.00), -- Cliente 7
('2025-10-04', 8, 15.75),  -- Cliente 8
('2025-10-05', 9, 18.50),  -- Cliente 9
('2025-10-05', 10, 45.00), -- Cliente 10
('2025-10-06', 11, 8.20),  -- Cliente 11
('2025-10-06', 12, 12.99), -- Cliente 12
('2025-10-07', 13, 22.50), -- Cliente 13
('2025-10-07', 14, 110.00),-- Cliente 14
('2025-10-08', 15, 40.00), -- Cliente 15
('2025-10-08', 16, 95.00), -- Cliente 16
('2025-10-09', 17, 550.00),-- Cliente 17
('2025-10-09', 18, 75.00), -- Cliente 18
('2025-10-10', 19, 65.90), -- Cliente 19
('2025-10-10', 20, 55.50), -- Cliente 20
('2025-10-11', 21, 30.00), -- Cliente 21
('2025-10-11', 22, 10.99), -- Cliente 22
('2025-10-12', 23, 25.00), -- Cliente 23
('2025-10-12', 24, 60.00), -- Cliente 24
('2025-10-13', 25, 19.99), -- Cliente 25
('2025-10-13', 26, 150.00),-- Cliente 26
('2025-10-14', 27, 80.00), -- Cliente 27
('2025-10-14', 28, 120.00),-- Cliente 28
('2025-10-15', 29, 800.00),-- Cliente 29
('2025-10-15', 30, 45.00), -- Cliente 30
('2025-10-16', 31, 70.00), -- Cliente 31
('2025-10-16', 32, 18.00), -- Cliente 32
('2025-10-17', 33, 40.00), -- Cliente 33
('2025-10-17', 34, 15.00), -- Cliente 34
('2025-10-18', 35, 350.00);-- Cliente 35

-- ========================================
-- 1. INSERTAR 35 REGISTROS EN CLIENTE
-- ========================================
-- Pedido 1: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(1, 1, 1, 1200.00);

-- Pedido 2: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(2, 2, 1, 85.50);

-- Pedido 3: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(3, 3, 1, 35.99);

-- Pedido 4: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(4, 4, 1, 450.00);

-- Pedido 5: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(5, 5, 1, 99.99);

-- Pedido 6: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(6, 6, 1, 180.00);

-- Pedido 7: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(7, 7, 1, 250.00);

-- Pedido 8: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(8, 8, 1, 15.75);

-- Pedido 9: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(9, 9, 1, 18.50);

-- Pedido 10: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(10, 10, 1, 45.00);

-- Pedido 11: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(11, 11, 1, 8.20);

-- Pedido 12: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(12, 12, 1, 12.99);

-- Pedido 13: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(13, 13, 1, 22.50);

-- Pedido 14: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(14, 14, 1, 110.00);

-- Pedido 15: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(15, 15, 1, 40.00);

-- Pedido 16: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(16, 16, 1, 95.00);

-- Pedido 17: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(17, 17, 1, 550.00);

-- Pedido 18: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(18, 18, 1, 75.00);

-- Pedido 19: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(19, 19, 1, 65.90);

-- Pedido 20: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(20, 20, 1, 55.50);

-- Pedido 21: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(21, 21, 1, 30.00);

-- Pedido 22: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(22, 22, 1, 10.99);

-- Pedido 23: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(23, 23, 1, 25.00);

-- Pedido 24: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(24, 24, 1, 60.00);

-- Pedido 25: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(25, 25, 1, 19.99);

-- Pedido 26: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(26, 26, 1, 150.00);

-- Pedido 27: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(27, 27, 1, 80.00);

-- Pedido 28: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(28, 28, 1, 120.00);

-- Pedido 29: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(29, 29, 1, 800.00);

-- Pedido 30: 1 artículo
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(30, 30, 1, 45.00);

-- Pedido 31: 2 artículos (Cliente 31)
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(31, 31, 1, 70.00);

-- Pedido 32: 2 artículos (Cliente 32)
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(32, 32, 1, 18.00);

-- Pedido 33: 2 artículos (Cliente 33)
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(33, 33, 1, 40.00);

-- Pedido 34: 2 artículos (Cliente 34)
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(34, 34, 1, 15.00);

-- Pedido 35: 2 artículos (Cliente 35)
INSERT INTO Pedidos_Detalle (id_pedido, id_producto, cantidad, subtotal) VALUES
(35, 35, 1, 350.00);
