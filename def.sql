drop table alegaciones;
drop table estados_de_alegacion;
drop table sanciones;
drop table estados_de_sancion;
drop table formas_de_pago;
drop table observaciones;
drop table radares;
drop table carreteras;
drop table conductores_vehiculos;
drop table vehiculos;
drop table conductores;
drop table personas;
drop table modelos;
drop table marcas;
drop table colores;

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
	nombre varchar(30) not null,
	direccion_postal number(6) not null,
	localidad varchar(20) not null,
	telefono varchar(9) not null,
  email varchar(20),
  fecha_de_nacimiento date not null
);


create table conductores
(
  dni varchar(9) primary key not null,
	nombre varchar(30) not null,
	direccion_postal number(6) not null,
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
	fecha_ultima_itv date not null,
	dni_propietario varchar(9) not null,
	dni_conductor_habitual varchar(9) not null,
  constraint color_vehiculos_FK foreign key (color) references colores(color),
  constraint marca_vehiculos_FK foreign key (marca) references marcas(marca),
  constraint modelo_vehiculos_FK foreign key (modelo) references modelos(modelo),
  constraint dni_propietario_vehiculos_FK foreign key (dni_propietario) references personas(dni)
);





create table conductores_vehiculos
(
  dni varchar(9) not null,
  matricula varchar(7) not null,
  constraint conductores_vehiculos_PK primary key (dni, matricula),
  constraint dni_c_v_FK foreign key (dni) references conductores(dni),
  constraint matricula_c_v_FK foreign key (matricula) references vehiculos(matricula)
);


create table carreteras
(
  nombre varchar(20) primary key not null,
  velocidad_maxima_permitida number(6) not null
);


create table radares
(
  nombre_de_carretera varchar(20) unique not null,
  sentido varchar(20) unique not null,
  punto_kilometrico number(6) unique not null,
  constraint radares_PK primary key (nombre_de_carretera, sentido, punto_kilometrico),
  constraint carretera_radares_FK foreign key (nombre_de_carretera) references carreteras(nombre)
);

create table observaciones
(
  matricula_del_vehiculo varchar(7) not null,
  carretera_del_radar varchar(20) not null,
  fecha_de_la_observacion date not null,
  velocidad_registrada number(6) not null,
  constraint observaciones_PK primary key (fecha_de_la_observacion, matricula_del_vehiculo),
  constraint carretera_observaciones_FK foreign key (carretera_del_radar) references radares(nombre_de_carretera),
  constraint matricula_observaciones_FK foreign key (matricula_del_vehiculo) references vehiculos(matricula)
);


create table formas_de_pago
(
  forma_de_pago varchar(20) not null primary key
);

create table estados_de_sancion
(
  estado varchar(20) not null primary key
);

create table sanciones
(
  dni_del_propietario varchar(9) not null,
  fecha_de_envio date not null,
  cuantia number not null,
  forma_de_pago varchar(20) not null,
  estado varchar(20) not null,
  constraint sanciones_PK primary key (dni_del_propietario, fecha_de_envio),
  constraint dni_sanciones_FK foreign key (dni_del_propietario) references personas(dni),
  constraint forma_de_pago_sanciones_FK foreign key (forma_de_pago) references formas_de_pago(forma_de_pago),
  constraint estado_sanciones_FK foreign key (estado) references estados_de_sancion(estado)
);

create table estados_de_alegacion
(
  estado varchar(20) not null primary key
);

create table alegaciones
(
  dni_del_propietario varchar(9) not null,
  fecha_de_la_sancion date not null,
  estado varchar(20) not null,
  fecha_de_ejecucion date,
  constraint alegaciones_PK primary key (dni_del_propietario, fecha_de_la_sancion), /* no puede haber mas de una alegacion por sancion */
  constraint dni_alegaciones_FK foreign key (dni_del_propietario, fecha_de_la_sancion) references sanciones(dni_del_propietario, fecha_de_envio)
);
