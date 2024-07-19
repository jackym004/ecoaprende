DROP DATABASE IF EXISTS db_ecoaprende;

CREATE DATABASE db_ecoaprende;

USE db_ecoaprende;

CREATE TABLE tb_carreras(
	id_carrera INT AUTO_INCREMENT PRIMARY KEY NOT NULL, #UNIQUE
    nombre_carrera VARCHAR(100) NOT NULL, #CHECK
    especialidad_carrera VARCHAR(100) NOT NULL
);

ALTER TABLE tb_carreras ADD
CONSTRAINT unique_idcarrera
UNIQUE (id_carrera);

ALTER TABLE tb_carreras ADD 
CONSTRAINT nombre_carrera_check 
CHECK (nombre_carrera <> '');

CREATE TABLE tb_administradores (
	id_administrador INT AUTO_INCREMENT PRIMARY KEY NOT NULL, #UNIQUE
    nombre_administrador  VARCHAR(50) NOT NULL,
    correo_administrador  VARCHAR(100) NOT NULL, #UNIQUE
    clave_administrador  VARCHAR(100) NOT NULL
);

ALTER TABLE tb_administradores ADD
CONSTRAINT unique_idadministrador
UNIQUE (id_administrador);

ALTER TABLE tb_administradores ADD
CONSTRAINT unique_correoadministrador
UNIQUE (correo_administrador);

CREATE TABLE tb_clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY NOT NULL, #UNIQUE
    nombre_cliente VARCHAR(50) NOT NULL,
    correo_cliente VARCHAR(100) NOT NULL, #UNIQUE
    clave_cliente VARCHAR(100) NOT NULL,
    telefono_cliente VARCHAR(9) NOT NULL, #CHECK UNIQUE
    estado_cliente BOOLEAN DEFAULT 1 NULL,
    dui_cliente VARCHAR(10) NOT NULL, #CHECK UNIQUE
    id_carrera INT #FK
);

ALTER TABLE tb_clientes ADD
CONSTRAINT unique_idcliente
UNIQUE (id_cliente);

ALTER TABLE tb_clientes ADD
CONSTRAINT fk_usuario_carrera
FOREIGN KEY (id_carrera)
REFERENCES tb_carreras(id_carrera);

ALTER TABLE tb_clientes ADD
CONSTRAINT unique_correocliente
UNIQUE (correo_cliente);

ALTER TABLE tb_clientes ADD
CONSTRAINT unique_telefonocliente
UNIQUE (telefono_cliente);

ALTER TABLE tb_clientes ADD
CONSTRAINT check_telefonocliente
CHECK (telefono_cliente > 0);

ALTER TABLE tb_clientes ADD
CONSTRAINT unique_duicliente
UNIQUE (dui_cliente);

CREATE TABLE tb_categorias (
	id_categoria INT AUTO_INCREMENT PRIMARY KEY NOT NULL, #PK UNIQUE
    nombre_categoria VARCHAR(50) NOT NULL, #UNIQUE
    descripcion_categoria VARCHAR(500) NOT NULL, #CHECK
    imagen_categoria VARCHAR(60)
);

ALTER TABLE tb_categorias ADD
CONSTRAINT unique_idcategoria
UNIQUE (id_categoria);

ALTER TABLE tb_categorias ADD
CONSTRAINT unique_nombrecategoria
UNIQUE (nombre_categoria);

ALTER TABLE tb_categorias ADD 
CONSTRAINT descripcion_categoria_check 
CHECK (descripcion_categoria <> '');

CREATE TABLE tb_libros(
  id_libro INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
  nombre_libro varchar(50) NOT NULL,
  descripcion_libro varchar(250) NOT NULL,
  precio_libro decimal(5,2) NOT NULL,
  existencias_libro int(10) UNSIGNED NOT NULL,
  imagen_libro varchar(25) NOT NULL,
  id_categoria int(10) UNSIGNED NOT NULL,
  estado_libro tinyint(1) NOT NULL,
  id_administrador int(10) UNSIGNED NOT NULL,
  fecha_libro date NOT NULL DEFAULT current_timestamp()
);

ALTER TABLE tb_libros ADD
CONSTRAINT unique_idlibro
UNIQUE (id_libro);

ALTER TABLE tb_libros ADD 
CONSTRAINT descripcion_libro_check 
CHECK (descripcion_libro <> '');

CREATE TABLE tb_pedidos(
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
estado_pedido ENUM('Pendiente', 'Entregado', 'En camino', 'Cancelado') NULL DEFAULT 'Pendiente',
fecha_pedido DATETIME DEFAULT NOW(),
direccion_pedido VARCHAR(50) NOT NULL,
id_cliente INT NOT NULL
);

ALTER TABLE tb_pedidos ADD 
CONSTRAINT unique_idpedido 
UNIQUE (id_pedido);


ALTER TABLE tb_pedidos ADD
CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente)
REFERENCES tb_clientes(id_cliente);

CREATE TABLE tb_detalles_pedidos(
id_detalles_pedidos INT AUTO_INCREMENT PRIMARY KEY,
precio_producto DECIMAL(5,2) UNSIGNED NOT NULL,
cantidad_comprada INT UNSIGNED NOT NULL,
id_pedido INT, #FK
id_libro INT #FK
);

ALTER TABLE tb_detalles_pedidos ADD
CONSTRAINT unique_iddetallespedidos
UNIQUE (id_detalles_pedidos);

ALTER TABLE tb_detalles_pedidos ADD
CONSTRAINT fk_detallepedido_pedido
FOREIGN KEY (id_pedido)
REFERENCES tb_pedidos(id_pedido);

ALTER TABLE tb_detalles_pedidos ADD 
CONSTRAINT fk_detallepedido_libro
FOREIGN KEY (id_libro)
REFERENCES tb_libros(id_libro);

CREATE TABLE tb_valoraciones(
id_valoracion INT AUTO_INCREMENT PRIMARY KEY,
calificacion_producto INT UNSIGNED NOT NULL,
comentario_producto TEXT NULL,
fecha_valoracion DATETIME DEFAULT NOW(),
estado_comentario BOOLEAN NOT NULL DEFAULT 1,
id_detalles_pedidos INT #FK
);

ALTER TABLE tb_valoraciones ADD
CONSTRAINT fk_valoracion_detallepedido
FOREIGN KEY (id_detalles_pedidos)
REFERENCES tb_detalles_pedidos(id_detalles_pedidos);

insert into tb_pedidos (estado_pedido, fecha_pedido, direccion_pedido)
values (Entregado, 2024-5-20, San_salvador);