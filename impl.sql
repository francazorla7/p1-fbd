

create table color (

  color varchar(20) primary key not null
);
create table marca (

  marca varchar(20) primary key not null
);

create table modelo (

  modelo varchar(20) primary key not null
);

create table vehiculo(

	matricula varchar(7) primary key not null,
	marca varchar(20) not null,
	numero_de_bastidor varchar(17) not null unique,
	modelo varchar(20) not null,
	color varchar(20) not null,
	fecha_matriculacion date not null,
	dni_propietario varchar(9) not null,
	dni_conductor_habitual varchar(9) not null,

  foreign key (color) references color (color),
  foreign key (marca) references marca (marca),
  foreign key (modelo) references modelo (modelo)
);





create table persona(

	dni varchar(9) primary key not null,
	nombre varchar(20) not null,
	apellidos varchar(30) not null,
	codigo_postal number(6) not null,
	localidad varchar(20) not null,
	telefono varchar(9) not null,
  email varchar(20)
);


create table conductor(

  dni varchar(9) primary key not null,
	nombre varchar(20) not null,
	apellidos varchar(30) not null,
	codigo_postal number(6) not null,
	localidad varchar(20) not null,
	telefono varchar(9) not null,
  email varchar(20),
  tipo_de_carnet varchar(20) not null,
  fecha_de_emision date not null,
  edad number not null check (edad >= 18)
);

create table conductor__vehiculo(

  dni varchar(9) unique not null,
  matricula varchar(7) unique not null
);

create table radar(

  carretera varchar(20) primary key not null,
  sentido varchar(20) unique not null,
  punto_kilometrico number(6) unique not null
);

create table observacion(

  matricula varchar(7) not null,
  carretera_del_radar varchar(20) not null,
  fecha date not null,
  hora varchar(8) not null,
  velocidad float not null
);


create table forma_de_pago(
  forma_de_pago varchar(20) not null primary key
);

create table estado(
  estado varchar(20) not null primary key
);

create table sancion(

  dni_del_propietario varchar(9) not null,
  fecha_de_envio date not null,
  cuantia number not null,
  /*la fecha limite de pago no hay que guardarla*/
  forma_de_pago varchar(20) not null,
  estado varchar(20) not null,

  foreign key (forma_de_pago) references forma_de_pago (forma_de_pago),
  foreign key (estado) references estado (estado)
);
