-- CREAR LAS TABLAS DE LA BD.

CREATE TABLE Especie(
idEspecie INTEGER,
nombre VARCHAR(60),
descripcion VARCHAR(60),
PRIMARY KEY(idEspecie)
);

CREATE TABLE Animal(
idAnimal INTEGER,
nombre VARCHAR(60),
sexo VARCHAR(60),
fechaNacimiento DATE,
fechaIngreso DATE,
idEspecie INTEGER,
PRIMARY KEY(idAnimal),
FOREIGN KEY(idEspecie) REFERENCES Especie(idEspecie)
ON UPDATE RESTRICT
ON DELETE RESTRICT
);

CREATE DOMAIN domTipoHabitat AS VARCHAR(20)
CHECK( VALUE IN( 'acuático', 'terrestre', 'híbrido'));

CREATE TABLE Habitat(
idHabitat INTEGER,
capacidad INTEGER,
tipo domTipoHabitat,
PRIMARY KEY(idHabitat)
);

CREATE TABLE Personal(
tipoDoc VARCHAR(20),
nroDoc VARCHAR(20),
nombre VARCHAR(60),
apellido VARCHAR(60),
fechaIngreso DATE,
genero VARCHAR(20),
localidad VARCHAR(60),
fechaNacimiento DATE,
PRIMARY KEY(tipoDoc, nroDoc)
);

CREATE TABLE Veterinario(
tipoDoc VARCHAR(20),
nroDoc VARCHAR(20),
especialidad VARCHAR(60),
PRIMARY KEY(tipoDoc, nroDoc),
FOREIGN KEY(tipoDoc, nroDoc) REFERENCES Personal(tipodoc, nrodoc)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE Vive(
idAnimal INTEGER,
idHabitat INTEGER,
PRIMARY KEY(idanimal, idhabitat),
FOREIGN KEY(idanimal) REFERENCES Animal(idanimal)
ON UPDATE CASCADE
ON DELETE CASCADE,
FOREIGN KEY(idhabitat) REFERENCES Habitat(idhabitat)
ON UPDATE CASCADE
ON DELETE RESTRICT
)

CREATE TABLE Atiende(
tipoDocPersonal VARCHAR(20),
nroDocPersonal VARCHAR(20),
idAnimal INTEGER,
fechaAtencion DATE,
motivo VARCHAR(60),
PRIMARY KEY(tipoDocPersonal, nroDocPersonal, idAnimal, fechaAtencion),
FOREIGN KEY(tipoDocPersonal, nroDocPersonal) REFERENCES
Personal(tipoDoc, nroDoc)
ON UPDATE CASCADE
ON DELETE RESTRICT,
FOREIGN KEY(idAnimal) REFERENCES Animal(idAnimal)
ON UPDATE CASCADE
ON DELETE RESTRICT
);


-- CREAR LOS ROLES (ejercicio 1a).

CREATE ROLE rol1 WITH LOGIN;
CREATE ROLE rol2 WITH LOGIN CREATEROLE;
CREATE ROLE rol3 WITH LOGIN CREATEROLE CREATEDB;

-- CREAR USUARIOS (ejercicio 1b).

-- REQUISITOS PREVIOS.
CREATE VIEW animales1 AS 
SELECT a.nombre, a.fechaNacimiento, e.nombre
FROM ANIMAL a NATURAL JOIN ESPECIE e;

-- USUARIO QUE SOLO PUEDE LEER SOLO UN SUBCONJUNTO DE ATRIBUTOS DE UNA TABLA (1bi)
CREATE USER soloLecturaParcial WITH PASSWORD '123';
GRANT SELECT ON animales1 TO soloLecturaParcial;

-- DOS USUARIOS QUE PERTENECEN A UNO DE LOS ROLES DEL ESQUEMA.
CREATE USER usuarioDeRol1 WITH PASSWORD '123';

CREATE USER usuarioDeRol2 WITH PASSWORD '123';