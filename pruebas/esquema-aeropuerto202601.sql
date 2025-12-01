--
-- PostgreSQL database dump
--

\restrict Ngss9u0h4GbqTH1k9qQXkvRFxfuxX9vtU3EAAS2avJxUe5G9qoD4rhAOq1omoyS

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: aerolinea_de_avion(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.aerolinea_de_avion(avion_id character varying) RETURNS TABLE(aeropuert_razon_social character varying, matricula_avion character varying, modelo_avion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT ar.razon_social, av.matricula_avion, av.modelo
    FROM aerolineas ar
    INNER JOIN avion av ON av.aerolinea_id = ar.aerolinea_id
    WHERE ar.aerolinea_id = (SELECT ar.aerolinea_id
                             FROM avion av
                             INNER JOIN aerolineas ar ON ar.aerolinea_id = av.aerolinea_id
                             WHERE av.matricula_avion = avion_id);
END
$$;


ALTER FUNCTION public.aerolinea_de_avion(avion_id character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aerolineas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aerolineas (
    aerolinea_id integer NOT NULL,
    razon_social character varying(100) NOT NULL,
    pais_origen_empresa character varying(50),
    ciudad character varying(50),
    municipio character varying(50),
    codigo_postal character varying(20),
    calle character varying(100),
    colonia character varying(50),
    numero_exterior character varying(10),
    pais character varying(50)
);


ALTER TABLE public.aerolineas OWNER TO postgres;

--
-- Name: TABLE aerolineas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.aerolineas IS 'Tabla que almacena información de las aerolíneas registradas en el sistema.';


--
-- Name: COLUMN aerolineas.aerolinea_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.aerolineas.aerolinea_id IS 'Identificador único de la aerolínea.';


--
-- Name: COLUMN aerolineas.razon_social; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.aerolineas.razon_social IS 'Nombre legal y comercial de la aerolínea.';


--
-- Name: COLUMN aerolineas.pais_origen_empresa; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.aerolineas.pais_origen_empresa IS 'País donde se fundó la aerolínea.';


--
-- Name: aeropuerto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeropuerto (
    aeropuerto_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    pais character varying(50),
    ciudad character varying(50),
    municipio character varying(50),
    codigo_postal character varying(20),
    calle character varying(100),
    colonia character varying(50),
    numero_exterior character varying(10)
);


ALTER TABLE public.aeropuerto OWNER TO postgres;

--
-- Name: TABLE aeropuerto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.aeropuerto IS 'Tabla que registra información de aeropuertos donde operan las aerolíneas.';


--
-- Name: avion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avion (
    matricula_avion character varying(20) NOT NULL,
    capacidad_pasajeros integer NOT NULL,
    modelo character varying(50),
    aerolinea_id integer,
    fecha_ultimo_mantenimiento date,
    CONSTRAINT chk_capacidad_pasajeros CHECK (((capacidad_pasajeros >= 0) AND (capacidad_pasajeros <= 1000))),
    CONSTRAINT chk_fecha_mantenimiento CHECK ((fecha_ultimo_mantenimiento <= CURRENT_DATE))
);


ALTER TABLE public.avion OWNER TO postgres;

--
-- Name: TABLE avion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.avion IS 'Tabla que almacena datos de la flota de aviones de cada aerolínea.';


--
-- Name: COLUMN avion.matricula_avion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avion.matricula_avion IS 'Matrícula única que identifica la aeronave.';


--
-- Name: COLUMN avion.capacidad_pasajeros; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avion.capacidad_pasajeros IS 'Número máximo de pasajeros que puede transportar. 0 para aviones de carga.';


--
-- Name: COLUMN avion.modelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.avion.modelo IS 'Modelo y marca de la aeronave.';


--
-- Name: boleto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.boleto (
    boleto_id integer NOT NULL,
    numero_asiento character varying(10),
    clase character varying(20),
    precio numeric(10,2) NOT NULL,
    numero_vuelo character varying(10),
    CONSTRAINT chk_precio_boleto CHECK (((precio > (0)::numeric) AND (precio <= (1000000)::numeric)))
);


ALTER TABLE public.boleto OWNER TO postgres;

--
-- Name: TABLE boleto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.boleto IS 'Tabla que registra los boletos disponibles para cada vuelo.';


--
-- Name: COLUMN boleto.boleto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.boleto_id IS 'Identificador único del boleto.';


--
-- Name: COLUMN boleto.numero_asiento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.numero_asiento IS 'Número del asiento asignado.';


--
-- Name: COLUMN boleto.clase; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.clase IS 'Clase de servicio (económica, ejecutiva, primera).';


--
-- Name: COLUMN boleto.precio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.boleto.precio IS 'Precio del boleto en la moneda local.';


--
-- Name: certificacion_mecanico_aeronave; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificacion_mecanico_aeronave (
    nombre character varying(100) NOT NULL,
    mecanico_id integer NOT NULL
);


ALTER TABLE public.certificacion_mecanico_aeronave OWNER TO postgres;

--
-- Name: TABLE certificacion_mecanico_aeronave; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.certificacion_mecanico_aeronave IS 'Tabla que almacena las certificaciones de mecánicos de aeronaves.';


--
-- Name: COLUMN certificacion_mecanico_aeronave.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_mecanico_aeronave.nombre IS 'Nombre de la certificación de mecánico de aeronaves.';


--
-- Name: COLUMN certificacion_mecanico_aeronave.mecanico_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_mecanico_aeronave.mecanico_id IS 'Identificador del mecánico certificado.';


--
-- Name: certificacion_seguridad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificacion_seguridad (
    nombre character varying(100) NOT NULL,
    sobrecargo_id integer NOT NULL
);


ALTER TABLE public.certificacion_seguridad OWNER TO postgres;

--
-- Name: TABLE certificacion_seguridad; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.certificacion_seguridad IS 'Tabla que almacena las certificaciones de seguridad de los sobrecargos.';


--
-- Name: certificacion_tipo_aeronave; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certificacion_tipo_aeronave (
    nombre character varying(100) NOT NULL,
    piloto_id integer NOT NULL
);


ALTER TABLE public.certificacion_tipo_aeronave OWNER TO postgres;

--
-- Name: TABLE certificacion_tipo_aeronave; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.certificacion_tipo_aeronave IS 'Tabla que almacena las certificaciones de tipo de aeronave de los pilotos.';


--
-- Name: COLUMN certificacion_tipo_aeronave.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_tipo_aeronave.nombre IS 'Nombre de la certificación de tipo de aeronave.';


--
-- Name: COLUMN certificacion_tipo_aeronave.piloto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certificacion_tipo_aeronave.piloto_id IS 'Identificador del piloto certificado para ese tipo de aeronave.';


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cliente_id integer NOT NULL,
    nombres character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50),
    fecha_nacimiento date
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- Name: TABLE cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.cliente IS 'Tabla que almacena información personal de los clientes.';


--
-- Name: COLUMN cliente.cliente_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cliente.cliente_id IS 'Identificador único del cliente.';


--
-- Name: COLUMN cliente.fecha_nacimiento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.cliente.fecha_nacimiento IS 'Fecha de nacimiento del cliente.';


--
-- Name: comprar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comprar (
    cliente_id integer NOT NULL,
    boleto_id integer NOT NULL,
    fecha_compra date
);


ALTER TABLE public.comprar OWNER TO postgres;

--
-- Name: TABLE comprar; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.comprar IS 'Tabla de relación que registra la compra de boletos por clientes.';


--
-- Name: contratar_aerolinea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contratar_aerolinea (
    aerolinea_id integer CONSTRAINT contratar_aerolinea_id_not_null NOT NULL,
    empleado_id integer CONSTRAINT contratar_empleado_id_not_null NOT NULL,
    fecha_ingreso date,
    fecha_egreso date
);


ALTER TABLE public.contratar_aerolinea OWNER TO postgres;

--
-- Name: TABLE contratar_aerolinea; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.contratar_aerolinea IS 'Tabla de relación que registra la contratación de empleados por aerolíneas.';


--
-- Name: contratar_aeropuerto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contratar_aeropuerto (
    aeropuerto_id integer NOT NULL,
    empleado_id integer NOT NULL,
    fecha_ingreso date NOT NULL,
    fecha_egreso date,
    CONSTRAINT chk_fechas_aeropuerto CHECK (((fecha_egreso IS NULL) OR (fecha_egreso > fecha_ingreso)))
);


ALTER TABLE public.contratar_aeropuerto OWNER TO postgres;

--
-- Name: TABLE contratar_aeropuerto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.contratar_aeropuerto IS 'Tabla de relación que registra la contratación de empleados por aeropuertos. La especialización del empleado (Controlador de Vuelo, Mecánico, etc.) se determina consultando las tablas correspondientes.';


--
-- Name: COLUMN contratar_aeropuerto.aeropuerto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.aeropuerto_id IS 'Identificador del aeropuerto empleador.';


--
-- Name: COLUMN contratar_aeropuerto.empleado_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.empleado_id IS 'Identificador del empleado contratado por el aeropuerto.';


--
-- Name: COLUMN contratar_aeropuerto.fecha_ingreso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.fecha_ingreso IS 'Fecha en que el empleado inició labores en el aeropuerto.';


--
-- Name: COLUMN contratar_aeropuerto.fecha_egreso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.contratar_aeropuerto.fecha_egreso IS 'Fecha en que el empleado terminó su relación laboral con el aeropuerto. NULL indica que aún está activo.';


--
-- Name: controlador_de_abordaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.controlador_de_abordaje (
    empleado_id integer NOT NULL,
    certificacion_atencion_cliente character varying(100),
    fecha_vencimiento_certificacion date
);


ALTER TABLE public.controlador_de_abordaje OWNER TO postgres;

--
-- Name: TABLE controlador_de_abordaje; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.controlador_de_abordaje IS 'Tabla que almacena información específica de controladores de abordaje, siendo un subtipo de Empleado.';


--
-- Name: controlador_de_vuelos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.controlador_de_vuelos (
    empleado_id integer NOT NULL,
    licencia_control_trafico character varying(50),
    sector_asignado character varying(50),
    fecha_vencimiento_licencia date
);


ALTER TABLE public.controlador_de_vuelos OWNER TO postgres;

--
-- Name: TABLE controlador_de_vuelos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.controlador_de_vuelos IS 'Tabla que almacena información específica de controladores de vuelo, siendo un subtipo de Empleado.';


--
-- Name: correo_aerolineas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.correo_aerolineas (
    aerolinea_id integer NOT NULL,
    direccion_correo character varying(100) NOT NULL
);


ALTER TABLE public.correo_aerolineas OWNER TO postgres;

--
-- Name: TABLE correo_aerolineas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.correo_aerolineas IS 'Tabla que almacena las direcciones de correo electrónico de las aerolíneas.';


--
-- Name: correo_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.correo_cliente (
    cliente_id integer NOT NULL,
    direccion_correo character varying(100) NOT NULL
);


ALTER TABLE public.correo_cliente OWNER TO postgres;

--
-- Name: TABLE correo_cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.correo_cliente IS 'Tabla que almacena las direcciones de correo electrónico de los clientes.';


--
-- Name: empleado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.empleado (
    empleado_id integer NOT NULL,
    nombres character varying(50) NOT NULL,
    apellido_paterno character varying(50) NOT NULL,
    apellido_materno character varying(50),
    pais character varying(50),
    ciudad character varying(50),
    municipio character varying(50),
    codigo_postal character varying(10),
    calle character varying(100),
    colonia character varying(50),
    numero_exterior character varying(10),
    numero_interior character varying(10),
    identificacion_unica_pobla character varying(50),
    salario numeric(10,2),
    fecha_nacimiento date,
    CONSTRAINT chk_fecha_nacimiento_empleado CHECK (((fecha_nacimiento >= '1940-01-01'::date) AND (fecha_nacimiento <= (CURRENT_DATE - '18 years'::interval)))),
    CONSTRAINT chk_salario_empleado CHECK (((salario >= (5000)::numeric) AND (salario <= (5000000)::numeric)))
);


ALTER TABLE public.empleado OWNER TO postgres;

--
-- Name: TABLE empleado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.empleado IS 'Tabla que contiene datos personales y de ubicación de todos los empleados.';


--
-- Name: COLUMN empleado.empleado_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.empleado_id IS 'Identificador único del empleado.';


--
-- Name: COLUMN empleado.nombres; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.nombres IS 'Nombre(s) del empleado.';


--
-- Name: COLUMN empleado.apellido_paterno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.apellido_paterno IS 'Apellido paterno del empleado.';


--
-- Name: COLUMN empleado.apellido_materno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.empleado.apellido_materno IS 'Apellido materno del empleado.';


--
-- Name: idioma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idioma (
    nombre character varying(50) NOT NULL,
    sobrecargo_id integer NOT NULL
);


ALTER TABLE public.idioma OWNER TO postgres;

--
-- Name: TABLE idioma; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.idioma IS 'Tabla que almacena los idiomas que hablan los sobrecargos.';


--
-- Name: mecanico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mecanico (
    empleado_id integer NOT NULL,
    titulo character varying(100),
    especializacion character varying(100)
);


ALTER TABLE public.mecanico OWNER TO postgres;

--
-- Name: TABLE mecanico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.mecanico IS 'Tabla que almacena información específica de los mecánicos, siendo un subtipo de Empleado.';


--
-- Name: piloto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.piloto (
    piloto_id integer NOT NULL,
    empleado_id integer NOT NULL,
    licencia character varying(50),
    horas_vuelo integer,
    fecha_vencimiento_licencia date,
    CONSTRAINT chk_horas_experiencia CHECK (((horas_vuelo >= 0) AND (horas_vuelo <= 50000)))
);


ALTER TABLE public.piloto OWNER TO postgres;

--
-- Name: TABLE piloto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.piloto IS 'Tabla que almacena información específica de los pilotos, siendo un subtipo de Empleado.';


--
-- Name: COLUMN piloto.piloto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.piloto_id IS 'Identificador único del piloto.';


--
-- Name: COLUMN piloto.empleado_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.empleado_id IS 'Referencia al empleado que es piloto.';


--
-- Name: COLUMN piloto.licencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.licencia IS 'Número de licencia del piloto.';


--
-- Name: COLUMN piloto.horas_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.horas_vuelo IS 'Total de horas de vuelo acumuladas por el piloto.';


--
-- Name: COLUMN piloto.fecha_vencimiento_licencia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto.fecha_vencimiento_licencia IS 'Fecha de vencimiento de la licencia del piloto.';


--
-- Name: piloto_vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.piloto_vuelo (
    piloto_id integer NOT NULL,
    numero_vuelo character varying(10) NOT NULL
);


ALTER TABLE public.piloto_vuelo OWNER TO postgres;

--
-- Name: TABLE piloto_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.piloto_vuelo IS 'Tabla de unión que asigna pilotos a los vuelos, modelando la relación muchos a muchos.';


--
-- Name: COLUMN piloto_vuelo.piloto_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto_vuelo.piloto_id IS 'Identificador del piloto asignado.';


--
-- Name: COLUMN piloto_vuelo.numero_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.piloto_vuelo.numero_vuelo IS 'Número del vuelo al que está asignado el piloto.';


--
-- Name: sobrecargo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sobrecargo (
    empleado_id integer NOT NULL
);


ALTER TABLE public.sobrecargo OWNER TO postgres;

--
-- Name: TABLE sobrecargo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sobrecargo IS 'Tabla que almacena información específica de sobrecargos, siendo un subtipo de Empleado.';


--
-- Name: telefono; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono (
    empleado_id integer NOT NULL,
    numero_telefono character varying(15) NOT NULL
);


ALTER TABLE public.telefono OWNER TO postgres;

--
-- Name: TABLE telefono; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.telefono IS 'Tabla que almacena los números telefónicos de los empleados.';


--
-- Name: telefono_aerolineas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono_aerolineas (
    aerolinea_id integer NOT NULL,
    numero_telefono character varying(15) NOT NULL
);


ALTER TABLE public.telefono_aerolineas OWNER TO postgres;

--
-- Name: TABLE telefono_aerolineas; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.telefono_aerolineas IS 'Tabla que almacena los números telefónicos de las aerolíneas.';


--
-- Name: telefono_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telefono_cliente (
    cliente_id integer NOT NULL,
    numero_telefono character varying(15) NOT NULL
);


ALTER TABLE public.telefono_cliente OWNER TO postgres;

--
-- Name: TABLE telefono_cliente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.telefono_cliente IS 'Tabla que almacena los números telefónicos de los clientes.';


--
-- Name: tipo_vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_vuelo (
    tipo_vuelo_id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text
);


ALTER TABLE public.tipo_vuelo OWNER TO postgres;

--
-- Name: TABLE tipo_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.tipo_vuelo IS 'Tabla catálogo que define los tipos de vuelo disponibles en el sistema.';


--
-- Name: COLUMN tipo_vuelo.tipo_vuelo_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tipo_vuelo.tipo_vuelo_id IS 'Identificador único del tipo de vuelo.';


--
-- Name: COLUMN tipo_vuelo.nombre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tipo_vuelo.nombre IS 'Nombre del tipo de vuelo (ej. Pasajeros, Carga, Mixto).';


--
-- Name: COLUMN tipo_vuelo.descripcion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.tipo_vuelo.descripcion IS 'Descripción detallada del tipo de vuelo.';


--
-- Name: vuelo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vuelo (
    numero_vuelo character varying(10) NOT NULL,
    tipo_vuelo_id integer,
    estado character varying(20),
    duracion time without time zone,
    fecha_salida date NOT NULL,
    hora_salida time without time zone NOT NULL,
    ciudad_salida character varying(50),
    pais_salida character varying(50),
    fecha_llegada date,
    hora_llegada time without time zone,
    ciudad_llegada character varying(50),
    pais_llegada character varying(50),
    matricula_avion character varying(20),
    aeropuerto_salida_id integer,
    aeropuerto_llegada_id integer,
    estado_vuelo character varying(20) DEFAULT 'programado'::character varying,
    duracion_minutos integer,
    CONSTRAINT chk_duracion_minutos CHECK (((duracion_minutos > 0) AND (duracion_minutos <= 1500))),
    CONSTRAINT chk_estado_vuelo CHECK (((estado_vuelo)::text = ANY ((ARRAY['programado'::character varying, 'abordando'::character varying, 'en_vuelo'::character varying, 'aterrizado'::character varying, 'cancelado'::character varying, 'retrasado'::character varying])::text[]))),
    CONSTRAINT chk_fechas_vuelo CHECK (((fecha_salida < fecha_llegada) OR ((fecha_salida = fecha_llegada) AND (hora_salida < hora_llegada))))
);


ALTER TABLE public.vuelo OWNER TO postgres;

--
-- Name: TABLE vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.vuelo IS 'Tabla que contiene información de vuelos programados y su estado.';


--
-- Name: COLUMN vuelo.numero_vuelo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.numero_vuelo IS 'Código único que identifica el vuelo.';


--
-- Name: COLUMN vuelo.tipo_vuelo_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.tipo_vuelo_id IS 'Referencia al tipo de vuelo del catálogo.';


--
-- Name: COLUMN vuelo.estado; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.estado IS 'Estado actual del vuelo (programado, en vuelo, cancelado, completado).';


--
-- Name: COLUMN vuelo.duracion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.duracion IS 'Tiempo estimado de duración del vuelo.';


--
-- Name: COLUMN vuelo.ciudad_salida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.ciudad_salida IS 'Ciudad de origen del vuelo.';


--
-- Name: COLUMN vuelo.pais_salida; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.pais_salida IS 'País de origen del vuelo.';


--
-- Name: COLUMN vuelo.ciudad_llegada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.ciudad_llegada IS 'Ciudad de destino del vuelo.';


--
-- Name: COLUMN vuelo.pais_llegada; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.pais_llegada IS 'País de destino del vuelo.';


--
-- Name: COLUMN vuelo.aeropuerto_salida_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.aeropuerto_salida_id IS 'Aeropuerto de origen del vuelo.';


--
-- Name: COLUMN vuelo.aeropuerto_llegada_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.vuelo.aeropuerto_llegada_id IS 'Aeropuerto de destino del vuelo.';


--
-- Name: aerolineas aerolineas_razon_social_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolineas
    ADD CONSTRAINT aerolineas_razon_social_key UNIQUE (razon_social);


--
-- Name: correo_aerolineas correo_aerolineas_direccion_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_aerolineas
    ADD CONSTRAINT correo_aerolineas_direccion_correo_key UNIQUE (direccion_correo);


--
-- Name: correo_cliente correo_cliente_direccion_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT correo_cliente_direccion_correo_key UNIQUE (direccion_correo);


--
-- Name: empleado empleado_identificacion_unica_pobla_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_identificacion_unica_pobla_key UNIQUE (identificacion_unica_pobla);


--
-- Name: aerolineas pk_aerolineas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aerolineas
    ADD CONSTRAINT pk_aerolineas PRIMARY KEY (aerolinea_id);


--
-- Name: aeropuerto pk_aeropuerto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeropuerto
    ADD CONSTRAINT pk_aeropuerto PRIMARY KEY (aeropuerto_id);


--
-- Name: avion pk_avion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT pk_avion PRIMARY KEY (matricula_avion);


--
-- Name: boleto pk_boleto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boleto
    ADD CONSTRAINT pk_boleto PRIMARY KEY (boleto_id);


--
-- Name: certificacion_mecanico_aeronave pk_cert_mecanico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_mecanico_aeronave
    ADD CONSTRAINT pk_cert_mecanico PRIMARY KEY (nombre, mecanico_id);


--
-- Name: certificacion_seguridad pk_cert_seguridad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_seguridad
    ADD CONSTRAINT pk_cert_seguridad PRIMARY KEY (nombre, sobrecargo_id);


--
-- Name: certificacion_tipo_aeronave pk_cert_tipo_aeronave; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_tipo_aeronave
    ADD CONSTRAINT pk_cert_tipo_aeronave PRIMARY KEY (nombre, piloto_id);


--
-- Name: cliente pk_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT pk_cliente PRIMARY KEY (cliente_id);


--
-- Name: comprar pk_comprar; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprar
    ADD CONSTRAINT pk_comprar PRIMARY KEY (cliente_id, boleto_id);


--
-- Name: contratar_aerolinea pk_contratar_aerolinea; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aerolinea
    ADD CONSTRAINT pk_contratar_aerolinea PRIMARY KEY (aerolinea_id, empleado_id);


--
-- Name: contratar_aeropuerto pk_contratar_aeropuerto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aeropuerto
    ADD CONSTRAINT pk_contratar_aeropuerto PRIMARY KEY (aeropuerto_id, empleado_id);


--
-- Name: controlador_de_abordaje pk_controlador_abordaje; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_abordaje
    ADD CONSTRAINT pk_controlador_abordaje PRIMARY KEY (empleado_id);


--
-- Name: controlador_de_vuelos pk_controlador_vuelos; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_vuelos
    ADD CONSTRAINT pk_controlador_vuelos PRIMARY KEY (empleado_id);


--
-- Name: correo_aerolineas pk_correo_aerolineas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_aerolineas
    ADD CONSTRAINT pk_correo_aerolineas PRIMARY KEY (aerolinea_id, direccion_correo);


--
-- Name: correo_cliente pk_correo_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT pk_correo_cliente PRIMARY KEY (cliente_id, direccion_correo);


--
-- Name: empleado pk_empleado; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT pk_empleado PRIMARY KEY (empleado_id);


--
-- Name: idioma pk_idioma; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT pk_idioma PRIMARY KEY (nombre, sobrecargo_id);


--
-- Name: mecanico pk_mecanico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanico
    ADD CONSTRAINT pk_mecanico PRIMARY KEY (empleado_id);


--
-- Name: piloto pk_piloto; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT pk_piloto PRIMARY KEY (piloto_id);


--
-- Name: piloto_vuelo pk_piloto_vuelo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto_vuelo
    ADD CONSTRAINT pk_piloto_vuelo PRIMARY KEY (piloto_id, numero_vuelo);


--
-- Name: sobrecargo pk_sobrecargo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sobrecargo
    ADD CONSTRAINT pk_sobrecargo PRIMARY KEY (empleado_id);


--
-- Name: telefono pk_telefono; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT pk_telefono PRIMARY KEY (empleado_id, numero_telefono);


--
-- Name: telefono_aerolineas pk_telefono_aerolineas; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_aerolineas
    ADD CONSTRAINT pk_telefono_aerolineas PRIMARY KEY (aerolinea_id, numero_telefono);


--
-- Name: telefono_cliente pk_telefono_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT pk_telefono_cliente PRIMARY KEY (cliente_id, numero_telefono);


--
-- Name: tipo_vuelo pk_tipo_vuelo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_vuelo
    ADD CONSTRAINT pk_tipo_vuelo PRIMARY KEY (tipo_vuelo_id);


--
-- Name: vuelo pk_vuelo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT pk_vuelo PRIMARY KEY (numero_vuelo);


--
-- Name: telefono_aerolineas telefono_aerolineas_numero_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_aerolineas
    ADD CONSTRAINT telefono_aerolineas_numero_telefono_key UNIQUE (numero_telefono);


--
-- Name: telefono_cliente telefono_cliente_numero_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT telefono_cliente_numero_telefono_key UNIQUE (numero_telefono);


--
-- Name: telefono telefono_numero_telefono_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT telefono_numero_telefono_key UNIQUE (numero_telefono);


--
-- Name: correo_cliente uq_correo_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT uq_correo_cliente UNIQUE (direccion_correo);


--
-- Name: avion fk_avion_aerolinea; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avion
    ADD CONSTRAINT fk_avion_aerolinea FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id) ON DELETE RESTRICT;


--
-- Name: boleto fk_boleto_vuelo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.boleto
    ADD CONSTRAINT fk_boleto_vuelo FOREIGN KEY (numero_vuelo) REFERENCES public.vuelo(numero_vuelo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: certificacion_mecanico_aeronave fk_cert_mec_mecanico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_mecanico_aeronave
    ADD CONSTRAINT fk_cert_mec_mecanico FOREIGN KEY (mecanico_id) REFERENCES public.mecanico(empleado_id);


--
-- Name: certificacion_seguridad fk_cert_seg_sobrecargo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_seguridad
    ADD CONSTRAINT fk_cert_seg_sobrecargo FOREIGN KEY (sobrecargo_id) REFERENCES public.sobrecargo(empleado_id);


--
-- Name: certificacion_tipo_aeronave fk_cert_tipo_piloto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certificacion_tipo_aeronave
    ADD CONSTRAINT fk_cert_tipo_piloto FOREIGN KEY (piloto_id) REFERENCES public.piloto(piloto_id);


--
-- Name: comprar fk_comprar_boleto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprar
    ADD CONSTRAINT fk_comprar_boleto FOREIGN KEY (boleto_id) REFERENCES public.boleto(boleto_id);


--
-- Name: comprar fk_comprar_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comprar
    ADD CONSTRAINT fk_comprar_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contratar_aeropuerto fk_contratar_aero_aeropuerto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aeropuerto
    ADD CONSTRAINT fk_contratar_aero_aeropuerto FOREIGN KEY (aeropuerto_id) REFERENCES public.aeropuerto(aeropuerto_id);


--
-- Name: contratar_aeropuerto fk_contratar_aero_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aeropuerto
    ADD CONSTRAINT fk_contratar_aero_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: contratar_aerolinea fk_contratar_aerolinea_aero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aerolinea
    ADD CONSTRAINT fk_contratar_aerolinea_aero FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id);


--
-- Name: contratar_aerolinea fk_contratar_aerolinea_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contratar_aerolinea
    ADD CONSTRAINT fk_contratar_aerolinea_emp FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: controlador_de_abordaje fk_control_abordaje_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_abordaje
    ADD CONSTRAINT fk_control_abordaje_emp FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: controlador_de_vuelos fk_control_vuelos_emp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.controlador_de_vuelos
    ADD CONSTRAINT fk_control_vuelos_emp FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: correo_aerolineas fk_correo_aerolineas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_aerolineas
    ADD CONSTRAINT fk_correo_aerolineas FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id);


--
-- Name: correo_cliente fk_correo_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.correo_cliente
    ADD CONSTRAINT fk_correo_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- Name: idioma fk_idioma_sobrecargo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idioma
    ADD CONSTRAINT fk_idioma_sobrecargo FOREIGN KEY (sobrecargo_id) REFERENCES public.sobrecargo(empleado_id);


--
-- Name: mecanico fk_mecanico_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mecanico
    ADD CONSTRAINT fk_mecanico_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: piloto fk_piloto_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT fk_piloto_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: piloto_vuelo fk_pilotovuelo_piloto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto_vuelo
    ADD CONSTRAINT fk_pilotovuelo_piloto FOREIGN KEY (piloto_id) REFERENCES public.piloto(piloto_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: piloto_vuelo fk_pilotovuelo_vuelo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.piloto_vuelo
    ADD CONSTRAINT fk_pilotovuelo_vuelo FOREIGN KEY (numero_vuelo) REFERENCES public.vuelo(numero_vuelo);


--
-- Name: sobrecargo fk_sobrecargo_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sobrecargo
    ADD CONSTRAINT fk_sobrecargo_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: telefono_aerolineas fk_tel_aerolineas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_aerolineas
    ADD CONSTRAINT fk_tel_aerolineas FOREIGN KEY (aerolinea_id) REFERENCES public.aerolineas(aerolinea_id);


--
-- Name: telefono_cliente fk_tel_cliente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono_cliente
    ADD CONSTRAINT fk_tel_cliente FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);


--
-- Name: telefono fk_telefono_empleado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telefono
    ADD CONSTRAINT fk_telefono_empleado FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: vuelo fk_vuelo_aeropuerto_llegada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_aeropuerto_llegada FOREIGN KEY (aeropuerto_llegada_id) REFERENCES public.aeropuerto(aeropuerto_id);


--
-- Name: vuelo fk_vuelo_aeropuerto_salida; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_aeropuerto_salida FOREIGN KEY (aeropuerto_salida_id) REFERENCES public.aeropuerto(aeropuerto_id);


--
-- Name: vuelo fk_vuelo_avion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_avion FOREIGN KEY (matricula_avion) REFERENCES public.avion(matricula_avion) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: vuelo fk_vuelo_tipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vuelo
    ADD CONSTRAINT fk_vuelo_tipo FOREIGN KEY (tipo_vuelo_id) REFERENCES public.tipo_vuelo(tipo_vuelo_id);


--
-- PostgreSQL database dump complete
--

\unrestrict Ngss9u0h4GbqTH1k9qQXkvRFxfuxX9vtU3EAAS2avJxUe5G9qoD4rhAOq1omoyS

