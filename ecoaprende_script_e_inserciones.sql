DROP DATABASE IF EXISTS db_ecoaprende;

CREATE DATABASE db_ecoaprende;

USE db_ecoaprende;

CREATE TABLE tb_universidad (
    id_universidad VARCHAR(36) PRIMARY KEY NOT NULL,
    nombre_universidad VARCHAR(100) NOT NULL
);

INSERT INTO tb_universidad (id_universidad, nombre_universidad) VALUES
('UN001', 'Universidad de El Salvador'),
('UN002', 'Universidad Tecnológica de El Salvador'),
('UN003', 'Universidad Francisco Gavidia'),
('UN004', 'Universidad Dr. José Matías Delgado'),
('UN005', 'Universidad Centroamericana "José Simeón Cañas"'),
('UN006', 'Universidad Don Bosco'),
('UN007', 'Universidad Evangélica de El Salvador'),
('UN008', 'Universidad Luterana Salvadoreña'),
('UN009', 'Universidad Politécnica de El Salvador'),
('UN0010', 'Universidad de Oriente'),
('UN0011', 'Universidad Pedagógica de El Salvador'),
('UN0012', 'Universidad Albert Einstein'),
('UN0013', 'Universidad Católica de El Salvador'),
('UN0014', 'Universidad Internacional Iberoamericana'),
('UN0015', 'Universidad Salvadoreña Alberto Masferrer'),
('UN0016', 'Universidad Dr. Andrés Bello'),
('UN0017', 'Universidad de Sonsonate'),
('UN0018', 'Universidad de San Miguel'),
('UN0019', 'Universidad Gerardo Barrios'),
('UN0020', 'Universidad Modular Abierta'),
('UN0021', 'Universidad Católica de Occidente'),
('UN0022', 'Universidad Internacional de San Isidro Labrador'),
('UN0023', 'Universidad Panamericana'),
('UN0024', 'Universidad del Istmo'),
('UN0025', 'Universidad Tecnológica de El Salvador "UTESA"');

CREATE TABLE tb_carrera(
	id_carrera VARCHAR(36) PRIMARY KEY NOT NULL, #CHECK
    nombre_carrera VARCHAR(100) NOT NULL,
    especialidad_carrera VARCHAR(100) NOT NULL,
    pensum_carrera MEDIUMBLOB NOT NULL,
    id_universidad VARCHAR(36) #FK
);

ALTER TABLE tb_carrera ADD
CONSTRAINT fk_universidad_carrera
FOREIGN KEY (id_universidad)
REFERENCES tb_universidad(id_universidad);

INSERT INTO tb_carrera (id_carrera, nombre_carrera, especialidad_carrera, pensum_carrera, id_universidad) VALUES
('C001', 'Ingeniería en Sistemas Informáticos', 'Desarrollo de software', 'Pensum en formato PDF', 'UN001'),
('C002', 'Medicina', 'Cirugía General', 'Pensum en formato PDF', 'UN002'),
('C003', 'Derecho', 'Derecho Penal', 'Pensum en formato PDF', 'UN003'),
('C004', 'Ingeniería Civil', 'Construcción de Obras Civiles', 'Pensum en formato PDF', 'UN004'),
('C005', 'Administración de Empresas', 'Finanzas Corporativas', 'Pensum en formato PDF', 'UN005'),
('C006', 'Psicología', 'Psicología Clínica', 'Pensum en formato PDF', 'UN006'),
('C007', 'Arquitectura', 'Diseño Urbano', 'Pensum en formato PDF', 'UN007'),
('C008', 'Enfermería', 'Cuidados Intensivos', 'Pensum en formato PDF', 'UN008'),
('C009', 'Contaduría Pública', 'Auditoría Financiera', 'Pensum en formato PDF', 'UN009'),
('C0010', 'Ingeniería Eléctrica', 'Energías Renovables', 'Pensum en formato PDF', 'UN0010'),
('C0011', 'Ciencias de la Educación', 'Pedagogía Infantil', 'Pensum en formato PDF', 'UN0011'),
('C0012', 'Comunicación Social', 'Periodismo', 'Pensum en formato PDF', 'UN0012'),
('C0013', 'Ingeniería Industrial', 'Gestión de la Producción', 'Pensum en formato PDF', 'UN0013'),
('C0014', 'Biología', 'Ecología', 'Pensum en formato PDF', 'UN0014'),
('C0015', 'Turismo', 'Gestión Hotelera', 'Pensum en formato PDF', 'UN0015'),
('C0016', 'Ingeniería Mecánica', 'Diseño de Máquinas', 'Pensum en formato PDF', 'UN0016'),
('C0017', 'Arte y Diseño', 'Diseño Gráfico', 'Pensum en formato PDF', 'UN0017'),
('C0018', 'Química', 'Química Orgánica', 'Pensum en formato PDF', 'UN0018'),
('C0019', 'Educación Física', 'Entrenamiento Deportivo', 'Pensum en formato PDF', 'UN0019'),
('C0020', 'Ingeniería en Informática', 'Seguridad Informática', 'Pensum en formato PDF', 'UN0020'),
('C0021', 'Nutrición y Dietética', 'Nutrición Clínica', 'Pensum en formato PDF', 'UN0021'),
('C0022', 'Ciencias Ambientales', 'Gestión Ambiental', 'Pensum en formato PDF', 'UN0022'),
('C0023', 'Ingeniería en Telecomunicaciones', 'Redes de Comunicación', 'Pensum en formato PDF', 'UN0023'),
('C0024', 'Matemáticas', 'Estadística', 'Pensum en formato PDF', 'UN0024'),
('C0025', 'Ingeniería Agronómica', 'Agricultura Sostenible', 'Pensum en formato PDF', 'UN0025');

SELECT * FROM tb_carrera;

CREATE TABLE tb_usuario (
	id_usuario VARCHAR(36) PRIMARY KEY NOT NULL, #UNIQUE
    nombre_usuario VARCHAR(50) NOT NULL,
    correo_usuario VARCHAR(100) NOT NULL, #UNIQUE
    clave_usuario VARCHAR(30) NOT NULL,
    telefono_usuario VARCHAR(9) NOT NULL, #CHECK UNIQUE
    dui_usuario VARCHAR(10) NOT NULL, #CHECK UNIQUE
    id_carrera VARCHAR(36) #FK
);

ALTER TABLE tb_usuario ADD
CONSTRAINT unique_idusuario
UNIQUE (id_usuario);

ALTER TABLE tb_usuario ADD
CONSTRAINT unique_correousuario
UNIQUE (correo_usuario);

ALTER TABLE tb_usuario ADD
CONSTRAINT unique_telefonousuario
UNIQUE (telefono_usuario);

ALTER TABLE tb_usuario ADD
CONSTRAINT check_telefonousuario 
CHECK (telefono_usuario > 0);

ALTER TABLE tb_usuario ADD
CONSTRAINT unique_duiusuario
UNIQUE (dui_usuario);

ALTER TABLE tb_usuario ADD
CONSTRAINT fk_usuario_carrera
FOREIGN KEY (id_carrera)
REFERENCES tb_carrera(id_carrera);

INSERT INTO tb_usuario (id_usuario, nombre_usuario, correo_usuario, clave_usuario, telefono_usuario, dui_usuario, id_carrera) VALUES
('U001', 'Juan Pérez', 'juan@example.com', 'clave123', '123', '1234567890', 'C001'),
('U002', 'María González', 'maria@example.com', 'clave456', '456', '0987654321', 'C002'),
('U003', 'Carlos López', 'carlos@example.com', 'clave789', '789', '1111111111', 'C003'),
('U004', 'Ana Martínez', 'ana@example.com', 'claveabc', '987', '2222222222', 'C004'),
('U005', 'Pedro Rodríguez', 'pedro@example.com', 'clavexyz', '654', '3333333333', 'C005'),
('U006', 'Laura García', 'laura@example.com', 'clave123', '321', '4444444444', 'C006'),
('U007', 'Luis Hernández', 'luis@example.com', 'clave456', '135', '5555555555', 'C007'),
('U008', 'Sofía Díaz', 'sofia@example.com', 'clave789', '246', '6666666666', 'C008'),
('U009', 'Elena Castro', 'elena@example.com', 'claveabc', '369', '7777777777', 'C009'),
('U0010', 'Javier Ramírez', 'javier@example.com', 'clavexyz', '829', '8888888888', 'C0010'),
('U0011', 'Lucía Gómez', 'lucia@example.com', 'clave123', '486', '9999999999', 'C0011'),
('U0012', 'Andrés Pérez', 'andres@example.com', 'clave456', '234', '0000000000', 'C0012'),
('U0013', 'Gabriela Rodríguez', 'gabriela@example.com', '563', '444525666', '1112223333', 'C0013'),
('U0014', 'Daniel González', 'daniel@example.com', 'claveabc', '349', '2224', 'C0014'),
('U0015', 'Marta López', 'marta@example.com', 'clavexyz', '563', '3445555', 'C0015'),
('U0016', 'José Martínez', 'jose@example.com', 'clave123', '423', '44456666', 'C0016'),
('U0017', 'Patricia Pérez', 'patricia@example.com', 'clave456', '589', '5556777', 'C0017'),
('U0018', 'Manuel Gómez', 'manuel@example.com', 'clave789', '645', '6778888', 'C0018'),
('U0019', 'Ana Ramírez', 'ana_r@example.com', 'claveabc', '674', '777889', 'C0019'),
('U0020', 'David García', 'david@example.com', 'clavexyz', '111', '8889390000', 'C0020'),
('U0021', 'Carmen López', 'carmen@example.com', 'clave123', '222', '9990111', 'C0021'),
('U0022', 'Roberto Díaz', 'roberto@example.com', 'clave456', '333', '0112222', 'C0022'),
('U0023', 'Sara Sánchez', 'sara@example.com', 'clave789', '444', '11122', 'C0023'),
('U0024', 'Diego Castro', 'diego@example.com', 'claveabc', '555', '2223334', 'C0024'),
('U0025', 'Fernanda Ramírez', 'fernanda@example.com', 'clavexyz', '666', '33344555', 'C0025');

SELECT * FROM tb_usuario;

CREATE TABLE tb_iniciosesion(
id_iniciosesion VARCHAR(36) PRIMARY KEY NOT NULL, #PK, UNIQUE
nombre_usuario VARCHAR(50) NOT NULL,
clave_usuario VARCHAR(30) NOT NULL,
id_usuario VARCHAR(36) #FK
);

ALTER TABLE tb_iniciosesion ADD
CONSTRAINT unique_id_inicio_sesion
UNIQUE (id_iniciosesion);

ALTER TABLE tb_iniciosesion ADD
CONSTRAINT fk_iniciosesion_usuario
FOREIGN KEY (id_usuario)
REFERENCES tb_usuario(id_usuario);

INSERT INTO tb_iniciosesion (id_iniciosesion, nombre_usuario, clave_usuario, id_usuario) VALUES
('IS001', 'usuario1', 'clave1', 'U001'),
('IS002', 'usuario2', 'clave2', 'U002'),
('IS003', 'usuario3', 'clave3', 'U003'),
('IS004', 'usuario4', 'clave4', 'U004'),
('IS005', 'usuario5', 'clave5', 'U005'),
('IS006', 'usuario6', 'clave6', 'U006'),
('IS007', 'usuario7', 'clave7', 'U007'),
('IS008', 'usuario8', 'clave8', 'U008'),
('IS009', 'usuario9', 'clave9', 'U009'),
('IS0010', 'usuario10', 'clave10', 'U0010'),
('IS0011', 'usuario11', 'clave11', 'U0011'),
('IS0012', 'usuario12', 'clave12', 'U0012'),
('IS0013', 'usuario13', 'clave13', 'U0013'),
('IS0014', 'usuario14', 'clave14', 'U0014'),
('IS0015', 'usuario15', 'clave15', 'U0015'),
('IS0016', 'usuario16', 'clave16', 'U0016'),
('IS0017', 'usuario17', 'clave17', 'U0017'),
('IS0018', 'usuario18', 'clave18', 'U0018'),
('IS0019', 'usuario19', 'clave19', 'U0019'),
('IS0020', 'usuario20', 'clave20', 'U0020'),
('IS0021', 'usuario21', 'clave21', 'U0021'),
('IS0022', 'usuario22', 'clave22', 'U0022'),
('IS0023', 'usuario23', 'clave23', 'U0023'),
('IS0024', 'usuario24', 'clave24', 'U0024'),
('IS0025', 'usuario25', 'clave25', 'U0025');


CREATE TABLE tb_detallepedido(
	id_detallepedido VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    cantidad_libro_pedido INT NOT NULL, #CHECK
    direccion_pedido VARCHAR(300) NOT NULL, #DEFAULT
    preciototal_libro_pedido DECIMAL(5,2) NOT NULL #CHECK
);

ALTER TABLE tb_detallepedido ADD
CONSTRAINT unique_id_detalle_pedido
UNIQUE (id_detallepedido);

ALTER TABLE tb_detallepedido ADD 
CONSTRAINT cantidad_libro_pedido_check 
CHECK (cantidad_libro_pedido <> '');

ALTER TABLE tb_detallepedido
ALTER COLUMN direccion_pedido 
SET DEFAULT 'Dirección por defecto';

ALTER TABLE tb_detallepedido ADD 
CONSTRAINT preciototal_libro_pedido_check 
CHECK (preciototal_libro_pedido <> '');

INSERT INTO tb_detallepedido (id_detallepedido, cantidad_libro_pedido, direccion_pedido, preciototal_libro_pedido) VALUES
('DP001', 5, 'Dirección 1', 50.00),
('DP0012', 3, 'Dirección 2', 30.00),
('DP0013', 2, 'Dirección 3', 20.00),
('DP0014', 4, 'Dirección 4', 40.00),
('DP0015', 6, 'Dirección 5', 60.00),
('DP0016', 1, 'Dirección 6', 10.00),
('DP0017', 3, 'Dirección 7', 30.00),
('DP0018', 2, 'Dirección 8', 20.00),
('DP0019', 4, 'Dirección 9', 40.00),
('DP00110', 5, 'Dirección 10', 50.00),
('DP00111', 3, 'Dirección 11', 30.00),
('DP00112', 2, 'Dirección 12', 20.00),
('DP00113', 4, 'Dirección 13', 40.00),
('DP00114', 6, 'Dirección 14', 60.00),
('DP00115', 1, 'Dirección 15', 10.00),
('DP00116', 3, 'Dirección 16', 30.00),
('DP00117', 2, 'Dirección 17', 20.00),
('DP00118', 4, 'Dirección 18', 40.00),
('DP00119', 5, 'Dirección 19', 50.00),
('DP00120', 3, 'Dirección 20', 30.00),
('DP00121', 2, 'Dirección 21', 20.00),
('DP00122', 4, 'Dirección 22', 40.00),
('DP00123', 6, 'Dirección 23', 60.00),
('DP00124', 1, 'Dirección 24', 10.00),
('DP00125', 3, 'Dirección 25', 30.00);

SELECT * FROM tb_detallepedido;

CREATE TABLE tb_autor(
	id_autor VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    nombre_autor VARCHAR(50) NOT NULL #UNIQUE
);

ALTER TABLE tb_autor ADD
CONSTRAINT unique_idautor
UNIQUE (id_autor);

ALTER TABLE tb_autor ADD
CONSTRAINT unique_nombreautor
UNIQUE (nombre_autor);

INSERT INTO tb_autor (id_autor, nombre_autor) VALUES
('A001', 'David J. Griffiths'),
('A002', 'Michael T. Goodrich'),
('A003', 'Roberto Tamassia'),
('A004', 'Thomas H. Cormen'),
('A005', 'Ronald L. Graham'),
('A006', 'Charles E. Leiserson'),
('A007', 'Clifford Stein'),
('A008', 'Gilbert Strang'),
('A009', 'David C. Lay'),
('A0010', 'Michael Spivak'),
('A0011', 'Steven E. Landsburg'),
('A0012', 'Harold Abelson'),
('A0013', 'Gerald Jay Sussman'),
('A0014', 'Andrew S. Tanenbaum'),
('A0015', 'Jeffrey D. Ullman'),
('A0016', 'John E. Hopcroft'),
('A0017', 'Rajiv Motwani'),
('A0018', 'Kenneth H. Rosen'),
('A0019', 'Paul A. Tipler'),
('A0020', 'Eugene Hecht'),
('A0021', 'Raymond Chang'),
('A0022', 'Donald A. McQuarrie'),
('A0023', 'Douglas A. Skoog'),
('A0024', 'Martha Alicia Alles'),
('A0025', 'José Antonio Marina');

CREATE TABLE tb_editorial(
	id_editorial VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    nombre_editorial VARCHAR(120) NOT NULL #UNIQUE
);

ALTER TABLE tb_editorial ADD
CONSTRAINT unique_ideditorial
UNIQUE (id_editorial);

ALTER TABLE tb_editorial ADD
CONSTRAINT unique_nombreeditorial
UNIQUE (nombre_editorial);

INSERT INTO tb_editorial (id_editorial, nombre_editorial) VALUES
('E001', 'Pearson Education'),
('E002', 'McGraw-Hill Education'),
('E003', 'Oxford University Press'),
('E004', 'Cambridge University Press'),
('E005', 'Prentice Hall'),
('E006', 'John Wiley & Sons'),
('E007', 'Springer Nature'),
('E008', 'Elsevier'),
('E009', 'Cengage Learning'),
('E0010', 'Harvard University Press'),
('E0011', 'Princeton University Press'),
('E0012', 'Yale University Press'),
('E0013', 'MIT Press'),
('E0014', 'University of Chicago Press'),
('E0015', 'Stanford University Press'),
('E0016', 'Columbia University Press'),
('E0017', 'University of California Press'),
('E0018', 'Routledge'),
('E0019', 'Taylor & Francis'),
('E0020', 'Sage Publications'),
('E0021', 'Palgrave Macmillan'),
('E0022', 'Macmillan Education'),
('E0023', 'Houghton Mifflin Harcourt'),
('E0024', 'Bedford/St. Martin´s'),
('E0025', 'W.W. Norton & Company');


CREATE TABLE tb_categoria (
	id_categoria VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    nombre_categoria VARCHAR(50) NOT NULL, #UNIQUE
    descripcion_categoria VARCHAR(500) NOT NULL #CHECK
);

ALTER TABLE tb_categoria ADD
CONSTRAINT unique_idcategoria
UNIQUE (id_categoria);

ALTER TABLE tb_categoria ADD
CONSTRAINT unique_nombrecategoria
UNIQUE (nombre_categoria);

ALTER TABLE tb_categoria ADD 
CONSTRAINT descripcion_categoria_check 
CHECK (descripcion_categoria <> '');

INSERT INTO tb_categoria (id_categoria, nombre_categoria, descripcion_categoria) VALUES
('CT001', 'Matemáticas', 'Libros relacionados con conceptos, teorías y aplicaciones matemáticas.'),
('CT002', 'Física', 'Libros que abarcan principios fundamentales, teorías y aplicaciones en el campo de la física.'),
('CT003', 'Química', 'Libros que cubren conceptos, experimentos y aplicaciones químicas.'),
('CT004', 'Biología', 'Libros que tratan sobre la ciencia de la vida, incluyendo genética, ecología, y biología celular.'),
('CT005', 'Ingeniería Eléctrica', 'Libros relacionados con circuitos eléctricos, electrónica, y sistemas de potencia.'),
('CT006', 'Ingeniería Mecánica', 'Libros que abordan principios de mecánica, termodinámica, y diseño de máquinas.'),
('CT007', 'Ingeniería Civil', 'Libros sobre diseño, construcción y mantenimiento de infraestructuras civiles.'),
('CT008', 'Ingeniería de Sistemas', 'Libros que cubren teoría y aplicaciones de sistemas de información y comunicación.'),
('CT009', 'Informática', 'Libros que abordan programación, algoritmos, y estructuras de datos.'),
('CT0010', 'Ciencias de la Computación', 'Libros que tratan sobre teoría y fundamentos de la informática.'),
('CT0011', 'Economía', 'Libros relacionados con teoría económica, políticas económicas y análisis económico.'),
('CT0012', 'Administración de Empresas', 'Libros que cubren principios y prácticas de gestión empresarial.'),
('CT0013', 'Contabilidad', 'Libros que abordan principios contables, auditoría y análisis financiero.'),
('CT0014', 'Finanzas', 'Libros relacionados con inversiones, mercados financieros y gestión financiera.'),
('CT0015', 'Derecho', 'Libros sobre teoría del derecho, legislación y sistemas legales.'),
('CT0016', 'Psicología', 'Libros que tratan sobre la mente, el comportamiento humano y la psicología clínica.'),
('CT0017', 'Sociología', 'Libros que abordan teoría sociológica, métodos de investigación y análisis social.'),
('CT0018', 'Historia', 'Libros sobre acontecimientos pasados, sociedades antiguas y movimientos históricos.'),
('CT0019', 'Filosofía', 'Libros que tratan sobre la búsqueda del conocimiento, la moral y la existencia humana.'),
('CT0020', 'Literatura', 'Libros que incluyen obras literarias clásicas y análisis literario.'),
('CT0021', 'Lingüística', 'Libros que abordan la estructura y evolución de los idiomas.'),
('CT0022', 'Educación', 'Libros sobre teoría pedagógica, métodos de enseñanza y psicología educativa.'),
('CT0023', 'Arte y Diseño', 'Libros que cubren historia del arte, técnicas de diseño y apreciación artística.'),
('CT0024', 'Arquitectura', 'Libros sobre diseño arquitectónico, planificación urbana y construcción sostenible.'),
('CT0025', 'Medicina', 'Libros relacionados con anatomía, fisiología, diagnóstico y tratamiento médico.');


CREATE TABLE tb_detalle_valoracion(
	id_detalle_valoracion VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    id_libro VARCHAR(36) NOT NULL, #FK
    id_usuario VARCHAR(36) NOT NULL #FK
);

CREATE TABLE tb_libro(
	id_libro VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    id_autor VARCHAR(36) NOT NULL, #FK
    id_editorial VARCHAR(36) NOT NULL, #FK
    id_categoria VARCHAR(36) NOT NULL, #FK
    descripcion_libro VARCHAR (800) NOT NULL #CHECK
);

ALTER TABLE tb_libro ADD
CONSTRAINT unique_idlibro
UNIQUE (id_libro);

ALTER TABLE tb_libro ADD
CONSTRAINT fk_libro_autor
FOREIGN KEY (id_autor)
REFERENCES tb_autor(id_autor);

ALTER TABLE tb_libro ADD
CONSTRAINT fk_libro_editorial
FOREIGN KEY (id_editorial)
REFERENCES tb_editorial(id_editorial);

ALTER TABLE tb_libro ADD
CONSTRAINT fk_libro_categoria
FOREIGN KEY (id_categoria)
REFERENCES tb_categoria(id_categoria);

ALTER TABLE tb_libro ADD 
CONSTRAINT descripcion_libro_check 
CHECK (descripcion_libro <> '');

CREATE TABLE tb_valoracion(
	id_valoracion VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
    id_libro VARCHAR(36) NOT NULL, #FK
    id_usuario VARCHAR(36) NOT NULL, #FK
    id_pedido VARCHAR(36) NOT NULL, #FK
    valoracion_pedido DECIMAL(5,2), #CHECK
    descripcion_valoracion VARCHAR(300)
);

ALTER TABLE tb_valoracion ADD
CONSTRAINT unique_idvaloracion
UNIQUE (id_valoracion);

ALTER TABLE tb_valoracion ADD
CONSTRAINT fk_valoracion_libro
FOREIGN KEY (id_libro)
REFERENCES tb_libro(id_libro);

ALTER TABLE tb_valoracion ADD
CONSTRAINT fk_valoracion_usuario
FOREIGN KEY (id_usuario)
REFERENCES tb_usuario(id_usuario);

ALTER TABLE tb_valoracion ADD 
CONSTRAINT descripcion_valoracion_check 
CHECK (descripcion_valoracion <> '');

CREATE TABLE tb_pedido(
	id_pedido VARCHAR(36) PRIMARY KEY NOT NULL, #PK UNIQUE
	descripcion_pedido VARCHAR(300), #CHECK
    id_usuario VARCHAR(36) #FK
);

ALTER TABLE tb_pedido ADD
CONSTRAINT unique_idpedido
UNIQUE (id_pedido);

ALTER TABLE tb_pedido ADD
CONSTRAINT fk_pedido_usuario
FOREIGN KEY (id_usuario)
REFERENCES tb_usuario(id_usuario);

ALTER TABLE tb_valoracion ADD
CONSTRAINT fk_valoracion_pedido
FOREIGN KEY (id_pedido)
REFERENCES tb_pedido(id_pedido);

INSERT INTO tb_libro (id_libro, id_autor, id_editorial, id_categoria, descripcion_libro) VALUES
('L001', 'A001', 'E001', 'CT001', 'Descripción del libro 1'),
('L002', 'A002', 'E002', 'CT002', 'Descripción del libro 2'),
('L003', 'A003', 'E003', 'CT003', 'Descripción del libro 3'),
('L004', 'A004', 'E004', 'CT004', 'Descripción del libro 4'),
('L005', 'A005', 'E005', 'CT005', 'Descripción del libro 5'),
('L006', 'A006', 'E006', 'CT006', 'Descripción del libro 6'),
('L007', 'A007', 'E007', 'CT007', 'Descripción del libro 7'),
('L008', 'A008', 'E008', 'CT008', 'Descripción del libro 8'),
('L009', 'A009', 'E009', 'CT009', 'Descripción del libro 9'),
('L0010', 'A0010', 'E0010', 'CT0010', 'Descripción del libro 10'),
('L0011', 'A0011', 'E0011', 'CT0011', 'Descripción del libro 11'),
('L0012', 'A0012', 'E0012', 'CT0012', 'Descripción del libro 12'),
('L0013', 'A0013', 'E0013', 'CT0013', 'Descripción del libro 13'),
('L0014', 'A0014', 'E0014', 'CT0014', 'Descripción del libro 14'),
('L0015', 'A0015', 'E0015', 'CT0015', 'Descripción del libro 15'),
('L0016', 'A0016', 'E0016', 'CT0016', 'Descripción del libro 16'),
('L0017', 'A0017', 'E0017', 'CT0017', 'Descripción del libro 17'),
('L0018', 'A0018', 'E0018', 'CT0018', 'Descripción del libro 18'),
('L0019', 'A0019', 'E0019', 'CT0019', 'Descripción del libro 19'),
('L0020', 'A0020', 'E0020', 'CT0020', 'Descripción del libro 20'),
('L0021', 'A0021', 'E0021', 'CT0021', 'Descripción del libro 21'),
('L0022', 'A0022', 'E0022', 'CT0022', 'Descripción del libro 22'),
('L0023', 'A0023', 'E0023', 'CT0023', 'Descripción del libro 23'),
('L0024', 'A0024', 'E0024', 'CT0024', 'Descripción del libro 24'),
('L0025', 'A0025', 'E0025', 'CT0025', 'Descripción del libro 25');

INSERT INTO tb_pedido (id_pedido, descripcion_pedido, id_usuario) VALUES
('P001', 'Descripción del pedido 1', 'U001'),
('P002', 'Descripción del pedido 2', 'U002'),
('P003', 'Descripción del pedido 3', 'U003'),
('P004', 'Descripción del pedido 4', 'U004'),
('P005', 'Descripción del pedido 5', 'U005'),
('P006', 'Descripción del pedido 6', 'U006'),
('P007', 'Descripción del pedido 7', 'U007'),
('P008', 'Descripción del pedido 8', 'U008'),
('P009', 'Descripción del pedido 9', 'U009'),
('P0010', 'Descripción del pedido 10', 'U0010'),
('P0011', 'Descripción del pedido 11', 'U0011'),
('P0012', 'Descripción del pedido 12', 'U0012'),
('P0013', 'Descripción del pedido 13', 'U0013'),
('P0014', 'Descripción del pedido 14', 'U0014'),
('P0015', 'Descripción del pedido 15', 'U0015'),
('P0016', 'Descripción del pedido 16', 'U0016'),
('P0017', 'Descripción del pedido 17', 'U0017'),
('P0018', 'Descripción del pedido 18', 'U0018'),
('P0019', 'Descripción del pedido 19', 'U0019'),
('P0020', 'Descripción del pedido 20', 'U0020'),
('P0021', 'Descripción del pedido 21', 'U0021'),
('P0022', 'Descripción del pedido 22', 'U0022'),
('P0023', 'Descripción del pedido 23', 'U0023'),
('P0024', 'Descripción del pedido 24', 'U0024'),
('P0025', 'Descripción del pedido 25', 'U0025');


INSERT INTO tb_valoracion (id_valoracion, id_libro, id_usuario, id_pedido, valoracion_pedido, descripcion_valoracion) VALUES
('V001', 'L001', 'U001', 'P001', 4.5, 'Descripción de la valoración 1'),
('V002', 'L002', 'U002', 'P002', 4.0, 'Descripción de la valoración 2'),
('V003', 'L003', 'U003', 'P003', 3.8, 'Descripción de la valoración 3'),
('V004', 'L004', 'U004', 'P004', 4.2, 'Descripción de la valoración 4'),
('V005', 'L005', 'U005', 'P005', 4.7, 'Descripción de la valoración 5'),
('V006', 'L006', 'U006', 'P006', 4.1, 'Descripción de la valoración 6'),
('V007', 'L007', 'U007', 'P007', 4.3, 'Descripción de la valoración 7'),
('V008', 'L008', 'U008', 'P008', 3.9, 'Descripción de la valoración 8'),
('V009', 'L009', 'U009', 'P009', 4.6, 'Descripción de la valoración 9'),
('V0010', 'L0010', 'U0010', 'P0010', 4.4, 'Descripción de la valoración 10'),
('V0011', 'L0011', 'U0011', 'P0011', 3.7, 'Descripción de la valoración 11'),
('V0012', 'L0012', 'U0012', 'P0012', 4.8, 'Descripción de la valoración 12'),
('V0013', 'L0013', 'U0013', 'P0013', 3.5, 'Descripción de la valoración 13'),
('V0014', 'L0014', 'U0014', 'P0014', 4.9, 'Descripción de la valoración 14'),
('V0015', 'L0015', 'U0015', 'P0015', 4.3, 'Descripción de la valoración 15'),
('V0016', 'L0016', 'U0016', 'P0016', 3.8, 'Descripción de la valoración 16'),
('V0017', 'L0017', 'U0017', 'P0017', 4.2, 'Descripción de la valoración 17'),
('V0018', 'L0018', 'U0018', 'P0018', 4.5, 'Descripción de la valoración 18'),
('V0019', 'L0019', 'U0019', 'P0019', 4.0, 'Descripción de la valoración 19'),
('V0020', 'L0020', 'U0020', 'P0020', 3.6, 'Descripción de la valoración 20'),
('V0021', 'L0021', 'U0021', 'P0021', 4.7, 'Descripción de la valoración 21'),
('V0022', 'L0022', 'U0022', 'P0022', 3.9, 'Descripción de la valoración 22'),
('V0023', 'L0023', 'U0023', 'P0023', 4.1, 'Descripción de la valoración 23'),
('V0024', 'L0024', 'U0024', 'P0024', 4.4, 'Descripción de la valoración 24'),
('V0025', 'L0025', 'U0025', 'P0025', 3.7, 'Descripción de la valoración 25');
