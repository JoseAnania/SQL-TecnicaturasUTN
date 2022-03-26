--Creación de Base de Datos

create database tecnicaturasUTN

--Abre Base de Datos

use tecnicaturasUTN

--Creación de Tablas

create table turno
(
cod_turno_examen numeric (3,0) not null identity (1,1)
,turno_examen varchar (90) not null
constraint PK_turno primary key (cod_turno_examen)
)

create table estado_materia
(
cod_estado_materia numeric (1,0) not null identity (1,1)
,estado_materia varchar (30) not null
constraint PK_estado_materia primary key (cod_estado_materia)
)

create table barrio
(
cod_barrio numeric (8,0) not null identity (1,1)
,nombre_barrio varchar (30) not null
constraint PK_barrio primary key (cod_barrio)
)

create table estado_civil
(
cod_estado_civil numeric (2,0) not null identity (1,1)
,nombre_estado varchar (30) not null
constraint PK_estado_civil primary key (cod_estado_civil)
)

create table tipo_trabajo
(
cod_tipo_trabajo numeric (3,0) not null identity (1,1)
,nombre_trabajo varchar (30) not null
constraint PK_tipo_trabajo primary key (cod_tipo_trabajo)
)

create table habitat
(
cod_habitat numeric (3,0) not null identity (1,1)
,nombre_habitat varchar (30) not null
constraint PK_habitat primary key (cod_habitat)
)

create table titulo
(
cod_titulo numeric (6,0) not null identity (1,1)
,nombre_titulo varchar (90) not null
constraint PK_titulo primary key (cod_titulo)
)

create table tipo_documento
 (
 cod_tipo_documento numeric (2,0) not null identity (1,1)
 ,nombre_tipo_documento varchar (30) not null
 constraint PK_documento primary key (cod_tipo_documento)
 )

  create table clasificacion
 (
 cod_clasificacion numeric (3,0) not null identity (1,1)
 ,nombre_clasificacion varchar (30) not null
 constraint PK_clasificacion primary key (cod_clasificacion)
 )

create table curso
(
cod_curso numeric (1,0) not null identity (1,1)
,nombre_curso varchar (30) not null
constraint PK_curso primary key (cod_curso)
)

create table telefono
(
cod_telefono numeric (1,0) not null identity (1,1)
,nombre_telefono varchar (30) not null
constraint PK_telefono primary key (cod_telefono)
)

create table año
(
cod_año numeric (1,0) not null identity (1,1)
,nombre_año varchar (50)
constraint PK_año primary key (cod_año)
)

create table cuatrimestre
(
cod_cuatrimestre numeric (1,0) not null identity (1,1)
,nombre_cuatrimestre varchar (50)
constraint PK_cuatimestre primary key (cod_cuatrimestre)
)


create table tecnicatura
(
cod_tecnicatura numeric (1,0) not null identity (1,1)
,nombre_tecnicatura varchar (50)not null
,titulo varchar (90) not null
,duracion_años numeric (2,1) not null
,duracion_cuatrimestres numeric (2,1) not null
,cantidad_materias numeric (2,0) not null
constraint PK_tecnicatura primary key (cod_tecnicatura)
)

create table docente
(
legajo_docente numeric (6,0) not null 
,apellido_docente varchar (30) not null
,nombre_docente varchar (30) not null
,cod_tipo_documento numeric (2,0)
,numero_documento numeric (8,0) not null
,cod_titulo numeric (6,0)
constraint PK_docente primary key (legajo_docente)
constraint FK_docente_tipo_documento foreign key (cod_tipo_documento) references tipo_documento (cod_tipo_documento)
,constraint FK_docente_titulo foreign key (cod_titulo) references titulo (cod_titulo)
)

create table materia
(
cod_materia numeric (3,0) not null identity (1,1)
,nombre_materia varchar (50) not null
,cod_tecnicatura numeric (1,0)
,cod_año numeric (1,0) 
,cod_cuatrimestre numeric (1,0)
,cod_clasificacion numeric (3,0)
constraint PK_materia primary key (cod_materia)
constraint FK_materia_tecnicatura foreign key (cod_tecnicatura) references tecnicatura (cod_tecnicatura)
,constraint FK_materia_clasificacion foreign key (cod_clasificacion) references clasificacion (cod_clasificacion)
,constraint FK_materia_año foreign key (cod_año) references año (cod_año)
,constraint FK_materia_cuatrimestre foreign key (cod_cuatrimestre) references cuatrimestre (cod_cuatrimestre)
)

create table estudiante
(
legajo_utn numeric (6,0) not null
,apellido varchar (30) not null
,nombre varchar (30) not null
,fecha_nacimiento datetime not null
,cod_tecnicatura numeric (1,0)
,fecha_ingreso datetime not null
,numero_calle numeric (5,0) null
,nombre_calle varchar (50) null
,cod_barrio numeric (8,0)
,cod_habitat numeric (3,0)
,cod_telefono numeric (1,0)
,nro_telefono numeric (10,0) null
,cod_tipo_trabajo numeric (3,0)
,cod_estado_civil numeric (2,0)
constraint PK_estudiante primary key (legajo_utn)
constraint FK_estudiante_tecnicatura foreign key (cod_tecnicatura) references tecnicatura (cod_tecnicatura)
,constraint FK_estudiante_barrio foreign key (cod_barrio) references barrio (cod_barrio)
,constraint FK_estudiante_habitat foreign key (cod_habitat) references habitat (cod_habitat)
,constraint FK_estudiante_tipo_trabajo foreign key (cod_tipo_trabajo) references tipo_trabajo (cod_tipo_trabajo)
,constraint FK_estudiante_estado_civil foreign key (cod_estado_civil) references estado_civil (cod_estado_civil)
,constraint FK_estudiante_telefono foreign key (cod_telefono) references telefono (cod_telefono)
)

create table examen
(
legajo_utn numeric (6,0)
,cod_materia numeric (3,0)
,cod_turno_examen numeric (3,0)
,nota_obtenida numeric (2,0)
constraint PK_examen primary key (legajo_utn, cod_materia, cod_turno_examen)
constraint FK_examen_estudiante foreign key (legajo_utn) references estudiante (legajo_utn)
,constraint FK_examen_materia foreign key (cod_materia) references materia (cod_materia)
)

create table docente_materia
(
legajo_docente numeric (6,0)
,cod_materia numeric (3,0)
,cod_curso numeric (1,0)
constraint PK_docente_materia primary key (legajo_docente, cod_materia, cod_curso)
constraint FK_docente_materia_docente foreign key (legajo_docente) references docente (legajo_docente)
,constraint FK_docente_materia_materia foreign key (cod_materia) references materia (cod_materia)
,constraint FK_docente_materia_curso foreign key (cod_curso) references curso (cod_curso)
)

create table estudiante_materia
(
legajo_utn numeric (6,0)
,cod_materia numeric (3,0)
,cod_curso numeric (1,0)
,fecha_inscripcion_cursado datetime not null
,cod_estado_materia numeric (1,0)
,fecha_estado_materia datetime not null
,nota_1 numeric (2,0)
,nota_2 numeric (2,0)
constraint PK_estudiante_materia primary key (legajo_utn, cod_materia, cod_curso)
constraint FK_estudiante_materia_estudiante foreign key (legajo_utn) references estudiante (legajo_utn)
,constraint FK_estudiante_materia_materia foreign key (cod_materia) references materia (cod_materia)
,constraint FK_estudiante_materia_curso foreign key (cod_curso) references curso (cod_curso)
)

--Altas de Registros
--Turnos
insert into turno (turno_examen)
values ('1º Turno')
insert into turno (turno_examen)
values ('2º Turno')
insert into turno (turno_examen)
values ('3º Turno')
insert into turno (turno_examen)
values ('Exámenes Generales 4º Turno')
insert into turno (turno_examen)
values ('5º Turno')
insert into turno (turno_examen)
values ('6º Turno')
insert into turno (turno_examen)
values ('Exámenes Generales 7º Turno')
insert into turno (turno_examen)
values ('8º Turno')
insert into turno (turno_examen)
values ('9º Turno')
insert into turno (turno_examen)
values ('10º Turno')

--Estado de Materia
insert into estado_materia (estado_materia)
values ('Libre')
insert into estado_materia (estado_materia)
values ('Regular')
insert into estado_materia (estado_materia)
values ('Promocionado')

--Barrio
insert into barrio (nombre_barrio)
values ('Alberdi')
insert into barrio (nombre_barrio)
values ('Alto Alberdi')
insert into barrio (nombre_barrio)
values ('Providencia')
insert into barrio (nombre_barrio)
values ('Barrio Jardín')
insert into barrio (nombre_barrio)
values ('San Martín')
insert into barrio (nombre_barrio)
values ('Alta Córdoba')
insert into barrio (nombre_barrio)
values ('Nueva Italia')
insert into barrio (nombre_barrio)
values ('Juniors')
insert into barrio (nombre_barrio)
values ('Matienzo')
insert into barrio (nombre_barrio)
values ('Cofico')
insert into barrio (nombre_barrio)
values ('General Paz')
insert into barrio (nombre_barrio)
values ('Centro')

--Estado Civil
insert into estado_civil (nombre_estado)
values ('Soltero')
insert into estado_civil (nombre_estado)
values ('Casado')
insert into estado_civil (nombre_estado)
values ('Divorciado')
insert into estado_civil (nombre_estado)
values ('Viudo')

--Tipo de Trabajo
insert into tipo_trabajo (nombre_trabajo)
values ('Administrativo')
insert into tipo_trabajo (nombre_trabajo)
values ('Operario')
insert into tipo_trabajo (nombre_trabajo)
values ('Técnico')
insert into tipo_trabajo (nombre_trabajo)
values ('Profesional')
insert into tipo_trabajo (nombre_trabajo)
values ('Administrativo')
insert into tipo_trabajo (nombre_trabajo)
values ('Sin Trabajo')
insert into tipo_trabajo (nombre_trabajo)
values ('Rural')
insert into tipo_trabajo (nombre_trabajo)
values ('Industrial')
insert into tipo_trabajo (nombre_trabajo)
values ('Lobbista')
insert into tipo_trabajo (nombre_trabajo)
values ('Viajante')
insert into tipo_trabajo (nombre_trabajo)
values ('Asesor Independiente')
insert into tipo_trabajo (nombre_trabajo)
values ('Cobrador')

--Habitat
insert into habitat (nombre_habitat)
values ('Departamento')
insert into habitat (nombre_habitat)
values ('Casa')
insert into habitat (nombre_habitat)
values ('Pensión')
insert into habitat (nombre_habitat)
values ('Piso Compartido')
insert into habitat (nombre_habitat)
values ('Barrio Cerrado')
insert into habitat (nombre_habitat)
values ('Casa de Familia')

--Título
insert into titulo (nombre_titulo)
values ('Ingeniero Civil')
insert into titulo (nombre_titulo)
values ('Ingeniero Electricista')
insert into titulo (nombre_titulo)
values ('Ingeniero Electrónico')
insert into titulo (nombre_titulo)
values ('Ingeniero Industrial')
insert into titulo (nombre_titulo)
values ('Ingeniero Mecánico')
insert into titulo (nombre_titulo)
values ('Ingeniero Metalúrgico')
insert into titulo (nombre_titulo)
values ('Ingeniero Químico')
insert into titulo (nombre_titulo)
values ('Ingeniero en Sistemas de Información')
insert into titulo (nombre_titulo)
values ('Licenciado en Tecnología Educativa')
insert into titulo (nombre_titulo)
values ('Licenciado en Higiene y Seguridad en el Trabajo')
insert into titulo (nombre_titulo)
values ('Contador')
insert into titulo (nombre_titulo)
values ('Analista de Sistemas de Computación')
insert into titulo (nombre_titulo)
values ('Licenciado en Administración de Empresas')

--Tipo de Documento
insert into tipo_documento (nombre_tipo_documento)
values ('D.N.I.')
insert into tipo_documento (nombre_tipo_documento)
values ('Cedula de Identidad')
insert into tipo_documento (nombre_tipo_documento)
values ('Libreta de Enrolamiento')
insert into tipo_documento (nombre_tipo_documento)
values ('Pasaporte')
insert into tipo_documento (nombre_tipo_documento)
values ('Libreta Cívica')

--Clasificación
 insert into clasificacion (nombre_clasificacion)
 values ('Programación')
 insert into clasificacion (nombre_clasificacion)
 values ('Básica')
 insert into clasificacion (nombre_clasificacion)
 values ('Matemáticas')
 insert into clasificacion (nombre_clasificacion)
 values ('Idiomas')
 insert into clasificacion (nombre_clasificacion)
 values ('Base de Datos')
 insert into clasificacion (nombre_clasificacion)
 values ('Contabilidad')
 insert into clasificacion (nombre_clasificacion)
 values ('Administración')
 insert into clasificacion (nombre_clasificacion)
 values ('Integradora')
 insert into clasificacion (nombre_clasificacion)
 values ('Práctica Profesional')
 insert into clasificacion (nombre_clasificacion)
 values ('Biología')
 insert into clasificacion (nombre_clasificacion)
 values ('Química')
 insert into clasificacion (nombre_clasificacion)
 values ('Física')
 insert into clasificacion (nombre_clasificacion)
 values ('Economía')
 insert into clasificacion (nombre_clasificacion)
 values ('Legislación')
 
 --Curso
 insert into curso (nombre_curso)
 values ('1w1')
 insert into curso (nombre_curso)
 values ('1w2')
 insert into curso (nombre_curso)
 values ('1w3')

 --Telefono
insert into telefono (nombre_telefono)
values ('Celular')
insert into telefono (nombre_telefono)
values ('Fijo')

 --Año
insert into año (nombre_año)
values ('Primer Año')
insert into año (nombre_año)
values ('Segundo Año')

 --Cuatrimestre
insert into cuatrimestre (nombre_cuatrimestre)
values ('Primer Cuatrimestre')
insert into cuatrimestre (nombre_cuatrimestre)
values ('Segundo Cuatrimestre')
insert into cuatrimestre (nombre_cuatrimestre)
values ('Tercer Cuatrimestre')
insert into cuatrimestre (nombre_cuatrimestre)
values ('Cuarto Cuatrimestre')


--Tecnicatura
insert into tecnicatura (nombre_tecnicatura, titulo, duracion_años, duracion_cuatrimestres, cantidad_materias)
values ('Tecnicatura en Programación', 'Tecnico Superior en Programación', 2, 4, 21)
insert into tecnicatura (nombre_tecnicatura, titulo, duracion_años, duracion_cuatrimestres, cantidad_materias)
values ('Tecnicatura en Idustrias Alimentarias', 'Tecnico Superior en Industrias Alimentarias', 2, 4, 14)
insert into tecnicatura (nombre_tecnicatura, titulo, duracion_años, duracion_cuatrimestres, cantidad_materias)
values ('Tecnicatura en Mecatrónica', 'Tecnico Superior en Mecatrónica', 2, 4, 19)
insert into tecnicatura (nombre_tecnicatura, titulo, duracion_años, duracion_cuatrimestres, cantidad_materias)
values ('Tecnicatura en Mantenimiento Industrial', 'Tecnico Superior en Mantenimiento Industrial', 2, 4, 26)
insert into tecnicatura (nombre_tecnicatura, titulo, duracion_años, duracion_cuatrimestres, cantidad_materias)
values ('Tecnicatura en Moldes, Matrices y Dispositivos', 'Tecnico Superior en Moldes, Matrices y Dispositivos', 2, 4, 21)

--Docente
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (105327, 'Tchami', 'Alphonse', 4, 22346322, 000009)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (100982, 'Cantarelli', 'Gianina', 1, 20562809, 000006)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (123547, 'Carpinella', 'Luis', 3, 06320898, 000001)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (005644, 'Sullivan', 'Patricio', 1, 25566142 , 000005)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (456431, 'Quintana', 'Marcelo', 1, 17785209, 000012)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (000001, 'Damiano', 'Luis', 5, 10101010 , 000003)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (635666, 'Botta', 'Oscar', 1, 14785236, 000008)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (464888, 'Ojeda', 'Norberto', 2, 777555, 000004)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (375951, 'Vulcano', 'Natalia', 1, 13288544, 000007)
insert into docente (legajo_docente, apellido_docente, nombre_docente, cod_tipo_documento, numero_documento, cod_titulo)
values (666224, 'Artime', 'Luis Fabián', 1, 15879456, 000010)

--Materia
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Estadística', 1, 1, 2, 3)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Elementos de Investigación Operativa', 1, 2, 3, 3)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Biología General', 2, 1, 1, 10)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Economía', 2, 2, 4, 3)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Matemática', 3, 1, 1, 3)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Pasantía en Entes Oficiales o Empresas', 3, 2, 4, 9)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Ingles', 4, 2, 3, 4)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Matemática', 4, 1, 1, 3)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Física', 5, 1, 2, 12)
insert into materia (nombre_materia, cod_tecnicatura, cod_año, cod_cuatrimestre, cod_clasificacion)
values ('Tecnología del Estampado', 5, 2, 4, 2)

--Estudiante
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (109257, 'Anania', 'José', '10/04/1981', 1, '01/01/2010', 75, 'Castro Barros', 3, 1, 2, 4737773, 5, 1)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (100856, 'Carrizo', 'Belen', '15/12/1990', 3, '01/01/2014', 1428, 'Peredo', 10, 5, 1, 155879635, 9, 3)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (105753, 'Venecia', 'Juan Manuel', '28/05/1987', 2, '01/01/2015', 720, 'Colon', 12, 2, 1, 155829635, 7, 1)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (100597, 'Kante', 'Maricel', '28/05/1978', 5, '01/01/2015', 123, 'Maipú', 5, 2, 1, 156333587, 8, 4)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (100100, 'Medina', 'Mariano', '03/02/1998', 5, '01/01/2012', 88, 'Arturo Orgaz', 1, 6, 2, 4247404, 3, 1)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (108976, 'Tundro', 'Angel', '20/10/1995', 4, '01/01/2011', 352, 'Independencia', 7, 4, 2, 4488879, 6, 3)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (106666, 'Godin', 'Demian', '16/07/1999', 1, '01/01/2010', 1120, 'Tronador', 11, 1, 1, 155555284, 12, 1)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (100874, 'Allende', 'Mauricio', '29/01/1982', 5, '01/01/2015', 39, 'Paso de los Andes', 11, 2, 1, 153658977, 1, 4)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (100524, 'Pineda', 'Ivan', '06/02/1990', 1, '01/01/2015', 327, 'Juan B. Justo', 7, 2, 2, 4279896, 10, 1)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (110385, 'Oliva', 'Norberto', '03/06/1992', 2, '01/01/2015', 764, 'Miguel de Guemes', 8, 5, 1, 155428931, 9, 3)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (100654, 'Mosconi', 'Alicia', '12/08/1993', 5, '01/01/2015', 1340, 'Velez Sarfield', 4, 1, 1, 154321783, 6, 3)
insert into estudiante (legajo_utn, apellido, nombre, fecha_nacimiento, cod_tecnicatura, fecha_ingreso, numero_calle, nombre_calle, cod_barrio, cod_habitat, cod_telefono, nro_telefono, cod_tipo_trabajo, cod_estado_civil)
values (109546, 'Berton', 'Giovanna', '02/09/1989', 3, '01/01/2015', 63, 'Dorrego', 3, 4, 1, 155978000, 6, 3)

--Examen
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (109257, 1, 10, 10)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (109257, 2, 5, 10)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100856, 5, 5, 2)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100856, 6, 8, 6)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (105753, 3, 2, 6)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (105753, 4, 1, 6)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100597, 9, 8, 1)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100597, 10, 1, 5)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100100, 9, 3, 5)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100100, 10, 1, 7)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (108976, 7, 6, 9)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (108976, 8, 4, 8)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (106666, 1, 5, 1)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (106666, 2, 8, 1)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100874, 9, 1, 6)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100874, 10, 1, 4)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100524, 1, 6, 10)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100524, 2, 2, 7)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (110385, 3, 2, 4)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (110385, 4, 8, 5)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100654, 7, 4, 2)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (100654, 8, 9, 6)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (109546, 5, 1, 8)
insert into examen (legajo_utn, cod_materia, cod_turno_examen, nota_obtenida)
values (109546, 6, 7, 9)

-- Docente por Materia
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (105327, 1, 1)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (100982, 2, 3)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (100982, 3, 1)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (123547, 3, 2)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (000001, 5, 1)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (000001, 7, 3)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (635666, 9, 2)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (464888, 4, 1)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (375951, 1, 3)
insert into docente_materia (legajo_docente, cod_materia, cod_curso)
values (666224, 10, 3)

-- Estudiante por Materia
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (109257, 1, 3, '01/03/2012', 3, '01/07/2012', 8, 8)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (100856, 1, 2, '01/07/2014', 2, '01/12/2014', 4, 6)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (105753, 3, 1, '01/03/2015', 1, '01/07/2015', 2, 2)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (100597, 9, 1, '01/07/2015', 2, '01/12/2015', 7, 5)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (100100, 9, 1, '01/07/2013', 3, '01/12/2013', 10, 8)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (108976, 7, 3, '01/07/2014', 1, '01/12/2014', 1, 3)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (106666, 1, 3, '01/07/2014', 2, '01/12/2014', 8, 4)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (100874, 9, 2, '01/07/2015', 2, '01/12/2015', 5, 6)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (100524, 1, 3, '01/07/2015', 3, '01/12/2015', 7, 10)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (110385, 3, 2, '01/07/2015', 2, '01/12/2015', 4, 6)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (100654, 7, 1, '01/07/2015', 1, '01/12/2015', 2, 2)
insert into estudiante_materia (legajo_utn, cod_materia, cod_curso, fecha_inscripcion_cursado, cod_estado_materia, fecha_estado_materia, nota_1, nota_2)
values (109546, 5, 2, '01/07/2015', 2, '01/12/2015', 7, 5)


--Búsquedas Sugeridas

--Cantidad de Alumnos regulares 

select legajo_utn, cod_estado_materia
from estudiante_materia
where cod_estado_materia = 2 

--Cantidad de Alumnos libres

select legajo_utn, cod_estado_materia
from estudiante_materia
where cod_estado_materia = 1

--Cantidad de Alumnos promocionados


select legajo_utn, cod_estado_materia
from estudiante_materia
where cod_estado_materia = 3

--Cantidad de Alumnos por materia

select legajo_utn, cod_materia
from estudiante_materia
order by cod_materia asc

--Cantidad de Alumnos por curso

select legajo_utn, cod_curso
from estudiante_materia
order by cod_curso 

--Cantidad de Alumnos por carrera

select legajo_utn, apellido, nombre, cod_tecnicatura as 'Carrera'
from estudiante
order by 4

--Alumnos por año de cursado

select legajo_utn, fecha_inscripcion_cursado
from estudiante_materia 
order by fecha_inscripcion_cursado

--Promedio de notas por alumno

select *, (nota_1+nota_2) / 2 'Promedio Alumnos'
from estudiante_materia
