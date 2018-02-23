drop table colores;
drop table marcas;
drop table modelos;
drop table personas;
drop table conductores;
drop table vehiculos;
drop table conductores_vehiculos;
drop table radares;
drop table observaciones;
drop table sanciones;
drop table formas_de_pago;
drop table estados;



create table colores
(
  color varchar(20) primary key not null
);
create table marcas
(
  marca varchar(20) primary key not null
);

create table modelos
(
  modelo varchar(20) primary key not null
);



create table personas
(
	dni varchar(9) primary key not null,
	nombre varchar(20) not null,
	apellidos varchar(30) not null,
	codigo_postal number(6) not null,
	localidad varchar(20) not null,
	telefono varchar(9) not null,
  email varchar(20),
  fecha_de_nacimiento date not null
);


create table conductores
(
  dni varchar(9) primary key not null,
	nombre varchar(20) not null,
	apellidos varchar(30) not null,
	codigo_postal number(6) not null,
  localidad varchar(20) not null,
	telefono varchar(9) not null,
  email varchar(20),
  fecha_de_nacimiento date not null,
  tipo_de_carnet varchar(20) not null,
  fecha_de_emision date not null,
  edad number not null check (edad >= 18)
);


create table vehiculos
(
	matricula varchar(7) primary key not null,
	marca varchar(20) not null,
	numero_de_bastidor varchar(17) not null unique,
	modelo varchar(20) not null,
	color varchar(20) not null,
	fecha_matriculacion date not null,
	dni_propietario varchar(9) not null,
	dni_conductor_habitual varchar(9) not null,

  foreign key (color) references colores(color),
  foreign key (marca) references marcas(marca),
  foreign key (modelo) references modelos(modelo),
  foreign key (dni_propietario) references personas(dni)
);






create table conductores_vehiculos
(
  dni varchar(9) not null,
  matricula varchar(7) not null,

  primary key (dni, matricula),

  foreign key (dni) references conductores(dni),
  foreign key (matricula) references vehiculos(matricula)
);



create table radares
(
  carretera varchar(20) primary key not null,
  sentido varchar(20) unique not null,
  punto_kilometrico number(6) unique not null
);

create table observaciones
(
  matricula varchar(7) not null,
  carretera_del_radar varchar(20) not null,
  fecha date not null, /* la fecha guarda fecha, hora, minuto y segundo */
  velocidad float not null,


  primary key (fecha, matricula) /* no es posible que se den dos observaciones al mismo tiempo en distintos sitios del mismo coche */
);


create table formas_de_pago
(
  forma_de_pago varchar(20) not null primary key
);

create table estados
(
  estado varchar(20) not null primary key
);

create table sanciones
(
  dni_del_propietario varchar(9) not null,
  fecha_de_envio date not null,
  cuantia number not null,
  /* la fecha limite de pago no hay que guardarla, se calcula */
  forma_de_pago varchar(20) not null,
  estado varchar(20) not null,

  primary key (dni_del_propietario, fecha_de_envio),

  foreign key (dni_del_propietario) references personas(dni),
  foreign key (forma_de_pago) references formas_de_pago(forma_de_pago),
  foreign key (estado) references estados(estado)
);
