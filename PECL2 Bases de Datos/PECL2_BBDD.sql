-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: "PECL2" | type: DATABASE --
-- -- DROP DATABASE IF EXISTS "PECL2";
-- CREATE DATABASE "PECL2";
-- -- ddl-end --
-- 

-- object: public."Trabajadores" | type: TABLE --
-- DROP TABLE IF EXISTS public."Trabajadores" CASCADE;
CREATE TABLE public."Trabajadores"(
	"DNI" char(9) NOT NULL,
	"teléfono" integer NOT NULL,
	nombre char(40) NOT NULL,
	horario char(16) NOT NULL,
	"ciudad_Tienda" char(20) NOT NULL,
	"barrio_Tienda" char(20) NOT NULL,
	CONSTRAINT "Trabajadores_pk" PRIMARY KEY ("DNI")

);
-- ddl-end --
ALTER TABLE public."Trabajadores" OWNER TO postgres;
-- ddl-end --

-- object: public."Cajero" | type: TABLE --
-- DROP TABLE IF EXISTS public."Cajero" CASCADE;
CREATE TABLE public."Cajero"(
	"DNI" char(9) NOT NULL,
	jornada integer NOT NULL,
-- 	"teléfono" integer NOT NULL,
-- 	nombre char(40) NOT NULL,
-- 	horario char(16) NOT NULL,
-- 	"ciudad_Tienda" char(20) NOT NULL,
-- 	"barrio_Tienda" char(20) NOT NULL,
	CONSTRAINT "Cajero_pk" PRIMARY KEY ("DNI")

) INHERITS(public."Trabajadores")
;
-- ddl-end --
ALTER TABLE public."Cajero" OWNER TO postgres;
-- ddl-end --

-- object: public."Ticket" | type: TABLE --
-- DROP TABLE IF EXISTS public."Ticket" CASCADE;
CREATE TABLE public."Ticket"(
	"idT" integer NOT NULL,
	"saldoAcumulado" float NOT NULL,
	"fecha/hora" timestamp NOT NULL,
	"cantidadProductos" char(40) NOT NULL,
	"nº socio_Socio" char(9) NOT NULL,
	"cantidadUsada" float NOT NULL,
	"usaSaldo" bool NOT NULL,
	"DNI_Cajero" char(9) NOT NULL,
	CONSTRAINT "Ticket_pk" PRIMARY KEY ("idT")

);
-- ddl-end --
ALTER TABLE public."Ticket" OWNER TO postgres;
-- ddl-end --

-- object: public."Cupón" | type: TABLE --
-- DROP TABLE IF EXISTS public."Cupón" CASCADE;
CREATE TABLE public."Cupón"(
	descuento char(3),
	"validezSemanal" timestamp NOT NULL,
	"códigoBarras_Producto" char(13) NOT NULL,
	CONSTRAINT "Cupón_pk" PRIMARY KEY ("códigoBarras_Producto")

);
-- ddl-end --
ALTER TABLE public."Cupón" OWNER TO postgres;
-- ddl-end --

-- object: public."Socio" | type: TABLE --
-- DROP TABLE IF EXISTS public."Socio" CASCADE;
CREATE TABLE public."Socio"(
	"nº socio" char(9) NOT NULL,
	nombre char(40) NOT NULL,
	"teléfono" integer NOT NULL,
	email char(40) NOT NULL,
	saldo float NOT NULL,
	calle char(20) NOT NULL,
	"nº portal" integer NOT NULL,
	CONSTRAINT "Socio_pk" PRIMARY KEY ("nº socio")

);
-- ddl-end --
ALTER TABLE public."Socio" OWNER TO postgres;
-- ddl-end --

-- object: public."Tienda" | type: TABLE --
-- DROP TABLE IF EXISTS public."Tienda" CASCADE;
CREATE TABLE public."Tienda"(
	ciudad char(20) NOT NULL,
	barrio char(20) NOT NULL,
	CONSTRAINT "Tienda_pk" PRIMARY KEY (ciudad,barrio)

);
-- ddl-end --
ALTER TABLE public."Tienda" OWNER TO postgres;
-- ddl-end --

-- object: public."Producto" | type: TABLE --
-- DROP TABLE IF EXISTS public."Producto" CASCADE;
CREATE TABLE public."Producto"(
	"códigoBarras" char(13) NOT NULL,
	stock integer NOT NULL,
	CONSTRAINT "Producto_pk" PRIMARY KEY ("códigoBarras")

);
-- ddl-end --
ALTER TABLE public."Producto" OWNER TO postgres;
-- ddl-end --

-- object: public."Opinión" | type: TABLE --
-- DROP TABLE IF EXISTS public."Opinión" CASCADE;
CREATE TABLE public."Opinión"(
	"fecha/hora" timestamp,
	"puntuación" float NOT NULL,
	"nº socio_Socio" char(9) NOT NULL,
	CONSTRAINT "Opinión_pk" PRIMARY KEY ("nº socio_Socio")

);
-- ddl-end --
ALTER TABLE public."Opinión" OWNER TO postgres;
-- ddl-end --

-- object: public."Oferta" | type: TABLE --
-- DROP TABLE IF EXISTS public."Oferta" CASCADE;
CREATE TABLE public."Oferta"(
	"semanaAño" date NOT NULL,
	descuento float NOT NULL,
	CONSTRAINT "Oferta_pk" PRIMARY KEY ("semanaAño")

);
-- ddl-end --
ALTER TABLE public."Oferta" OWNER TO postgres;
-- ddl-end --

-- object: public."CompraEn" | type: TABLE --
-- DROP TABLE IF EXISTS public."CompraEn" CASCADE;
CREATE TABLE public."CompraEn"(
	"nº socio_Socio" char(9) NOT NULL,
	"ciudad_Tienda" char(20) NOT NULL,
	"barrio_Tienda" char(20) NOT NULL,
	CONSTRAINT "CompraEn_pk" PRIMARY KEY ("nº socio_Socio","ciudad_Tienda","barrio_Tienda")

);
-- ddl-end --

-- object: "Socio_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CompraEn" DROP CONSTRAINT IF EXISTS "Socio_fk" CASCADE;
ALTER TABLE public."CompraEn" ADD CONSTRAINT "Socio_fk" FOREIGN KEY ("nº socio_Socio")
REFERENCES public."Socio" ("nº socio") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Tienda_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CompraEn" DROP CONSTRAINT IF EXISTS "Tienda_fk" CASCADE;
ALTER TABLE public."CompraEn" ADD CONSTRAINT "Tienda_fk" FOREIGN KEY ("ciudad_Tienda","barrio_Tienda")
REFERENCES public."Tienda" (ciudad,barrio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Socio_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Ticket" DROP CONSTRAINT IF EXISTS "Socio_fk" CASCADE;
ALTER TABLE public."Ticket" ADD CONSTRAINT "Socio_fk" FOREIGN KEY ("nº socio_Socio")
REFERENCES public."Socio" ("nº socio") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Socio_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Opinión" DROP CONSTRAINT IF EXISTS "Socio_fk" CASCADE;
ALTER TABLE public."Opinión" ADD CONSTRAINT "Socio_fk" FOREIGN KEY ("nº socio_Socio")
REFERENCES public."Socio" ("nº socio") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Cajero_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Ticket" DROP CONSTRAINT IF EXISTS "Cajero_fk" CASCADE;
ALTER TABLE public."Ticket" ADD CONSTRAINT "Cajero_fk" FOREIGN KEY ("DNI_Cajero")
REFERENCES public."Cajero" ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Tiene" | type: TABLE --
-- DROP TABLE IF EXISTS public."Tiene" CASCADE;
CREATE TABLE public."Tiene"(
	"ciudad_Tienda" char(20) NOT NULL,
	"barrio_Tienda" char(20) NOT NULL,
	"códigoBarras_Producto" char(13) NOT NULL,
	CONSTRAINT "Tiene_pk" PRIMARY KEY ("ciudad_Tienda","barrio_Tienda","códigoBarras_Producto")

);
-- ddl-end --

-- object: "Tienda_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Tiene" DROP CONSTRAINT IF EXISTS "Tienda_fk" CASCADE;
ALTER TABLE public."Tiene" ADD CONSTRAINT "Tienda_fk" FOREIGN KEY ("ciudad_Tienda","barrio_Tienda")
REFERENCES public."Tienda" (ciudad,barrio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Producto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Tiene" DROP CONSTRAINT IF EXISTS "Producto_fk" CASCADE;
ALTER TABLE public."Tiene" ADD CONSTRAINT "Producto_fk" FOREIGN KEY ("códigoBarras_Producto")
REFERENCES public."Producto" ("códigoBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Producto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Cupón" DROP CONSTRAINT IF EXISTS "Producto_fk" CASCADE;
ALTER TABLE public."Cupón" ADD CONSTRAINT "Producto_fk" FOREIGN KEY ("códigoBarras_Producto")
REFERENCES public."Producto" ("códigoBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."CuponParaSocio" | type: TABLE --
-- DROP TABLE IF EXISTS public."CuponParaSocio" CASCADE;
CREATE TABLE public."CuponParaSocio"(
	"códigoBarras_Producto_Cupón" char(13) NOT NULL,
	"nº socio_Socio" char(9) NOT NULL,
	CONSTRAINT "CuponParaSocio_pk" PRIMARY KEY ("códigoBarras_Producto_Cupón","nº socio_Socio")

);
-- ddl-end --

-- object: "Cupón_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CuponParaSocio" DROP CONSTRAINT IF EXISTS "Cupón_fk" CASCADE;
ALTER TABLE public."CuponParaSocio" ADD CONSTRAINT "Cupón_fk" FOREIGN KEY ("códigoBarras_Producto_Cupón")
REFERENCES public."Cupón" ("códigoBarras_Producto") MATCH FULL
ON DELETE RESTRICT ON UPDATE NO ACTION;
-- ddl-end --

-- object: "Socio_fk" | type: CONSTRAINT --
-- ALTER TABLE public."CuponParaSocio" DROP CONSTRAINT IF EXISTS "Socio_fk" CASCADE;
ALTER TABLE public."CuponParaSocio" ADD CONSTRAINT "Socio_fk" FOREIGN KEY ("nº socio_Socio")
REFERENCES public."Socio" ("nº socio") MATCH FULL
ON DELETE RESTRICT ON UPDATE NO ACTION;
-- ddl-end --

-- object: public."Tienen" | type: TABLE --
-- DROP TABLE IF EXISTS public."Tienen" CASCADE;
CREATE TABLE public."Tienen"(
	"semanaAño_Oferta" date NOT NULL,
	"códigoBarras_Producto" char(13) NOT NULL,
	"fechaInicio" date NOT NULL,
	"fechaFin" date NOT NULL,
	CONSTRAINT "Tienen_pk" PRIMARY KEY ("semanaAño_Oferta","códigoBarras_Producto","fechaInicio","fechaFin")

);
-- ddl-end --

-- object: "Oferta_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Tienen" DROP CONSTRAINT IF EXISTS "Oferta_fk" CASCADE;
ALTER TABLE public."Tienen" ADD CONSTRAINT "Oferta_fk" FOREIGN KEY ("semanaAño_Oferta")
REFERENCES public."Oferta" ("semanaAño") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Producto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Tienen" DROP CONSTRAINT IF EXISTS "Producto_fk" CASCADE;
ALTER TABLE public."Tienen" ADD CONSTRAINT "Producto_fk" FOREIGN KEY ("códigoBarras_Producto")
REFERENCES public."Producto" ("códigoBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Incluye" | type: TABLE --
-- DROP TABLE IF EXISTS public."Incluye" CASCADE;
CREATE TABLE public."Incluye"(
	"idT_Ticket" integer NOT NULL,
	"códigoBarras_Producto" char(13) NOT NULL,
	cantidad integer NOT NULL,
	CONSTRAINT "Incluye_pk" PRIMARY KEY ("idT_Ticket","códigoBarras_Producto")

);
-- ddl-end --

-- object: "Ticket_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Incluye" DROP CONSTRAINT IF EXISTS "Ticket_fk" CASCADE;
ALTER TABLE public."Incluye" ADD CONSTRAINT "Ticket_fk" FOREIGN KEY ("idT_Ticket")
REFERENCES public."Ticket" ("idT") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Producto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Incluye" DROP CONSTRAINT IF EXISTS "Producto_fk" CASCADE;
ALTER TABLE public."Incluye" ADD CONSTRAINT "Producto_fk" FOREIGN KEY ("códigoBarras_Producto")
REFERENCES public."Producto" ("códigoBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Devuelve" | type: TABLE --
-- DROP TABLE IF EXISTS public."Devuelve" CASCADE;
CREATE TABLE public."Devuelve"(
	"idT_Ticket" integer NOT NULL,
	"códigoBarras_Producto" char(13) NOT NULL,
	cantidad integer NOT NULL,
	CONSTRAINT "Devuelve_pk" PRIMARY KEY ("idT_Ticket","códigoBarras_Producto",cantidad)

);
-- ddl-end --

-- object: "Ticket_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Devuelve" DROP CONSTRAINT IF EXISTS "Ticket_fk" CASCADE;
ALTER TABLE public."Devuelve" ADD CONSTRAINT "Ticket_fk" FOREIGN KEY ("idT_Ticket")
REFERENCES public."Ticket" ("idT") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Producto_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Devuelve" DROP CONSTRAINT IF EXISTS "Producto_fk" CASCADE;
ALTER TABLE public."Devuelve" ADD CONSTRAINT "Producto_fk" FOREIGN KEY ("códigoBarras_Producto")
REFERENCES public."Producto" ("códigoBarras") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: public."Reponedor" | type: TABLE --
-- DROP TABLE IF EXISTS public."Reponedor" CASCADE;
CREATE TABLE public."Reponedor"(
	"DNI" char(9) NOT NULL,
	"número de horas" float NOT NULL,
-- 	"teléfono" integer NOT NULL,
-- 	nombre char(40) NOT NULL,
-- 	horario char(16) NOT NULL,
-- 	"ciudad_Tienda" char(20) NOT NULL,
-- 	"barrio_Tienda" char(20) NOT NULL,
	CONSTRAINT "Reponedor_pk" PRIMARY KEY ("DNI")

) INHERITS(public."Trabajadores")
;
-- ddl-end --
ALTER TABLE public."Reponedor" OWNER TO postgres;
-- ddl-end --

-- object: public."Evaluación" | type: TABLE --
-- DROP TABLE IF EXISTS public."Evaluación" CASCADE;
CREATE TABLE public."Evaluación"(
	"DNI_Trabajadores" char(9) NOT NULL,
	"DNI_Trabajadores1" char(9) NOT NULL,
	nota float NOT NULL,
	CONSTRAINT "Evaluación_pk" PRIMARY KEY ("DNI_Trabajadores","DNI_Trabajadores1")

);
-- ddl-end --

-- object: "Trabajadores_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Evaluación" DROP CONSTRAINT IF EXISTS "Trabajadores_fk" CASCADE;
ALTER TABLE public."Evaluación" ADD CONSTRAINT "Trabajadores_fk" FOREIGN KEY ("DNI_Trabajadores")
REFERENCES public."Trabajadores" ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Trabajadores_fk1" | type: CONSTRAINT --
-- ALTER TABLE public."Evaluación" DROP CONSTRAINT IF EXISTS "Trabajadores_fk1" CASCADE;
ALTER TABLE public."Evaluación" ADD CONSTRAINT "Trabajadores_fk1" FOREIGN KEY ("DNI_Trabajadores1")
REFERENCES public."Trabajadores" ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --

-- object: "Tienda_fk" | type: CONSTRAINT --
-- ALTER TABLE public."Trabajadores" DROP CONSTRAINT IF EXISTS "Tienda_fk" CASCADE;
ALTER TABLE public."Trabajadores" ADD CONSTRAINT "Tienda_fk" FOREIGN KEY ("ciudad_Tienda","barrio_Tienda")
REFERENCES public."Tienda" (ciudad,barrio) MATCH FULL
ON DELETE RESTRICT ON UPDATE CASCADE;
-- ddl-end --


