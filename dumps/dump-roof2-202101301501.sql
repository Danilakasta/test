--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.5

-- Started on 2021-01-30 15:01:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16888)
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id bigint NOT NULL,
    bank_name character varying(255) NOT NULL,
    bik integer NOT NULL,
    code integer,
    corr_account character varying(20) NOT NULL,
    depart_address character varying(255),
    inn integer NOT NULL,
    value character varying(20) NOT NULL,
    contractor_id bigint NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16896)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16901)
-- Name: contractors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contractors (
    id bigint NOT NULL,
    contractor_sub_type integer,
    delivery_address character varying(255),
    email character varying(255),
    fiz_address character varying(255),
    inn integer,
    kpp integer,
    name character varying(255),
    ogrn integer,
    okpo integer,
    phone character varying(255),
    type integer,
    ur_address character varying(255)
);


ALTER TABLE public.contractors OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16909)
-- Name: forbidden_size; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forbidden_size (
    id bigint NOT NULL,
    created timestamp without time zone,
    modified timestamp without time zone,
    value_from double precision,
    value_to double precision,
    machine_id bigint,
    product_id bigint,
    user_id bigint
);


ALTER TABLE public.forbidden_size OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17041)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16914)
-- Name: history_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.history_item (
    id bigint NOT NULL,
    message character varying(255),
    new_state integer,
    "timestamp" timestamp without time zone,
    created_by_id bigint,
    history_order integer
);


ALTER TABLE public.history_item OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16919)
-- Name: machine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine (
    id bigint NOT NULL,
    length integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.machine OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16924)
-- Name: machine_width; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.machine_width (
    machine_id bigint NOT NULL,
    width_id bigint NOT NULL
);


ALTER TABLE public.machine_width OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16929)
-- Name: material_color; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material_color (
    id bigint NOT NULL,
    color character varying(255),
    created timestamp without time zone,
    modified timestamp without time zone,
    name character varying(255),
    user_id bigint
);


ALTER TABLE public.material_color OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16937)
-- Name: materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materials (
    id bigint NOT NULL,
    cover integer NOT NULL,
    created timestamp without time zone,
    fact_coefficient double precision,
    length integer NOT NULL,
    manufacturer character varying(255) NOT NULL,
    material_class integer NOT NULL,
    material_color integer,
    modified timestamp without time zone,
    party character varying(255) NOT NULL,
    price double precision NOT NULL,
    price_delivery double precision NOT NULL,
    price_one_metre double precision,
    price_one_tone double precision NOT NULL,
    remains double precision,
    serial_number integer NOT NULL,
    teor_coefficient double precision,
    used double precision,
    weight_of_bay double precision NOT NULL,
    width_fact double precision NOT NULL,
    width_id bigint
);


ALTER TABLE public.materials OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16945)
-- Name: order_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_info (
    id bigint NOT NULL,
    created timestamp without time zone,
    discount integer,
    done timestamp without time zone,
    due_date date NOT NULL,
    due_time time without time zone NOT NULL,
    modified timestamp without time zone,
    order_type integer,
    parent_id bigint,
    state integer,
    wp_order_id bigint,
    customer_id bigint NOT NULL,
    pickup_location_id bigint NOT NULL
);


ALTER TABLE public.order_info OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16950)
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    id bigint NOT NULL,
    comment character varying(255),
    created timestamp without time zone,
    done timestamp without time zone,
    height double precision,
    material_class integer,
    material_color integer,
    material_cover integer,
    modified timestamp without time zone,
    order_id bigint,
    order_type integer,
    total_price double precision NOT NULL,
    quantity integer,
    size character varying(255),
    state integer,
    product_id bigint,
    width_id bigint,
    CONSTRAINT order_item_height_check CHECK ((height <= (12)::double precision)),
    CONSTRAINT order_item_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16960)
-- Name: order_item_manufacture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item_manufacture (
    id bigint NOT NULL,
    comment character varying(255),
    created timestamp without time zone,
    done timestamp without time zone,
    height double precision,
    material_class integer,
    material_color integer,
    material_cover integer,
    modified timestamp without time zone,
    order_type integer,
    total_price double precision NOT NULL,
    quantity double precision,
    size character varying(255),
    state integer,
    order_id bigint,
    product_id bigint,
    width_id bigint,
    CONSTRAINT order_item_manufacture_quantity_check CHECK ((quantity >= (1)::double precision))
);


ALTER TABLE public.order_item_manufacture OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16969)
-- Name: pickup_location; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickup_location (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.pickup_location OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16974)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id bigint NOT NULL,
    cargo_type integer,
    category character varying(255),
    name character varying(255),
    price double precision,
    second_title character varying(255),
    square_meters double precision,
    title character varying(255),
    type integer,
    width double precision
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16982)
-- Name: product_amount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_amount (
    id bigint NOT NULL,
    material_class integer,
    material_cover integer,
    price double precision,
    self_price double precision,
    width_id bigint,
    CONSTRAINT product_amount_price_check CHECK (((price >= (1)::double precision) AND (price <= (1000)::double precision)))
);


ALTER TABLE public.product_amount OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16988)
-- Name: site_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_category (
    id bigint NOT NULL,
    created timestamp without time zone,
    img_path character varying(255),
    key character varying(255),
    modified timestamp without time zone,
    title character varying(255),
    url character varying(255),
    parent_id bigint
);


ALTER TABLE public.site_category OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16996)
-- Name: site_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.site_product (
    id bigint NOT NULL,
    created timestamp without time zone,
    full_price character varying(255),
    img_path character varying(255),
    modified timestamp without time zone,
    path character varying(255),
    price character varying(255),
    prop character varying(255),
    site_name character varying(255),
    title character varying(255),
    category_id bigint
);


ALTER TABLE public.site_product OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17004)
-- Name: trimming; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trimming (
    id bigint NOT NULL,
    created timestamp without time zone,
    modified timestamp without time zone,
    value double precision,
    user_id bigint,
    width_id bigint
);


ALTER TABLE public.trimming OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17009)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    locked boolean NOT NULL,
    password_hash character varying(255),
    role integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17017)
-- Name: warehouse_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouse_item (
    id bigint NOT NULL,
    comment character varying(255),
    quantity integer,
    state integer,
    machine_id bigint,
    material_id bigint,
    order_item_id bigint,
    product_id bigint,
    warehouse_type_id bigint,
    CONSTRAINT warehouse_item_quantity_check CHECK ((quantity >= 1))
);


ALTER TABLE public.warehouse_item OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17023)
-- Name: warehouse_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warehouse_type (
    id bigint NOT NULL,
    created timestamp without time zone,
    description character varying(255),
    modified timestamp without time zone,
    name character varying(255),
    user_id bigint
);


ALTER TABLE public.warehouse_type OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17031)
-- Name: width; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.width (
    id bigint NOT NULL,
    created timestamp without time zone,
    modified timestamp without time zone,
    value double precision,
    user_id bigint
);


ALTER TABLE public.width OWNER TO postgres;

--
-- TOC entry 2991 (class 0 OID 16888)
-- Dependencies: 202
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2992 (class 0 OID 16896)
-- Dependencies: 203
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2993 (class 0 OID 16901)
-- Dependencies: 204
-- Data for Name: contractors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.contractors VALUES (1, 0, NULL, NULL, NULL, NULL, NULL, ' (замена бракованной продукции)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2, 0, NULL, NULL, NULL, NULL, NULL, ' ГСС К ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3, 0, NULL, NULL, NULL, NULL, 910201001, '«АВТОР-ДОМ», Виктор ', NULL, NULL, '7 910 158 9115_Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (4, 0, NULL, NULL, NULL, NULL, 910801001, '«ДИК» _ Максим ', NULL, NULL, '7 978 585 0776_Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (5, 0, NULL, NULL, NULL, NULL, 910901001, '«СТРОИТЕЛЬНАЯ КОМПАНИЯ-ЛИДЕР», Левон ', NULL, NULL, '7 917 981 6962_Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (6, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '79788040015 Лена физ лицо от Виталия', 0, NULL);
INSERT INTO public.contractors VALUES (7, 0, NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (8, 0, NULL, NULL, NULL, NULL, NULL, '21 Век Севастополь (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (9, 0, NULL, NULL, NULL, NULL, NULL, 'Azes81@mail.ru  ', NULL, NULL, '7  978 747 1501', 0, NULL);
INSERT INTO public.contractors VALUES (10, 0, NULL, NULL, NULL, NULL, NULL, 'ROOF МОНТАЖ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (11, 1, NULL, NULL, NULL, NULL, NULL, 'Абажер И.И. ', NULL, NULL, '7 978 743 43 44', 0, NULL);
INSERT INTO public.contractors VALUES (12, 1, NULL, NULL, NULL, NULL, NULL, 'Аббасов Г.Н. ', NULL, NULL, '7 978 75 53 183', 0, NULL);
INSERT INTO public.contractors VALUES (13, 1, NULL, NULL, NULL, NULL, NULL, 'Абдулаев Л.А. ', NULL, NULL, '7978 70 14 222', 0, NULL);
INSERT INTO public.contractors VALUES (14, 0, NULL, NULL, NULL, NULL, NULL, 'Абдулкеримов  (Евпатория) -А. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (15, 1, NULL, NULL, NULL, NULL, NULL, 'Абдуллаев Азиз Рефатович ', NULL, NULL, '7 978 789 67 27', 0, NULL);
INSERT INTO public.contractors VALUES (16, 0, NULL, NULL, NULL, NULL, NULL, 'Абдуллаев Куртсеид ', NULL, NULL, ' 7978 040 80 31', 0, NULL);
INSERT INTO public.contractors VALUES (17, 1, NULL, NULL, NULL, NULL, NULL, 'Абдуллаев РТ 79788380710', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (18, 1, NULL, NULL, NULL, NULL, NULL, 'Абдуллаева СО 79787862022', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (19, 0, NULL, NULL, NULL, NULL, NULL, 'Абдульвапов Аметхан ', NULL, NULL, '7978 884 03 06', 0, NULL);
INSERT INTO public.contractors VALUES (20, 1, NULL, NULL, NULL, NULL, NULL, 'Абдульвапов Н.Р. ', NULL, NULL, '7978 04 17 051', 0, NULL);
INSERT INTO public.contractors VALUES (21, 1, NULL, NULL, NULL, NULL, NULL, 'Абдумеджитов ', NULL, NULL, '7 978 049 88 80', 0, NULL);
INSERT INTO public.contractors VALUES (22, 1, NULL, NULL, NULL, NULL, NULL, 'Абдураимов Арсен ', NULL, NULL, '7978 860 83 51', 0, NULL);
INSERT INTO public.contractors VALUES (23, 0, NULL, NULL, NULL, NULL, NULL, 'Абдураимов Ридван ', NULL, NULL, '7 978 70 26 992', 0, NULL);
INSERT INTO public.contractors VALUES (24, 1, NULL, NULL, NULL, NULL, NULL, 'Абдураимов Э.Р. ', NULL, NULL, '7 978 049 83 12', 0, NULL);
INSERT INTO public.contractors VALUES (25, 1, NULL, NULL, NULL, NULL, NULL, 'Абдураимов Эскендер ', NULL, NULL, '7978 728 65 77', 0, NULL);
INSERT INTO public.contractors VALUES (26, 1, NULL, NULL, NULL, NULL, NULL, 'Абдураманов Д.Ш. ', NULL, NULL, '79788386770', 0, NULL);
INSERT INTO public.contractors VALUES (27, 0, NULL, NULL, NULL, NULL, NULL, 'Абдураманов З.З. ', NULL, NULL, '7978 803 16 41', 0, NULL);
INSERT INTO public.contractors VALUES (28, 1, NULL, NULL, NULL, NULL, NULL, 'Абдураманов Эмиль (Евпатория) д.п.-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (29, 1, NULL, NULL, NULL, NULL, NULL, 'Абдурахманов Ф.Р. ', NULL, NULL, '79785516921', 0, NULL);
INSERT INTO public.contractors VALUES (30, 1, NULL, NULL, NULL, NULL, NULL, 'Абдурашитов И.С. ', NULL, NULL, '7 978 706 98 31', 0, NULL);
INSERT INTO public.contractors VALUES (31, 0, NULL, NULL, NULL, NULL, NULL, 'Абдурашитов Рефат ', NULL, NULL, '79787079598', 0, NULL);
INSERT INTO public.contractors VALUES (32, 0, NULL, NULL, NULL, NULL, NULL, 'Абдусаттаров Ленмар ', NULL, NULL, '7 978 834 06 68', 0, NULL);
INSERT INTO public.contractors VALUES (33, 1, NULL, NULL, NULL, NULL, NULL, 'Абельторов Р.Р. ', NULL, NULL, '79788455453', 0, NULL);
INSERT INTO public.contractors VALUES (34, 0, NULL, NULL, NULL, NULL, NULL, 'Абибулаев Дилявер ', NULL, NULL, '7 978 079 19 66', 0, NULL);
INSERT INTO public.contractors VALUES (35, 1, NULL, NULL, NULL, NULL, NULL, 'Абибулаев Л.Н. ', NULL, NULL, '7 978 734 02 05', 0, NULL);
INSERT INTO public.contractors VALUES (36, 1, NULL, NULL, NULL, NULL, NULL, 'Абибулаев Ленур 79787340205', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (37, 1, NULL, NULL, NULL, NULL, NULL, 'Абибулаев РШ79787078634', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (38, 1, NULL, NULL, NULL, NULL, NULL, 'Абибулаев РЭ 79788570524', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (39, 1, NULL, NULL, NULL, NULL, NULL, 'Абибулаев С.Х. ', NULL, NULL, '7 978 00 40 146', 0, NULL);
INSERT INTO public.contractors VALUES (40, 0, NULL, NULL, NULL, NULL, NULL, 'Абибуллаев Р.А. ', NULL, NULL, '79788570524', 0, NULL);
INSERT INTO public.contractors VALUES (41, 1, NULL, NULL, NULL, NULL, NULL, 'Абиев РЗ 79788064272', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (42, 0, NULL, NULL, NULL, NULL, NULL, 'Абилтаров Ресуль ', NULL, NULL, '7 978 78 74 562', 0, NULL);
INSERT INTO public.contractors VALUES (43, 1, NULL, NULL, NULL, NULL, NULL, 'Абильтаров Э.А. ', NULL, NULL, '79787037357', 0, NULL);
INSERT INTO public.contractors VALUES (44, 1, NULL, NULL, NULL, NULL, NULL, 'Абитаров А.З. ', NULL, NULL, '7 978 0 111 875', 0, NULL);
INSERT INTO public.contractors VALUES (45, 1, NULL, NULL, NULL, NULL, NULL, 'Абитаров Р.Р. ', NULL, NULL, '7 978 845 54 53', 0, NULL);
INSERT INTO public.contractors VALUES (46, 1, NULL, NULL, NULL, NULL, NULL, 'Абкадыров Р.Р. ', NULL, NULL, '7 978 040 61 14', 0, NULL);
INSERT INTO public.contractors VALUES (47, 0, NULL, NULL, NULL, NULL, NULL, 'Аблаев Айдер ', NULL, NULL, '7 978 88 41 180', 0, NULL);
INSERT INTO public.contractors VALUES (48, 0, NULL, NULL, NULL, NULL, NULL, 'Аблаев Н.Ш. ', NULL, NULL, '7 978 863 11 87', 0, NULL);
INSERT INTO public.contractors VALUES (49, 2, NULL, NULL, NULL, NULL, NULL, 'Аблаев Нурзет  (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (50, 1, NULL, NULL, NULL, NULL, NULL, 'Аблаев С.А. ', NULL, NULL, '79787907300', 0, NULL);
INSERT INTO public.contractors VALUES (51, 0, NULL, NULL, NULL, NULL, NULL, 'Аблаев Сервер ', NULL, NULL, '7 918 10 11 918', 0, NULL);
INSERT INTO public.contractors VALUES (52, 1, NULL, NULL, NULL, NULL, NULL, 'Аблаев Э.С. ', NULL, NULL, '7 978 850 30 90', 0, NULL);
INSERT INTO public.contractors VALUES (53, 1, NULL, NULL, NULL, NULL, NULL, 'Аблаев Эрнест ', NULL, NULL, '7978 7033 244', 0, NULL);
INSERT INTO public.contractors VALUES (54, 1, NULL, NULL, NULL, NULL, NULL, 'Аблаева З.Р. ', NULL, NULL, '79787280755', 0, NULL);
INSERT INTO public.contractors VALUES (55, 1, NULL, NULL, NULL, NULL, NULL, 'Аблимичитов Рустем 8978 856 06 96', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (56, 1, NULL, NULL, NULL, NULL, NULL, 'Аблязизов ИА 79788598434', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (57, 0, NULL, NULL, NULL, NULL, NULL, 'Аблязизова Ленура ', NULL, NULL, '79781147853 ', 0, NULL);
INSERT INTO public.contractors VALUES (58, 0, NULL, NULL, NULL, NULL, NULL, 'Аблязов М.М. ', NULL, NULL, '79781171540', 0, NULL);
INSERT INTO public.contractors VALUES (59, 1, NULL, NULL, NULL, NULL, NULL, 'Аблязов Руслан ', NULL, NULL, '7 978 84 29 941', 0, NULL);
INSERT INTO public.contractors VALUES (60, 1, NULL, NULL, NULL, NULL, NULL, 'Аблязова ЛН 79788279360', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (61, 2, NULL, NULL, NULL, NULL, NULL, 'Аблякимов Айдер (Джанкой)  ', NULL, NULL, '7978 738-52-83-А.', 0, NULL);
INSERT INTO public.contractors VALUES (62, 1, NULL, NULL, NULL, NULL, NULL, 'Аблякимов Айдер ', NULL, NULL, '7 978 706 52 77', 0, NULL);
INSERT INTO public.contractors VALUES (63, 1, NULL, NULL, NULL, NULL, NULL, 'Аблякимов Р.А. ', NULL, NULL, '7 978 0285837', 0, NULL);
INSERT INTO public.contractors VALUES (64, 1, NULL, NULL, NULL, NULL, NULL, 'Аблякимов Р.К. ', NULL, NULL, '7 978 79 14 550', 0, NULL);
INSERT INTO public.contractors VALUES (65, 0, NULL, NULL, NULL, NULL, NULL, 'Аблялимов Арсен ', NULL, NULL, '7 978 26 37 720', 0, NULL);
INSERT INTO public.contractors VALUES (66, 1, NULL, NULL, NULL, NULL, NULL, 'Аблялимов Ахтем ', NULL, NULL, '7 978 830 87 89', 0, NULL);
INSERT INTO public.contractors VALUES (67, 0, NULL, NULL, NULL, NULL, NULL, 'Абляметов Ленур (д.п.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (68, 0, NULL, NULL, NULL, NULL, NULL, 'Аблямитов Эскендер ', NULL, NULL, '7 978 856 49 06', 0, NULL);
INSERT INTO public.contractors VALUES (69, 0, NULL, NULL, NULL, NULL, NULL, 'Аблясизов Шамиль ', NULL, NULL, '7 978 71 59 873', 0, NULL);
INSERT INTO public.contractors VALUES (70, 1, NULL, NULL, NULL, NULL, NULL, 'Аблятифов М.Н. ', NULL, NULL, '7 978 835 02 76', 0, NULL);
INSERT INTO public.contractors VALUES (71, 0, NULL, NULL, NULL, NULL, NULL, 'Абражиев В.Г. ', NULL, NULL, '79787460240', 0, NULL);
INSERT INTO public.contractors VALUES (72, 2, NULL, NULL, NULL, NULL, NULL, 'Абраменко Владислав Геннадьевич ( Рада ) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (73, 0, NULL, NULL, NULL, NULL, NULL, 'Абрамов Александр ', NULL, NULL, '79782103292', 0, NULL);
INSERT INTO public.contractors VALUES (74, 1, NULL, NULL, NULL, NULL, NULL, 'Абрамчук А.А. ', NULL, NULL, '7978 769 05 10', 0, NULL);
INSERT INTO public.contractors VALUES (75, 1, NULL, NULL, NULL, NULL, NULL, 'Абросимов Александр ', NULL, NULL, '7 978 879 22 48', 0, NULL);
INSERT INTO public.contractors VALUES (76, 1, NULL, NULL, NULL, NULL, NULL, 'Абросимов Ю.И. ', NULL, NULL, '7 978 913 88 13', 0, NULL);
INSERT INTO public.contractors VALUES (77, 0, NULL, NULL, NULL, NULL, NULL, 'Абсалямов ', NULL, NULL, '7 978 751 17 15', 0, NULL);
INSERT INTO public.contractors VALUES (78, 0, NULL, NULL, NULL, NULL, NULL, 'Абултаров С.Ю.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (79, 0, NULL, NULL, NULL, NULL, NULL, 'Авагян Гагик ', NULL, NULL, '7 978 860 57 71 (72)', 0, NULL);
INSERT INTO public.contractors VALUES (80, 1, NULL, NULL, NULL, NULL, NULL, 'Авакян ВВ 79787513207', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (81, 1, NULL, NULL, NULL, NULL, NULL, 'Авамилов Рефат Шевкетович ', NULL, NULL, '7978 78 55 766', 0, NULL);
INSERT INTO public.contractors VALUES (82, 1, NULL, NULL, NULL, NULL, NULL, 'Аверьянов Е ', NULL, NULL, '79787249030', 0, NULL);
INSERT INTO public.contractors VALUES (83, 1, NULL, NULL, NULL, NULL, NULL, 'Аверьянов И ', NULL, NULL, '79781004597', 0, NULL);
INSERT INTO public.contractors VALUES (84, 0, NULL, NULL, NULL, NULL, NULL, 'Аветисян Гарик ', NULL, NULL, ' 7978 840 59 79', 0, NULL);
INSERT INTO public.contractors VALUES (85, 0, NULL, NULL, NULL, NULL, NULL, 'Авиамонтаж Андрашов Александр Леонидович ', NULL, NULL, '7 978 841 6150', 0, NULL);
INSERT INTO public.contractors VALUES (86, 1, NULL, NULL, NULL, NULL, NULL, 'Авраменко ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (87, 0, NULL, NULL, NULL, NULL, NULL, 'Авторгуп Крым ООО ', NULL, NULL, '79781079007 Игорь Петрович', 0, NULL);
INSERT INTO public.contractors VALUES (88, 1, NULL, NULL, NULL, NULL, NULL, 'Агавелян Роман Александрович ', NULL, NULL, '7978 70 88 003', 0, NULL);
INSERT INTO public.contractors VALUES (89, 1, NULL, NULL, NULL, NULL, NULL, 'Агапов А.К. ', NULL, NULL, '7 978 815 04 19', 0, NULL);
INSERT INTO public.contractors VALUES (90, 1, NULL, NULL, NULL, NULL, NULL, 'Агафонов АВ 79787170459', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (91, 0, NULL, NULL, NULL, NULL, NULL, 'Агеев А.В. ', NULL, NULL, '7 978 840 87 04', 0, NULL);
INSERT INTO public.contractors VALUES (92, 0, NULL, NULL, NULL, NULL, NULL, 'Агеев Марат ', NULL, NULL, '7 918 345 07 67', 0, NULL);
INSERT INTO public.contractors VALUES (93, 1, NULL, NULL, NULL, NULL, NULL, 'Агеносова АМ 9176569444', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (94, 0, NULL, NULL, NULL, NULL, NULL, 'Агровера Сергей ', NULL, NULL, '7 978 72 22 564', 0, NULL);
INSERT INTO public.contractors VALUES (95, 0, NULL, NULL, NULL, NULL, NULL, 'АгроСпецМеханизация 8989 855 05 17 Сергей ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (96, 0, NULL, NULL, NULL, NULL, NULL, 'Адейкин ', NULL, NULL, '7 978 740 35 63', 0, NULL);
INSERT INTO public.contractors VALUES (97, 1, NULL, NULL, NULL, NULL, NULL, 'Адельсеитова АБ 79787918976', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (98, 0, NULL, NULL, NULL, NULL, NULL, 'Аджи Алимов ЧП (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (99, 1, NULL, NULL, NULL, NULL, NULL, 'Аджиаблаев ', NULL, NULL, '7 978 830 64 49', 0, NULL);
INSERT INTO public.contractors VALUES (100, 1, NULL, NULL, NULL, NULL, NULL, 'Аджиаблаев Руслан ', NULL, NULL, '7 978 832 72 42', 0, NULL);
INSERT INTO public.contractors VALUES (101, 1, NULL, NULL, NULL, NULL, NULL, 'Аджиаметов Рустем ', NULL, NULL, '7 978 852 00 19', 0, NULL);
INSERT INTO public.contractors VALUES (102, 1, NULL, NULL, NULL, NULL, NULL, 'Аджигафаров Э.С. ', NULL, NULL, '7978 836 13 39', 0, NULL);
INSERT INTO public.contractors VALUES (103, 1, NULL, NULL, NULL, NULL, NULL, 'Аджимамбетов 79787900629', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (104, 1, NULL, NULL, NULL, NULL, NULL, 'Аджимамбетов РС 79788722305', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (105, 1, NULL, NULL, NULL, NULL, NULL, 'Аджиумеров Н.А. ', NULL, NULL, '7 978 743 79 36', 0, NULL);
INSERT INTO public.contractors VALUES (106, 0, NULL, NULL, NULL, NULL, NULL, 'Адиль Асанов ', NULL, NULL, '7 978 787 52 00', 0, NULL);
INSERT INTO public.contractors VALUES (107, 1, NULL, NULL, NULL, NULL, NULL, 'Адильшаев Р.К. ', NULL, NULL, '7978 707 84 17', 0, NULL);
INSERT INTO public.contractors VALUES (108, 0, NULL, NULL, NULL, NULL, NULL, 'Админора ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (109, 1, NULL, NULL, NULL, NULL, NULL, 'Аетдинов 79788379216', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (110, 0, NULL, NULL, NULL, NULL, NULL, 'Аетдинов Вильдан Хайретдинович ', NULL, NULL, '79788379216', 0, NULL);
INSERT INTO public.contractors VALUES (111, 1, NULL, NULL, NULL, NULL, NULL, 'Азаматов Ш.Э. ', NULL, NULL, '79781389331', 0, NULL);
INSERT INTO public.contractors VALUES (112, 1, NULL, NULL, NULL, NULL, NULL, 'Азаров А.Л. ', NULL, NULL, '7 9788391120', 0, NULL);
INSERT INTO public.contractors VALUES (113, 2, NULL, NULL, NULL, NULL, NULL, 'Азбука ремонта  Хафизов Эмиль Ахмедович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (114, 0, NULL, NULL, NULL, NULL, NULL, 'Азиз', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (115, 0, NULL, NULL, NULL, NULL, NULL, 'Азиз СТК ', NULL, NULL, '7978 703 05 50', 0, NULL);
INSERT INTO public.contractors VALUES (116, 1, NULL, NULL, NULL, NULL, NULL, 'Азизов Руслан ', NULL, NULL, '7 978 024 37 50', 0, NULL);
INSERT INTO public.contractors VALUES (117, 2, NULL, NULL, NULL, NULL, NULL, 'Айвазов Л. Э. - А', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (118, 0, NULL, NULL, NULL, NULL, NULL, 'Айдер ', NULL, NULL, '7978 799 55 70', 0, NULL);
INSERT INTO public.contractors VALUES (119, 0, NULL, NULL, NULL, NULL, NULL, 'Айдер Евпатория ', NULL, NULL, '79787262158', 0, NULL);
INSERT INTO public.contractors VALUES (120, 1, NULL, NULL, NULL, NULL, NULL, 'Акабян ЭД 79780366965', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (121, 0, NULL, NULL, NULL, NULL, 910201001, '"АКАМАС"" _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (122, 1, NULL, NULL, NULL, NULL, NULL, 'Акапян А.Д. ', NULL, NULL, '7978 70 87 500', 0, NULL);
INSERT INTO public.contractors VALUES (123, 0, NULL, NULL, NULL, NULL, NULL, 'Аквапрув 79788305285 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (124, 0, NULL, NULL, NULL, NULL, 910201001, '"АКВАПРУВ"" _Дмитрий ', NULL, NULL, '7 978 707 81 23 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (125, 1, NULL, NULL, NULL, NULL, NULL, 'Акимов А.Е. ', NULL, NULL, '79780627877', 0, NULL);
INSERT INTO public.contractors VALUES (126, 1, NULL, NULL, NULL, NULL, NULL, 'Акимов М.М. ', NULL, NULL, '7 978 865 54 05', 0, NULL);
INSERT INTO public.contractors VALUES (127, 1, NULL, NULL, NULL, NULL, NULL, 'Акимов М.Х. ', NULL, NULL, '7 978 79 141 16', 0, NULL);
INSERT INTO public.contractors VALUES (128, 1, NULL, NULL, NULL, NULL, NULL, 'Акимов РН 79788974452', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (129, 0, NULL, NULL, NULL, NULL, NULL, 'Акимова Л.А. ', NULL, NULL, '7 978 523 5025', 0, NULL);
INSERT INTO public.contractors VALUES (130, 1, NULL, NULL, NULL, NULL, NULL, 'Акиньшин СВ 79787113881', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (131, 0, NULL, NULL, NULL, NULL, NULL, 'Акопджанян М.В. ', NULL, NULL, '7978 851 76 84', 0, NULL);
INSERT INTO public.contractors VALUES (132, 0, NULL, NULL, NULL, NULL, NULL, 'Аксенов Владисла Сергеевич ', NULL, NULL, '79114756500', 0, NULL);
INSERT INTO public.contractors VALUES (133, 1, NULL, NULL, NULL, NULL, NULL, 'Акульев А.И. ', NULL, NULL, '7978 881 65 53', 0, NULL);
INSERT INTO public.contractors VALUES (134, 0, NULL, NULL, NULL, NULL, 230901001, 'АЛВЕР ООО - А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (135, 1, NULL, NULL, NULL, NULL, NULL, 'Алдошин В.В. ', NULL, NULL, '79787730384', 0, NULL);
INSERT INTO public.contractors VALUES (136, 0, NULL, NULL, NULL, NULL, NULL, 'Алдушин Владимир Федорович ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (137, 0, NULL, NULL, NULL, NULL, NULL, 'Александр ', NULL, NULL, '79787675695', 0, NULL);
INSERT INTO public.contractors VALUES (138, 1, NULL, NULL, NULL, NULL, NULL, 'Александр 79787292707', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (139, 0, NULL, NULL, NULL, NULL, NULL, 'Александр Дача Строй (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (140, 0, NULL, NULL, NULL, NULL, NULL, 'Александр Евгеньевич Golub_krimea@mail.ru', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (141, 1, NULL, NULL, NULL, NULL, NULL, 'Александр И. 8-978-8464-565', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (142, 1, NULL, NULL, NULL, NULL, NULL, 'Александр от Влада ', NULL, NULL, '79787362455', 0, NULL);
INSERT INTO public.contractors VALUES (143, 0, NULL, NULL, NULL, NULL, NULL, 'Александра  _ ', NULL, NULL, '7 978 825 73 91 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (144, 1, NULL, NULL, NULL, NULL, NULL, 'Александров ДВ 79788005548', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (145, 1, NULL, NULL, NULL, NULL, NULL, 'Александров ЮБ ', NULL, NULL, '79788717574', 0, NULL);
INSERT INTO public.contractors VALUES (146, 1, NULL, NULL, NULL, NULL, NULL, 'Александрова Марина ', NULL, NULL, '7 978 74 152 33', 0, NULL);
INSERT INTO public.contractors VALUES (147, 1, NULL, NULL, NULL, NULL, NULL, 'Алексеев ИВ 79785554848', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (148, 1, NULL, NULL, NULL, NULL, NULL, 'Алексей Кровельщик', NULL, NULL, '7978 027 75 20', 0, NULL);
INSERT INTO public.contractors VALUES (149, 1, NULL, NULL, NULL, NULL, NULL, 'Алексей Платинное ', NULL, NULL, '7 978 872 18 97', 0, NULL);
INSERT INTO public.contractors VALUES (150, 1, NULL, NULL, NULL, NULL, NULL, 'Алексейчик А.Я. ', NULL, NULL, '7 978 046 15 29', 0, NULL);
INSERT INTO public.contractors VALUES (151, 0, NULL, NULL, NULL, NULL, NULL, 'Алеф-Виналь-Крым  ', NULL, NULL, '7 978 560 38 33 Денис ООО', 0, NULL);
INSERT INTO public.contractors VALUES (152, 0, NULL, NULL, NULL, NULL, NULL, 'Алехин Борис ', NULL, NULL, '7 978 78 36 199', 0, NULL);
INSERT INTO public.contractors VALUES (153, 0, NULL, NULL, NULL, NULL, NULL, 'Алещенкова Л.А. ', NULL, NULL, '7 978 71 98 264', 0, NULL);
INSERT INTO public.contractors VALUES (154, 0, NULL, NULL, NULL, NULL, NULL, 'Алиакберов Радий ', NULL, NULL, '7926 88 44 798', 0, NULL);
INSERT INTO public.contractors VALUES (155, 1, NULL, NULL, NULL, NULL, NULL, 'Алибутаев Эдуард ', NULL, NULL, '7978 784 38 17-А.', 0, NULL);
INSERT INTO public.contractors VALUES (156, 1, NULL, NULL, NULL, NULL, NULL, 'Алиев А,С, ', NULL, NULL, '79780240817', 0, NULL);
INSERT INTO public.contractors VALUES (157, 1, NULL, NULL, NULL, NULL, NULL, 'Алиев АЭ 89884561594', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (158, 1, NULL, NULL, NULL, NULL, NULL, 'Алиев Н.К. ', NULL, NULL, '7978 073 0 888', 0, NULL);
INSERT INTO public.contractors VALUES (159, 0, NULL, NULL, NULL, NULL, NULL, 'Алиев Элшад ', NULL, NULL, '7 978 730 81 37', 0, NULL);
INSERT INTO public.contractors VALUES (160, 1, NULL, NULL, NULL, NULL, NULL, 'Алиев Эмиль ', NULL, NULL, '7978 86 24 071', 0, NULL);
INSERT INTO public.contractors VALUES (161, 1, NULL, NULL, NULL, NULL, NULL, 'Алиев ЭЧ 79788782477', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (162, 1, NULL, NULL, NULL, NULL, NULL, 'Алимджанов АЭ 79788548252', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (163, 1, NULL, NULL, NULL, NULL, NULL, 'Алимов Исмаил ', NULL, NULL, '7 918 034 06 22', 0, NULL);
INSERT INTO public.contractors VALUES (164, 1, NULL, NULL, NULL, NULL, NULL, 'Алисов А.И. ', NULL, NULL, '7 978 859 22 21', 0, NULL);
INSERT INTO public.contractors VALUES (165, 0, NULL, NULL, NULL, NULL, NULL, 'АЛМИ  ', NULL, NULL, '7-978-101-25-98 И. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (166, 1, NULL, NULL, NULL, NULL, NULL, 'Алонов А.Г. ', NULL, NULL, '7 978 551 37 07', 0, NULL);
INSERT INTO public.contractors VALUES (167, 1, NULL, NULL, NULL, NULL, NULL, 'Алоян А.Р. ', NULL, NULL, '79785722227', 0, NULL);
INSERT INTO public.contractors VALUES (168, 0, NULL, NULL, NULL, NULL, 910101001, 'АЛУШТАКУРОРТСНАБ, ', NULL, NULL, '7 978 837 67 67 Илона _Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (169, 0, NULL, NULL, NULL, NULL, NULL, 'Алькор-НВП ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (170, 1, NULL, NULL, NULL, NULL, NULL, 'Альперн А.В. ', NULL, NULL, '79788721897', 0, NULL);
INSERT INTO public.contractors VALUES (171, 0, NULL, NULL, NULL, NULL, NULL, 'Альфа Газ Инвест ', NULL, NULL, '7 978 817 61 16     Виктор Иванович', 0, NULL);
INSERT INTO public.contractors VALUES (172, 0, NULL, NULL, NULL, NULL, NULL, 'Альфа-центр-проект, Игорь ', NULL, NULL, '7 978 022 3237 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (173, 0, NULL, NULL, NULL, NULL, NULL, 'Альфетаев Амет ', NULL, NULL, '7 978 77 26 174', 0, NULL);
INSERT INTO public.contractors VALUES (174, 0, NULL, NULL, NULL, NULL, NULL, 'Альянс  (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (175, 0, NULL, NULL, NULL, NULL, NULL, 'АльянсЦентр ООО79877740618', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (176, 2, NULL, NULL, NULL, NULL, NULL, 'Алэн', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (177, 1, NULL, NULL, NULL, NULL, NULL, 'Амелин А.А. ', NULL, NULL, '7978 746 03 17', 0, NULL);
INSERT INTO public.contractors VALUES (178, 1, NULL, NULL, NULL, NULL, NULL, 'Амет-уста Ф.М. ', NULL, NULL, '7 978 815 97 28', 0, NULL);
INSERT INTO public.contractors VALUES (179, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов 79787289292', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (180, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов 79788029066', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (181, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов А.С. ', NULL, NULL, '7 978 830 99 19', 0, NULL);
INSERT INTO public.contractors VALUES (182, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов Арсен Сейранович ', NULL, NULL, '79787669309', 0, NULL);
INSERT INTO public.contractors VALUES (183, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов МУ79788522290', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (184, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов Руслан ', NULL, NULL, '7978 82 881 68', 0, NULL);
INSERT INTO public.contractors VALUES (185, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов С Э 79788353801', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (186, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов Э.А. ', NULL, NULL, '79780464377', 0, NULL);
INSERT INTO public.contractors VALUES (187, 1, NULL, NULL, NULL, NULL, NULL, 'Аметов Ю.С. ', NULL, NULL, '7 978 067 53 19', 0, NULL);
INSERT INTO public.contractors VALUES (188, 1, NULL, NULL, NULL, NULL, NULL, 'Аметова Г.М. ', NULL, NULL, '7 978 70 50 948', 0, NULL);
INSERT INTO public.contractors VALUES (189, 1, NULL, NULL, NULL, NULL, NULL, 'Амяга Валерий ', NULL, NULL, '7 978 861 48 01 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (190, 0, NULL, NULL, NULL, NULL, NULL, 'Анатолий (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (191, 1, NULL, NULL, NULL, NULL, NULL, 'Анафиев Б.А. ', NULL, NULL, '7 978 800 79 75', 0, NULL);
INSERT INTO public.contractors VALUES (192, 0, NULL, NULL, NULL, NULL, NULL, 'Анафиев Эльвис', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (193, 1, NULL, NULL, NULL, NULL, NULL, 'Анащенков Д.В. ', NULL, NULL, '7 978 815 75 43', 0, NULL);
INSERT INTO public.contractors VALUES (194, 1, NULL, NULL, NULL, NULL, NULL, 'Андеяшкин 79787736684', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (195, 0, NULL, NULL, NULL, NULL, NULL, 'Андреев Александр ', NULL, NULL, '7 978 711 82 30', 0, NULL);
INSERT INTO public.contractors VALUES (196, 1, NULL, NULL, NULL, NULL, NULL, 'Андреев В.А. ', NULL, NULL, '7 978 858 02 32', 0, NULL);
INSERT INTO public.contractors VALUES (197, 1, NULL, NULL, NULL, NULL, NULL, 'Андреев ДА 79787587777', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (198, 1, NULL, NULL, NULL, NULL, NULL, 'Андреев Дмитрий Владимирович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (199, 1, NULL, NULL, NULL, NULL, NULL, 'Андреев С.А., ', NULL, NULL, '79182102767', 0, NULL);
INSERT INTO public.contractors VALUES (200, 1, NULL, NULL, NULL, NULL, NULL, 'Андреев Сергей ', NULL, NULL, '7 978 726 23 42', 0, NULL);
INSERT INTO public.contractors VALUES (201, 1, NULL, NULL, NULL, NULL, NULL, 'Андреева Н.В. ', NULL, NULL, '7 978 834 9767', 0, NULL);
INSERT INTO public.contractors VALUES (202, 1, NULL, NULL, NULL, NULL, NULL, 'Андрей ', NULL, NULL, '79788411752', 0, NULL);
INSERT INTO public.contractors VALUES (203, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей А.Н', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (204, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей А.Н (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (205, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей А.Н (И) ', NULL, NULL, '7978 216 03 65', 0, NULL);
INSERT INTO public.contractors VALUES (206, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей Алушта 8-978-816-20-77', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (207, 1, NULL, NULL, NULL, NULL, NULL, 'Андрей Клиент Бухты', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (208, 1, NULL, NULL, NULL, NULL, NULL, 'Андрей МЧС ', NULL, NULL, '7978 804 92 55', 0, NULL);
INSERT INTO public.contractors VALUES (209, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей Родничок', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (210, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (211, 0, NULL, NULL, NULL, NULL, NULL, 'Андрей Ф. (д.п.)_ Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (212, 1, NULL, NULL, NULL, NULL, NULL, 'Андрияш Денис ', NULL, NULL, '7978 75 28 327', 0, NULL);
INSERT INTO public.contractors VALUES (213, 0, NULL, NULL, NULL, NULL, NULL, 'Андронов Александр Александрович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (214, 1, NULL, NULL, NULL, NULL, NULL, 'Андронов С.П. ', NULL, NULL, '7 978 76 04 322', 0, NULL);
INSERT INTO public.contractors VALUES (215, 0, NULL, NULL, NULL, NULL, NULL, 'Андрусик В.П. ', NULL, NULL, '7 978 71 60 367', 0, NULL);
INSERT INTO public.contractors VALUES (216, 1, NULL, NULL, NULL, NULL, NULL, 'Андрущенко И.А. ', NULL, NULL, '7978 708 59 80', 0, NULL);
INSERT INTO public.contractors VALUES (217, 1, NULL, NULL, NULL, NULL, NULL, 'Аниканова СИ 79787749501', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (218, 1, NULL, NULL, NULL, NULL, NULL, 'Анисимов П.Н. ', NULL, NULL, '7 978 75 46 551', 0, NULL);
INSERT INTO public.contractors VALUES (219, 1, NULL, NULL, NULL, NULL, NULL, 'Анисимов С.В. ', NULL, NULL, '7 978 713 1 629', 0, NULL);
INSERT INTO public.contractors VALUES (220, 0, NULL, NULL, NULL, NULL, NULL, 'Анисимова Наталья ', NULL, NULL, '7 978 79 32 146', 0, NULL);
INSERT INTO public.contractors VALUES (221, 0, NULL, NULL, NULL, NULL, NULL, 'Анисин Максим Анатольевич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (222, 1, NULL, NULL, NULL, NULL, NULL, 'Анкипчук 79785622735', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (223, 0, NULL, NULL, NULL, NULL, NULL, 'Анна мария партнеры  ', NULL, NULL, '7 978 762 88 17 Константин ООО', 0, NULL);
INSERT INTO public.contractors VALUES (224, 0, NULL, NULL, NULL, NULL, NULL, 'Анна цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (225, 0, NULL, NULL, NULL, NULL, NULL, 'Анохин Александр ', NULL, NULL, '7 978 775 04 34', 0, NULL);
INSERT INTO public.contractors VALUES (226, 1, NULL, NULL, NULL, NULL, NULL, 'Анохин Антон ', NULL, NULL, '7 978 79 49 702', 0, NULL);
INSERT INTO public.contractors VALUES (227, 1, NULL, NULL, NULL, NULL, NULL, 'Анпилогова Н 79788619780', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (228, 0, NULL, NULL, NULL, NULL, NULL, 'Антей  (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (229, 0, NULL, NULL, NULL, NULL, NULL, 'Антипчук М.В. ', NULL, NULL, '7 978 77 02 908', 0, NULL);
INSERT INTO public.contractors VALUES (230, 0, NULL, NULL, NULL, NULL, NULL, 'Антон Евпатория 2-Гвардейской армии', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (231, 1, NULL, NULL, NULL, NULL, NULL, 'Антон Завозин', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (232, 1, NULL, NULL, NULL, NULL, NULL, 'Антон Завозин / Влад', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (233, 0, NULL, NULL, NULL, NULL, NULL, 'АНТОН-Н , ', NULL, NULL, '7 978 026 75 82 Иосиф ООО', 0, NULL);
INSERT INTO public.contractors VALUES (234, 1, NULL, NULL, NULL, NULL, NULL, 'Антоненко Е.А. ', NULL, NULL, '7 978 906 69 76', 0, NULL);
INSERT INTO public.contractors VALUES (235, 2, NULL, NULL, NULL, NULL, NULL, 'Антонов КГ 89788265424 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (236, 0, NULL, NULL, NULL, NULL, NULL, 'Антонов С.Е. ', NULL, NULL, '7 978 711 93 86', 0, NULL);
INSERT INTO public.contractors VALUES (237, 2, NULL, NULL, NULL, NULL, NULL, 'Антощук В. И.  СЛАВЯНСК на КУБАНИ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (238, 1, NULL, NULL, NULL, NULL, NULL, 'Ануфриев Виктор Михайлович ', NULL, NULL, '7 978 845 76 82', 0, NULL);
INSERT INTO public.contractors VALUES (239, 1, NULL, NULL, NULL, NULL, NULL, 'Анучкин Д.И. ', NULL, NULL, '7978 733 62 35', 0, NULL);
INSERT INTO public.contractors VALUES (240, 1, NULL, NULL, NULL, NULL, NULL, 'Анфалов Д.В, ', NULL, NULL, '79787478003', 0, NULL);
INSERT INTO public.contractors VALUES (241, 0, NULL, NULL, NULL, NULL, 352501001, '"АО ""ВАД"", Петр ', NULL, NULL, '7 978 006 2820_Л."', 0, NULL);
INSERT INTO public.contractors VALUES (242, 0, NULL, NULL, NULL, NULL, NULL, 'АО Пансионат Канака ', NULL, NULL, '79788336283 Карина', 0, NULL);
INSERT INTO public.contractors VALUES (243, 0, NULL, NULL, NULL, NULL, NULL, 'АО Прогресс (от Рады)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (244, 0, NULL, NULL, NULL, NULL, NULL, 'АО Симферопольский ЗМЗ ', NULL, NULL, '7978 764 05 35 Владимир', 0, NULL);
INSERT INTO public.contractors VALUES (245, 0, NULL, NULL, NULL, NULL, NULL, 'Апостол Ю. ', NULL, NULL, '7 97 88 97 5465', 0, NULL);
INSERT INTO public.contractors VALUES (246, 2, NULL, NULL, NULL, NULL, NULL, 'Аралаш', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (247, 0, NULL, NULL, NULL, NULL, NULL, 'Араменский С.П. ', NULL, NULL, '7 978 84 255 16', 0, NULL);
INSERT INTO public.contractors VALUES (248, 1, NULL, NULL, NULL, NULL, NULL, 'Арап А.С. ', NULL, NULL, '79787060097', 0, NULL);
INSERT INTO public.contractors VALUES (249, 1, NULL, NULL, NULL, NULL, NULL, 'Арарат ', NULL, NULL, '7 978  735 31 18, Миша ', 0, NULL);
INSERT INTO public.contractors VALUES (250, 1, NULL, NULL, NULL, NULL, NULL, 'Арасланов 8 928 842 23 40', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (251, 1, NULL, NULL, NULL, NULL, NULL, 'Арбузов А.Е. ', NULL, NULL, '7 978 752 79 33', 0, NULL);
INSERT INTO public.contractors VALUES (252, 0, NULL, NULL, NULL, NULL, NULL, 'Арбузова Л.В. ', NULL, NULL, '7 978 817 60 38', 0, NULL);
INSERT INTO public.contractors VALUES (253, 1, NULL, NULL, NULL, NULL, NULL, 'Арефьев Алексей ', NULL, NULL, '7 978 784 52 82', 0, NULL);
INSERT INTO public.contractors VALUES (254, 0, NULL, NULL, NULL, NULL, 910201001, 'АРИКИ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (255, 1, NULL, NULL, NULL, NULL, NULL, 'Арипов А.Ш. ', NULL, NULL, '7 978 023 92 04', 0, NULL);
INSERT INTO public.contractors VALUES (256, 1, NULL, NULL, NULL, NULL, NULL, 'Арифов ОЮ 79787929947', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (257, 1, NULL, NULL, NULL, NULL, NULL, 'Аркадьев 79787136514', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (258, 0, NULL, NULL, NULL, NULL, 910801001, '"АРМАДА-К"", Михаил Григорьевич _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (259, 0, NULL, NULL, NULL, NULL, NULL, 'Армафит ', NULL, NULL, '79033607603 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (260, 0, NULL, NULL, NULL, NULL, NULL, 'Арсен ', NULL, NULL, '7 978 79 14 939 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (261, 0, NULL, NULL, NULL, NULL, NULL, 'Арсен ', NULL, NULL, '7978 709 04 82 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (262, 0, NULL, NULL, NULL, NULL, NULL, 'Арсенал-Крым Антон (Евпатория) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (263, 1, NULL, NULL, NULL, NULL, NULL, 'Арсентьев Вячеслав ', NULL, NULL, '7 978 877 49 26', 0, NULL);
INSERT INTO public.contractors VALUES (264, 0, NULL, NULL, NULL, NULL, NULL, 'Артамонов Владимир Иванович ', NULL, NULL, '79787882722', 0, NULL);
INSERT INTO public.contractors VALUES (265, 0, NULL, NULL, NULL, NULL, NULL, 'Артем ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (266, 0, NULL, NULL, NULL, NULL, NULL, 'Артём', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (267, 1, NULL, NULL, NULL, NULL, NULL, 'Артем бухты покупатель', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (268, 1, NULL, NULL, NULL, NULL, NULL, 'Артем кровельщик 7-918-111-72-10', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (269, 0, NULL, NULL, NULL, NULL, NULL, 'Артем руф', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (270, 1, NULL, NULL, NULL, NULL, NULL, 'Артем Цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (271, 1, NULL, NULL, NULL, NULL, NULL, 'Артеменко Дмитрий Сергеевич ', NULL, NULL, '7978 712 25 84', 0, NULL);
INSERT INTO public.contractors VALUES (272, 1, NULL, NULL, NULL, NULL, NULL, 'Артеменко Елена ', NULL, NULL, '7978 729 79 70 (20)', 0, NULL);
INSERT INTO public.contractors VALUES (273, 0, NULL, NULL, NULL, NULL, NULL, 'Артемов Валерий Эриковичч ', NULL, NULL, '79788606551', 0, NULL);
INSERT INTO public.contractors VALUES (274, 1, NULL, NULL, NULL, NULL, NULL, 'Артемьев В.Н. ', NULL, NULL, '7 978 861 74 65', 0, NULL);
INSERT INTO public.contractors VALUES (275, 1, NULL, NULL, NULL, NULL, NULL, 'Артемьев ИВ 79787324822', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (276, 1, NULL, NULL, NULL, NULL, NULL, 'Артемьев ИВ 79788324822', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (277, 1, NULL, NULL, NULL, NULL, NULL, 'Артюхов АГ 79780778577', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (278, 1, NULL, NULL, NULL, NULL, NULL, 'Артюхова Л.Н. ', NULL, NULL, '7 978 85 75 303', 0, NULL);
INSERT INTO public.contractors VALUES (279, 1, NULL, NULL, NULL, NULL, NULL, 'Арутюнян А.А. ', NULL, NULL, '7 978 801 71 02', 0, NULL);
INSERT INTO public.contractors VALUES (280, 0, NULL, NULL, NULL, NULL, NULL, 'Архипов Антон Алексеевич ', NULL, NULL, '79227599444', 0, NULL);
INSERT INTO public.contractors VALUES (281, 1, NULL, NULL, NULL, NULL, NULL, 'Архипов Б.Г. ', NULL, NULL, '7978 76 31 801', 0, NULL);
INSERT INTO public.contractors VALUES (282, 0, NULL, NULL, NULL, NULL, 701701001, '"АРЦ НК"" _Елена Пономарева ', NULL, NULL, '7 913 820 37 98_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (283, 1, NULL, NULL, NULL, NULL, NULL, 'Арютчев 79787658085', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (284, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов А.А. ', NULL, NULL, '79787456984', 0, NULL);
INSERT INTO public.contractors VALUES (285, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов А.Т. ', NULL, NULL, '7 978 76 12 130', 0, NULL);
INSERT INTO public.contractors VALUES (286, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов Д.Р. ', NULL, NULL, '7 978 824 25 77', 0, NULL);
INSERT INTO public.contractors VALUES (287, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов Р.Р ', NULL, NULL, '79787588266', 0, NULL);
INSERT INTO public.contractors VALUES (288, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов Р.С. ', NULL, NULL, '7978 897 78 71', 0, NULL);
INSERT INTO public.contractors VALUES (289, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов Р.Т. ', NULL, NULL, '7 978 83 03 258', 0, NULL);
INSERT INTO public.contractors VALUES (290, 0, NULL, NULL, NULL, NULL, NULL, 'Асанов С.М. ', NULL, NULL, '7 978 73 197 83', 0, NULL);
INSERT INTO public.contractors VALUES (291, 1, NULL, NULL, NULL, NULL, NULL, 'Асанов Феит ', NULL, NULL, '7 978 741 51 86', 0, NULL);
INSERT INTO public.contractors VALUES (292, 0, NULL, NULL, NULL, NULL, NULL, 'Асанов Элим  ', NULL, NULL, '7918 686 11 82-А. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (293, 0, NULL, NULL, NULL, NULL, 910201001, '"АСГАРД"", Виноградов Виталий Валерьевич ', NULL, NULL, '7 978 755 0995 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (294, 1, NULL, NULL, NULL, NULL, NULL, 'Асеев А.К. ', NULL, NULL, '7 978 78 09 728', 0, NULL);
INSERT INTO public.contractors VALUES (295, 0, NULL, NULL, NULL, NULL, NULL, 'АСК Групп', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (296, 1, NULL, NULL, NULL, NULL, NULL, 'Астапов С.Н. ', NULL, NULL, '7 978 787 66 96', 0, NULL);
INSERT INTO public.contractors VALUES (297, 1, NULL, NULL, NULL, NULL, NULL, 'Астафьев ВВ 79788483412', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (298, 1, NULL, NULL, NULL, NULL, NULL, 'Асютин П.П. ', NULL, NULL, '7978 74 61 059', 0, NULL);
INSERT INTO public.contractors VALUES (299, 0, NULL, NULL, NULL, NULL, NULL, 'Атлант  ', NULL, NULL, '7 978 983 08 20 Владимир ООО', 0, NULL);
INSERT INTO public.contractors VALUES (300, 0, NULL, NULL, NULL, NULL, 910201001, '"АТЛАНТ ГРУПП"", Денис Викторович ', NULL, NULL, '7 978 708 4785 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (301, 0, NULL, NULL, NULL, NULL, 781001001, 'АТЛАНТ ООО - А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (302, 0, NULL, NULL, NULL, NULL, NULL, 'Атлант ООО ', NULL, NULL, '79898380007', 0, NULL);
INSERT INTO public.contractors VALUES (303, 0, NULL, NULL, NULL, NULL, NULL, 'Атлант.Проспект Победы 109а (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (304, 0, NULL, NULL, NULL, NULL, NULL, 'АТМ-БУД 79788270021 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (305, 0, NULL, NULL, NULL, NULL, NULL, 'Атмен 79787086829 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (306, 1, NULL, NULL, NULL, NULL, NULL, 'Аулов 79788088462', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (307, 1, NULL, NULL, NULL, NULL, NULL, 'Аустер ЭВ 79787253930', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (308, 1, NULL, NULL, NULL, NULL, NULL, 'Афанасиевский АА 79788295140', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (309, 1, NULL, NULL, NULL, NULL, NULL, 'Ахметов Ф.Ф. ', NULL, NULL, '7978 209 85 88', 0, NULL);
INSERT INTO public.contractors VALUES (310, 0, NULL, NULL, NULL, NULL, NULL, 'Ахтем (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (311, 1, NULL, NULL, NULL, NULL, NULL, 'Ахтемов А.А. ', NULL, NULL, '7978 897 92 38', 0, NULL);
INSERT INTO public.contractors VALUES (312, 0, NULL, NULL, NULL, NULL, NULL, 'Ачилов Р.Д. ', NULL, NULL, '79787064576', 0, NULL);
INSERT INTO public.contractors VALUES (313, 1, NULL, NULL, NULL, NULL, NULL, 'Ачилова Л. ', NULL, NULL, '7 978 70 64 576', 0, NULL);
INSERT INTO public.contractors VALUES (314, 1, NULL, NULL, NULL, NULL, NULL, 'Ачкасов ВЛ 79788104867', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (315, 1, NULL, NULL, NULL, NULL, NULL, 'Ачкасов ОГ 79787081868', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (316, 1, NULL, NULL, NULL, NULL, NULL, 'Ашиков 79789047770', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (317, 0, NULL, NULL, NULL, NULL, NULL, 'Ашиков Н.И. ', NULL, NULL, '7978 904 77 17 ', 0, NULL);
INSERT INTO public.contractors VALUES (318, 1, NULL, NULL, NULL, NULL, NULL, 'Ашот ', NULL, NULL, '79780498446', 0, NULL);
INSERT INTO public.contractors VALUES (319, 0, NULL, NULL, NULL, NULL, NULL, 'Ашрапов Мустафа ', NULL, NULL, '79780220172', 0, NULL);
INSERT INTO public.contractors VALUES (320, 1, NULL, NULL, NULL, NULL, NULL, 'Бабенко А.И. ', NULL, NULL, '7 978 84 16 332', 0, NULL);
INSERT INTO public.contractors VALUES (321, 1, NULL, NULL, NULL, NULL, NULL, 'Бабенко АН 79182600240', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (322, 0, NULL, NULL, NULL, NULL, NULL, 'Бабиченко М.М. ', NULL, NULL, '7 978 066 63 74', 0, NULL);
INSERT INTO public.contractors VALUES (323, 0, NULL, NULL, NULL, NULL, NULL, 'Бабкин А.А. ', NULL, NULL, '7 978 744 09 96', 0, NULL);
INSERT INTO public.contractors VALUES (324, 1, NULL, NULL, NULL, NULL, NULL, 'Бабулевич К.Г. ', NULL, NULL, '7 978 715 00 49', 0, NULL);
INSERT INTO public.contractors VALUES (325, 0, NULL, NULL, NULL, NULL, NULL, 'Бабяк В.В. ', NULL, NULL, '7978 829 67 00', 0, NULL);
INSERT INTO public.contractors VALUES (326, 1, NULL, NULL, NULL, NULL, NULL, 'Баган Ю. ', NULL, NULL, '7978 780 75 88 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (327, 1, NULL, NULL, NULL, NULL, NULL, 'Багдасарян Л.Н. ', NULL, NULL, '7978 725 5742 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (328, 0, NULL, NULL, NULL, NULL, NULL, 'Багдасарян Роберт ', NULL, NULL, '79195885600', 0, NULL);
INSERT INTO public.contractors VALUES (329, 1, NULL, NULL, NULL, NULL, NULL, 'Багишев Э.С. ', NULL, NULL, '7978 7 827 927', 0, NULL);
INSERT INTO public.contractors VALUES (330, 1, NULL, NULL, NULL, NULL, NULL, 'Баграмян С.Н. ', NULL, NULL, '7978 83 14 261', 0, NULL);
INSERT INTO public.contractors VALUES (331, 1, NULL, NULL, NULL, NULL, NULL, 'Багрец АН 79780770181', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (332, 0, NULL, NULL, NULL, NULL, NULL, 'Багрец Е.А. ', NULL, NULL, '7 978 201 54 07', 0, NULL);
INSERT INTO public.contractors VALUES (333, 1, NULL, NULL, NULL, NULL, NULL, 'Багрец З.В. ', NULL, NULL, '7978 868 03 47 (0770181)', 0, NULL);
INSERT INTO public.contractors VALUES (334, 0, NULL, NULL, NULL, NULL, NULL, 'Бажан Денис ', NULL, NULL, '7 978 99 00099', 0, NULL);
INSERT INTO public.contractors VALUES (335, 0, NULL, NULL, NULL, NULL, NULL, '"База""Монетное""с.Пионерское.(И)"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (336, 2, NULL, NULL, NULL, NULL, NULL, 'Базаев Павел Павлович (Саки) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (337, 1, NULL, NULL, NULL, NULL, NULL, 'Баздырев И. В. ', NULL, NULL, '79787512359', 0, NULL);
INSERT INTO public.contractors VALUES (338, 1, NULL, NULL, NULL, NULL, NULL, 'Баздырев СН 79787235098', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (339, 1, NULL, NULL, NULL, NULL, NULL, 'Базин К.С. ', NULL, NULL, '7978 809 64 54', 0, NULL);
INSERT INTO public.contractors VALUES (340, 0, NULL, NULL, NULL, NULL, NULL, 'Базылева Валентина ', NULL, NULL, '79787483661', 0, NULL);
INSERT INTO public.contractors VALUES (341, 1, NULL, NULL, NULL, NULL, NULL, 'Баймах РШ 79788241213', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (342, 1, NULL, NULL, NULL, NULL, NULL, 'Байрамов Б.М. ', NULL, NULL, '7 912 326 05 05', 0, NULL);
INSERT INTO public.contractors VALUES (343, 1, NULL, NULL, NULL, NULL, NULL, 'Байрамов МВ 79780056259', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (344, 1, NULL, NULL, NULL, NULL, NULL, 'Бакальчук Юрий ', NULL, NULL, '7978 724 84 94', 0, NULL);
INSERT INTO public.contractors VALUES (345, 1, NULL, NULL, NULL, NULL, NULL, 'Баканов В.В. ', NULL, NULL, '7978 782 95 10', 0, NULL);
INSERT INTO public.contractors VALUES (346, 1, NULL, NULL, NULL, NULL, NULL, 'Бакиев Э.И. ', NULL, NULL, '79787284088', 0, NULL);
INSERT INTO public.contractors VALUES (347, 0, NULL, NULL, NULL, NULL, NULL, 'Баков Сергей ', NULL, NULL, '7 978 70 80 853', 0, NULL);
INSERT INTO public.contractors VALUES (348, 0, NULL, NULL, NULL, NULL, NULL, 'Бакулин А.Ю. ', NULL, NULL, '7978 81 00 692', 0, NULL);
INSERT INTO public.contractors VALUES (349, 1, NULL, NULL, NULL, NULL, NULL, 'Баламутин НВ 79787476838', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (350, 0, NULL, NULL, NULL, NULL, NULL, 'Балас Александр Петрович ', NULL, NULL, '79780069948/47', 0, NULL);
INSERT INTO public.contractors VALUES (351, 1, NULL, NULL, NULL, NULL, NULL, 'Балаховский В.М. ', NULL, NULL, '7 978 815 73 67', 0, NULL);
INSERT INTO public.contractors VALUES (352, 1, NULL, NULL, NULL, NULL, NULL, 'Балахонов ДВ 79789902237', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (353, 1, NULL, NULL, NULL, NULL, NULL, 'Балджи ША 79787667950', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (354, 1, NULL, NULL, NULL, NULL, NULL, 'Баликова В.И. ', NULL, NULL, '7978 707 84 07', 0, NULL);
INSERT INTO public.contractors VALUES (355, 1, NULL, NULL, NULL, NULL, NULL, 'Балинский СГ 79788383456', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (356, 1, NULL, NULL, NULL, NULL, NULL, 'Балюк А.А. ', NULL, NULL, '7978 841 13 01', 0, NULL);
INSERT INTO public.contractors VALUES (357, 1, NULL, NULL, NULL, NULL, NULL, 'Баннов НА ', NULL, NULL, '79788409341', 0, NULL);
INSERT INTO public.contractors VALUES (358, 1, NULL, NULL, NULL, NULL, NULL, 'Барабан Н.Н. ', NULL, NULL, '79787753635', 0, NULL);
INSERT INTO public.contractors VALUES (359, 1, NULL, NULL, NULL, NULL, NULL, 'Барабанщикова УВ 89913441021', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (360, 1, NULL, NULL, NULL, NULL, NULL, 'Барабаш И.А. ', NULL, NULL, '7 978 828 9310', 0, NULL);
INSERT INTO public.contractors VALUES (361, 1, NULL, NULL, NULL, NULL, NULL, 'Баранов ВИ 79787122486', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (362, 1, NULL, NULL, NULL, NULL, NULL, 'Баранов Ю.В. ', NULL, NULL, '7978 706 06 54', 0, NULL);
INSERT INTO public.contractors VALUES (363, 1, NULL, NULL, NULL, NULL, NULL, 'Баранова Л.Г. ', NULL, NULL, '7978 720 92 48', 0, NULL);
INSERT INTO public.contractors VALUES (364, 2, NULL, NULL, NULL, NULL, NULL, 'Баранушкин П. Г.  ИП КРАСНОДАР', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (365, 1, NULL, NULL, NULL, NULL, NULL, 'Барбаренко Ю.Б. ', NULL, NULL, '7978 734 09 63', 0, NULL);
INSERT INTO public.contractors VALUES (366, 1, NULL, NULL, NULL, NULL, NULL, 'Барбышев М.А. ', NULL, NULL, '7 978 550 63 57', 0, NULL);
INSERT INTO public.contractors VALUES (367, 1, NULL, NULL, NULL, NULL, NULL, 'Баринов О.С. ', NULL, NULL, '7 978 751 52 62', 0, NULL);
INSERT INTO public.contractors VALUES (368, 1, NULL, NULL, NULL, NULL, NULL, 'Баришполец А.П. ', NULL, NULL, '7 978 706 11 27', 0, NULL);
INSERT INTO public.contractors VALUES (369, 1, NULL, NULL, NULL, NULL, NULL, 'Баришполец А.П. ', NULL, NULL, '7 978 706 11 27', 0, NULL);
INSERT INTO public.contractors VALUES (370, 1, NULL, NULL, NULL, NULL, NULL, 'Баркарь Алексей ', NULL, NULL, '7 978 831 38 61', 0, NULL);
INSERT INTO public.contractors VALUES (371, 1, NULL, NULL, NULL, NULL, NULL, 'Барский А 79781012617', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (372, 1, NULL, NULL, NULL, NULL, NULL, 'Басенко ЕВ 79787133062', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (373, 1, NULL, NULL, NULL, NULL, NULL, 'Басистый Г.И. ', NULL, NULL, '7 978 707 84 10', 0, NULL);
INSERT INTO public.contractors VALUES (374, 0, NULL, NULL, NULL, NULL, NULL, 'Бастион ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (375, 1, NULL, NULL, NULL, NULL, NULL, 'Батыров И.А. ', NULL, NULL, '7 978 75 59 218', 0, NULL);
INSERT INTO public.contractors VALUES (376, 0, NULL, NULL, NULL, NULL, NULL, 'Батыршин Риф 8 982 595 32 22', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (377, 1, NULL, NULL, NULL, NULL, NULL, 'Батьков СВ ', NULL, NULL, '79788314262', 0, NULL);
INSERT INTO public.contractors VALUES (378, 0, NULL, NULL, NULL, NULL, 910201001, 'БАХАРЕВ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (379, 0, NULL, NULL, NULL, NULL, NULL, 'Бахтизин С.М. ', NULL, NULL, '7 978 722 59 46', 0, NULL);
INSERT INTO public.contractors VALUES (380, 1, NULL, NULL, NULL, NULL, NULL, 'Баценко Наталья Анатольевна ', NULL, NULL, '7978 722 80 62', 0, NULL);
INSERT INTO public.contractors VALUES (381, 1, NULL, NULL, NULL, NULL, NULL, 'Бацких ЮВ 79787508639', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (382, 0, NULL, NULL, NULL, NULL, NULL, 'Башкирев Станислав ', NULL, NULL, '79780531240', 0, NULL);
INSERT INTO public.contractors VALUES (383, 1, NULL, NULL, NULL, NULL, NULL, 'Бебнев АА 79787119270', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (384, 0, NULL, NULL, NULL, NULL, NULL, 'БЕГ  г.Алушта ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (385, 1, NULL, NULL, NULL, NULL, NULL, 'Бедаш МН 79780653752', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (386, 1, NULL, NULL, NULL, NULL, NULL, 'Бедин П.Е. ', NULL, NULL, '7 978 703 51 94', 0, NULL);
INSERT INTO public.contractors VALUES (387, 1, NULL, NULL, NULL, NULL, NULL, 'Бедринская Наталья Михайловна 89787469505', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (388, 1, NULL, NULL, NULL, NULL, NULL, 'Безвербный В.А. 8-978-767-82-88', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (389, 0, NULL, NULL, NULL, NULL, NULL, 'Безвербный Д.А. ', NULL, NULL, '79787678311', 0, NULL);
INSERT INTO public.contractors VALUES (390, 2, NULL, NULL, NULL, NULL, NULL, 'Безгинская Алла ( Евпатория )-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (391, 0, NULL, NULL, NULL, NULL, NULL, 'Беззубенков Сергей Васильевич ', NULL, NULL, '79787550305', 0, NULL);
INSERT INTO public.contractors VALUES (392, 0, NULL, NULL, NULL, NULL, NULL, 'Безкоровайный Олег ', NULL, NULL, '79788103412', 0, NULL);
INSERT INTO public.contractors VALUES (393, 1, NULL, NULL, NULL, NULL, NULL, 'Безручкин СЮ 79780539794', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (394, 1, NULL, NULL, NULL, NULL, NULL, 'Бейтуллаев  Д. (Каменка) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (395, 1, NULL, NULL, NULL, NULL, NULL, 'Бекиров АЭ 79789956236 к п', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (396, 1, NULL, NULL, NULL, NULL, NULL, 'Бекиров Л.Э. ', NULL, NULL, '7978 87 71 638', 0, NULL);
INSERT INTO public.contractors VALUES (397, 1, NULL, NULL, NULL, NULL, NULL, 'Бекиров Н.Н. ', NULL, NULL, '7978 275 85 08', 0, NULL);
INSERT INTO public.contractors VALUES (398, 0, NULL, NULL, NULL, NULL, NULL, 'Бекиров Рефат ', NULL, NULL, '7978 757 13 97', 0, NULL);
INSERT INTO public.contractors VALUES (399, 0, NULL, NULL, NULL, NULL, NULL, 'Бекиров Рустем ', NULL, NULL, '79788396077', 0, NULL);
INSERT INTO public.contractors VALUES (400, 1, NULL, NULL, NULL, NULL, NULL, 'Бекиров С.Б. ', NULL, NULL, '7978 800 98 82', 0, NULL);
INSERT INTO public.contractors VALUES (401, 1, NULL, NULL, NULL, NULL, NULL, 'Бекиров Т.М. ', NULL, NULL, '7 978 065 87 26', 0, NULL);
INSERT INTO public.contractors VALUES (402, 1, NULL, NULL, NULL, NULL, NULL, 'Бекиров Эльвис ', NULL, NULL, '7 978 86 99 800', 0, NULL);
INSERT INTO public.contractors VALUES (403, 0, NULL, NULL, NULL, NULL, NULL, 'Бекиров Якуб ', NULL, NULL, '7 978 773 20 27', 0, NULL);
INSERT INTO public.contractors VALUES (404, 1, NULL, NULL, NULL, NULL, NULL, 'Бекташ Марлен ', NULL, NULL, '7 978 758 21 65', 0, NULL);
INSERT INTO public.contractors VALUES (405, 0, NULL, NULL, NULL, NULL, NULL, 'Белаш Сергей ', NULL, NULL, '7 978 750 43 68', 0, NULL);
INSERT INTO public.contractors VALUES (406, 1, NULL, NULL, NULL, NULL, NULL, 'Белашов П.В. ', NULL, NULL, '7 978 711 47 57', 0, NULL);
INSERT INTO public.contractors VALUES (407, 1, NULL, NULL, NULL, NULL, NULL, 'Белик А.С. ', NULL, NULL, '7978 884 56 85', 0, NULL);
INSERT INTO public.contractors VALUES (408, 1, NULL, NULL, NULL, NULL, NULL, 'Белик Станислав ', NULL, NULL, '7 978 725 38 39', 0, NULL);
INSERT INTO public.contractors VALUES (409, 0, NULL, NULL, NULL, NULL, NULL, 'Белицкая Н.Е. ', NULL, NULL, '7 978 705 80 60', 0, NULL);
INSERT INTO public.contractors VALUES (410, 1, NULL, NULL, NULL, NULL, NULL, 'Белич ИА 79787107191', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (411, 1, NULL, NULL, NULL, NULL, NULL, 'Беличенко Александр ', NULL, NULL, '7 978 742 89 43', 0, NULL);
INSERT INTO public.contractors VALUES (412, 1, NULL, NULL, NULL, NULL, NULL, 'Беличков АА 79787276640 (д.п)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (413, 1, NULL, NULL, NULL, NULL, NULL, 'Белобородов Вадим Валериевич ', NULL, NULL, '7978 846 39 85', 0, NULL);
INSERT INTO public.contractors VALUES (414, 1, NULL, NULL, NULL, NULL, NULL, 'Белов СС 79780228308', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (415, 0, NULL, NULL, NULL, NULL, NULL, 'Белозор Александр Павлович ', NULL, NULL, '79787592468', 0, NULL);
INSERT INTO public.contractors VALUES (416, 1, NULL, NULL, NULL, NULL, NULL, 'Белокопытов АН ', NULL, NULL, '79780544984', 0, NULL);
INSERT INTO public.contractors VALUES (417, 0, NULL, NULL, NULL, NULL, NULL, 'Белоус Н.В. ', NULL, NULL, '7 978 74 82 412', 0, NULL);
INSERT INTO public.contractors VALUES (418, 0, NULL, NULL, NULL, NULL, NULL, 'Белоус Н.В. ', NULL, NULL, '7 978 74 82 412', 0, NULL);
INSERT INTO public.contractors VALUES (419, 0, NULL, NULL, NULL, NULL, NULL, 'Белоусов', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (420, 0, NULL, NULL, NULL, NULL, NULL, 'Белоусов Михаил -А. ', NULL, NULL, '7978 713 89 33', 0, NULL);
INSERT INTO public.contractors VALUES (421, 1, NULL, NULL, NULL, NULL, NULL, 'Белошейкин В.Н. ', NULL, NULL, '7 978 70 85 180', 0, NULL);
INSERT INTO public.contractors VALUES (422, 1, NULL, NULL, NULL, NULL, NULL, 'Белошицкая С.Г. ', NULL, NULL, '7978 843 48 24', 0, NULL);
INSERT INTO public.contractors VALUES (423, 0, NULL, NULL, NULL, NULL, NULL, 'Белый Виктор ', NULL, NULL, '79788887042', 0, NULL);
INSERT INTO public.contractors VALUES (424, 0, NULL, NULL, NULL, NULL, NULL, 'Белый О.В. ', NULL, NULL, '79785751313', 0, NULL);
INSERT INTO public.contractors VALUES (425, 0, NULL, NULL, NULL, NULL, NULL, 'Белых С.В. ', NULL, NULL, '7 978 76 98 528', 0, NULL);
INSERT INTO public.contractors VALUES (426, 1, NULL, NULL, NULL, NULL, NULL, 'Бельков С.Н. ', NULL, NULL, '7978 789 96 13', 0, NULL);
INSERT INTO public.contractors VALUES (427, 1, NULL, NULL, NULL, NULL, NULL, 'Белявцев В.В. ', NULL, NULL, '79788214830', 0, NULL);
INSERT INTO public.contractors VALUES (428, 1, NULL, NULL, NULL, NULL, NULL, 'Белягов В.Л. ', NULL, NULL, '7 978 880 25 30', 0, NULL);
INSERT INTO public.contractors VALUES (429, 0, NULL, NULL, NULL, NULL, NULL, 'Беляев И.Н. ', NULL, NULL, '7 978 77 458 48', 0, NULL);
INSERT INTO public.contractors VALUES (430, 0, NULL, NULL, NULL, NULL, NULL, 'Беляева Н.В. ', NULL, NULL, '7 978 727 55 95', 0, NULL);
INSERT INTO public.contractors VALUES (431, 1, NULL, NULL, NULL, NULL, NULL, 'Беляков А.Д. ', NULL, NULL, '7 978 734 09 32', 0, NULL);
INSERT INTO public.contractors VALUES (432, 1, NULL, NULL, NULL, NULL, NULL, 'Беляков П.П. ', NULL, NULL, '7 978 768 60 61', 0, NULL);
INSERT INTO public.contractors VALUES (433, 1, NULL, NULL, NULL, NULL, NULL, 'Беляков П.П. ', NULL, NULL, '7978 790 52 88 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (434, 1, NULL, NULL, NULL, NULL, NULL, 'Белямов А.М. ', NULL, NULL, '79780041597', 0, NULL);
INSERT INTO public.contractors VALUES (435, 1, NULL, NULL, NULL, NULL, NULL, 'Бенли А.Н. ', NULL, NULL, '7978 104 8354 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (436, 1, NULL, NULL, NULL, NULL, NULL, 'Бенюх Наталья ', NULL, NULL, '7978 073 74 78 (', 0, NULL);
INSERT INTO public.contractors VALUES (437, 1, NULL, NULL, NULL, NULL, NULL, 'Берберов ', NULL, NULL, '7 978 733 88 13', 0, NULL);
INSERT INTO public.contractors VALUES (438, 0, NULL, NULL, NULL, NULL, NULL, 'Бердус И.В ', NULL, NULL, '79788321854', 0, NULL);
INSERT INTO public.contractors VALUES (439, 1, NULL, NULL, NULL, NULL, NULL, 'Бердышев В.В. ', NULL, NULL, '7978 848 35 40', 0, NULL);
INSERT INTO public.contractors VALUES (440, 1, NULL, NULL, NULL, NULL, NULL, 'Бережной А.А. ', NULL, NULL, '79785087952', 0, NULL);
INSERT INTO public.contractors VALUES (441, 1, NULL, NULL, NULL, NULL, NULL, 'Бережной И.М. ', NULL, NULL, '7 912 88 36 187', 0, NULL);
INSERT INTO public.contractors VALUES (442, 1, NULL, NULL, NULL, NULL, NULL, 'Березин А.А. ', NULL, NULL, '7 978 814 54 86', 0, NULL);
INSERT INTO public.contractors VALUES (443, 1, NULL, NULL, NULL, NULL, NULL, 'Березин АО 79788474642', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (444, 0, NULL, NULL, NULL, NULL, NULL, 'Березников Николай Алексеевич ', NULL, NULL, '79788574912', 0, NULL);
INSERT INTO public.contractors VALUES (445, 1, NULL, NULL, NULL, NULL, NULL, 'Березов Сергей Павлович ', NULL, NULL, '7978 830 09 69', 0, NULL);
INSERT INTO public.contractors VALUES (446, 1, NULL, NULL, NULL, NULL, NULL, 'Беспалько ВС 79787522362', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (447, 1, NULL, NULL, NULL, NULL, NULL, 'Бессонов А.А. ', NULL, NULL, '7 978 81 75 660', 0, NULL);
INSERT INTO public.contractors VALUES (448, 1, NULL, NULL, NULL, NULL, NULL, 'Бессонов В.С, ', NULL, NULL, '7978 848 37 80', 0, NULL);
INSERT INTO public.contractors VALUES (449, 1, NULL, NULL, NULL, NULL, NULL, 'Бешлиев П.В. ', NULL, NULL, '7 978 78 90 533', 0, NULL);
INSERT INTO public.contractors VALUES (450, 0, NULL, NULL, NULL, NULL, NULL, 'Би Транс 79782585808 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (451, 1, NULL, NULL, NULL, NULL, NULL, 'Биджанов А.Х. ', NULL, NULL, '7978 078 32 49', 0, NULL);
INSERT INTO public.contractors VALUES (452, 1, NULL, NULL, NULL, NULL, NULL, 'Бизносюк АН 79787643625', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (453, 1, NULL, NULL, NULL, NULL, NULL, 'Билаш С.С. ', NULL, NULL, '79787475322', 0, NULL);
INSERT INTO public.contractors VALUES (454, 1, NULL, NULL, NULL, NULL, NULL, 'Билял Сервер ', NULL, NULL, '7978 740 87 75', 0, NULL);
INSERT INTO public.contractors VALUES (455, 1, NULL, NULL, NULL, NULL, NULL, 'Билялов А.А. ', NULL, NULL, '7978 89 67 906', 0, NULL);
INSERT INTO public.contractors VALUES (456, 1, NULL, NULL, NULL, NULL, NULL, 'Билялов Асан (кров) ', NULL, NULL, '7978 141 83 66', 0, NULL);
INSERT INTO public.contractors VALUES (457, 1, NULL, NULL, NULL, NULL, NULL, 'Билялов ЛМ 79782201453', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (458, 0, NULL, NULL, NULL, NULL, NULL, 'Билялов Н.Р. ', NULL, NULL, '79788517758', 0, NULL);
INSERT INTO public.contractors VALUES (459, 1, NULL, NULL, NULL, NULL, NULL, 'Бирюкова ГН 79788386221', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (460, 1, NULL, NULL, NULL, NULL, NULL, 'Бирюкова Наталья Дмитриевна ', NULL, NULL, '7978 802 43 17 (18)', 0, NULL);
INSERT INTO public.contractors VALUES (461, 1, NULL, NULL, NULL, NULL, NULL, 'Битюков Д.Ю. ', NULL, NULL, '7 978 722 54 03', 0, NULL);
INSERT INTO public.contractors VALUES (462, 1, NULL, NULL, NULL, NULL, NULL, 'Биченов Р.А. ', NULL, NULL, '7978 032 48 79', 0, NULL);
INSERT INTO public.contractors VALUES (463, 0, NULL, NULL, NULL, NULL, NULL, 'Бишули 79787371890 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (464, 0, NULL, NULL, NULL, NULL, NULL, 'Близняков Евгений', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (465, 1, NULL, NULL, NULL, NULL, NULL, 'Блинова С.Д. ', NULL, NULL, '7 978 78 74 102', 0, NULL);
INSERT INTO public.contractors VALUES (466, 1, NULL, NULL, NULL, NULL, NULL, 'Бобас ВВ 79787290799 98', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (467, 1, NULL, NULL, NULL, NULL, NULL, 'Бобко В.И. 8-978-733-56-92', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (468, 1, NULL, NULL, NULL, NULL, NULL, 'Боборыкин ВВ 79788100112', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (469, 1, NULL, NULL, NULL, NULL, NULL, 'Бобриков А.Д. ', NULL, NULL, '7 978 818 05 45', 0, NULL);
INSERT INTO public.contractors VALUES (470, 0, NULL, NULL, NULL, NULL, NULL, 'Бобров А.А. ', NULL, NULL, '7 978 799 25 78', 0, NULL);
INSERT INTO public.contractors VALUES (471, 1, NULL, NULL, NULL, NULL, NULL, 'Бобров ВВ 79787151660', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (472, 1, NULL, NULL, NULL, NULL, NULL, 'Бобылков СВ 79788261491 надежда', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (473, 0, NULL, NULL, NULL, NULL, NULL, 'Бовт Сергей Федорович ', NULL, NULL, '79787525121', 0, NULL);
INSERT INTO public.contractors VALUES (474, 1, NULL, NULL, NULL, NULL, NULL, 'Богачевская Галина ', NULL, NULL, '7 978 844 51 97', 0, NULL);
INSERT INTO public.contractors VALUES (475, 1, NULL, NULL, NULL, NULL, NULL, 'Богданов Н.В. ', NULL, NULL, '7978 834 41 21', 0, NULL);
INSERT INTO public.contractors VALUES (476, 0, NULL, NULL, NULL, NULL, NULL, 'Богомолов Кирилл Викторович ', NULL, NULL, '79780635378', 0, NULL);
INSERT INTO public.contractors VALUES (477, 1, NULL, NULL, NULL, NULL, NULL, 'Богославский А.П. ', NULL, NULL, '7 978 77 15 185', 0, NULL);
INSERT INTO public.contractors VALUES (478, 0, NULL, NULL, NULL, NULL, NULL, 'Богословский Александр Анатольевич ', NULL, NULL, '79788066277', 0, NULL);
INSERT INTO public.contractors VALUES (479, 1, NULL, NULL, NULL, NULL, NULL, 'Боднар АА 79787222125', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (480, 0, NULL, NULL, NULL, NULL, NULL, 'Бодня Сергей ', NULL, NULL, '7 978 711 88 10', 0, NULL);
INSERT INTO public.contractors VALUES (481, 1, NULL, NULL, NULL, NULL, NULL, 'Бойко АН 79780597067 кп', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (482, 1, NULL, NULL, NULL, NULL, NULL, 'Бойко В.К. ', NULL, NULL, '7978 72 35 107', 0, NULL);
INSERT INTO public.contractors VALUES (483, 0, NULL, NULL, NULL, NULL, NULL, 'Бойко Владимир (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (484, 1, NULL, NULL, NULL, NULL, NULL, 'Бойко Владимир ', NULL, NULL, '7978 71 325 72', 0, NULL);
INSERT INTO public.contractors VALUES (485, 0, NULL, NULL, NULL, NULL, NULL, 'Бойко Иван Иванович ', NULL, NULL, '7 978 272 84 38', 0, NULL);
INSERT INTO public.contractors VALUES (486, 1, NULL, NULL, NULL, NULL, NULL, 'Бойко Л.А. ', NULL, NULL, '7978 777 92 91', 0, NULL);
INSERT INTO public.contractors VALUES (487, 1, NULL, NULL, NULL, NULL, NULL, 'Бойко СВ 79787194988', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (488, 1, NULL, NULL, NULL, NULL, NULL, 'Бойко Т.В. ', NULL, NULL, '7 978 835 01 11', 0, NULL);
INSERT INTO public.contractors VALUES (489, 1, NULL, NULL, NULL, NULL, NULL, 'Боков КИ 79787508747', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (490, 1, NULL, NULL, NULL, NULL, NULL, 'Болдырева И.Л. ', NULL, NULL, '7 978 74 84 338', 0, NULL);
INSERT INTO public.contractors VALUES (491, 1, NULL, NULL, NULL, NULL, NULL, 'Болсуновский С.Л. ', NULL, NULL, '7 978 74 70 582', 0, NULL);
INSERT INTO public.contractors VALUES (492, 0, NULL, NULL, NULL, NULL, NULL, 'Большак Н.А. ', NULL, NULL, '7 9787475464', 0, NULL);
INSERT INTO public.contractors VALUES (493, 0, NULL, NULL, NULL, NULL, NULL, 'Большаков Эдуард ', NULL, NULL, '79781420662', 0, NULL);
INSERT INTO public.contractors VALUES (494, 1, NULL, NULL, NULL, NULL, NULL, 'Большаков Ю.Н. ', NULL, NULL, '7 978 721 03 64', 0, NULL);
INSERT INTO public.contractors VALUES (495, 0, NULL, NULL, NULL, NULL, NULL, 'Бондаренко ', NULL, NULL, '79787821940', 0, NULL);
INSERT INTO public.contractors VALUES (496, 1, NULL, NULL, NULL, NULL, NULL, 'Бондаренко АВ 79788605861', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (497, 0, NULL, NULL, NULL, NULL, NULL, 'Бондаренко Валентин ', NULL, NULL, '79788269168', 0, NULL);
INSERT INTO public.contractors VALUES (498, 0, NULL, NULL, NULL, NULL, NULL, 'Бондаренко Владимир ', NULL, NULL, '79787123634', 0, NULL);
INSERT INTO public.contractors VALUES (499, 1, NULL, NULL, NULL, NULL, NULL, 'Бондаренко К ', NULL, NULL, '7978 750 38 55', 0, NULL);
INSERT INTO public.contractors VALUES (500, 1, NULL, NULL, NULL, NULL, NULL, 'Бондаренко М.Ю. ', NULL, NULL, '79787344225', 0, NULL);
INSERT INTO public.contractors VALUES (501, 2, NULL, NULL, NULL, NULL, NULL, 'Бондаренко ОВ  79788749938 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (502, 1, NULL, NULL, NULL, NULL, NULL, 'Бондарь И.Н. ', NULL, NULL, '7978 763 46 83 (86)', 0, NULL);
INSERT INTO public.contractors VALUES (503, 1, NULL, NULL, NULL, NULL, NULL, 'Бонев Д.Б. ', NULL, NULL, '7 978 80 95 437', 0, NULL);
INSERT INTO public.contractors VALUES (504, 1, NULL, NULL, NULL, NULL, NULL, 'Бонсевич С.С. ', NULL, NULL, '7 978 898 4006', 0, NULL);
INSERT INTO public.contractors VALUES (505, 1, NULL, NULL, NULL, NULL, NULL, 'Бооль АВ 79780183741', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (506, 1, NULL, NULL, NULL, NULL, NULL, 'Борденюк ДВ 79788230779', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (507, 0, NULL, NULL, NULL, NULL, NULL, 'Борикун В.П. ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (508, 1, NULL, NULL, NULL, NULL, NULL, 'Борикун В.П. 8-978-70-64-101', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (509, 1, NULL, NULL, NULL, NULL, NULL, 'Борисенко В.В. ', NULL, NULL, '7978 829 60 74', 0, NULL);
INSERT INTO public.contractors VALUES (510, 0, NULL, NULL, NULL, NULL, NULL, 'Борисенко Михаил ', NULL, NULL, '79787473451', 0, NULL);
INSERT INTO public.contractors VALUES (511, 1, NULL, NULL, NULL, NULL, NULL, 'Борисенко МН 79787473448', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (512, 0, NULL, NULL, NULL, NULL, NULL, 'Борисенко Ф.Ф. ', NULL, NULL, '7 978 77 24 551', 0, NULL);
INSERT INTO public.contractors VALUES (513, 0, NULL, NULL, NULL, NULL, NULL, 'Борисенко Юрий_Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (514, 1, NULL, NULL, NULL, NULL, NULL, 'Борисова СВ 79788248853', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (515, 1, NULL, NULL, NULL, NULL, NULL, 'Борисовский ВП 79787701880', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (516, 0, NULL, NULL, NULL, NULL, NULL, 'Борисюк Н.Л. ', NULL, NULL, '7978 820 60 22', 0, NULL);
INSERT INTO public.contractors VALUES (517, 1, NULL, NULL, NULL, NULL, NULL, 'Боровиков И.В. ', NULL, NULL, '7978 73 76 155', 0, NULL);
INSERT INTO public.contractors VALUES (518, 1, NULL, NULL, NULL, NULL, NULL, 'Боровиков М.В. ', NULL, NULL, '79787376156', 0, NULL);
INSERT INTO public.contractors VALUES (519, 0, NULL, NULL, NULL, NULL, NULL, 'Боровков Петр ', NULL, NULL, '79785848247', 0, NULL);
INSERT INTO public.contractors VALUES (520, 1, NULL, NULL, NULL, NULL, NULL, 'Боровой В.М. ', NULL, NULL, '79788057536', 0, NULL);
INSERT INTO public.contractors VALUES (521, 0, NULL, NULL, NULL, NULL, NULL, 'Боровский ', NULL, NULL, '79787242599', 0, NULL);
INSERT INTO public.contractors VALUES (522, 1, NULL, NULL, NULL, NULL, NULL, 'Боровский А.В. ', NULL, NULL, '7 978 724 25 99', 0, NULL);
INSERT INTO public.contractors VALUES (523, 1, NULL, NULL, NULL, NULL, NULL, 'Бородай ЕВ 79787274808', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (524, 1, NULL, NULL, NULL, NULL, NULL, 'Бороденко В.Г. ', NULL, NULL, '7 978 71 333 21', 0, NULL);
INSERT INTO public.contractors VALUES (525, 1, NULL, NULL, NULL, NULL, NULL, 'Бородина Елена Витальевна (Николаевка) ', NULL, NULL, '7 978 085 60 16', 0, NULL);
INSERT INTO public.contractors VALUES (526, 1, NULL, NULL, NULL, NULL, NULL, 'Бортовский А.И. ', NULL, NULL, '7 978 722 29 81', 0, NULL);
INSERT INTO public.contractors VALUES (527, 1, NULL, NULL, NULL, NULL, NULL, 'Бортовский Ю.А. ', NULL, NULL, '79787223016', 0, NULL);
INSERT INTO public.contractors VALUES (528, 0, NULL, NULL, NULL, NULL, NULL, 'Бортовский Юрий ', NULL, NULL, '79787223016', 0, NULL);
INSERT INTO public.contractors VALUES (529, 0, NULL, NULL, NULL, NULL, NULL, 'Босько В.И. ', NULL, NULL, '7 989 773 46 45', 0, NULL);
INSERT INTO public.contractors VALUES (530, 0, NULL, NULL, NULL, NULL, NULL, 'Ботнарь А.С, ', NULL, NULL, '7 978 550 90 56', 0, NULL);
INSERT INTO public.contractors VALUES (531, 1, NULL, NULL, NULL, NULL, NULL, 'Боцион АВ 79787290623', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (532, 1, NULL, NULL, NULL, NULL, NULL, 'Бочегов СА 79788076728', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (533, 0, NULL, NULL, NULL, NULL, NULL, 'Бранец Д.В. ', NULL, NULL, '7 978 028 666 1', 0, NULL);
INSERT INTO public.contractors VALUES (534, 0, NULL, NULL, NULL, NULL, NULL, 'Бранец Дмитрий Владимирович ', NULL, NULL, '79787663040 ', 0, NULL);
INSERT INTO public.contractors VALUES (535, 1, NULL, NULL, NULL, NULL, NULL, 'Братковская В.В. ', NULL, NULL, '7 978 70 90 756', 0, NULL);
INSERT INTO public.contractors VALUES (536, 0, NULL, NULL, NULL, NULL, NULL, 'Бределева Лидия Юрьевна ', NULL, NULL, '79815585146', 0, NULL);
INSERT INTO public.contractors VALUES (537, 1, NULL, NULL, NULL, NULL, NULL, 'Брезгунов АВ 79787553027', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (538, 1, NULL, NULL, NULL, NULL, NULL, 'Брель П.П. ', NULL, NULL, '7 978 781 29 75', 0, NULL);
INSERT INTO public.contractors VALUES (539, 1, NULL, NULL, NULL, NULL, NULL, 'Бригада', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (540, 1, NULL, NULL, NULL, NULL, NULL, 'Брижахин НМ 79788349984', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (541, 0, NULL, NULL, NULL, NULL, NULL, 'Бриз ООО ', NULL, NULL, '7 978 803 13 15 ( дир. Оксана Владимировна)', 0, NULL);
INSERT INTO public.contractors VALUES (542, 1, NULL, NULL, NULL, NULL, NULL, 'Бродоцкий А.Ю. ', NULL, NULL, '7 987 82 77 776', 0, NULL);
INSERT INTO public.contractors VALUES (543, 1, NULL, NULL, NULL, NULL, NULL, 'Бродский Р ', NULL, NULL, '7978 747 54 88', 0, NULL);
INSERT INTO public.contractors VALUES (544, 2, NULL, NULL, NULL, NULL, NULL, 'Брусенко Ольга Сергеевна _Юрий ', NULL, NULL, '7 978 010 49 76 _Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (545, 1, NULL, NULL, NULL, NULL, NULL, 'Брындин Д 79165749957', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (546, 1, NULL, NULL, NULL, NULL, NULL, 'Брянова АИ ', NULL, NULL, '79787484130', 0, NULL);
INSERT INTO public.contractors VALUES (547, 0, NULL, NULL, NULL, NULL, 616301001, '"БСП"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (548, 1, NULL, NULL, NULL, NULL, NULL, 'Бубнов КЭ 79787071823', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (549, 1, NULL, NULL, NULL, NULL, NULL, 'Бугай П.В. ', NULL, NULL, '79788063238', 0, NULL);
INSERT INTO public.contractors VALUES (550, 1, NULL, NULL, NULL, NULL, NULL, 'Бугров ВА ', NULL, NULL, '79787368541', 0, NULL);
INSERT INTO public.contractors VALUES (551, 1, NULL, NULL, NULL, NULL, NULL, 'Бугров С.Н. ', NULL, NULL, '7 978 819 04 00', 0, NULL);
INSERT INTO public.contractors VALUES (552, 0, NULL, NULL, NULL, NULL, NULL, 'Будаков В.Г. ', NULL, NULL, '7 978 79 16 148', 0, NULL);
INSERT INTO public.contractors VALUES (553, 1, NULL, NULL, NULL, NULL, NULL, 'Будяк ПФ 79787158481', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (554, 1, NULL, NULL, NULL, NULL, NULL, 'Булавинцев ВВ 79787080773', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (555, 1, NULL, NULL, NULL, NULL, NULL, 'Буланович Алексей  (д.п.) - Л. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (556, 1, NULL, NULL, NULL, NULL, NULL, 'Булатов Ф.В. ', NULL, NULL, '7 978 847 55 09', 0, NULL);
INSERT INTO public.contractors VALUES (557, 0, NULL, NULL, NULL, NULL, NULL, 'Булатов Э.К. ', NULL, NULL, '7978 844 6113', 0, NULL);
INSERT INTO public.contractors VALUES (558, 0, NULL, NULL, NULL, NULL, NULL, 'Булатович В.Ю. ', NULL, NULL, '79787069703', 0, NULL);
INSERT INTO public.contractors VALUES (559, 1, NULL, NULL, NULL, NULL, NULL, 'Булах С.В. ', NULL, NULL, '7978 74 25 711', 0, NULL);
INSERT INTO public.contractors VALUES (560, 1, NULL, NULL, NULL, NULL, NULL, 'Булахов СС 79787628031', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (561, 1, NULL, NULL, NULL, NULL, NULL, 'Булаш О.С. ', NULL, NULL, '7 978 789 94 83', 0, NULL);
INSERT INTO public.contractors VALUES (562, 1, NULL, NULL, NULL, NULL, NULL, 'Булаш ОС 79780521727', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (563, 1, NULL, NULL, NULL, NULL, NULL, 'Булгаков П.В. ', NULL, NULL, '7 978 724 89 88', 0, NULL);
INSERT INTO public.contractors VALUES (564, 1, NULL, NULL, NULL, NULL, NULL, 'Булгаренко ПВ 79787978232', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (565, 0, NULL, NULL, NULL, NULL, NULL, 'Булдаков Владимир Степанович ', NULL, NULL, '79787903819', 0, NULL);
INSERT INTO public.contractors VALUES (566, 0, NULL, NULL, NULL, NULL, NULL, 'Буленков М.В. ', NULL, NULL, '7 978 77 35 575', 0, NULL);
INSERT INTO public.contractors VALUES (567, 1, NULL, NULL, NULL, NULL, NULL, 'Бунь М.Е. ', NULL, NULL, '7 978 844 98 77', 0, NULL);
INSERT INTO public.contractors VALUES (568, 1, NULL, NULL, NULL, NULL, NULL, 'Бурда В.И. ', NULL, NULL, '7 978 805 70 31', 0, NULL);
INSERT INTO public.contractors VALUES (569, 1, NULL, NULL, NULL, NULL, NULL, 'Бурдаков Н 79788495374', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (570, 0, NULL, NULL, NULL, NULL, NULL, 'Бурдин Владимир', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (571, 1, NULL, NULL, NULL, NULL, NULL, 'Бурдун НИ 79785499223', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (572, 1, NULL, NULL, NULL, NULL, NULL, 'Бурлака АВ 79787923475', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (573, 1, NULL, NULL, NULL, NULL, NULL, 'Бурнашев И.В. ', NULL, NULL, '7978 840 73 06', 0, NULL);
INSERT INTO public.contractors VALUES (574, 1, NULL, NULL, NULL, NULL, NULL, 'Буруков АА 79787110760', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (575, 1, NULL, NULL, NULL, NULL, NULL, 'Бурцев ВМ 79782742640', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (576, 1, NULL, NULL, NULL, NULL, NULL, 'Бурцева Галина Александрова  79788299210', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (577, 0, NULL, NULL, NULL, NULL, NULL, 'Буслаев Дмитрий ', NULL, NULL, '79788470209', 0, NULL);
INSERT INTO public.contractors VALUES (578, 0, NULL, NULL, NULL, NULL, NULL, 'Бутенко Андрей ', NULL, NULL, ' 7978 836 20 86', 0, NULL);
INSERT INTO public.contractors VALUES (579, 1, NULL, NULL, NULL, NULL, NULL, 'Бутрин Егор Александрович 89128137105', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (580, 0, NULL, NULL, NULL, NULL, NULL, 'Бутько Е.В. ', NULL, NULL, '7 978 878 85 20', 0, NULL);
INSERT INTO public.contractors VALUES (581, 0, NULL, NULL, NULL, NULL, NULL, 'Бушев С.М. ', NULL, NULL, '79781227123', 0, NULL);
INSERT INTO public.contractors VALUES (582, 1, NULL, NULL, NULL, NULL, NULL, 'Буштец 79781028301', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (583, 1, NULL, NULL, NULL, NULL, NULL, 'Бушуев В.А. ', NULL, NULL, '7 978 883 52 47', 0, NULL);
INSERT INTO public.contractors VALUES (584, 1, NULL, NULL, NULL, NULL, NULL, 'Быков В.В. ', NULL, NULL, '7 978 7 66 32 10', 0, NULL);
INSERT INTO public.contractors VALUES (585, 1, NULL, NULL, NULL, NULL, NULL, 'Быков Л.Л. ', NULL, NULL, '7 978 802 10 03', 0, NULL);
INSERT INTO public.contractors VALUES (586, 2, NULL, NULL, NULL, NULL, NULL, 'Быковский МБ 89104023005', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (587, 1, NULL, NULL, NULL, NULL, NULL, 'Быстров О.В. ', NULL, NULL, '7 978 713 79 96', 0, NULL);
INSERT INTO public.contractors VALUES (588, 0, NULL, NULL, NULL, NULL, NULL, 'Бычков Богдан ', NULL, NULL, '79787131779', 0, NULL);
INSERT INTO public.contractors VALUES (589, 1, NULL, NULL, NULL, NULL, NULL, 'Бычков ВА 79780037593', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (590, 1, NULL, NULL, NULL, NULL, NULL, 'Бычковский ИН 79788408061', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (591, 0, NULL, NULL, NULL, NULL, NULL, 'Вааков С.З. ', NULL, NULL, '7978 748 7353', 0, NULL);
INSERT INTO public.contractors VALUES (592, 1, NULL, NULL, NULL, NULL, NULL, 'Ваапов 79787484353', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (593, 1, NULL, NULL, NULL, NULL, NULL, 'Вагайцев А.Г. ', NULL, NULL, '7 978 00 40 855', 0, NULL);
INSERT INTO public.contractors VALUES (594, 0, NULL, NULL, NULL, NULL, NULL, 'Вагнер С.В. ', NULL, NULL, '7 978 730 89 59', 0, NULL);
INSERT INTO public.contractors VALUES (595, 1, NULL, NULL, NULL, NULL, NULL, 'Ваджипов ДТ 79788290936', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (596, 0, NULL, NULL, NULL, NULL, NULL, 'Ваджипов Э.Т. ', NULL, NULL, '7978 022 71 39', 0, NULL);
INSERT INTO public.contractors VALUES (597, 1, NULL, NULL, NULL, NULL, NULL, 'Вадик Гибщик', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (598, 0, NULL, NULL, NULL, NULL, NULL, 'Вадим ', NULL, NULL, '79265959442', 0, NULL);
INSERT INTO public.contractors VALUES (599, 2, NULL, NULL, NULL, NULL, NULL, 'Вадим Вандер ', NULL, NULL, '7 978 760 12 24 (д.п) Ан', 0, NULL);
INSERT INTO public.contractors VALUES (600, 0, NULL, NULL, NULL, NULL, NULL, 'Вадим Струков ', NULL, NULL, '7 978 505 4724 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (601, 1, NULL, NULL, NULL, NULL, NULL, 'Вайнаровский ВП 79787650417', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (602, 1, NULL, NULL, NULL, NULL, NULL, 'Вакалов А.С. ', NULL, NULL, '79787077900', 0, NULL);
INSERT INTO public.contractors VALUES (603, 1, NULL, NULL, NULL, NULL, NULL, 'Вакс ВН 79780930244', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (604, 1, NULL, NULL, NULL, NULL, NULL, 'Валединский Д.В. ', NULL, NULL, '79789445115', 0, NULL);
INSERT INTO public.contractors VALUES (605, 0, NULL, NULL, NULL, NULL, NULL, 'Валерий с Бинатела ', NULL, NULL, '7 978 902 65 37', 0, NULL);
INSERT INTO public.contractors VALUES (606, 1, NULL, NULL, NULL, NULL, NULL, 'Валл П.П. ', NULL, NULL, '7 978 8429995', 0, NULL);
INSERT INTO public.contractors VALUES (607, 1, NULL, NULL, NULL, NULL, NULL, 'Валуев И.Н ', NULL, NULL, '7978 002 87 70', 0, NULL);
INSERT INTO public.contractors VALUES (608, 0, NULL, NULL, NULL, NULL, NULL, 'Валькевич Н.В. ', NULL, NULL, '79787813392', 0, NULL);
INSERT INTO public.contractors VALUES (609, 0, NULL, NULL, NULL, NULL, NULL, 'Валяев Александр ', NULL, NULL, '79788957115', 0, NULL);
INSERT INTO public.contractors VALUES (610, 1, NULL, NULL, NULL, NULL, NULL, 'Валяев Юрий Иванович ', NULL, NULL, '79787508591', 0, NULL);
INSERT INTO public.contractors VALUES (611, 0, NULL, NULL, NULL, NULL, 911001001, 'ВАМП ООО -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (612, 1, NULL, NULL, NULL, NULL, NULL, 'Ваня станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (613, 1, NULL, NULL, NULL, NULL, NULL, 'Ваня цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (614, 0, NULL, NULL, NULL, NULL, NULL, 'Варакин Н.А. ', NULL, NULL, '79787158551', 0, NULL);
INSERT INTO public.contractors VALUES (615, 1, NULL, NULL, NULL, NULL, NULL, 'Варлашин АН 79788689792', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (616, 1, NULL, NULL, NULL, NULL, NULL, 'Варцабов Г.С.', NULL, NULL, '7978 899 39 80', 0, NULL);
INSERT INTO public.contractors VALUES (617, 2, NULL, NULL, NULL, NULL, NULL, 'Василенко А. Н. ( Родник ) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (618, 1, NULL, NULL, NULL, NULL, NULL, 'Василенко В.В. ', NULL, NULL, '7 910 158 91 15', 0, NULL);
INSERT INTO public.contractors VALUES (619, 1, NULL, NULL, NULL, NULL, NULL, 'Василенко ГС 79787882753', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (620, 1, NULL, NULL, NULL, NULL, NULL, 'Василенко СА ', NULL, NULL, '79787829970', 0, NULL);
INSERT INTO public.contractors VALUES (621, 1, NULL, NULL, NULL, NULL, NULL, 'Василец В.В. ', NULL, NULL, '7 978 73 209 75', 0, NULL);
INSERT INTO public.contractors VALUES (622, 1, NULL, NULL, NULL, NULL, NULL, 'Василец ВВ 79787320975', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (623, 1, NULL, NULL, NULL, NULL, NULL, 'Васильев И.В. ', NULL, NULL, '7 978 826 99 40', 0, NULL);
INSERT INTO public.contractors VALUES (624, 0, NULL, NULL, NULL, NULL, NULL, 'Васильев Н.А. ', NULL, NULL, '7 988 620 76 44', 0, NULL);
INSERT INTO public.contractors VALUES (625, 1, NULL, NULL, NULL, NULL, NULL, 'Васильев Никита ', NULL, NULL, '7 978 715 92 17', 0, NULL);
INSERT INTO public.contractors VALUES (626, 1, NULL, NULL, NULL, NULL, NULL, 'Васильковец А.И. ', NULL, NULL, '7 978 887 67 58', 0, NULL);
INSERT INTO public.contractors VALUES (627, 1, NULL, NULL, NULL, NULL, NULL, 'Васильченко А.В. ', NULL, NULL, '7 978 70 86 206 Крым Инвест Строй (И)', 0, NULL);
INSERT INTO public.contractors VALUES (628, 0, NULL, NULL, NULL, NULL, NULL, 'Васильченко Марина ', NULL, NULL, '7 978 756 01 76', 0, NULL);
INSERT INTO public.contractors VALUES (629, 1, NULL, NULL, NULL, NULL, NULL, 'Васина Т.С. ', NULL, NULL, '7 978 77 625 27', 0, NULL);
INSERT INTO public.contractors VALUES (630, 0, NULL, NULL, NULL, NULL, NULL, 'Ватутин А.М. ', NULL, NULL, '7978 130 10 33 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (631, 1, NULL, NULL, NULL, NULL, NULL, 'Ватцет 79787274580', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (632, 1, NULL, NULL, NULL, NULL, NULL, 'Вахрушева ТВ 79787437540', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (633, 1, NULL, NULL, NULL, NULL, NULL, 'Вахтанг ', NULL, NULL, '7 978 871 52 95', 0, NULL);
INSERT INTO public.contractors VALUES (634, 0, NULL, NULL, NULL, NULL, NULL, 'Ваш Дом Павел ', NULL, NULL, '7 978 723 23 29 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (635, 1, NULL, NULL, NULL, NULL, NULL, 'Ваш дом, Евгений, Севастополь, ', NULL, NULL, '7 978 700-70-07 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (636, 1, NULL, NULL, NULL, NULL, NULL, 'Вейсов З.А. ', NULL, NULL, '7 978 013 28 38', 0, NULL);
INSERT INTO public.contractors VALUES (637, 0, NULL, NULL, NULL, NULL, 910301001, 'ВЕК ООО- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (638, 1, NULL, NULL, NULL, NULL, NULL, 'Велес Варвара Анатольевна ', NULL, NULL, '79780362377', 0, NULL);
INSERT INTO public.contractors VALUES (639, 0, NULL, NULL, NULL, NULL, NULL, 'Велес ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (640, 0, NULL, NULL, NULL, NULL, 910901001, 'Велес-Крым ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (641, 1, NULL, NULL, NULL, NULL, NULL, 'Велигоцкий А.В. ', NULL, NULL, '7 978 728 18 95', 0, NULL);
INSERT INTO public.contractors VALUES (642, 1, NULL, NULL, NULL, NULL, NULL, 'Велиев АИ 79788663564', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (643, 1, NULL, NULL, NULL, NULL, NULL, 'Велиев В.А. ', NULL, NULL, '7 978 887 89 36', 0, NULL);
INSERT INTO public.contractors VALUES (644, 0, NULL, NULL, NULL, NULL, 910201001, 'ВЕЛИЙ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (645, 1, NULL, NULL, NULL, NULL, NULL, 'Великая Е.П. ', NULL, NULL, '7 978 837 44 64', 0, NULL);
INSERT INTO public.contractors VALUES (646, 1, NULL, NULL, NULL, NULL, NULL, 'Великов С.В. ', NULL, NULL, '7978 825 12 52', 0, NULL);
INSERT INTO public.contractors VALUES (647, 1, NULL, NULL, NULL, NULL, NULL, 'Велиулаве ДЗ 79788353786', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (648, 2, NULL, NULL, NULL, NULL, NULL, 'Величка Евгений (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (649, 1, NULL, NULL, NULL, NULL, NULL, 'Велишаев О.И. ', NULL, NULL, '7978 7621982 (Алушта) -А.', 0, NULL);
INSERT INTO public.contractors VALUES (650, 1, NULL, NULL, NULL, NULL, NULL, 'Венгер АВ 79883147138', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (651, 1, NULL, NULL, NULL, NULL, NULL, 'Веников В.С. ', NULL, NULL, '7978 79 87 518', 0, NULL);
INSERT INTO public.contractors VALUES (652, 0, NULL, NULL, NULL, NULL, NULL, 'Веников Владимир Сергеевич ', NULL, NULL, '7 978 79 87 518', 0, NULL);
INSERT INTO public.contractors VALUES (653, 1, NULL, NULL, NULL, NULL, NULL, 'Вербов Е.Ф. ', NULL, NULL, '7 978 74 72 890', 0, NULL);
INSERT INTO public.contractors VALUES (654, 1, NULL, NULL, NULL, NULL, NULL, 'Верден ', NULL, NULL, '7978 831 50 80', 0, NULL);
INSERT INTO public.contractors VALUES (655, 1, NULL, NULL, NULL, NULL, NULL, 'Верещака Д.К. ', NULL, NULL, '7978 713 92 51', 0, NULL);
INSERT INTO public.contractors VALUES (656, 1, NULL, NULL, NULL, NULL, NULL, 'Вернези А.Д. ', NULL, NULL, '79787602975', 0, NULL);
INSERT INTO public.contractors VALUES (657, 0, NULL, NULL, NULL, NULL, NULL, 'Вероника РОДНИК ', NULL, NULL, '7 978 212 9000 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (658, 0, NULL, NULL, NULL, NULL, NULL, 'Вертегел Вячеслав ', NULL, NULL, '7 978 269 01 63', 0, NULL);
INSERT INTO public.contractors VALUES (659, 1, NULL, NULL, NULL, NULL, NULL, 'Вершинин Ю.В. ', NULL, NULL, '7 978 00 40 889', 0, NULL);
INSERT INTO public.contractors VALUES (660, 0, NULL, NULL, NULL, NULL, NULL, 'Вершинина Марина ', NULL, NULL, '79788427708', 0, NULL);
INSERT INTO public.contractors VALUES (661, 1, NULL, NULL, NULL, NULL, NULL, 'Веселов АИ 79787929621', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (662, 1, NULL, NULL, NULL, NULL, NULL, 'Веселовка ', NULL, NULL, '79780051852 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (663, 1, NULL, NULL, NULL, NULL, NULL, 'Ветошкина И.Г. ', NULL, NULL, '7 978 725 47 39', 0, NULL);
INSERT INTO public.contractors VALUES (664, 1, NULL, NULL, NULL, NULL, NULL, 'Ветров ИГ 79787731992', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (665, 0, NULL, NULL, NULL, NULL, NULL, 'Вечная Стройка  (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (666, 0, NULL, NULL, NULL, NULL, NULL, 'ВЗМК 60   88115362880 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (667, 1, NULL, NULL, NULL, NULL, NULL, 'Видай ЕН 79780799622', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (668, 1, NULL, NULL, NULL, NULL, NULL, 'Видиборенко А.В. ', NULL, NULL, '7978 754 91 90', 0, NULL);
INSERT INTO public.contractors VALUES (669, 1, NULL, NULL, NULL, NULL, NULL, 'Виеро ВП 79787644781', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (670, 0, NULL, NULL, NULL, NULL, NULL, 'Виктор Николаевич г.Саки ', NULL, NULL, '7 978 007 29 54', 0, NULL);
INSERT INTO public.contractors VALUES (671, 0, NULL, NULL, NULL, NULL, NULL, 'Виктория ООО (Севастополь) д.п. ', NULL, NULL, '7978 768 4314 Сергей', 0, NULL);
INSERT INTO public.contractors VALUES (672, 0, NULL, NULL, NULL, NULL, NULL, 'Викторова ТГ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (673, 1, NULL, NULL, NULL, NULL, NULL, 'Вилен Марьино -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (761, 1, NULL, NULL, NULL, NULL, NULL, 'Гавриченко 79189832995', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (674, 1, NULL, NULL, NULL, NULL, NULL, 'Вилла де люкс (Надежда Ермолаева ', NULL, NULL, '7978 099 05 09) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (675, 1, NULL, NULL, NULL, NULL, NULL, 'Вильчинский АВ 79787512900', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (676, 0, NULL, NULL, NULL, NULL, NULL, 'Виля', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (677, 1, NULL, NULL, NULL, NULL, NULL, 'Винаев Р.И. ', NULL, NULL, '7978 787 73 75', 0, NULL);
INSERT INTO public.contractors VALUES (678, 1, NULL, NULL, NULL, NULL, NULL, 'Винник Е.А. ', NULL, NULL, '7 978 77 10 162', 0, NULL);
INSERT INTO public.contractors VALUES (679, 1, NULL, NULL, NULL, NULL, NULL, 'Винничук В.Р. ', NULL, NULL, '7 978 093 72 49', 0, NULL);
INSERT INTO public.contractors VALUES (680, 1, NULL, NULL, NULL, NULL, NULL, 'Винс СВ 79787645909', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (681, 1, NULL, NULL, NULL, NULL, NULL, 'Вирясов АД  ', NULL, NULL, '79787806691', 0, NULL);
INSERT INTO public.contractors VALUES (682, 0, NULL, NULL, NULL, NULL, NULL, 'Висич В.К. ', NULL, NULL, '7978 729 61 26', 0, NULL);
INSERT INTO public.contractors VALUES (683, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий (пр.) ', NULL, NULL, '7 978 71 22 660', 0, NULL);
INSERT INTO public.contractors VALUES (684, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий ', NULL, NULL, '7 978 791 84 45', 0, NULL);
INSERT INTO public.contractors VALUES (685, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий менеджер', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (686, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий Севастополь (И) 7978-205-10-20', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (687, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (688, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (689, 1, NULL, NULL, NULL, NULL, NULL, 'Виталий Ялта', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (690, 1, NULL, NULL, NULL, NULL, NULL, 'Витвитский НИ 79787062565', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (691, 1, NULL, NULL, NULL, NULL, NULL, 'Влад', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (692, 0, NULL, NULL, NULL, NULL, NULL, 'Влад Водитель Рич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (693, 0, NULL, NULL, NULL, NULL, NULL, 'Влад станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (694, 0, NULL, NULL, NULL, NULL, NULL, 'Владимир  ', NULL, NULL, '7 978 822 36 45 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (695, 0, NULL, NULL, NULL, NULL, NULL, 'Владимир Красноперекопск ', NULL, NULL, '7 978 875 37 61 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (696, 1, NULL, NULL, NULL, NULL, NULL, 'Власенко В.В. ', NULL, NULL, '7 978 824 09 96', 0, NULL);
INSERT INTO public.contractors VALUES (697, 0, NULL, NULL, NULL, NULL, NULL, 'Власенко Юрий Владимирович 89824779297', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (698, 1, NULL, NULL, NULL, NULL, NULL, 'Власков В.Н. ', NULL, NULL, '7 978 843 16 44', 0, NULL);
INSERT INTO public.contractors VALUES (699, 1, NULL, NULL, NULL, NULL, NULL, 'Власов АП 79787223475', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (700, 1, NULL, NULL, NULL, NULL, NULL, 'Власов М.Ю. ', NULL, NULL, '79183401769', 0, NULL);
INSERT INTO public.contractors VALUES (701, 0, NULL, NULL, NULL, NULL, NULL, 'Власов Юрий ', NULL, NULL, '7 978 78 14 701', 0, NULL);
INSERT INTO public.contractors VALUES (702, 1, NULL, NULL, NULL, NULL, NULL, 'Власова ЛГ 79787533655', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (703, 1, NULL, NULL, NULL, NULL, NULL, 'Вова гибщик', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (704, 1, NULL, NULL, NULL, NULL, NULL, 'Вовк Г.В. ', NULL, NULL, '79787238407', 0, NULL);
INSERT INTO public.contractors VALUES (705, 1, NULL, NULL, NULL, NULL, NULL, 'Вовк Д.А. ', NULL, NULL, '7 978 7811462, ', 0, NULL);
INSERT INTO public.contractors VALUES (706, 1, NULL, NULL, NULL, NULL, NULL, 'Водолащенко А.Г 7978-79-17-009', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (707, 1, NULL, NULL, NULL, NULL, NULL, 'Воевуцкая НФ 79788749752', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (708, 1, NULL, NULL, NULL, NULL, NULL, 'Войтенко К.М. ', NULL, NULL, '7978 862 76 19', 0, NULL);
INSERT INTO public.contractors VALUES (709, 1, NULL, NULL, NULL, NULL, NULL, 'Войтенко М.В. ', NULL, NULL, '79787230742', 0, NULL);
INSERT INTO public.contractors VALUES (710, 1, NULL, NULL, NULL, NULL, NULL, 'Войтицкий ИД 79787122067', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (711, 1, NULL, NULL, NULL, NULL, NULL, 'Волдобин В.А. ', NULL, NULL, '7978 784 50 90', 0, NULL);
INSERT INTO public.contractors VALUES (712, 1, NULL, NULL, NULL, NULL, NULL, 'Волик И.А. ', NULL, NULL, '7 978 70 68 447', 0, NULL);
INSERT INTO public.contractors VALUES (713, 1, NULL, NULL, NULL, NULL, NULL, 'Волков А.А. ', NULL, NULL, '7 978 733 98 47', 0, NULL);
INSERT INTO public.contractors VALUES (714, 0, NULL, NULL, NULL, NULL, NULL, 'Волков А.С. ', NULL, NULL, '7 978 709 24 12', 0, NULL);
INSERT INTO public.contractors VALUES (715, 1, NULL, NULL, NULL, NULL, NULL, 'Волков АН 79788106414', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (716, 1, NULL, NULL, NULL, NULL, NULL, 'Волков В.Н. ', NULL, NULL, '7 978 752 87 98', 0, NULL);
INSERT INTO public.contractors VALUES (717, 1, NULL, NULL, NULL, NULL, NULL, 'Волков В.Н. ', NULL, NULL, '7978 75 169 58 (5%)', 0, NULL);
INSERT INTO public.contractors VALUES (718, 1, NULL, NULL, NULL, NULL, NULL, 'Волков Д 79787719912', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (719, 1, NULL, NULL, NULL, NULL, NULL, 'Волкова И.Ю. ', NULL, NULL, '79787353851', 0, NULL);
INSERT INTO public.contractors VALUES (720, 1, NULL, NULL, NULL, NULL, NULL, 'Волкогонов Александр ', NULL, NULL, '7978 142 08 20', 0, NULL);
INSERT INTO public.contractors VALUES (721, 1, NULL, NULL, NULL, NULL, NULL, 'Волобуев 79787647393', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (722, 1, NULL, NULL, NULL, NULL, NULL, 'Волобуев В.В. ', NULL, NULL, '79787518152', 0, NULL);
INSERT INTO public.contractors VALUES (723, 0, NULL, NULL, NULL, NULL, NULL, 'Володин Андрей ', NULL, NULL, '79787845090', 0, NULL);
INSERT INTO public.contractors VALUES (724, 1, NULL, NULL, NULL, NULL, NULL, 'Володин ВС ', NULL, NULL, '79782040131', 0, NULL);
INSERT INTO public.contractors VALUES (725, 1, NULL, NULL, NULL, NULL, NULL, 'Володин С.Г. ', NULL, NULL, '7978 849 41 98', 0, NULL);
INSERT INTO public.contractors VALUES (726, 1, NULL, NULL, NULL, NULL, NULL, 'Волошенко А.С. ', NULL, NULL, '7978 764 23 78', 0, NULL);
INSERT INTO public.contractors VALUES (727, 1, NULL, NULL, NULL, NULL, NULL, 'Волощук В.Н. ', NULL, NULL, '7978 751 62 16', 0, NULL);
INSERT INTO public.contractors VALUES (728, 0, NULL, NULL, NULL, NULL, NULL, 'Воробьев А.А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (729, 1, NULL, NULL, NULL, NULL, NULL, 'Воробьев В.И. ', NULL, NULL, '7978 710 99 95', 0, NULL);
INSERT INTO public.contractors VALUES (730, 0, NULL, NULL, NULL, NULL, NULL, 'Воробьев Игорь ', NULL, NULL, '79787080846', 0, NULL);
INSERT INTO public.contractors VALUES (731, 1, NULL, NULL, NULL, NULL, NULL, 'Воробьев Олег Александрович ', NULL, NULL, '79788350309', 0, NULL);
INSERT INTO public.contractors VALUES (732, 1, NULL, NULL, NULL, NULL, NULL, 'Воробьев ПА 79788742627', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (733, 1, NULL, NULL, NULL, NULL, NULL, 'Воронин ВВ ', NULL, NULL, '79780815896', 0, NULL);
INSERT INTO public.contractors VALUES (734, 1, NULL, NULL, NULL, NULL, NULL, 'Воронин Денис ', NULL, NULL, '7978 021 43 11', 0, NULL);
INSERT INTO public.contractors VALUES (735, 1, NULL, NULL, NULL, NULL, NULL, 'Воронков Н.В. ', NULL, NULL, ' 7 978 75 52 845', 0, NULL);
INSERT INTO public.contractors VALUES (736, 0, NULL, NULL, NULL, NULL, NULL, 'Воронцов 79781086419', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (737, 0, NULL, NULL, NULL, NULL, NULL, 'Воронцов О.Е. ', NULL, NULL, '7978 746 98 18', 0, NULL);
INSERT INTO public.contractors VALUES (738, 0, NULL, NULL, NULL, NULL, NULL, 'Воропаев В.С. ', NULL, NULL, '7 978 810 29 77', 0, NULL);
INSERT INTO public.contractors VALUES (739, 1, NULL, NULL, NULL, NULL, NULL, 'Воропай К.А. ', NULL, NULL, '7 978 815 79 30', 0, NULL);
INSERT INTO public.contractors VALUES (740, 1, NULL, NULL, NULL, NULL, NULL, 'Воротников Сергей Иванович ', NULL, NULL, '7978 748 43 44', 0, NULL);
INSERT INTO public.contractors VALUES (741, 0, NULL, NULL, NULL, NULL, NULL, 'Ворошилов О.И.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (742, 1, NULL, NULL, NULL, NULL, NULL, 'Ворфлик А.В. ', NULL, NULL, '7 978 271 83 77', 0, NULL);
INSERT INTO public.contractors VALUES (743, 1, NULL, NULL, NULL, NULL, NULL, 'Восток сервис ', NULL, NULL, '7 978 125 05 37 Олег', 0, NULL);
INSERT INTO public.contractors VALUES (744, 1, NULL, NULL, NULL, NULL, NULL, 'Востриков АВ 79787751770', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (745, 1, NULL, NULL, NULL, NULL, NULL, 'Вострухин ЮН 79787033078', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (746, 1, NULL, NULL, NULL, NULL, NULL, 'Врублевский РВ 79787419060', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (747, 0, NULL, NULL, NULL, NULL, 910301001, '"ВСЕ ДЛЯ КРОВЛИ"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (748, 0, NULL, NULL, NULL, NULL, NULL, 'ВСК (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (749, 0, NULL, NULL, NULL, NULL, 910201001, '"ВСК""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (750, 1, NULL, NULL, NULL, NULL, NULL, 'Выгулярный М.А. ', NULL, NULL, '7 978 73 71 446', 0, NULL);
INSERT INTO public.contractors VALUES (751, 1, NULL, NULL, NULL, NULL, NULL, 'Вырвихвост И.В., ', NULL, NULL, '7 978 834 96 32', 0, NULL);
INSERT INTO public.contractors VALUES (752, 0, NULL, NULL, NULL, NULL, NULL, 'Высокова Людмила ', NULL, NULL, '7 978 25 99 077', 0, NULL);
INSERT INTO public.contractors VALUES (753, 1, NULL, NULL, NULL, NULL, NULL, 'Высоцкий А.В. ', NULL, NULL, '7978 77 30 171', 0, NULL);
INSERT INTO public.contractors VALUES (754, 1, NULL, NULL, NULL, NULL, NULL, 'Высоцкий В.Н. ', NULL, NULL, '7978 753 14 69', 0, NULL);
INSERT INTO public.contractors VALUES (755, 1, NULL, NULL, NULL, NULL, NULL, 'Вяльшин РШ 89151012020', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (756, 1, NULL, NULL, NULL, NULL, NULL, 'Габьев АА 79788649348', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (757, 1, NULL, NULL, NULL, NULL, NULL, 'Гаврилец 79788480601', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (758, 1, NULL, NULL, NULL, NULL, NULL, 'Гаврилов Александр ', NULL, NULL, '7978 874 10 74', 0, NULL);
INSERT INTO public.contractors VALUES (759, 0, NULL, NULL, NULL, NULL, NULL, 'Гаврилов Дмитрий ', NULL, NULL, '79787483782 ', 0, NULL);
INSERT INTO public.contractors VALUES (760, 0, NULL, NULL, NULL, NULL, NULL, 'Гавриляк Татьяна Степановна ', NULL, NULL, '79788932073', 0, NULL);
INSERT INTO public.contractors VALUES (762, 0, NULL, NULL, NULL, NULL, NULL, 'Гавриченко С.В. ', NULL, NULL, '79189832995', 0, NULL);
INSERT INTO public.contractors VALUES (763, 1, NULL, NULL, NULL, NULL, NULL, 'Гаврюшенко А.А. ', NULL, NULL, '7 978 0799 633', 0, NULL);
INSERT INTO public.contractors VALUES (764, 1, NULL, NULL, NULL, NULL, NULL, 'Гагаринов А.П., ', NULL, NULL, '7 978 767 11 15', 0, NULL);
INSERT INTO public.contractors VALUES (765, 0, NULL, NULL, NULL, NULL, NULL, 'Гаджиев Юрий ', NULL, NULL, '79788452753', 0, NULL);
INSERT INTO public.contractors VALUES (766, 0, NULL, NULL, NULL, NULL, NULL, 'Гаевская З.А. ', NULL, NULL, '7 978 824 10 37', 0, NULL);
INSERT INTO public.contractors VALUES (767, 0, NULL, NULL, NULL, NULL, NULL, 'Гаевский Ю.В.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (768, 0, NULL, NULL, NULL, NULL, 526201001, '"ГАЗСТРОЙ""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (769, 1, NULL, NULL, NULL, NULL, NULL, 'Галайко А.И. ', NULL, NULL, '7 978 828 33 63', 0, NULL);
INSERT INTO public.contractors VALUES (770, 1, NULL, NULL, NULL, NULL, NULL, 'Галета Н.И. ', NULL, NULL, '7978 77 32 318', 0, NULL);
INSERT INTO public.contractors VALUES (771, 1, NULL, NULL, NULL, NULL, NULL, 'Галищев А.В. ', NULL, NULL, '7 978 753 60 17', 0, NULL);
INSERT INTO public.contractors VALUES (772, 0, NULL, NULL, NULL, NULL, NULL, 'Галищев А.В. ', NULL, NULL, '7 978 753 60 17', 0, NULL);
INSERT INTO public.contractors VALUES (773, 1, NULL, NULL, NULL, NULL, NULL, 'Галищук Илья ', NULL, NULL, '7 978 711 75 35', 0, NULL);
INSERT INTO public.contractors VALUES (774, 1, NULL, NULL, NULL, NULL, NULL, 'Галкин АЮ 79788793321', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (775, 0, NULL, NULL, NULL, NULL, NULL, 'Галла Строй Плюс ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (776, 1, NULL, NULL, NULL, NULL, NULL, 'Галоян Л.Ж. ', NULL, NULL, '7978 860 18 53', 0, NULL);
INSERT INTO public.contractors VALUES (777, 1, NULL, NULL, NULL, NULL, NULL, 'Галынин ВФ 79787725393', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (778, 2, NULL, NULL, NULL, NULL, NULL, 'Гамма-Групп (Бахчисарай)  -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (779, 1, NULL, NULL, NULL, NULL, NULL, 'Ганин А.С. ', NULL, NULL, '7 978 049 50 63', 0, NULL);
INSERT INTO public.contractors VALUES (780, 1, NULL, NULL, NULL, NULL, NULL, 'Гапоненко М.С. ', NULL, NULL, '7 978 73 41 236', 0, NULL);
INSERT INTO public.contractors VALUES (781, 1, NULL, NULL, NULL, NULL, NULL, 'Гапонюк ВВ 79787193478', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (782, 1, NULL, NULL, NULL, NULL, NULL, 'Гаран С кп79781189578', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (783, 1, NULL, NULL, NULL, NULL, NULL, 'Гарановский В.В. ', NULL, NULL, '79787080865', 0, NULL);
INSERT INTO public.contractors VALUES (784, 0, NULL, NULL, NULL, NULL, NULL, 'Гарант Сервис', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (785, 0, NULL, NULL, NULL, NULL, NULL, 'Гарант Строй (Евпатория) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (786, 0, NULL, NULL, NULL, NULL, NULL, 'Гарант Строй Крым  -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (787, 0, NULL, NULL, NULL, NULL, NULL, 'Гарашко А.Н. ', NULL, NULL, '7978830-20-30', 0, NULL);
INSERT INTO public.contractors VALUES (788, 1, NULL, NULL, NULL, NULL, NULL, 'Гарифулин Т ', NULL, NULL, '79780754714', 0, NULL);
INSERT INTO public.contractors VALUES (789, 1, NULL, NULL, NULL, NULL, NULL, 'Гарифулин Т ', NULL, NULL, '79780754714', 0, NULL);
INSERT INTO public.contractors VALUES (790, 1, NULL, NULL, NULL, NULL, NULL, 'Гаркулич АН 79780542095', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (791, 0, NULL, NULL, NULL, NULL, NULL, 'Гаршина Виктория ', NULL, NULL, '7 978 73 82 176', 0, NULL);
INSERT INTO public.contractors VALUES (792, 0, NULL, NULL, NULL, NULL, NULL, 'Гаршина Виктория ', NULL, NULL, '797870382176', 0, NULL);
INSERT INTO public.contractors VALUES (793, 0, NULL, NULL, NULL, NULL, NULL, 'Гасанов Руслан ', NULL, NULL, '79787382588', 0, NULL);
INSERT INTO public.contractors VALUES (794, 1, NULL, NULL, NULL, NULL, NULL, 'Гатилов СВ 79787455518', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (795, 0, NULL, NULL, NULL, NULL, NULL, 'Гафаров Мурат ', NULL, NULL, '7 978 84 67 558', 0, NULL);
INSERT INTO public.contractors VALUES (796, 0, NULL, NULL, NULL, NULL, NULL, 'Гафаров Назим ', NULL, NULL, '7 978 760 03 84', 0, NULL);
INSERT INTO public.contractors VALUES (797, 1, NULL, NULL, NULL, NULL, NULL, 'Гафаров Руслан ', NULL, NULL, '7 978 76 41 095', 0, NULL);
INSERT INTO public.contractors VALUES (798, 1, NULL, NULL, NULL, NULL, NULL, 'Гафаров Эльвис', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (799, 1, NULL, NULL, NULL, NULL, NULL, 'Гафаров Эльвис ', NULL, NULL, ' 7 978 7853309', 0, NULL);
INSERT INTO public.contractors VALUES (800, 0, NULL, NULL, NULL, NULL, NULL, 'Гацко Анатолий ', NULL, NULL, '7 978 816 70 51', 0, NULL);
INSERT INTO public.contractors VALUES (801, 0, NULL, NULL, NULL, NULL, NULL, '"ГБУ РК ""Крымская ГГМЭ"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (802, 0, NULL, NULL, NULL, NULL, NULL, '"ГБУ РК ""РСТЦ ""Крым-Спорт"" ', NULL, NULL, '7978 7246641"', 0, NULL);
INSERT INTO public.contractors VALUES (803, 0, NULL, NULL, NULL, NULL, NULL, '"ГБУЗ РК "" РЕСПУБЛИКАНСКАЯ ДЕТСКАЯ КЛИНИЧЕСКАЯ БОЛЬНИЦА"" ', NULL, NULL, '7 978 734 32 92 Андрей Григорьевич"', 0, NULL);
INSERT INTO public.contractors VALUES (804, 0, NULL, NULL, NULL, NULL, NULL, 'ГБУЗ РК КРЦМКИСМП 3652519543', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (805, 1, NULL, NULL, NULL, NULL, NULL, 'Гвоздик С.В. ', NULL, NULL, '7 978 827 56 47', 0, NULL);
INSERT INTO public.contractors VALUES (806, 0, NULL, NULL, NULL, NULL, NULL, 'ГВСУ № 7 Бельбек Никита - Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (807, 0, NULL, NULL, NULL, NULL, NULL, 'Геворкян Р.Е. ', NULL, NULL, '7978 73 40 165', 0, NULL);
INSERT INTO public.contractors VALUES (808, 1, NULL, NULL, NULL, NULL, NULL, 'Геденидзе В.В. ', NULL, NULL, '7978 871 52 95', 0, NULL);
INSERT INTO public.contractors VALUES (809, 0, NULL, NULL, NULL, NULL, NULL, 'Гей Д.В. ', NULL, NULL, '7988 98 88 18 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (810, 0, NULL, NULL, NULL, NULL, NULL, 'Гек С.Б. ', NULL, NULL, '7 978 7313243', 0, NULL);
INSERT INTO public.contractors VALUES (811, 1, NULL, NULL, NULL, NULL, NULL, 'Гениатулин А 78797531121 к п', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (812, 0, NULL, NULL, NULL, NULL, NULL, 'Геннадий (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (813, 0, NULL, NULL, NULL, NULL, NULL, 'Геннадий Г.В.(И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (814, 1, NULL, NULL, NULL, NULL, NULL, 'Георгий Николаевич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (815, 1, NULL, NULL, NULL, NULL, NULL, 'Герак М.В. ', NULL, NULL, '7 978 730 29 15', 0, NULL);
INSERT INTO public.contractors VALUES (816, 1, NULL, NULL, NULL, NULL, NULL, 'Герасиков Александр ', NULL, NULL, '7978 83 70 412', 0, NULL);
INSERT INTO public.contractors VALUES (817, 1, NULL, NULL, NULL, NULL, NULL, 'Герасимов Г.В. ', NULL, NULL, '7978 781 78 46', 0, NULL);
INSERT INTO public.contractors VALUES (818, 1, NULL, NULL, NULL, NULL, NULL, 'Герасимчук НН 79788239528', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (819, 0, NULL, NULL, NULL, NULL, NULL, 'Гермак А.В. ', NULL, NULL, '79787522083', 0, NULL);
INSERT INTO public.contractors VALUES (820, 1, NULL, NULL, NULL, NULL, NULL, 'Герман 8978 740 49 23', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (821, 1, NULL, NULL, NULL, NULL, NULL, 'Герман А.Ю. ', NULL, NULL, '7 978 706 67 53', 0, NULL);
INSERT INTO public.contractors VALUES (822, 0, NULL, NULL, NULL, NULL, NULL, 'Германчю Г.Г.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (823, 1, NULL, NULL, NULL, NULL, NULL, 'Гермес', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (824, 0, NULL, NULL, NULL, 1838019019, 910201001, '"ГЕРМЕССТРОЙ"", Рафиль _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (825, 0, NULL, NULL, NULL, NULL, NULL, 'Гертье В.В.', NULL, NULL, ' 7 978 228 04 09', 0, NULL);
INSERT INTO public.contractors VALUES (826, 0, NULL, NULL, NULL, NULL, NULL, 'Гетьман П.П. ', NULL, NULL, '7 978 72 25 889', 0, NULL);
INSERT INTO public.contractors VALUES (827, 0, NULL, NULL, NULL, NULL, 502901001, 'ГЕФЕСТ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (828, 0, NULL, NULL, NULL, NULL, NULL, 'Гефест СМЦ (Саки) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (829, 0, NULL, NULL, NULL, NULL, NULL, 'ГефестСтройИнвест', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (830, 0, NULL, NULL, NULL, NULL, 920101001, '"ГЕФЕСТСТРОЙИНВЕСТ"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (831, 1, NULL, NULL, NULL, NULL, NULL, 'Гибщики Бибо и Бобо', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (832, 1, NULL, NULL, NULL, NULL, NULL, 'Гибщики Сергей и Александр', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (833, 0, NULL, NULL, NULL, NULL, 920101001, 'ГИДРОЗАЩИТА ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (834, 0, NULL, NULL, NULL, NULL, 910201001, 'ГИП МОНОЛИТ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (835, 2, NULL, NULL, NULL, NULL, NULL, 'Гирда А.А. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (836, 1, NULL, NULL, NULL, NULL, NULL, 'Гирко ИМ 79787846970', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (837, 1, NULL, NULL, NULL, NULL, NULL, 'Гирский В.В. ', NULL, NULL, '7978 87 81 891', 0, NULL);
INSERT INTO public.contractors VALUES (838, 0, NULL, NULL, NULL, NULL, NULL, 'Гирский Виктор Васильевич ', NULL, NULL, '79788781891', 0, NULL);
INSERT INTO public.contractors VALUES (839, 1, NULL, NULL, NULL, NULL, NULL, 'Гирский Д.А. ', NULL, NULL, '7978 724 84 15', 0, NULL);
INSERT INTO public.contractors VALUES (840, 0, NULL, NULL, NULL, NULL, NULL, 'ГК Владоград', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (841, 1, NULL, NULL, NULL, NULL, NULL, 'ГКУ РК Безопасный регион ', NULL, NULL, '7978 804 92 55', 0, NULL);
INSERT INTO public.contractors VALUES (842, 1, NULL, NULL, NULL, NULL, NULL, 'Главацкий С.Д. ', NULL, NULL, '7978 105 14 50', 0, NULL);
INSERT INTO public.contractors VALUES (843, 0, NULL, NULL, NULL, NULL, NULL, 'Глацкий С.Д. ', NULL, NULL, '7978 105 14 50', 0, NULL);
INSERT INTO public.contractors VALUES (844, 0, NULL, NULL, NULL, NULL, 540701001, '"ГЛОБУС - АЛЬЯНС"", Илья ', NULL, NULL, '7 978 845 57 62_Л. (д.п.) ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (845, 0, NULL, NULL, NULL, NULL, NULL, 'Глуховский Владимир ', NULL, NULL, '79788584266', 0, NULL);
INSERT INTO public.contractors VALUES (846, 1, NULL, NULL, NULL, NULL, NULL, 'Глушак АИ 79787340940', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (847, 0, NULL, NULL, NULL, NULL, NULL, 'Глушак Эдуард Анатольевич ', NULL, NULL, '79787550247', 0, NULL);
INSERT INTO public.contractors VALUES (848, 1, NULL, NULL, NULL, NULL, NULL, 'Глушич А.А. ', NULL, NULL, '7978 72 81 984', 0, NULL);
INSERT INTO public.contractors VALUES (849, 1, NULL, NULL, NULL, NULL, NULL, 'Глущенко Д.В. ', NULL, NULL, '7 995 188 61 40', 0, NULL);
INSERT INTO public.contractors VALUES (850, 1, NULL, NULL, NULL, NULL, NULL, 'Гнатюк ИВ79787586563', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (851, 0, NULL, NULL, NULL, NULL, NULL, 'Гнездилов А.Н. ', NULL, NULL, '7978 827 9151 (Севастополь)', 0, NULL);
INSERT INTO public.contractors VALUES (852, 1, NULL, NULL, NULL, NULL, NULL, 'Гниловской Д.П. ', NULL, NULL, '7978 835 17 40', 0, NULL);
INSERT INTO public.contractors VALUES (853, 1, NULL, NULL, NULL, NULL, NULL, 'Гнчаренко ЮВ 79787086563', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (854, 1, NULL, NULL, NULL, NULL, NULL, 'Голенков С.А. ', NULL, NULL, '7 978 75 87 195', 0, NULL);
INSERT INTO public.contractors VALUES (855, 1, NULL, NULL, NULL, NULL, NULL, 'Голец П.О. ', NULL, NULL, '7 978 111 96 68', 0, NULL);
INSERT INTO public.contractors VALUES (856, 1, NULL, NULL, NULL, NULL, NULL, 'Голиков К.Л. ', NULL, NULL, '7978 718 72 30', 0, NULL);
INSERT INTO public.contractors VALUES (857, 0, NULL, NULL, NULL, NULL, NULL, 'Голиков О.Ю. ', NULL, NULL, '7 978 222 84 14', 0, NULL);
INSERT INTO public.contractors VALUES (858, 1, NULL, NULL, NULL, NULL, NULL, 'Голикова С.С. ', NULL, NULL, '7 978 723 93 10', 0, NULL);
INSERT INTO public.contractors VALUES (859, 1, NULL, NULL, NULL, NULL, NULL, 'Голинко Максим ', NULL, NULL, '79788021591', 0, NULL);
INSERT INTO public.contractors VALUES (860, 1, NULL, NULL, NULL, NULL, NULL, 'Голобородько Константин ', NULL, NULL, '7 978 766-25-59', 0, NULL);
INSERT INTO public.contractors VALUES (861, 1, NULL, NULL, NULL, NULL, NULL, 'Головатый В.А. ', NULL, NULL, '7 978 846 97 92', 0, NULL);
INSERT INTO public.contractors VALUES (862, 1, NULL, NULL, NULL, NULL, NULL, 'Головин Д.В. ', NULL, NULL, '7 978 841 37 07', 0, NULL);
INSERT INTO public.contractors VALUES (863, 0, NULL, NULL, NULL, NULL, NULL, 'Головко Александр ', NULL, NULL, '7 978 733 92 32', 0, NULL);
INSERT INTO public.contractors VALUES (864, 1, NULL, NULL, NULL, NULL, NULL, 'Головко ЕИ 79785557520', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (865, 0, NULL, NULL, NULL, NULL, NULL, 'Головченко В.В. ', NULL, NULL, '7 978 957 39 89', 0, NULL);
INSERT INTO public.contractors VALUES (866, 1, NULL, NULL, NULL, NULL, NULL, 'Голубев АМ ', NULL, NULL, '79788150342', 0, NULL);
INSERT INTO public.contractors VALUES (867, 1, NULL, NULL, NULL, NULL, NULL, 'Голубев Виталий ', NULL, NULL, '7978 046 74 27', 0, NULL);
INSERT INTO public.contractors VALUES (868, 2, NULL, NULL, NULL, NULL, NULL, 'Голубев С. С.  СИМФЕРОПОЛЬ ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (869, 0, NULL, NULL, NULL, NULL, NULL, 'Голубева Н.А. ', NULL, NULL, '7 978 701 57 20', 0, NULL);
INSERT INTO public.contractors VALUES (870, 0, NULL, NULL, NULL, NULL, NULL, 'Голубова С.И. ', NULL, NULL, '7 978 815 03 28', 0, NULL);
INSERT INTO public.contractors VALUES (871, 0, NULL, NULL, NULL, NULL, NULL, 'Голубович Н. ', NULL, NULL, '7 978 7536 164', 0, NULL);
INSERT INTO public.contractors VALUES (872, 1, NULL, NULL, NULL, NULL, NULL, 'Гоменюк Д.Д. ', NULL, NULL, '7978 75 69 947', 0, NULL);
INSERT INTO public.contractors VALUES (873, 1, NULL, NULL, NULL, NULL, NULL, 'Гонтарь В.П. ', NULL, NULL, '7 978 064 09 44', 0, NULL);
INSERT INTO public.contractors VALUES (874, 1, NULL, NULL, NULL, NULL, NULL, 'Гончар С.В. ', NULL, NULL, '7 978 082 02 71', 0, NULL);
INSERT INTO public.contractors VALUES (875, 1, NULL, NULL, NULL, NULL, NULL, 'Гончаренко А.В. ', NULL, NULL, '7 978 750 45 28', 0, NULL);
INSERT INTO public.contractors VALUES (876, 1, NULL, NULL, NULL, NULL, NULL, 'Гончаренко В.В. ', NULL, NULL, '7 978 7080 255', 0, NULL);
INSERT INTO public.contractors VALUES (877, 1, NULL, NULL, NULL, NULL, NULL, 'Гончаренко В.В. ', NULL, NULL, '7 978 71 83 303', 0, NULL);
INSERT INTO public.contractors VALUES (878, 0, NULL, NULL, NULL, NULL, NULL, 'Гончаренко В.Н. ', NULL, NULL, '7 978 771 77 50', 0, NULL);
INSERT INTO public.contractors VALUES (879, 1, NULL, NULL, NULL, NULL, NULL, 'Гончаренко П.В. ', NULL, NULL, '79787923507', 0, NULL);
INSERT INTO public.contractors VALUES (880, 1, NULL, NULL, NULL, NULL, NULL, 'Гончаров В.А. ', NULL, NULL, '7978 718 37 33', 0, NULL);
INSERT INTO public.contractors VALUES (881, 1, NULL, NULL, NULL, NULL, NULL, 'Гончаров С.Ю. ', NULL, NULL, '7 978 848 95 25', 0, NULL);
INSERT INTO public.contractors VALUES (882, 1, NULL, NULL, NULL, NULL, NULL, 'Гончарук НП 79787569717', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (883, 0, NULL, NULL, NULL, NULL, NULL, 'Горбатюк Дмитрий (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (884, 0, NULL, NULL, NULL, NULL, NULL, 'Горгола Алексей ', NULL, NULL, '79785787260', 0, NULL);
INSERT INTO public.contractors VALUES (885, 1, NULL, NULL, NULL, NULL, NULL, 'Гордеев Н 79787460343', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (886, 1, NULL, NULL, NULL, NULL, NULL, 'Горденко Т.В. ', NULL, NULL, '79780572870', 0, NULL);
INSERT INTO public.contractors VALUES (887, 0, NULL, NULL, NULL, NULL, NULL, 'Гордиенко Роман ', NULL, NULL, '7 978 127 6047 ', 0, NULL);
INSERT INTO public.contractors VALUES (888, 1, NULL, NULL, NULL, NULL, NULL, 'Гореликов А.А. ', NULL, NULL, '7978 763 47 33', 0, NULL);
INSERT INTO public.contractors VALUES (889, 1, NULL, NULL, NULL, NULL, NULL, 'Горелкин АГ 79788217544', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (890, 1, NULL, NULL, NULL, NULL, NULL, 'Горецкий АС 79787159030', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (891, 1, NULL, NULL, NULL, NULL, NULL, 'Городов А.С. ', NULL, NULL, '7978 816 18 89 Ан (кр)', 0, NULL);
INSERT INTO public.contractors VALUES (892, 0, NULL, NULL, NULL, NULL, NULL, 'Городок  Андриенко Р. 978-259-80-99  ( И ) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (893, 0, NULL, NULL, NULL, NULL, NULL, 'Городок  Андриенко Р. 978-259-80-99 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (894, 0, NULL, NULL, NULL, NULL, NULL, 'Городок (Джанкой) Олег ', NULL, NULL, '7978 099 10 40 Олег', 0, NULL);
INSERT INTO public.contractors VALUES (895, 0, NULL, NULL, NULL, NULL, NULL, 'Гороховский В.А. ', NULL, NULL, '79180519392', 0, NULL);
INSERT INTO public.contractors VALUES (896, 1, NULL, NULL, NULL, NULL, NULL, 'Горусов 79787914696', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (897, 1, NULL, NULL, NULL, NULL, NULL, 'Горусов Владимир ', NULL, NULL, '7 978 725 10 58', 0, NULL);
INSERT INTO public.contractors VALUES (898, 0, NULL, NULL, NULL, NULL, NULL, 'Горький Максим ', NULL, NULL, '7 978 111 01 02', 0, NULL);
INSERT INTO public.contractors VALUES (899, 1, NULL, NULL, NULL, NULL, NULL, 'Горяев ВВ 79780541222', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (900, 0, NULL, NULL, NULL, NULL, NULL, 'Горячек Л.Г. ', NULL, NULL, '7978 884 94 07', 0, NULL);
INSERT INTO public.contractors VALUES (901, 0, NULL, NULL, NULL, NULL, NULL, 'Гостев Александр ', NULL, NULL, '79873373777', 0, NULL);
INSERT INTO public.contractors VALUES (902, 1, NULL, NULL, NULL, NULL, NULL, 'Гоцуляк И.А. ', NULL, NULL, '79787130353', 0, NULL);
INSERT INTO public.contractors VALUES (903, 0, NULL, NULL, NULL, NULL, NULL, 'Гошельник Сергей ', NULL, NULL, '79788255400', 0, NULL);
INSERT INTO public.contractors VALUES (904, 1, NULL, NULL, NULL, NULL, NULL, 'Грабевник АН ', NULL, NULL, '79780643911', 0, NULL);
INSERT INTO public.contractors VALUES (905, 1, NULL, NULL, NULL, NULL, NULL, 'Грабин ОВ 79788057083', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (906, 1, NULL, NULL, NULL, NULL, NULL, 'Грабовский ГЮ 79788339384', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (907, 1, NULL, NULL, NULL, NULL, NULL, 'Грабчак А.А. ', NULL, NULL, '79788159745', 0, NULL);
INSERT INTO public.contractors VALUES (908, 0, NULL, NULL, NULL, NULL, NULL, 'Гранд инвест строй _ И.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (909, 0, NULL, NULL, NULL, NULL, NULL, 'Гранит   (Судак)- А. ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (910, 0, NULL, NULL, NULL, NULL, 540201001, '"ГРАНИТ-К"",  _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (911, 0, NULL, NULL, NULL, NULL, NULL, 'Границкий Л.В. ', NULL, NULL, '7978 7991142', 0, NULL);
INSERT INTO public.contractors VALUES (912, 1, NULL, NULL, NULL, NULL, NULL, 'Гранков СА 79787819419(к.п)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (913, 0, NULL, NULL, NULL, NULL, NULL, 'Грачева Светлана', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (914, 1, NULL, NULL, NULL, NULL, NULL, 'Гребенщиков М.П. ', NULL, NULL, '7 978 723 02 84', 0, NULL);
INSERT INTO public.contractors VALUES (915, 0, NULL, NULL, NULL, NULL, NULL, 'Гребень ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (916, 2, NULL, NULL, NULL, NULL, NULL, 'Гребень Роман Александрович, ', NULL, NULL, '7 978 79 05 227 _Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (917, 1, NULL, NULL, NULL, NULL, NULL, 'Гревцев А.А. ', NULL, NULL, '7 978 80 87 042', 0, NULL);
INSERT INTO public.contractors VALUES (918, 0, NULL, NULL, NULL, NULL, NULL, 'Гречинский В.П. ', NULL, NULL, '7 978 854 47 78', 0, NULL);
INSERT INTO public.contractors VALUES (919, 1, NULL, NULL, NULL, NULL, NULL, 'Гречихин А.И. ', NULL, NULL, '79782151880', 0, NULL);
INSERT INTO public.contractors VALUES (920, 0, NULL, NULL, NULL, NULL, NULL, 'Гречишин', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (921, 1, NULL, NULL, NULL, NULL, NULL, 'Грибаченко Г.А. ', NULL, NULL, '7 978 7333075', 0, NULL);
INSERT INTO public.contractors VALUES (922, 1, NULL, NULL, NULL, NULL, NULL, 'Григорашенко ПМ 79788146858', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (923, 0, NULL, NULL, NULL, NULL, NULL, 'Григорий Золотое поле', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (924, 0, NULL, NULL, NULL, NULL, NULL, 'Григорий Мелихов ', NULL, NULL, '7 978 895 68 51 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (925, 0, NULL, NULL, NULL, NULL, NULL, 'Григорий Олендра ', NULL, NULL, '79788488722', 0, NULL);
INSERT INTO public.contractors VALUES (926, 1, NULL, NULL, NULL, NULL, NULL, 'Григоров АВ 79787538102', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (927, 1, NULL, NULL, NULL, NULL, NULL, 'Григорусь Н.Г. ', NULL, NULL, '7 978 87 77 083', 0, NULL);
INSERT INTO public.contractors VALUES (928, 1, NULL, NULL, NULL, NULL, NULL, 'Григорьев (Кольчугино) ', NULL, NULL, '7 978 788 07 87', 0, NULL);
INSERT INTO public.contractors VALUES (929, 1, NULL, NULL, NULL, NULL, NULL, 'Григорьев А.Ю. ', NULL, NULL, '79787835927', 0, NULL);
INSERT INTO public.contractors VALUES (930, 0, NULL, NULL, NULL, NULL, NULL, 'Григорьев Николай ', NULL, NULL, '79782575360', 0, NULL);
INSERT INTO public.contractors VALUES (931, 1, NULL, NULL, NULL, NULL, NULL, 'Григорьев С.А. ', NULL, NULL, '7 978 823 19 10', 0, NULL);
INSERT INTO public.contractors VALUES (932, 1, NULL, NULL, NULL, NULL, NULL, 'Григорьев С.И. ', NULL, NULL, '7 978 744 09 10', 0, NULL);
INSERT INTO public.contractors VALUES (933, 0, NULL, NULL, NULL, NULL, NULL, 'Григорян А.В. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (934, 0, NULL, NULL, NULL, NULL, NULL, 'Григорян Андроник Александрович ', NULL, NULL, '79780765846', 0, NULL);
INSERT INTO public.contractors VALUES (935, 2, NULL, NULL, NULL, NULL, NULL, 'Григурко Валерий Константинович (Саки)_Л. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (936, 1, NULL, NULL, NULL, NULL, NULL, 'Гридасов В.А. ', NULL, NULL, '7978 758 27 85', 0, NULL);
INSERT INTO public.contractors VALUES (937, 0, NULL, NULL, NULL, NULL, NULL, 'Грималовский А.В. ', NULL, NULL, '7 978 720 72 82', 0, NULL);
INSERT INTO public.contractors VALUES (938, 1, NULL, NULL, NULL, NULL, NULL, 'Грингауз Е.Б. ', NULL, NULL, '7978 262 06 69', 0, NULL);
INSERT INTO public.contractors VALUES (939, 0, NULL, NULL, NULL, NULL, NULL, 'Гринлайн ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (940, 1, NULL, NULL, NULL, NULL, NULL, 'Гринчишин А.В. ', NULL, NULL, '79782284058', 0, NULL);
INSERT INTO public.contractors VALUES (941, 1, NULL, NULL, NULL, NULL, NULL, 'Грипа ИИ 79787340981', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (942, 1, NULL, NULL, NULL, NULL, NULL, 'Грисько А.Н. ', NULL, NULL, '7 978 847 20 83', 0, NULL);
INSERT INTO public.contractors VALUES (943, 1, NULL, NULL, NULL, NULL, NULL, 'Грицан А.К. ', NULL, NULL, '7 978 813 43 13', 0, NULL);
INSERT INTO public.contractors VALUES (944, 1, NULL, NULL, NULL, NULL, NULL, 'Грицко Е.Ф. ', NULL, NULL, '7 978 70 68 555', 0, NULL);
INSERT INTO public.contractors VALUES (945, 0, NULL, NULL, NULL, NULL, NULL, 'Гришак Андрей ', NULL, NULL, '79787806821', 0, NULL);
INSERT INTO public.contractors VALUES (946, 1, NULL, NULL, NULL, NULL, NULL, 'Гришакин ОА ', NULL, NULL, '79787252534', 0, NULL);
INSERT INTO public.contractors VALUES (947, 1, NULL, NULL, NULL, NULL, NULL, 'Гришко И.Н.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (948, 1, NULL, NULL, NULL, NULL, NULL, 'Грищенко ВВ 79788883541', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (949, 0, NULL, NULL, NULL, NULL, NULL, 'Гробовец Анатолий Гаврилович ', NULL, NULL, '79787372110', 0, NULL);
INSERT INTO public.contractors VALUES (950, 1, NULL, NULL, NULL, NULL, NULL, 'Громовой А.С. ', NULL, NULL, '79787177511', 0, NULL);
INSERT INTO public.contractors VALUES (951, 1, NULL, NULL, NULL, NULL, NULL, 'Гросс В.П. ', NULL, NULL, '7 978 879 37 38', 0, NULL);
INSERT INTO public.contractors VALUES (952, 0, NULL, NULL, NULL, NULL, NULL, 'Гросса', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (953, 1, NULL, NULL, NULL, NULL, NULL, 'Гросу В. ', NULL, NULL, '79099825150', 0, NULL);
INSERT INTO public.contractors VALUES (954, 1, NULL, NULL, NULL, NULL, NULL, 'Грошев П.Е. ', NULL, NULL, '7 978 724 99 74', 0, NULL);
INSERT INTO public.contractors VALUES (955, 0, NULL, NULL, NULL, NULL, NULL, 'Груздев Александр ', NULL, NULL, '7 978 722 99 56', 0, NULL);
INSERT INTO public.contractors VALUES (956, 1, NULL, NULL, NULL, NULL, NULL, 'Груздев Д.И. ', NULL, NULL, '7978 836 60 82', 0, NULL);
INSERT INTO public.contractors VALUES (957, 0, NULL, NULL, NULL, NULL, NULL, 'Груцин Ю.Е. ', NULL, NULL, '7 978 713 36 32', 0, NULL);
INSERT INTO public.contractors VALUES (958, 0, NULL, NULL, NULL, NULL, NULL, 'Грушевой Николай Николаевич ', NULL, NULL, '79787265164', 0, NULL);
INSERT INTO public.contractors VALUES (959, 1, NULL, NULL, NULL, NULL, NULL, 'Грушин ПИ 79787847624', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (960, NULL, NULL, NULL, NULL, NULL, 231001001, 'ГУ – Отделение Пенсионного фонда РФ по Краснодарскому краю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (961, NULL, NULL, NULL, NULL, NULL, 910201001, 'ГУ – Отделение Пенсионного фонда РФ по Республике Крым', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (962, 0, NULL, NULL, NULL, NULL, NULL, 'Губский А.В. ', NULL, NULL, '7 978 71 299 59', 0, NULL);
INSERT INTO public.contractors VALUES (963, 0, NULL, NULL, NULL, NULL, NULL, 'Губский Е.А. ', NULL, NULL, '7 978 706 725 7', 0, NULL);
INSERT INTO public.contractors VALUES (964, 1, NULL, NULL, NULL, NULL, NULL, 'Гудзь ДС 79787309475', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (965, 1, NULL, NULL, NULL, NULL, NULL, 'Гудиленко АИ ', NULL, NULL, '79788168203 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (966, 1, NULL, NULL, NULL, NULL, NULL, 'Гудинович И.В. ', NULL, NULL, '7 978 711 36 45', 0, NULL);
INSERT INTO public.contractors VALUES (967, 1, NULL, NULL, NULL, NULL, NULL, 'Гузарашвили Л.В. ', NULL, NULL, '7 978 033 93 79', 0, NULL);
INSERT INTO public.contractors VALUES (968, 1, NULL, NULL, NULL, NULL, NULL, 'Гузенко НГ 79787549579', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (969, 1, NULL, NULL, NULL, NULL, NULL, 'Гузовский А.Н. ', NULL, NULL, '7 978 735 8053', 0, NULL);
INSERT INTO public.contractors VALUES (970, 1, NULL, NULL, NULL, NULL, NULL, 'Гук Василий Марьянович ', NULL, NULL, '7 978 711 36 91', 0, NULL);
INSERT INTO public.contractors VALUES (971, 1, NULL, NULL, NULL, NULL, NULL, 'Гук О.В. ', NULL, NULL, '7 978 743 09 15', 0, NULL);
INSERT INTO public.contractors VALUES (972, 1, NULL, NULL, NULL, NULL, NULL, 'Гук О.В. ', NULL, NULL, '7978 743 0915', 0, NULL);
INSERT INTO public.contractors VALUES (973, 1, NULL, NULL, NULL, NULL, NULL, 'Гулевский В.В. ', NULL, NULL, '7 978 129 80 96', 0, NULL);
INSERT INTO public.contractors VALUES (974, 0, NULL, NULL, NULL, NULL, NULL, 'Гулевский С.А. ', NULL, NULL, '7 978 747 06 36', 0, NULL);
INSERT INTO public.contractors VALUES (975, 0, NULL, NULL, NULL, NULL, NULL, 'Гулисгаускас А.В. ', NULL, NULL, '7 978 77 02 864', 0, NULL);
INSERT INTO public.contractors VALUES (976, 1, NULL, NULL, NULL, NULL, NULL, 'Гулюк АВ 79155630784', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (977, 1, NULL, NULL, NULL, NULL, NULL, 'Гуляев Антон ', NULL, NULL, '7978 711 74 61', 0, NULL);
INSERT INTO public.contractors VALUES (978, 0, NULL, NULL, NULL, NULL, NULL, 'Гуляев Олег ', NULL, NULL, '79780314131', 0, NULL);
INSERT INTO public.contractors VALUES (979, 0, NULL, NULL, NULL, NULL, NULL, 'ГУП РК  Крымэнэрго  73652548370', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (980, 0, NULL, NULL, NULL, NULL, 910201001, 'ГУП РК «ЧЕРНОМОРНЕФТЕГАЗ»', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (981, 0, NULL, NULL, NULL, NULL, NULL, 'ГУП РК Крымхлеб ', NULL, NULL, '7 978 824 20 16 Татьяна', 0, NULL);
INSERT INTO public.contractors VALUES (982, 1, NULL, NULL, NULL, NULL, NULL, 'Гупалова ЕП 79787566561', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (983, 0, NULL, NULL, NULL, NULL, NULL, 'Гурбик В.М.', NULL, NULL, '79780637300', 0, NULL);
INSERT INTO public.contractors VALUES (984, 1, NULL, NULL, NULL, NULL, NULL, 'Гурец Р.Г. ', NULL, NULL, '7 978 72 32 790', 0, NULL);
INSERT INTO public.contractors VALUES (985, 1, NULL, NULL, NULL, NULL, NULL, 'Гуринов В.А. ', NULL, NULL, '79787542816', 0, NULL);
INSERT INTO public.contractors VALUES (986, 1, NULL, NULL, NULL, NULL, NULL, 'Гуркин ПВ 79781441592', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (987, 0, NULL, NULL, NULL, NULL, NULL, 'Гусаренко Елена ', NULL, NULL, '79787660678', 0, NULL);
INSERT INTO public.contractors VALUES (988, 2, NULL, NULL, NULL, NULL, NULL, 'Гусев АА 79780639817 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (989, 2, NULL, NULL, NULL, NULL, NULL, 'Гусев Владимир Николаевич ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (990, 1, NULL, NULL, NULL, NULL, NULL, 'Гусев Ю.Г. ', NULL, NULL, '7 978 74 98 410', 0, NULL);
INSERT INTO public.contractors VALUES (991, 1, NULL, NULL, NULL, NULL, NULL, 'Гуськов А.В. ', NULL, NULL, '7 978 858 42 67', 0, NULL);
INSERT INTO public.contractors VALUES (992, 1, NULL, NULL, NULL, NULL, NULL, 'Гутник В.В. ', NULL, NULL, '7 978 778 03 33', 0, NULL);
INSERT INTO public.contractors VALUES (993, 0, NULL, NULL, NULL, NULL, NULL, 'Гутянко А.Н. ', NULL, NULL, '7 978 831 8353', 0, NULL);
INSERT INTO public.contractors VALUES (994, 2, NULL, NULL, NULL, NULL, NULL, 'Гуцуляк ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (995, 1, NULL, NULL, NULL, NULL, NULL, 'Давтян ГГ ', NULL, NULL, '79788384850', 0, NULL);
INSERT INTO public.contractors VALUES (996, 1, NULL, NULL, NULL, NULL, NULL, 'Давыдова В.А. ', NULL, NULL, '7 978 731 79 19', 0, NULL);
INSERT INTO public.contractors VALUES (997, 0, NULL, NULL, NULL, NULL, NULL, 'Давыдова В.А. ', NULL, NULL, '7 978 731 79 19', 0, NULL);
INSERT INTO public.contractors VALUES (998, 0, NULL, NULL, NULL, NULL, NULL, 'Дан Инвест Строй', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (999, 0, NULL, NULL, NULL, NULL, NULL, 'ДАН ИнвестСтрой', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1000, 1, NULL, NULL, NULL, NULL, NULL, 'Данил ', NULL, NULL, '79886706434', 0, NULL);
INSERT INTO public.contractors VALUES (1001, 1, NULL, NULL, NULL, NULL, NULL, 'Данил от Влада 89787699263', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1002, 0, NULL, NULL, NULL, NULL, NULL, 'Данилевич В. ', NULL, NULL, '79173 911 305', 0, NULL);
INSERT INTO public.contractors VALUES (1003, 0, NULL, NULL, NULL, NULL, NULL, 'Данилевич Виктор (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1004, 0, NULL, NULL, NULL, NULL, NULL, 'Даниленко Александр ', NULL, NULL, '79787914693', 0, NULL);
INSERT INTO public.contractors VALUES (1005, 1, NULL, NULL, NULL, NULL, NULL, 'Даниленко С.Н. 79788167638', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1006, 0, NULL, NULL, NULL, NULL, NULL, 'Данилин Ю.В. ', NULL, NULL, '7 978 70 60 592', 0, NULL);
INSERT INTO public.contractors VALUES (1007, 1, NULL, NULL, NULL, NULL, NULL, 'Данилов В.М. ', NULL, NULL, '7 978 069 32 01', 0, NULL);
INSERT INTO public.contractors VALUES (1008, 2, NULL, NULL, NULL, NULL, NULL, 'Данилович Константин Владимирович-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1009, 1, NULL, NULL, NULL, NULL, NULL, 'Данилюк Дмитрий Владимирович ', NULL, NULL, '79782087096', 0, NULL);
INSERT INTO public.contractors VALUES (1010, 0, NULL, NULL, NULL, NULL, NULL, 'Данчеко С.В. ', NULL, NULL, '79787418450', 0, NULL);
INSERT INTO public.contractors VALUES (1011, 0, NULL, NULL, NULL, NULL, NULL, 'Данченко А.В. ', NULL, NULL, '79788160191', 0, NULL);
INSERT INTO public.contractors VALUES (1012, 1, NULL, NULL, NULL, NULL, NULL, 'Данченко АВ 79788160191', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1013, 1, NULL, NULL, NULL, NULL, NULL, 'Данченко Д.В. ', NULL, NULL, '7 978 827 22 90', 0, NULL);
INSERT INTO public.contractors VALUES (1014, 0, NULL, NULL, NULL, NULL, NULL, 'Данченко С.В. ', NULL, NULL, '79787418450', 0, NULL);
INSERT INTO public.contractors VALUES (1015, 1, NULL, NULL, NULL, NULL, NULL, 'Даньшин ЕА 79787204293', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1016, 1, NULL, NULL, NULL, NULL, NULL, 'Даньшина КИ 79787204292', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1017, 0, NULL, NULL, NULL, NULL, 910201001, '"ДАТЕКС""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1018, 0, NULL, NULL, NULL, NULL, NULL, 'ДАХ-СЕРВИСС (Севастополь) ООО-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1019, 0, NULL, NULL, NULL, NULL, NULL, 'ДачаСтрой Севастополь ', NULL, NULL, '7 978 805 2629 д.п.-А.', 0, NULL);
INSERT INTO public.contractors VALUES (1020, 1, NULL, NULL, NULL, NULL, NULL, 'Дашиев Евгений ', NULL, NULL, '7 978 133 17 87 (д.п.) - Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1021, 1, NULL, NULL, NULL, NULL, NULL, 'Двирнык В.И. ', NULL, NULL, '7 978 87 18 999', 0, NULL);
INSERT INTO public.contractors VALUES (1022, 1, NULL, NULL, NULL, NULL, NULL, 'Дворецкий Д.А. ', NULL, NULL, '79788559285', 0, NULL);
INSERT INTO public.contractors VALUES (1023, 1, NULL, NULL, NULL, NULL, NULL, 'Дворченко А.П. ', NULL, NULL, '7978 7469 252', 0, NULL);
INSERT INTO public.contractors VALUES (1024, 1, NULL, NULL, NULL, NULL, NULL, 'Дворченко Ю.В. ', NULL, NULL, '7 978 721 71 39', 0, NULL);
INSERT INTO public.contractors VALUES (1025, 0, NULL, NULL, NULL, NULL, NULL, 'Дворченко Юрий ', NULL, NULL, '7 978 721 71 39', 0, NULL);
INSERT INTO public.contractors VALUES (1026, 0, NULL, NULL, NULL, NULL, NULL, 'Дворянов Н.А. ', NULL, NULL, '7 978 70 86 536', 0, NULL);
INSERT INTO public.contractors VALUES (1027, 0, NULL, NULL, NULL, NULL, NULL, 'Дебют ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1028, 1, NULL, NULL, NULL, NULL, NULL, 'Деев АС 79787245477', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1029, 1, NULL, NULL, NULL, NULL, NULL, 'Дейнеко Ю.Н. ', NULL, NULL, '7978 810 56 84', 0, NULL);
INSERT INTO public.contractors VALUES (1030, 0, NULL, NULL, NULL, NULL, NULL, 'Дек групп-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1031, 0, NULL, NULL, NULL, NULL, NULL, 'Деккер - Крым Виктор ', NULL, NULL, '7978 83 49 726 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1032, 1, NULL, NULL, NULL, NULL, NULL, 'Демиденко В.А. ', NULL, NULL, '7 978 730 57 54', 0, NULL);
INSERT INTO public.contractors VALUES (1033, 1, NULL, NULL, NULL, NULL, NULL, 'Демиденко В.А. ', NULL, NULL, '7 978 730 57 54 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1034, 0, NULL, NULL, NULL, NULL, NULL, 'Демидов А.Н. ', NULL, NULL, '7 978 8 33 0596', 0, NULL);
INSERT INTO public.contractors VALUES (1035, 1, NULL, NULL, NULL, NULL, NULL, 'Демин В.А. ', NULL, NULL, '7 978 733 61 63', 0, NULL);
INSERT INTO public.contractors VALUES (1036, 1, NULL, NULL, NULL, NULL, NULL, 'Демина Т.А. ', NULL, NULL, '7 978 013 88 52', 0, NULL);
INSERT INTO public.contractors VALUES (1037, 0, NULL, NULL, NULL, NULL, NULL, 'Деминов Андрей ', NULL, NULL, '79189967536', 0, NULL);
INSERT INTO public.contractors VALUES (1038, 0, NULL, NULL, NULL, NULL, NULL, 'Демченко Андрей ', NULL, NULL, '79787310102', 0, NULL);
INSERT INTO public.contractors VALUES (1039, 1, NULL, NULL, NULL, NULL, NULL, 'Демченко СВ 79787704955', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1040, 0, NULL, NULL, NULL, NULL, NULL, 'Демьянов Сергей ', NULL, NULL, '7 978 791 31 25', 0, NULL);
INSERT INTO public.contractors VALUES (1041, 0, NULL, NULL, NULL, NULL, NULL, 'Демьянов Сергей ', NULL, NULL, '7 978 791 31 25', 0, NULL);
INSERT INTO public.contractors VALUES (1042, 0, NULL, NULL, NULL, NULL, NULL, 'Денис Пионерское ', NULL, NULL, '79781057067', 0, NULL);
INSERT INTO public.contractors VALUES (1043, 0, NULL, NULL, NULL, NULL, NULL, 'Денисов Д.А. ', NULL, NULL, '79787134081', 0, NULL);
INSERT INTO public.contractors VALUES (1044, 1, NULL, NULL, NULL, NULL, NULL, 'Денисов СА 79787617661', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1045, 1, NULL, NULL, NULL, NULL, NULL, 'Денчук Г.С. ', NULL, NULL, '7978 745 74 05', 0, NULL);
INSERT INTO public.contractors VALUES (1046, 0, NULL, NULL, NULL, NULL, NULL, 'Депутатов Александр ', NULL, NULL, '7 978 718 95 26', 0, NULL);
INSERT INTO public.contractors VALUES (1047, 1, NULL, NULL, NULL, NULL, NULL, 'Дервишев ЭШ 79787233744', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1048, 1, NULL, NULL, NULL, NULL, NULL, 'Дергунов С.А. ', NULL, NULL, '7978 146 21 71', 0, NULL);
INSERT INTO public.contractors VALUES (1049, 1, NULL, NULL, NULL, NULL, NULL, 'Деревенчук О.П. ', NULL, NULL, '7978 813 51 04', 0, NULL);
INSERT INTO public.contractors VALUES (1050, 1, NULL, NULL, NULL, NULL, NULL, 'Деревянко В.И. ', NULL, NULL, '7 978 70 84 630', 0, NULL);
INSERT INTO public.contractors VALUES (1051, 0, NULL, NULL, NULL, NULL, NULL, 'Дереза Любовь Николаевна ', NULL, NULL, '7 978 724 04 46', 0, NULL);
INSERT INTO public.contractors VALUES (1052, 1, NULL, NULL, NULL, NULL, NULL, 'Дереш СБ 79788067274', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1053, 1, NULL, NULL, NULL, NULL, NULL, 'Деркач Александр Михайлович ', NULL, NULL, '79787658099', 0, NULL);
INSERT INTO public.contractors VALUES (1054, 0, NULL, NULL, NULL, NULL, NULL, 'Дефаров Руслан ', NULL, NULL, '7 978 76 41 095', 0, NULL);
INSERT INTO public.contractors VALUES (1055, 1, NULL, NULL, NULL, NULL, NULL, 'Деянов Е.И. ', NULL, NULL, '7 978 814 98 96', 0, NULL);
INSERT INTO public.contractors VALUES (1056, 1, NULL, NULL, NULL, NULL, NULL, 'Джаббаров Э.Я. ', NULL, NULL, '7978 75 907 34', 0, NULL);
INSERT INTO public.contractors VALUES (1057, 1, NULL, NULL, NULL, NULL, NULL, 'Джалилов РЮ 79787075056', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1058, 1, NULL, NULL, NULL, NULL, NULL, 'Джамилов Л.Ф. ', NULL, NULL, '7978 708 05 95', 0, NULL);
INSERT INTO public.contractors VALUES (1059, 1, NULL, NULL, NULL, NULL, NULL, 'Джанклыч Э.Р. ', NULL, NULL, '7 978 813 50 22', 0, NULL);
INSERT INTO public.contractors VALUES (1060, 0, NULL, NULL, NULL, NULL, NULL, 'Джанкой Металлобаза Сергей', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1061, 1, NULL, NULL, NULL, NULL, NULL, 'Джапаров Нариман ', NULL, NULL, '79787288266', 0, NULL);
INSERT INTO public.contractors VALUES (1062, 1, NULL, NULL, NULL, NULL, NULL, 'Джапаров С.Э. ', NULL, NULL, '7 978 855 05 83', 0, NULL);
INSERT INTO public.contractors VALUES (1063, 1, NULL, NULL, NULL, NULL, NULL, 'Джафаров Олег -А. (д.п.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1064, 2, NULL, NULL, NULL, NULL, NULL, 'Джевдетов Дилявер Энверович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1065, 1, NULL, NULL, NULL, NULL, NULL, 'Джелялов И.А. ', NULL, NULL, '7 978 029 43 89', 0, NULL);
INSERT INTO public.contractors VALUES (1066, 0, NULL, NULL, NULL, NULL, NULL, 'Джелялов Руслан ', NULL, NULL, '7978 124 93 10', 0, NULL);
INSERT INTO public.contractors VALUES (1067, 1, NULL, NULL, NULL, NULL, NULL, 'Джемакулов Артур ', NULL, NULL, '7 978 829 42 40', 0, NULL);
INSERT INTO public.contractors VALUES (1068, 0, NULL, NULL, NULL, NULL, NULL, 'Джемилев Д.С. ', NULL, NULL, '7978 856-04-03', 0, NULL);
INSERT INTO public.contractors VALUES (1069, 0, NULL, NULL, NULL, NULL, NULL, 'Джемилев О.Х ', NULL, NULL, '79788876742', 0, NULL);
INSERT INTO public.contractors VALUES (1070, 1, NULL, NULL, NULL, NULL, NULL, 'Джемилов Н.Ф. ', NULL, NULL, '7978 708 05 95', 0, NULL);
INSERT INTO public.contractors VALUES (1071, 1, NULL, NULL, NULL, NULL, NULL, 'Джемилов РШ 79788406252', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1072, 1, NULL, NULL, NULL, NULL, NULL, 'Джербинов М.М. ', NULL, NULL, '7 978 838 15 03', 0, NULL);
INSERT INTO public.contractors VALUES (1073, 1, NULL, NULL, NULL, NULL, NULL, 'Джур И.В. ', NULL, NULL, '7 978 78 72 533', 0, NULL);
INSERT INTO public.contractors VALUES (1074, 1, NULL, NULL, NULL, NULL, NULL, 'Дзиканский НС 79787245768', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1075, 1, NULL, NULL, NULL, NULL, NULL, 'Дзюба А.В. ', NULL, NULL, '79788311289', 0, NULL);
INSERT INTO public.contractors VALUES (1076, 0, NULL, NULL, NULL, NULL, NULL, 'Дзюба Н.Ю. ', NULL, NULL, '7 978 897 40 27', 0, NULL);
INSERT INTO public.contractors VALUES (1077, 1, NULL, NULL, NULL, NULL, NULL, 'ДиА ООО (Александр ', NULL, NULL, '7 978 900 00 35)', 0, NULL);
INSERT INTO public.contractors VALUES (1078, 1, NULL, NULL, NULL, NULL, NULL, 'Диденко А.Н. ', NULL, NULL, '79780154095', 0, NULL);
INSERT INTO public.contractors VALUES (1079, 1, NULL, NULL, NULL, NULL, NULL, 'Диденко Андрей Анатольевич ', NULL, NULL, '7978 7380 385 (4)', 0, NULL);
INSERT INTO public.contractors VALUES (1080, 1, NULL, NULL, NULL, NULL, NULL, 'Диденко В.С. ', NULL, NULL, '7978 817 59 95', 0, NULL);
INSERT INTO public.contractors VALUES (1081, 1, NULL, NULL, NULL, NULL, NULL, 'Диденко С.Г. ', NULL, NULL, '7978 711 77 83', 0, NULL);
INSERT INTO public.contractors VALUES (1082, 0, NULL, NULL, NULL, NULL, 910801001, 'Дизайн Строй Рает ', NULL, 927783, '7 978 759 45 80 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1083, 0, NULL, NULL, NULL, NULL, 910801001, 'ДИЗАЙНСТРОЙ ООО -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1084, 0, NULL, NULL, NULL, NULL, NULL, 'Дилявер ', NULL, NULL, '7 978 824 25 77 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1085, 0, NULL, NULL, NULL, NULL, NULL, 'Димаков Николай Александрович ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1086, 1, NULL, NULL, NULL, NULL, NULL, 'Димидов КД 79787336381', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1087, 1, NULL, NULL, NULL, NULL, NULL, 'Димитров ВИ 79787087033', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1088, 1, NULL, NULL, NULL, NULL, NULL, 'Дихтярский А.В. ', NULL, NULL, '79787501533', 0, NULL);
INSERT INTO public.contractors VALUES (1089, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитриев А.В. ', NULL, NULL, '7978 143 0963', 0, NULL);
INSERT INTO public.contractors VALUES (1090, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитриев В.В. ', NULL, NULL, '7 978 070 29 48', 0, NULL);
INSERT INTO public.contractors VALUES (1091, 0, NULL, NULL, NULL, NULL, NULL, 'Дмитриев В.Г. ', NULL, NULL, '79787434570', 0, NULL);
INSERT INTO public.contractors VALUES (1092, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитриев С.В. ', NULL, NULL, '7978 844 61 31', 0, NULL);
INSERT INTO public.contractors VALUES (1093, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитрий 79780123623 дп', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1094, 0, NULL, NULL, NULL, NULL, NULL, 'Дмитрий Вищеревич (с.Равнополье) ', NULL, NULL, '7 978 77 31 161 _А.', 0, NULL);
INSERT INTO public.contractors VALUES (1095, 0, NULL, NULL, NULL, NULL, NULL, 'Дмитрий г. Ялта ул Южнобережное шоссе 5а (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2523, 0, NULL, NULL, NULL, NULL, NULL, 'Насиб', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1096, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитрий канцелярия ', NULL, NULL, '79787473644', 0, NULL);
INSERT INTO public.contractors VALUES (1097, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитрий Николаенко', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1098, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитрий Санитарная, 83 7978 706 48 51', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1099, 0, NULL, NULL, NULL, NULL, NULL, 'Дмитрий Чумаков ', NULL, NULL, '7 978 849 47 04', 0, NULL);
INSERT INTO public.contractors VALUES (1100, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитрощук А.А. ', NULL, NULL, '7978 777 59 63', 0, NULL);
INSERT INTO public.contractors VALUES (1101, 1, NULL, NULL, NULL, NULL, NULL, 'Дмитрюк Г.Г. ', NULL, NULL, '7 978 72 02 918', 0, NULL);
INSERT INTO public.contractors VALUES (1102, 0, NULL, NULL, NULL, NULL, NULL, 'Дмитрягин В.Н. ', NULL, NULL, '7 978 746 92 82', 0, NULL);
INSERT INTO public.contractors VALUES (1103, 2, NULL, NULL, NULL, NULL, NULL, 'Доброрезова И. И.  ХОЛМСКАЯ ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1104, 2, NULL, NULL, NULL, NULL, NULL, 'Доброрезова И. И. ИП АБИНСК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1105, 2, NULL, NULL, NULL, NULL, NULL, 'Доброрезова И. И. ИП СЕВЕРСКАЯ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1106, 1, NULL, NULL, NULL, NULL, NULL, 'Довбыш МН 79788273350', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1107, 1, NULL, NULL, NULL, NULL, NULL, 'Довгалюк В.А. ', NULL, NULL, '7 978 067 14 10', 0, NULL);
INSERT INTO public.contractors VALUES (1108, 1, NULL, NULL, NULL, NULL, NULL, 'Дойчев Сергей ', NULL, NULL, '7 978 70 63 222', 0, NULL);
INSERT INTO public.contractors VALUES (1109, 0, NULL, NULL, NULL, NULL, NULL, 'Докалюк Олег ', NULL, NULL, '79787510754 ', 0, NULL);
INSERT INTO public.contractors VALUES (1110, 0, NULL, NULL, NULL, NULL, NULL, 'Долгиих Михаил ', NULL, NULL, '79788141656', 0, NULL);
INSERT INTO public.contractors VALUES (1111, 0, NULL, NULL, NULL, NULL, NULL, 'Долгих Анна', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1112, 1, NULL, NULL, NULL, NULL, NULL, 'Долгополов АИ 79787417735', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1113, 1, NULL, NULL, NULL, NULL, NULL, 'Долгополов Н.А. ', NULL, NULL, '7 978 7335 655', 0, NULL);
INSERT INTO public.contractors VALUES (1114, 1, NULL, NULL, NULL, NULL, NULL, 'Долгоруков 79787677450', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1115, 1, NULL, NULL, NULL, NULL, NULL, 'Должиков А.А. ', NULL, NULL, '7978 879 41 97', 0, NULL);
INSERT INTO public.contractors VALUES (1116, 1, NULL, NULL, NULL, NULL, NULL, 'Доля ВВ 79787113572', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1117, 0, NULL, NULL, NULL, NULL, NULL, 'Дом Крым (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1118, 1, NULL, NULL, NULL, NULL, NULL, 'Домашний А.Н. ', NULL, NULL, '7 978 822 90 05', 0, NULL);
INSERT INTO public.contractors VALUES (1119, 0, NULL, NULL, NULL, NULL, NULL, 'Домино', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1120, 0, NULL, NULL, NULL, NULL, NULL, 'Дон Снаб', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1121, 1, NULL, NULL, NULL, NULL, NULL, 'Донских АН 79787665651', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1122, 0, NULL, NULL, NULL, NULL, NULL, 'ДонСнаб (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1123, 1, NULL, NULL, NULL, NULL, NULL, 'Донцов В.А. ', NULL, NULL, '79898515301', 0, NULL);
INSERT INTO public.contractors VALUES (1124, 0, NULL, NULL, NULL, NULL, NULL, 'Дорогинский В.А. ', NULL, NULL, '7 978 710 8040', 0, NULL);
INSERT INTO public.contractors VALUES (1125, 1, NULL, NULL, NULL, NULL, NULL, 'Дорогинский ОА ', NULL, NULL, '79787108050', 0, NULL);
INSERT INTO public.contractors VALUES (1126, 0, NULL, NULL, NULL, NULL, NULL, 'Дорошенко ', NULL, NULL, '7 978 740 06 93', 0, NULL);
INSERT INTO public.contractors VALUES (1127, 0, NULL, NULL, NULL, NULL, NULL, 'Дорошенко Виктор ', NULL, NULL, '79787989708', 0, NULL);
INSERT INTO public.contractors VALUES (1128, 0, NULL, NULL, NULL, NULL, NULL, 'Дорошенко Владимир ', NULL, NULL, '79788808850', 0, NULL);
INSERT INTO public.contractors VALUES (1129, 0, NULL, NULL, NULL, NULL, NULL, 'Дорошенко Сергей Александрович ', NULL, NULL, '79787254482', 0, NULL);
INSERT INTO public.contractors VALUES (1130, 1, NULL, NULL, NULL, NULL, NULL, 'Драй Л.А. ', NULL, NULL, '7978 810 56 55', 0, NULL);
INSERT INTO public.contractors VALUES (1131, 1, NULL, NULL, NULL, NULL, NULL, 'Драморецкая ВВ 79787529759', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1132, 1, NULL, NULL, NULL, NULL, NULL, 'Драморецкий 79787182717', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1133, 1, NULL, NULL, NULL, NULL, NULL, 'Дранников Л.А. ', NULL, NULL, '7 978 76 44 935', 0, NULL);
INSERT INTO public.contractors VALUES (1134, 1, NULL, NULL, NULL, NULL, NULL, 'Драч А.И. ', NULL, NULL, '7 978 822 25 89', 0, NULL);
INSERT INTO public.contractors VALUES (1135, 1, NULL, NULL, NULL, NULL, NULL, 'Древятникова Т.А. ', NULL, NULL, '7978 823 95 20', 0, NULL);
INSERT INTO public.contractors VALUES (1136, 1, NULL, NULL, NULL, NULL, NULL, 'Дрешлюк ГА 79782136399', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1137, 0, NULL, NULL, NULL, NULL, NULL, 'Дровикова Светлана Михайловна ', NULL, NULL, '79787181772', 0, NULL);
INSERT INTO public.contractors VALUES (1138, 1, NULL, NULL, NULL, NULL, NULL, 'Дроговоз ГА 79788700260', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1139, 1, NULL, NULL, NULL, NULL, NULL, 'Дрозд А.В. ', NULL, NULL, '79787633868', 0, NULL);
INSERT INTO public.contractors VALUES (1140, 1, NULL, NULL, NULL, NULL, NULL, 'Дрозд А.С. ', NULL, NULL, '7 978 763 19 94', 0, NULL);
INSERT INTO public.contractors VALUES (1141, 0, NULL, NULL, NULL, NULL, NULL, 'Дрозд Юрий Владимирович ', NULL, NULL, '79788838944', 0, NULL);
INSERT INTO public.contractors VALUES (1142, 1, NULL, NULL, NULL, NULL, NULL, 'Дроздов ИС 79787062464', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1143, 0, NULL, NULL, NULL, NULL, 692601001, '"ДСК"", Прудников Владимир ', NULL, NULL, '7 989 241 8914 - Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (1144, 1, NULL, NULL, NULL, NULL, NULL, 'Дубин Руслан И 79781139020', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1145, 1, NULL, NULL, NULL, NULL, NULL, 'Дубинский ВВ 79788791864', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1146, 0, NULL, NULL, NULL, NULL, NULL, 'Дубов  М.А. ', NULL, NULL, '7978 816 81 49', 0, NULL);
INSERT INTO public.contractors VALUES (1147, 1, NULL, NULL, NULL, NULL, NULL, 'Дубов А. С. ИП ГЕЛЕНДЖИК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1148, 1, NULL, NULL, NULL, NULL, NULL, 'Дубовенко СЛ 798780545400', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1149, 0, NULL, NULL, NULL, NULL, NULL, 'Дубровин С.В. ', NULL, NULL, '7978 745 37 07', 0, NULL);
INSERT INTO public.contractors VALUES (1150, 1, NULL, NULL, NULL, NULL, NULL, 'Дубровский В.А. ', NULL, NULL, ' 7 978 73 1234 2', 0, NULL);
INSERT INTO public.contractors VALUES (1151, 0, NULL, NULL, NULL, NULL, NULL, 'Дугай Михаил- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1152, 1, NULL, NULL, NULL, NULL, NULL, 'Дудник И.П. ', NULL, NULL, '7 978 020 84 36', 0, NULL);
INSERT INTO public.contractors VALUES (1153, 0, NULL, NULL, NULL, NULL, NULL, 'Дудник Михаил ', NULL, NULL, '79788350183', 0, NULL);
INSERT INTO public.contractors VALUES (1154, 1, NULL, NULL, NULL, NULL, NULL, 'Дудченко П.В. ', NULL, NULL, '79787545988', 0, NULL);
INSERT INTO public.contractors VALUES (1155, 0, NULL, NULL, NULL, NULL, NULL, 'Дулама С ', NULL, NULL, '79780042321', 0, NULL);
INSERT INTO public.contractors VALUES (1156, 0, NULL, NULL, NULL, NULL, NULL, 'Дупенко Виктор ', NULL, NULL, '79788066257', 0, NULL);
INSERT INTO public.contractors VALUES (1157, 0, NULL, NULL, NULL, NULL, NULL, 'Дурман И.В. ', NULL, NULL, '7 978 745 58 35', 0, NULL);
INSERT INTO public.contractors VALUES (1158, 1, NULL, NULL, NULL, NULL, NULL, 'Дусь АА ', NULL, NULL, '79787690008', 0, NULL);
INSERT INTO public.contractors VALUES (1159, 0, NULL, NULL, NULL, NULL, NULL, 'Дыкий Олег Владимирович ', NULL, NULL, '7 978 050 02 90', 0, NULL);
INSERT INTO public.contractors VALUES (1160, 1, NULL, NULL, NULL, NULL, NULL, 'Дышлевой А.В. ', NULL, NULL, '7 978 71 33 593', 0, NULL);
INSERT INTO public.contractors VALUES (1161, 1, NULL, NULL, NULL, NULL, NULL, 'Дьяков Евгений Александрович ', NULL, NULL, '79781083421', 0, NULL);
INSERT INTO public.contractors VALUES (1162, 0, NULL, NULL, NULL, NULL, NULL, 'Дьяченко Александр ', NULL, NULL, '7 978 75 819 25', 0, NULL);
INSERT INTO public.contractors VALUES (1163, 1, NULL, NULL, NULL, NULL, NULL, 'Дьяченко Михаил Викторович ', NULL, NULL, '79787818588', 0, NULL);
INSERT INTO public.contractors VALUES (1164, 1, NULL, NULL, NULL, NULL, NULL, 'Дэйнэко Нонна Петровна', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1165, 1, NULL, NULL, NULL, NULL, NULL, 'Дюдяев С.В. ', NULL, NULL, '7 978 899 66 21', 0, NULL);
INSERT INTO public.contractors VALUES (1166, 0, NULL, NULL, NULL, NULL, NULL, 'Дятлев О.А. ', NULL, NULL, '7 918 332 82 50', 0, NULL);
INSERT INTO public.contractors VALUES (1167, 0, NULL, NULL, NULL, NULL, NULL, 'Евгений Севастополь (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1168, 1, NULL, NULL, NULL, NULL, NULL, 'Евдокимов Сергей Владимирович ', NULL, NULL, '79789952414', 0, NULL);
INSERT INTO public.contractors VALUES (1169, 1, NULL, NULL, NULL, NULL, NULL, 'Евстратов ЮС 79780775086', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1170, 2, NULL, NULL, NULL, NULL, NULL, 'Евтушенко Андрей Валентинович (KUDO)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1171, 1, NULL, NULL, NULL, NULL, NULL, 'Евтушенко С.Б. ', NULL, NULL, '7978 87 01 044', 0, NULL);
INSERT INTO public.contractors VALUES (1172, 1, NULL, NULL, NULL, NULL, NULL, 'Евтягин Максим', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1173, 1, NULL, NULL, NULL, NULL, NULL, 'Егоров ВВ 79787183346 (к п)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1174, 0, NULL, NULL, NULL, NULL, NULL, 'Егоров С.В. ', NULL, NULL, '7978 748 63 39', 0, NULL);
INSERT INTO public.contractors VALUES (1175, 1, NULL, NULL, NULL, NULL, NULL, 'Егорченко С.А. ', NULL, NULL, '7978 76 70 250', 0, NULL);
INSERT INTO public.contractors VALUES (1176, 1, NULL, NULL, NULL, NULL, NULL, 'Елизаров В.Е. ', NULL, NULL, '7 978 898 52 16', 0, NULL);
INSERT INTO public.contractors VALUES (1177, 0, NULL, NULL, NULL, NULL, NULL, 'Елизаров В.Е. ', NULL, NULL, '7 978 898 52 16', 0, NULL);
INSERT INTO public.contractors VALUES (1178, 1, NULL, NULL, NULL, NULL, NULL, 'Елизарова Ю.Б. ', NULL, NULL, '79781037083', 0, NULL);
INSERT INTO public.contractors VALUES (1179, 1, NULL, NULL, NULL, NULL, NULL, 'Елинек Андрей ', NULL, NULL, '7978 89 635 20', 0, NULL);
INSERT INTO public.contractors VALUES (1180, 1, NULL, NULL, NULL, NULL, NULL, 'Елсуфьев В.П. ', NULL, NULL, '7978 70 66 044', 0, NULL);
INSERT INTO public.contractors VALUES (1181, 1, NULL, NULL, NULL, NULL, NULL, 'Ельцов А.Н. ', NULL, NULL, '7 978 860 88 93', 0, NULL);
INSERT INTO public.contractors VALUES (1182, 1, NULL, NULL, NULL, NULL, NULL, 'Емельяненко АС 79780642333', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1183, 1, NULL, NULL, NULL, NULL, NULL, 'Емельянов А.В. ', NULL, NULL, '7 978 837 1459', 0, NULL);
INSERT INTO public.contractors VALUES (1184, 0, NULL, NULL, NULL, NULL, NULL, 'Емельянов А.М. ', NULL, NULL, '7 978 837 1459', 0, NULL);
INSERT INTO public.contractors VALUES (1185, 1, NULL, NULL, NULL, NULL, NULL, 'Емельянов Алексей ', NULL, NULL, '7978 7 222 034', 0, NULL);
INSERT INTO public.contractors VALUES (1186, 1, NULL, NULL, NULL, NULL, NULL, 'Емельянова Е.И. ', NULL, NULL, '79788303787', 0, NULL);
INSERT INTO public.contractors VALUES (1187, 1, NULL, NULL, NULL, NULL, NULL, 'Емельянцев В.В. ', NULL, NULL, '7978 74 98 681', 0, NULL);
INSERT INTO public.contractors VALUES (1188, 2, NULL, NULL, NULL, NULL, NULL, 'Енгоян Самсон Мартинович  _А. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1189, 1, NULL, NULL, NULL, NULL, NULL, 'Еременко В.В. ', NULL, NULL, '7 978 833 26 29', 0, NULL);
INSERT INTO public.contractors VALUES (1190, 1, NULL, NULL, NULL, NULL, NULL, 'Еремин 79788430051', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1191, 1, NULL, NULL, NULL, NULL, NULL, 'Еремченко С.В. ', NULL, NULL, '7 978 75 25 132', 0, NULL);
INSERT INTO public.contractors VALUES (1192, 1, NULL, NULL, NULL, NULL, NULL, 'Ермак Л.А. ', NULL, NULL, '7978 7 140 515', 0, NULL);
INSERT INTO public.contractors VALUES (1193, 1, NULL, NULL, NULL, NULL, NULL, 'Ермаков А.В. ', NULL, NULL, '7 978 7232 469', 0, NULL);
INSERT INTO public.contractors VALUES (1194, 0, NULL, NULL, NULL, NULL, NULL, 'Ермаков А.М. ', NULL, NULL, '7 978 728 22 40', 0, NULL);
INSERT INTO public.contractors VALUES (1195, 1, NULL, NULL, NULL, NULL, NULL, 'Ермаков В.Ф. ', NULL, NULL, '7978 74 50 172', 0, NULL);
INSERT INTO public.contractors VALUES (1196, 1, NULL, NULL, NULL, NULL, NULL, 'Ермакова В.С. ', NULL, NULL, '79787880439', 0, NULL);
INSERT INTO public.contractors VALUES (1197, 0, NULL, NULL, NULL, NULL, NULL, 'Ермилов И.Ф. ', NULL, NULL, '79787842132', 0, NULL);
INSERT INTO public.contractors VALUES (1198, 1, NULL, NULL, NULL, NULL, NULL, 'Ермоленко МА 79787825962', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1199, 1, NULL, NULL, NULL, NULL, NULL, 'Ермолов ИА 79787987573', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1200, 1, NULL, NULL, NULL, NULL, NULL, 'Ерух Ю.О. ', NULL, NULL, '7 978 74 76 888', 0, NULL);
INSERT INTO public.contractors VALUES (1201, 1, NULL, NULL, NULL, NULL, NULL, 'Ершов Сергей Станиславович ', NULL, NULL, '7978 800 40 95', 0, NULL);
INSERT INTO public.contractors VALUES (1202, 1, NULL, NULL, NULL, NULL, NULL, 'Есаян Артур ', NULL, NULL, '7978 804 02 14', 0, NULL);
INSERT INTO public.contractors VALUES (1203, 1, NULL, NULL, NULL, NULL, NULL, 'Естишин АН 79787278239', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1204, 0, NULL, NULL, NULL, NULL, NULL, 'Еськин С.В. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1205, 0, NULL, NULL, NULL, NULL, NULL, 'Ефанов Андрей ', NULL, NULL, '7 978 788 37 13', 0, NULL);
INSERT INTO public.contractors VALUES (1206, 1, NULL, NULL, NULL, NULL, NULL, 'Ефименко С.В. ', NULL, NULL, '7 978 762 80 19', 0, NULL);
INSERT INTO public.contractors VALUES (1207, 1, NULL, NULL, NULL, NULL, NULL, 'Ефремов Р 79788039047', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1208, 0, NULL, NULL, NULL, NULL, NULL, 'Жабин Александр ', NULL, NULL, '7978 770-72-03', 0, NULL);
INSERT INTO public.contractors VALUES (1209, 1, NULL, NULL, NULL, NULL, NULL, 'Жабина Ж Ф 79787065785', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1210, 1, NULL, NULL, NULL, NULL, NULL, 'Жабровец ВВ 79787690296', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1211, 1, NULL, NULL, NULL, NULL, NULL, 'Жар Сергей ', NULL, NULL, '7978 824 32 42 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (1212, 1, NULL, NULL, NULL, NULL, NULL, 'Жариков Ю.А. ', NULL, NULL, '7978 72 55 286', 0, NULL);
INSERT INTO public.contractors VALUES (1213, 0, NULL, NULL, NULL, NULL, NULL, 'Жданов Андрей ', NULL, NULL, '7978 86 00 121', 0, NULL);
INSERT INTO public.contractors VALUES (1214, 1, NULL, NULL, NULL, NULL, NULL, 'Жданова Ю 79788515183', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1215, 0, NULL, NULL, NULL, NULL, NULL, 'Жданович Алексей ', NULL, NULL, '7978 200 77 17', 0, NULL);
INSERT INTO public.contractors VALUES (1216, 0, NULL, NULL, NULL, NULL, NULL, 'Железнодорожный Жилсервис ', NULL, NULL, '7 978 060 7597 Владислав', 0, NULL);
INSERT INTO public.contractors VALUES (1217, 0, NULL, NULL, NULL, NULL, NULL, 'Железный Виктор Александрович ', NULL, NULL, '79782149768', 0, NULL);
INSERT INTO public.contractors VALUES (1218, 1, NULL, NULL, NULL, NULL, NULL, 'Железняков АН 79788437745 кп', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1219, 1, NULL, NULL, NULL, NULL, NULL, 'Желлаков В.А.  ', NULL, NULL, '7978 725- 7307 Севастополь', 0, NULL);
INSERT INTO public.contractors VALUES (1220, 0, NULL, NULL, NULL, NULL, NULL, 'Жемчужина Босфора', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1221, 0, NULL, NULL, NULL, NULL, NULL, 'Жернова С.А. ', NULL, NULL, '79788649485', 0, NULL);
INSERT INTO public.contractors VALUES (1222, 0, NULL, NULL, NULL, NULL, NULL, 'Жибер Алексей ', NULL, NULL, '7  978 83 84 225', 0, NULL);
INSERT INTO public.contractors VALUES (1223, 1, NULL, NULL, NULL, NULL, NULL, 'Живило А.В. ', NULL, NULL, '7 978 811 31 67', 0, NULL);
INSERT INTO public.contractors VALUES (1224, 1, NULL, NULL, NULL, NULL, NULL, 'Жила М.В. ', NULL, NULL, '79787376020', 0, NULL);
INSERT INTO public.contractors VALUES (1225, 2, NULL, NULL, NULL, NULL, NULL, 'Жиленков Сергей Владимирович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1226, 2, NULL, NULL, NULL, NULL, NULL, 'Жилин Виталий Владиславович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1227, 0, NULL, NULL, NULL, NULL, NULL, 'Жилло Д.А. ', NULL, NULL, '7 978 710 50 29', 0, NULL);
INSERT INTO public.contractors VALUES (1228, 0, NULL, NULL, NULL, NULL, NULL, 'Жирнов Владимир ', NULL, NULL, '7 978 738 1778', 0, NULL);
INSERT INTO public.contractors VALUES (1229, 1, NULL, NULL, NULL, NULL, NULL, 'Житник Сергей Станиславович ', NULL, NULL, '7978 71 11 092', 0, NULL);
INSERT INTO public.contractors VALUES (1230, 1, NULL, NULL, NULL, NULL, NULL, 'Житников О.О. ', NULL, NULL, '7 978 862 53 69', 0, NULL);
INSERT INTO public.contractors VALUES (1231, 0, NULL, NULL, NULL, NULL, NULL, 'Жихарев Евгений Александрович ', NULL, NULL, '7 978 747 0004', 0, NULL);
INSERT INTO public.contractors VALUES (1232, 0, NULL, NULL, NULL, NULL, 911101001, 'ЖК ЦЕНТРАЛ ПАРК ЖСК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1233, 0, NULL, NULL, NULL, NULL, NULL, 'Жмак Сергей ', NULL, NULL, '79787459861', 0, NULL);
INSERT INTO public.contractors VALUES (1234, 1, NULL, NULL, NULL, NULL, NULL, 'Жолуденко Сергей ', NULL, NULL, '79787333291', 0, NULL);
INSERT INTO public.contractors VALUES (1235, 1, NULL, NULL, NULL, NULL, NULL, 'ЖСК 91', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1236, 0, NULL, NULL, NULL, NULL, 910201001, 'ЖСК Салгирское ', NULL, NULL, '7978 736 62 78 Руслан', 0, NULL);
INSERT INTO public.contractors VALUES (1237, 0, NULL, NULL, NULL, NULL, NULL, 'Жук Павел Федорович ', NULL, NULL, '7 978 840 57 87', 0, NULL);
INSERT INTO public.contractors VALUES (1238, 0, NULL, NULL, NULL, NULL, NULL, 'Жуков Борис Алексеевич ИП ', NULL, NULL, '79788198975', 0, NULL);
INSERT INTO public.contractors VALUES (1239, 1, NULL, NULL, NULL, NULL, NULL, 'Жуков Д.В. ', NULL, NULL, '7 978 800 62 65', 0, NULL);
INSERT INTO public.contractors VALUES (1240, 0, NULL, NULL, NULL, NULL, NULL, 'Жуков О.В. ', NULL, NULL, '79787767195', 0, NULL);
INSERT INTO public.contractors VALUES (1241, 1, NULL, NULL, NULL, NULL, NULL, 'Жуков Р.И. ', NULL, NULL, '79781311187', 0, NULL);
INSERT INTO public.contractors VALUES (1242, 0, NULL, NULL, NULL, NULL, NULL, 'Жуланов А.В.  ', NULL, NULL, '7978 032 6307 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1243, 1, NULL, NULL, NULL, NULL, NULL, 'Жупанов Ю.Е. ', NULL, NULL, '79788174919', 0, NULL);
INSERT INTO public.contractors VALUES (1244, 1, NULL, NULL, NULL, NULL, NULL, 'Журавлев В.М. ', NULL, NULL, '7 978 7295 263', 0, NULL);
INSERT INTO public.contractors VALUES (1245, 1, NULL, NULL, NULL, NULL, NULL, 'Журавлев ВМ 79787295263', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1246, 1, NULL, NULL, NULL, NULL, NULL, 'Журавлев Николай Алексеевич ', NULL, NULL, '79781089585', 0, NULL);
INSERT INTO public.contractors VALUES (1247, 1, NULL, NULL, NULL, NULL, NULL, 'Жургунов ЖД79788807974', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1248, 1, NULL, NULL, NULL, NULL, NULL, 'Жучков В.А. ', NULL, NULL, '7978 825 24 28', 0, NULL);
INSERT INTO public.contractors VALUES (1249, 1, NULL, NULL, NULL, NULL, NULL, 'Забияченко С.Л. ', NULL, NULL, '7 978 8560399', 0, NULL);
INSERT INTO public.contractors VALUES (1250, 1, NULL, NULL, NULL, NULL, NULL, 'Заблодская Л.С. ', NULL, NULL, '7 978 8 42 97 32', 0, NULL);
INSERT INTO public.contractors VALUES (1251, 1, NULL, NULL, NULL, NULL, NULL, 'Заболотный ПП 79787256905', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1252, 0, NULL, NULL, NULL, NULL, NULL, 'Забродько М.В. ', NULL, NULL, '7 978 75 87 519', 0, NULL);
INSERT INTO public.contractors VALUES (1253, 0, NULL, NULL, NULL, NULL, NULL, 'Завадский Андрей ', NULL, NULL, '7 978 856 77 16', 0, NULL);
INSERT INTO public.contractors VALUES (1254, 1, NULL, NULL, NULL, NULL, NULL, 'Заваленко А.С. ', NULL, NULL, '7 918 260 16 60', 0, NULL);
INSERT INTO public.contractors VALUES (1255, 0, NULL, NULL, NULL, NULL, NULL, 'Заваленко Светлана Викторовна ', NULL, NULL, '7978 7510162', 0, NULL);
INSERT INTO public.contractors VALUES (1256, 0, NULL, NULL, NULL, NULL, NULL, 'Завальный Андрей ', NULL, NULL, '7 978 770 88 13 (д.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1257, 1, NULL, NULL, NULL, NULL, NULL, 'Завертайло К.Н. ', NULL, NULL, '7 978 842 40 32', 0, NULL);
INSERT INTO public.contractors VALUES (1258, 0, NULL, NULL, NULL, NULL, NULL, 'Завод Кровли и Фасада Эмиль ', NULL, NULL, '7978 761-83-07-А.', 0, NULL);
INSERT INTO public.contractors VALUES (1259, 0, NULL, NULL, NULL, NULL, NULL, 'Завод металло-пластиковых конструкций ESTRA', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1260, 0, NULL, NULL, NULL, NULL, NULL, 'Завод Первомайский', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1261, 2, NULL, NULL, NULL, NULL, NULL, 'Завозин А.Н.  СИМФЕРОПОЛЬ ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1262, 0, NULL, NULL, NULL, NULL, NULL, 'Завозин Антон', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1263, 2, NULL, NULL, NULL, NULL, NULL, 'Завозин Николай Георгиевич ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1264, 2, NULL, NULL, NULL, NULL, NULL, 'Завозин Николай Николаевич ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1265, 2, NULL, NULL, NULL, NULL, NULL, 'Завозина Е.О.  АНАПА ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1266, 1, NULL, NULL, NULL, NULL, NULL, 'Заворотниченко ЕГ 79787123668', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1267, 0, NULL, NULL, NULL, NULL, NULL, 'Заговалко А.В. ', NULL, NULL, '7 978 771 49 96', 0, NULL);
INSERT INTO public.contractors VALUES (1268, 1, NULL, NULL, NULL, NULL, NULL, 'Загородний В.Б. ', NULL, NULL, '7978 825 62 33', 0, NULL);
INSERT INTO public.contractors VALUES (1269, 1, NULL, NULL, NULL, NULL, NULL, 'Загородняя Г.М. ', NULL, NULL, '7 978 772 48 19', 0, NULL);
INSERT INTO public.contractors VALUES (1270, 1, NULL, NULL, NULL, NULL, NULL, 'Загоруйко А.Ю. ', NULL, NULL, '7 978 116 23 56', 0, NULL);
INSERT INTO public.contractors VALUES (1271, 1, NULL, NULL, NULL, NULL, NULL, 'Загорулько Н.В. ', NULL, NULL, '7 978 766 53 34', 0, NULL);
INSERT INTO public.contractors VALUES (1272, 1, NULL, NULL, NULL, NULL, NULL, 'Задеба А.А. ', NULL, NULL, '7978 71 32 351', 0, NULL);
INSERT INTO public.contractors VALUES (1273, 1, NULL, NULL, NULL, NULL, NULL, 'Задоров В.Я. ', NULL, NULL, '7 978 72 30 046', 0, NULL);
INSERT INTO public.contractors VALUES (1274, 1, NULL, NULL, NULL, NULL, NULL, 'Задорожный В.Л ', NULL, NULL, '7 978 731 20 98', 0, NULL);
INSERT INTO public.contractors VALUES (1275, 1, NULL, NULL, NULL, NULL, NULL, 'Задорожный Николай Иванович ', NULL, NULL, '79787217533', 0, NULL);
INSERT INTO public.contractors VALUES (1276, 1, NULL, NULL, NULL, NULL, NULL, 'Задорожный С. ', NULL, NULL, '79780119350', 0, NULL);
INSERT INTO public.contractors VALUES (1277, 0, NULL, NULL, NULL, NULL, NULL, 'Заец Александр Иванович ', NULL, NULL, '79787296333', 0, NULL);
INSERT INTO public.contractors VALUES (1278, 0, NULL, NULL, NULL, NULL, NULL, 'Заец Е.В. ', NULL, NULL, '7 978 702 87 39', 0, NULL);
INSERT INTO public.contractors VALUES (1279, 1, NULL, NULL, NULL, NULL, NULL, 'Заика ЕА 79787720706', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1280, 1, NULL, NULL, NULL, NULL, NULL, 'Заика ЯВ 79787826235', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1281, 0, NULL, NULL, NULL, NULL, NULL, 'Заинчковский Ю.В. ', NULL, NULL, '7 978 764 96 01', 0, NULL);
INSERT INTO public.contractors VALUES (1282, 0, NULL, NULL, NULL, NULL, NULL, 'Зайцев Д.В. ', NULL, NULL, '79787899597', 0, NULL);
INSERT INTO public.contractors VALUES (1283, 1, NULL, NULL, NULL, NULL, NULL, 'Зайцев С.А. ', NULL, NULL, '7978 75 47 635', 0, NULL);
INSERT INTO public.contractors VALUES (1284, 1, NULL, NULL, NULL, NULL, NULL, 'Зайцева А.А., ', NULL, NULL, '7 978 73 43 149', 0, NULL);
INSERT INTO public.contractors VALUES (1285, 1, NULL, NULL, NULL, NULL, NULL, 'Зайцева Анастасия Андреевна 8 912 585 45 45', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1286, 0, NULL, NULL, NULL, NULL, NULL, 'Зайченко А.А. ', NULL, NULL, '7 978 8 185 797', 0, NULL);
INSERT INTO public.contractors VALUES (1287, 1, NULL, NULL, NULL, NULL, NULL, 'Закардонец АН 79780040863', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1288, 1, NULL, NULL, NULL, NULL, NULL, 'Закир', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1289, 0, NULL, NULL, NULL, NULL, NULL, 'Закир станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1290, 0, NULL, NULL, NULL, NULL, NULL, 'Закир станочник, Влад станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1291, 0, NULL, NULL, NULL, NULL, NULL, 'Залевский Руслан ', NULL, NULL, '7 978 807 44 96', 0, NULL);
INSERT INTO public.contractors VALUES (1292, 0, NULL, NULL, NULL, NULL, NULL, 'Залесская Жанна Леонидовна ', NULL, NULL, '79788605848', 0, NULL);
INSERT INTO public.contractors VALUES (1293, 1, NULL, NULL, NULL, NULL, NULL, 'Заломенков Д.С. ', NULL, NULL, '7 978 716 000 1', 0, NULL);
INSERT INTO public.contractors VALUES (1294, 1, NULL, NULL, NULL, NULL, NULL, 'Заминов К.Б. ', NULL, NULL, '7 978 005 27 10', 0, NULL);
INSERT INTO public.contractors VALUES (1295, 1, NULL, NULL, NULL, NULL, NULL, 'Замятин В.В. ', NULL, NULL, '7978 750 99 09', 0, NULL);
INSERT INTO public.contractors VALUES (1296, 1, NULL, NULL, NULL, NULL, NULL, 'Заплатин А 79827212129 79780483074', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1297, 1, NULL, NULL, NULL, NULL, NULL, 'Зарапин А.Л. ', NULL, NULL, '7978 753 61 60', 0, NULL);
INSERT INTO public.contractors VALUES (1298, 0, NULL, NULL, NULL, NULL, NULL, 'Заремблюк Дмитрий ', NULL, NULL, '7 978 879 555 6', 0, NULL);
INSERT INTO public.contractors VALUES (1299, 0, NULL, NULL, NULL, NULL, NULL, 'Зарубин Александр ', NULL, NULL, '79782018881', 0, NULL);
INSERT INTO public.contractors VALUES (1300, 1, NULL, NULL, NULL, NULL, NULL, 'Затрубченко А.А, ', NULL, NULL, '79788533530', 0, NULL);
INSERT INTO public.contractors VALUES (1301, 2, NULL, NULL, NULL, NULL, NULL, 'Захаревский Василий Викторович  ', NULL, NULL, '7 978 736 94 17 _Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1302, 1, NULL, NULL, NULL, NULL, NULL, 'Захаркив В 79788928819', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1303, 1, NULL, NULL, NULL, NULL, NULL, 'Захаркин АН 79787643967', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1304, 1, NULL, NULL, NULL, NULL, NULL, 'Захаров АЕ 79780047385', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1305, 1, NULL, NULL, NULL, NULL, NULL, 'Захаров Константин ', NULL, NULL, '7 978 788 77 59', 0, NULL);
INSERT INTO public.contractors VALUES (1306, 1, NULL, NULL, NULL, NULL, NULL, 'Захаров Ю.В. ', NULL, NULL, '79781015882', 0, NULL);
INSERT INTO public.contractors VALUES (1307, 0, NULL, NULL, NULL, NULL, NULL, 'Захарова Яна Юрьевна ', NULL, NULL, '79288258885', 0, NULL);
INSERT INTO public.contractors VALUES (1308, 0, NULL, NULL, NULL, NULL, NULL, 'Захарчук А.В. ', NULL, NULL, '7978 713 - 74 -42', 0, NULL);
INSERT INTO public.contractors VALUES (1309, 1, NULL, NULL, NULL, NULL, NULL, 'Захарчук СП 79780326506', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1310, 1, NULL, NULL, NULL, NULL, NULL, 'Захарян 79896604179', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1311, 1, NULL, NULL, NULL, NULL, NULL, 'Захарян М.В. ', NULL, NULL, '7 918 216 44 23', 0, NULL);
INSERT INTO public.contractors VALUES (1312, 1, NULL, NULL, NULL, NULL, NULL, 'Захожий В.С. ', NULL, NULL, '7 978 848 32 03', 0, NULL);
INSERT INTO public.contractors VALUES (1313, 0, NULL, NULL, NULL, NULL, NULL, 'Зацепин Андрей Эдуардович ', NULL, NULL, '79788601885', 0, NULL);
INSERT INTO public.contractors VALUES (1314, 1, NULL, NULL, NULL, NULL, NULL, 'Заяц М.Ф. ', NULL, NULL, '7978 818 28 36', 0, NULL);
INSERT INTO public.contractors VALUES (1315, 1, NULL, NULL, NULL, NULL, NULL, 'Згода 79787402416', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1316, 0, NULL, NULL, NULL, NULL, 771901001, '"ЗЕВС"", Андрей ', NULL, NULL, '7 987 95 63 559 ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (1317, 1, NULL, NULL, NULL, NULL, NULL, 'Зейтулаев Кулдус ', NULL, NULL, '7978 201 73 49', 0, NULL);
INSERT INTO public.contractors VALUES (1318, 1, NULL, NULL, NULL, NULL, NULL, 'Зейтуллаев Э.Э. ', NULL, NULL, '7 978 840 94 75', 0, NULL);
INSERT INTO public.contractors VALUES (1319, 1, NULL, NULL, NULL, NULL, NULL, 'Зейтуло А.Т. ', NULL, NULL, '7978 0071 882', 0, NULL);
INSERT INTO public.contractors VALUES (1320, 0, NULL, NULL, NULL, NULL, NULL, 'Зекиляев Дилявер (от Сейрана)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1321, 0, NULL, NULL, NULL, NULL, NULL, 'Зекина Л.Н. ', NULL, NULL, '7 978 729 45 30', 0, NULL);
INSERT INTO public.contractors VALUES (1322, 0, NULL, NULL, NULL, NULL, NULL, 'Зекиряев Дилявер ', NULL, NULL, '7 978 004 63 58', 0, NULL);
INSERT INTO public.contractors VALUES (1323, 1, NULL, NULL, NULL, NULL, NULL, 'Зеленин 79788557430', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1324, 1, NULL, NULL, NULL, NULL, NULL, 'Зеленский В.В. ', NULL, NULL, '7978 829 19 37', 0, NULL);
INSERT INTO public.contractors VALUES (1325, 1, NULL, NULL, NULL, NULL, NULL, 'Зеленский ВИ 79787113808', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1326, 1, NULL, NULL, NULL, NULL, NULL, 'Зеленский ИС 79787715175', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1327, 2, NULL, NULL, NULL, NULL, NULL, 'Зеливянский А.Ю.  8 978 022-77-66(55) саморезы ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1328, 1, NULL, NULL, NULL, NULL, NULL, 'Зелькин АЕ 79788330566', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1329, 1, NULL, NULL, NULL, NULL, NULL, 'Земляченко ВА 79781427280', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1330, 1, NULL, NULL, NULL, NULL, NULL, 'Земсков ИА 79787081613', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1331, 1, NULL, NULL, NULL, NULL, NULL, 'Зенков НЮ 79788764890', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1332, 0, NULL, NULL, NULL, NULL, NULL, 'Зиединов Джафер Мустафаевич ', NULL, NULL, '79780041627', 0, NULL);
INSERT INTO public.contractors VALUES (1333, 1, NULL, NULL, NULL, NULL, NULL, 'Зикиряев Д.Э. ', NULL, NULL, '7 978 004 63 58', 0, NULL);
INSERT INTO public.contractors VALUES (1334, 1, NULL, NULL, NULL, NULL, NULL, 'Зикраев Р.З. ', NULL, NULL, '7 978 83 80 892', 0, NULL);
INSERT INTO public.contractors VALUES (1335, 1, NULL, NULL, NULL, NULL, NULL, 'Зинединов ДА ', NULL, NULL, '79780655338', 0, NULL);
INSERT INTO public.contractors VALUES (1336, 1, NULL, NULL, NULL, NULL, NULL, 'Зиновьев С.С. ', NULL, NULL, '7978 203 30 73', 0, NULL);
INSERT INTO public.contractors VALUES (1337, 0, NULL, NULL, NULL, NULL, NULL, 'Зиновьева Светлана', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1338, 1, NULL, NULL, NULL, NULL, NULL, 'Зинченко 79787873712', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1339, 1, NULL, NULL, NULL, NULL, NULL, 'Зинченко В.В. ', NULL, NULL, '7 978 3 42 462', 0, NULL);
INSERT INTO public.contractors VALUES (1340, 1, NULL, NULL, NULL, NULL, NULL, 'Зиядинов С.Н. ', NULL, NULL, '7978 842 7 625', 0, NULL);
INSERT INTO public.contractors VALUES (1341, 1, NULL, NULL, NULL, NULL, NULL, 'Злобин А.Д. ', NULL, NULL, '7 978 138 49 98', 0, NULL);
INSERT INTO public.contractors VALUES (1342, 1, NULL, NULL, NULL, NULL, NULL, 'Злобин СВ 79787249092', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1343, 0, NULL, NULL, NULL, NULL, NULL, 'Знаменское ', NULL, NULL, '7 978 846 0271 Сергей', 0, NULL);
INSERT INTO public.contractors VALUES (1344, 1, NULL, NULL, NULL, NULL, NULL, 'Зозулинский АВ 79787565610', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1345, 1, NULL, NULL, NULL, NULL, NULL, 'Зонов СВ 79822538887', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1346, 1, NULL, NULL, NULL, NULL, NULL, 'Зотов И.Б. 8 903 675 36 25', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1347, 0, NULL, NULL, NULL, NULL, NULL, 'Зуб Р.А. ', NULL, NULL, '7 978 82 35 638', 0, NULL);
INSERT INTO public.contractors VALUES (1348, 1, NULL, NULL, NULL, NULL, NULL, 'Зубарев Николай ', NULL, NULL, '7 978 758 71 59', 0, NULL);
INSERT INTO public.contractors VALUES (1349, 1, NULL, NULL, NULL, NULL, NULL, 'Зубик Р.Р. ', NULL, NULL, '7 978 74 72 872', 0, NULL);
INSERT INTO public.contractors VALUES (1350, 1, NULL, NULL, NULL, NULL, NULL, 'Зубов Я.В. ', NULL, NULL, '7 978 731 58 27', 0, NULL);
INSERT INTO public.contractors VALUES (1351, 0, NULL, NULL, NULL, NULL, NULL, 'Зубоченко Денис ', NULL, NULL, '7 978 7115 602', 0, NULL);
INSERT INTO public.contractors VALUES (1352, 1, NULL, NULL, NULL, NULL, NULL, 'Зуев Н.В. ', NULL, NULL, '7 978 815 31 90', 0, NULL);
INSERT INTO public.contractors VALUES (1353, 1, NULL, NULL, NULL, NULL, NULL, 'Зыков АВ 79787445284', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1354, 0, NULL, NULL, NULL, NULL, NULL, 'Ибадуллаев С.Р. ', NULL, NULL, '7 978 032 64 91', 0, NULL);
INSERT INTO public.contractors VALUES (1355, 1, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1356, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов 7 978 883 01 00', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1357, 1, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов А.А. ', NULL, NULL, '7 988 967 62 62', 0, NULL);
INSERT INTO public.contractors VALUES (1358, 1, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов А.Х. ', NULL, NULL, '7 978 738 26 30', 0, NULL);
INSERT INTO public.contractors VALUES (1359, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Абльмеджид ', NULL, NULL, '7 978 011 90 23', 0, NULL);
INSERT INTO public.contractors VALUES (1360, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Айдер ', NULL, NULL, '7 978 73 82 630', 0, NULL);
INSERT INTO public.contractors VALUES (1361, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Аким ', NULL, NULL, '7 988 967 62 62', 0, NULL);
INSERT INTO public.contractors VALUES (1362, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Амет', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1363, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Амет ', NULL, NULL, '7 978 717 58 66', 0, NULL);
INSERT INTO public.contractors VALUES (1364, 1, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Арсен ', NULL, NULL, '7 978 75 98 495', 0, NULL);
INSERT INTO public.contractors VALUES (1365, 1, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Р 79787644887', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1366, 0, NULL, NULL, NULL, NULL, NULL, 'Ибрагимов Э.Т. ', NULL, NULL, '7978 7209152', 0, NULL);
INSERT INTO public.contractors VALUES (1367, 0, NULL, NULL, NULL, NULL, NULL, 'Ибраим ', NULL, NULL, '7978 057 6073', 0, NULL);
INSERT INTO public.contractors VALUES (1368, 1, NULL, NULL, NULL, NULL, NULL, 'Ибраимов Н.С. ', NULL, NULL, '7 978 829 44 68', 0, NULL);
INSERT INTO public.contractors VALUES (1369, 0, NULL, NULL, NULL, NULL, NULL, 'Иваненко Эдуард ', NULL, NULL, '7 978 918 16 18', 0, NULL);
INSERT INTO public.contractors VALUES (1370, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов ', NULL, NULL, '7 978 918 16 18', 0, NULL);
INSERT INTO public.contractors VALUES (1371, 0, NULL, NULL, NULL, NULL, NULL, 'Иванов ', NULL, NULL, '7978 724 1318', 0, NULL);
INSERT INTO public.contractors VALUES (1372, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов 79787137691', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1373, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов А.Ж. ', NULL, NULL, '7978 080 79 09', 0, NULL);
INSERT INTO public.contractors VALUES (1374, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов А.П. ', NULL, NULL, '7 978 745 49 83', 0, NULL);
INSERT INTO public.contractors VALUES (1375, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов ВА 79787456298', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1376, 2, NULL, NULL, NULL, NULL, NULL, 'Иванов Владимир Михайлович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1377, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов И.И. ', NULL, NULL, '7 978 7260779', 0, NULL);
INSERT INTO public.contractors VALUES (1378, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов И.И. ', NULL, NULL, '7 978 828 85 49', 0, NULL);
INSERT INTO public.contractors VALUES (1379, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов ИА 79788025119', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1380, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов ИИ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1381, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов ИИ 79788789817', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1382, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов КМ 79788295255', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1383, 0, NULL, NULL, NULL, NULL, NULL, 'Иванов С.А. ', NULL, NULL, '7 978 718 23 77', 0, NULL);
INSERT INTO public.contractors VALUES (1384, 0, NULL, NULL, NULL, NULL, NULL, 'Иванов С.М. ', NULL, NULL, '7 978 721 67 02', 0, NULL);
INSERT INTO public.contractors VALUES (1385, 1, NULL, NULL, NULL, NULL, NULL, 'Иванов СА 79787191160', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1386, 1, NULL, NULL, NULL, NULL, NULL, 'Иванова НЛ 79787818738', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1387, 1, NULL, NULL, NULL, NULL, NULL, 'Иванцов 79787308111', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1388, 0, NULL, NULL, NULL, NULL, NULL, 'Иванцов Андрей', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1389, 1, NULL, NULL, NULL, NULL, NULL, 'Иванченко Оксана ', NULL, NULL, '7 978 861 86 39', 0, NULL);
INSERT INTO public.contractors VALUES (1390, 0, NULL, NULL, NULL, NULL, NULL, 'Ивашечкина Н.И. ', NULL, NULL, '7 978 789 19 62', 0, NULL);
INSERT INTO public.contractors VALUES (1391, 1, NULL, NULL, NULL, NULL, NULL, 'Иващенко Н.Н. ', NULL, NULL, '7 978 713 85 75', 0, NULL);
INSERT INTO public.contractors VALUES (1392, 1, NULL, NULL, NULL, NULL, NULL, 'Ивлев Д.С. ', NULL, NULL, '7 978 809 71 22', 0, NULL);
INSERT INTO public.contractors VALUES (1393, 1, NULL, NULL, NULL, NULL, NULL, 'Ивлева Л.Н. ', NULL, NULL, '7978 838 000 5', 0, NULL);
INSERT INTO public.contractors VALUES (1394, 1, NULL, NULL, NULL, NULL, NULL, 'Игнатенко Александр ', NULL, NULL, '79788238025', 0, NULL);
INSERT INTO public.contractors VALUES (1395, 0, NULL, NULL, NULL, NULL, NULL, 'Игнатенко Г.А. ', NULL, NULL, '7 978 00 42 241', 0, NULL);
INSERT INTO public.contractors VALUES (1396, 1, NULL, NULL, NULL, NULL, NULL, 'Игнатенко НА 79788294523', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1397, 1, NULL, NULL, NULL, NULL, NULL, 'Игнатьев ВП 79787016988', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1398, 1, NULL, NULL, NULL, NULL, NULL, 'Игнатюк ВИ 79787674609', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1399, 0, NULL, NULL, NULL, NULL, NULL, 'Игорь ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1400, 1, NULL, NULL, NULL, NULL, NULL, 'Игорь ', NULL, NULL, '7 989 128 08 08', 0, NULL);
INSERT INTO public.contractors VALUES (1401, 0, NULL, NULL, NULL, NULL, NULL, 'Игорь водитель', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1402, 1, NULL, NULL, NULL, NULL, NULL, 'Игорь Львович ', NULL, NULL, '7 916 676 12 79 (Межводное)', 0, NULL);
INSERT INTO public.contractors VALUES (1403, 1, NULL, NULL, NULL, NULL, NULL, 'Игумнов А.И. ', NULL, NULL, '7 978 769 82 48', 0, NULL);
INSERT INTO public.contractors VALUES (1404, 0, NULL, NULL, NULL, NULL, NULL, 'Иджиаблаев Бахтияр ', NULL, NULL, '7 978 864 12 41', 0, NULL);
INSERT INTO public.contractors VALUES (1405, 1, NULL, NULL, NULL, NULL, NULL, 'Идрисов 79787228612', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1406, 1, NULL, NULL, NULL, NULL, NULL, 'Идрисов И.Р. ', NULL, NULL, '7978 751 30 93', 0, NULL);
INSERT INTO public.contractors VALUES (1407, 1, NULL, NULL, NULL, NULL, NULL, 'Идрисов Н.Ш. ', NULL, NULL, '7 978 745 02 77', 0, NULL);
INSERT INTO public.contractors VALUES (1408, 1, NULL, NULL, NULL, NULL, NULL, 'Идрисов Ридван ', NULL, NULL, '7978 776 56 45 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (1409, 0, NULL, NULL, NULL, NULL, NULL, 'Ижболгин В.Н.', NULL, NULL, '79787727035', 0, NULL);
INSERT INTO public.contractors VALUES (1410, 1, NULL, NULL, NULL, NULL, NULL, 'Ижина ТА 79787401640', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1411, 1, NULL, NULL, NULL, NULL, NULL, 'Избаш Н.Ю. ', NULL, NULL, '7 978 575 78 91 Федер Федорович', 0, NULL);
INSERT INTO public.contractors VALUES (1412, 1, NULL, NULL, NULL, NULL, NULL, 'Издебский С.В. ', NULL, NULL, '7 978 014 34 04', 0, NULL);
INSERT INTO public.contractors VALUES (1413, 0, NULL, NULL, NULL, NULL, NULL, 'Изет кровельщик ', NULL, NULL, '7 978 845 92 96 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1414, 0, NULL, NULL, NULL, NULL, NULL, 'Изет Сейтаров ', NULL, NULL, '7978 75 29 816', 0, NULL);
INSERT INTO public.contractors VALUES (1415, 0, NULL, NULL, NULL, NULL, NULL, 'Изетов Али ', NULL, NULL, '7 978 78 25 234', 0, NULL);
INSERT INTO public.contractors VALUES (1416, 1, NULL, NULL, NULL, NULL, NULL, 'Изетов Н.М. ', NULL, NULL, '7 978 86 23 063', 0, NULL);
INSERT INTO public.contractors VALUES (1417, 0, NULL, NULL, NULL, NULL, NULL, 'Изетов Р.И. ', NULL, NULL, '7 978 733 95 61', 0, NULL);
INSERT INTO public.contractors VALUES (1418, 1, NULL, NULL, NULL, NULL, NULL, 'Изетов Р.Э. ', NULL, NULL, '7978 733 95 61 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (1419, 0, NULL, NULL, NULL, NULL, NULL, 'Изитулаева Надежда Александровна', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1420, 1, NULL, NULL, NULL, NULL, NULL, 'Измайлов Мемет 79780239777', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1421, 1, NULL, NULL, NULL, NULL, NULL, 'Измерли Е.Г. ', NULL, NULL, '7978 810 68 00', 0, NULL);
INSERT INTO public.contractors VALUES (1422, 0, NULL, NULL, NULL, NULL, NULL, 'Изумруд-В АО ', NULL, NULL, '7 978 769 39 22 Елена Александровна', 0, NULL);
INSERT INTO public.contractors VALUES (1423, 1, NULL, NULL, NULL, NULL, NULL, 'Илиев И.Б. ', NULL, NULL, '7 978 884 69 63', 0, NULL);
INSERT INTO public.contractors VALUES (1424, 1, NULL, NULL, NULL, NULL, NULL, 'Ильин Алексей ', NULL, NULL, '7 978 889 1665', 0, NULL);
INSERT INTO public.contractors VALUES (1425, 1, NULL, NULL, NULL, NULL, NULL, 'Ильин Евгений кп ', NULL, NULL, '7978 74 57 686', 0, NULL);
INSERT INTO public.contractors VALUES (1426, 0, NULL, NULL, NULL, NULL, NULL, 'Ильин к п   ', NULL, NULL, '7 978 73 82 692', 0, NULL);
INSERT INTO public.contractors VALUES (1427, 1, NULL, NULL, NULL, NULL, NULL, 'Ильиных В.Л. ', NULL, NULL, '7978 781 73 69', 0, NULL);
INSERT INTO public.contractors VALUES (1428, 1, NULL, NULL, NULL, NULL, NULL, 'Ильницкий А.В. ', NULL, NULL, '7 978 848 87 13', 0, NULL);
INSERT INTO public.contractors VALUES (1429, 0, NULL, NULL, NULL, NULL, NULL, 'Илья _', NULL, NULL, '7 978 845 57 62 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1430, 0, NULL, NULL, NULL, NULL, NULL, 'Илья ', NULL, NULL, '7 978 845 57 62 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1431, 1, NULL, NULL, NULL, NULL, NULL, 'Илья ', NULL, NULL, '79787139831', 0, NULL);
INSERT INTO public.contractors VALUES (1432, 0, NULL, NULL, NULL, NULL, NULL, 'Илья Мощенко', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1433, 1, NULL, NULL, NULL, NULL, NULL, 'Ильясов АР 79787930856', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1434, 0, NULL, NULL, NULL, NULL, NULL, 'Ильяшенко Олег ', NULL, NULL, '7 978 81 40 911', 0, NULL);
INSERT INTO public.contractors VALUES (1435, 0, NULL, NULL, NULL, NULL, NULL, 'ИММА ГРУП  79190362634 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1436, 1, NULL, NULL, NULL, NULL, NULL, 'Имралиев И.А. ', NULL, NULL, '7 978 863 40 39', 0, NULL);
INSERT INTO public.contractors VALUES (1437, 0, NULL, NULL, NULL, NULL, NULL, 'Инвест Плюс ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1438, 0, NULL, NULL, NULL, NULL, NULL, 'ИНТЕРСТИЛ ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1439, 1, NULL, NULL, NULL, NULL, NULL, 'Иншин Константин Иванович ', NULL, NULL, '7978 753 78 56', 0, NULL);
INSERT INTO public.contractors VALUES (1440, 1, NULL, NULL, NULL, NULL, NULL, 'Ионец В.Н. ', NULL, NULL, '7 978 941 11 98', 0, NULL);
INSERT INTO public.contractors VALUES (1441, 1, NULL, NULL, NULL, NULL, NULL, 'Ионинков Д.А. ', NULL, NULL, '79787339321', 0, NULL);
INSERT INTO public.contractors VALUES (1442, 1, NULL, NULL, NULL, NULL, NULL, 'ИП Гарнуша', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1443, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Горлатенко А.В.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1444, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Завозин (на магазин)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1445, 2, NULL, NULL, NULL, NULL, NULL, 'ИП Завозина Елена Владимировна', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1446, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Завозина Елена Владимировна 2', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1447, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Комфорт (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1448, 2, NULL, NULL, NULL, NULL, NULL, 'ИП Корсун Сергей (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1449, 2, NULL, NULL, NULL, NULL, NULL, 'ИП Кровля Цент (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1450, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Мирошниченко А.В', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1451, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Рахманкулова ', NULL, NULL, '7 978 761 83 07', 0, NULL);
INSERT INTO public.contractors VALUES (1452, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Сазанов (от КЛГрупп)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1453, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Сафонов Александр ', NULL, NULL, '7 978 708 12 35 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1454, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Сахнюк ', NULL, NULL, '7 978 046 85 39', 0, NULL);
INSERT INTO public.contractors VALUES (1455, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Умеров Амет Решатович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1456, 0, NULL, NULL, NULL, NULL, NULL, 'ИП Усеинов А.Р.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1457, 1, NULL, NULL, NULL, NULL, NULL, 'Ипатов Артем Генадьевич ', NULL, NULL, '7978 79 154 85', 0, NULL);
INSERT INTO public.contractors VALUES (1458, 2, NULL, NULL, NULL, NULL, NULL, 'Ира Меркурий ', NULL, NULL, '7978 701 24 17', 0, NULL);
INSERT INTO public.contractors VALUES (1459, 1, NULL, NULL, NULL, NULL, NULL, 'Ирина менеджер', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1460, 1, NULL, NULL, NULL, NULL, NULL, 'Исаев С.Л. ', NULL, NULL, '7 978 730 98 95', 0, NULL);
INSERT INTO public.contractors VALUES (1461, 1, NULL, NULL, NULL, NULL, NULL, 'Исаев С.Л. ', NULL, NULL, '7 978 730 98 95', 0, NULL);
INSERT INTO public.contractors VALUES (1462, 1, NULL, NULL, NULL, NULL, NULL, 'Исаев ТА 79780556330', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1463, 1, NULL, NULL, NULL, NULL, NULL, 'Исаченок С.М. ', NULL, NULL, '7978 754 64 53', 0, NULL);
INSERT INTO public.contractors VALUES (1464, 1, NULL, NULL, NULL, NULL, NULL, 'Исламов В.В. ', NULL, NULL, '7 978 766 29 55', 0, NULL);
INSERT INTO public.contractors VALUES (1465, 1, NULL, NULL, NULL, NULL, NULL, 'Ислям ', NULL, NULL, '7 978 72 168 0201', 0, NULL);
INSERT INTO public.contractors VALUES (1466, 0, NULL, NULL, NULL, NULL, NULL, 'Ислямов А.А. ', NULL, NULL, '7 978 89 77 218', 0, NULL);
INSERT INTO public.contractors VALUES (1467, 1, NULL, NULL, NULL, NULL, NULL, 'Ислямов Р.И.  ', NULL, NULL, '7985 098 12 11', 0, NULL);
INSERT INTO public.contractors VALUES (1468, 1, NULL, NULL, NULL, NULL, NULL, 'Ислямов С.Т ', NULL, NULL, '7 985 637 70 19', 0, NULL);
INSERT INTO public.contractors VALUES (1469, 1, NULL, NULL, NULL, NULL, NULL, 'Ислямов Э.Э. ', NULL, NULL, '7978 831 28 84', 0, NULL);
INSERT INTO public.contractors VALUES (1470, 1, NULL, NULL, NULL, NULL, NULL, 'Ислямов Ю.А. ', NULL, NULL, '79782795140', 0, NULL);
INSERT INTO public.contractors VALUES (1471, 1, NULL, NULL, NULL, NULL, NULL, 'Исмаило Ильяс ', NULL, NULL, '79781309882 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1472, 1, NULL, NULL, NULL, NULL, NULL, 'Исмаилов АА 79780491592', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1473, 0, NULL, NULL, NULL, NULL, NULL, 'Исмаилов Азиз ', NULL, NULL, '79782284620', 0, NULL);
INSERT INTO public.contractors VALUES (1474, 1, NULL, NULL, NULL, NULL, NULL, 'Исмаилов Ш.Р. ', NULL, NULL, '7978 706 44 49', 0, NULL);
INSERT INTO public.contractors VALUES (1475, 2, NULL, NULL, NULL, NULL, NULL, 'Исхаков Руслан ( Джанкой) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1476, NULL, NULL, NULL, NULL, NULL, 231501001, 'ИФНС России по г. Новороссийску Краснодарского края', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1477, NULL, NULL, NULL, NULL, NULL, 910201001, 'ИФНС России по г.Симферополю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1478, 1, NULL, NULL, NULL, NULL, NULL, 'Ичетовкин АГ 79788230372', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1479, 1, NULL, NULL, NULL, NULL, NULL, 'Ишкинин А.В. ', NULL, NULL, '79787875455', 0, NULL);
INSERT INTO public.contractors VALUES (1480, 1, NULL, NULL, NULL, NULL, NULL, 'Ищенко СН 79787664248', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1481, 0, NULL, NULL, NULL, NULL, NULL, 'К-СТРОЙ ', NULL, NULL, '7978 212-01-68 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (1482, 1, NULL, NULL, NULL, NULL, NULL, 'Кабалюк 79787558995', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1483, 1, NULL, NULL, NULL, NULL, NULL, 'Кабир РН 79788931516', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1484, 1, NULL, NULL, NULL, NULL, NULL, 'Кабулов А.М. ', NULL, NULL, '7978 828 78 22', 0, NULL);
INSERT INTO public.contractors VALUES (1485, 0, NULL, NULL, NULL, NULL, 616301001, '"Кавказпромавтоматика"" _Олег ', NULL, NULL, '7 978 752 17 99_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (1486, 1, NULL, NULL, NULL, NULL, NULL, 'Кавкьянов А.А. ', NULL, NULL, '7 913 878 08 88', 0, NULL);
INSERT INTO public.contractors VALUES (1487, 0, NULL, NULL, NULL, NULL, NULL, 'Кавсантехмонтаж ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1488, 1, NULL, NULL, NULL, NULL, NULL, 'Кадеев В.В. ', NULL, NULL, '7 978 751 48 69', 0, NULL);
INSERT INTO public.contractors VALUES (1489, 1, NULL, NULL, NULL, NULL, NULL, 'Кадейкин В.В. ', NULL, NULL, '7978 78 38 193', 0, NULL);
INSERT INTO public.contractors VALUES (1490, 0, NULL, NULL, NULL, NULL, NULL, 'Кадинский Михаил Андреевич ', NULL, NULL, '79788412518', 0, NULL);
INSERT INTO public.contractors VALUES (1491, 0, NULL, NULL, NULL, NULL, NULL, 'Кадирзаде Ш.М. ', NULL, NULL, '7978 86 81 635', 0, NULL);
INSERT INTO public.contractors VALUES (1492, 1, NULL, NULL, NULL, NULL, NULL, 'Кадочников СИ 79780374469', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1493, 1, NULL, NULL, NULL, NULL, NULL, 'Кадыев Т.П 7978-755-90-67', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1494, 0, NULL, NULL, NULL, NULL, NULL, 'Кадыров Ират ', NULL, NULL, '7 978 801 86 60', 0, NULL);
INSERT INTO public.contractors VALUES (1495, 0, NULL, NULL, NULL, NULL, NULL, 'Кадыров Р.Н. ', NULL, NULL, '7 978 809 68 23', 0, NULL);
INSERT INTO public.contractors VALUES (1496, 1, NULL, NULL, NULL, NULL, NULL, 'Кадыров Э.А. ', NULL, NULL, '7 978 791 43 50', 0, NULL);
INSERT INTO public.contractors VALUES (1497, 1, NULL, NULL, NULL, NULL, NULL, 'Кадыров Э.С. ', NULL, NULL, '7 978 79 81 207', 0, NULL);
INSERT INTO public.contractors VALUES (1498, 0, NULL, NULL, NULL, NULL, NULL, 'Кадыров Я.Ю. 8-978-824-41-56', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1499, 1, NULL, NULL, NULL, NULL, NULL, 'Казаев А.А. ', NULL, NULL, '7 978 834 77 94', 0, NULL);
INSERT INTO public.contractors VALUES (1500, 0, NULL, NULL, NULL, NULL, NULL, 'Казак  (Джанкой) ', NULL, NULL, '7978 822 91 99 -А. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1501, 0, NULL, NULL, NULL, NULL, NULL, 'Казак В.А. ', NULL, NULL, '7 978 108 04 74', 0, NULL);
INSERT INTO public.contractors VALUES (1502, 1, NULL, NULL, NULL, NULL, NULL, 'Казаков А.В. ', NULL, NULL, '7978 815 22 91', 0, NULL);
INSERT INTO public.contractors VALUES (1503, 1, NULL, NULL, NULL, NULL, NULL, 'Казаков Д.А., ', NULL, NULL, '7 978 722 76 03', 0, NULL);
INSERT INTO public.contractors VALUES (1504, 2, NULL, NULL, NULL, NULL, NULL, 'Казанцев В.В ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1505, 1, NULL, NULL, NULL, NULL, NULL, 'Казбеков А.А. ', NULL, NULL, '7978 711 75 48', 0, NULL);
INSERT INTO public.contractors VALUES (1506, 0, NULL, NULL, NULL, NULL, NULL, 'Казунка В.Г. ', NULL, NULL, '79788782507', 0, NULL);
INSERT INTO public.contractors VALUES (1507, 1, NULL, NULL, NULL, NULL, NULL, 'Казьмин Николай ', NULL, NULL, '7 978 890 76 44', 0, NULL);
INSERT INTO public.contractors VALUES (1508, 1, NULL, NULL, NULL, NULL, NULL, 'Каиров А.С. ', NULL, NULL, '7978 78 453 86', 0, NULL);
INSERT INTO public.contractors VALUES (1509, 0, NULL, NULL, NULL, NULL, NULL, 'Калафатов Сервер (Снабинвестпром) (д.п.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1510, 0, NULL, NULL, NULL, NULL, NULL, 'Калашников Н.М.', NULL, NULL, '79782264827', 0, NULL);
INSERT INTO public.contractors VALUES (1511, 0, NULL, NULL, NULL, NULL, NULL, 'Калёшник Э.В. ', NULL, NULL, '7 978 858 83 93', 0, NULL);
INSERT INTO public.contractors VALUES (1512, 1, NULL, NULL, NULL, NULL, NULL, 'Калинин А.В. ', NULL, NULL, '79780824387', 0, NULL);
INSERT INTO public.contractors VALUES (1513, 0, NULL, NULL, NULL, NULL, NULL, 'Калинин Вадим Владимирович ', NULL, NULL, '79787567643', 0, NULL);
INSERT INTO public.contractors VALUES (1514, 1, NULL, NULL, NULL, NULL, NULL, 'Калинина Н.И. ', NULL, NULL, '7978 8 705 700', 0, NULL);
INSERT INTO public.contractors VALUES (1515, 1, NULL, NULL, NULL, NULL, NULL, 'Калиниченко А.П. ', NULL, NULL, '7 978 767 87 88', 0, NULL);
INSERT INTO public.contractors VALUES (1516, 1, NULL, NULL, NULL, NULL, NULL, 'Калинкин А.А. ', NULL, NULL, '7 978 021 43 40', 0, NULL);
INSERT INTO public.contractors VALUES (1517, 1, NULL, NULL, NULL, NULL, NULL, 'Калугин ДП 79787990210', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1518, 1, NULL, NULL, NULL, NULL, NULL, 'Калыч АВ 79788511806', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1519, 1, NULL, NULL, NULL, NULL, NULL, 'Кальмук Т 79780786991', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1520, 1, NULL, NULL, NULL, NULL, NULL, 'Калягин М.В. ', NULL, NULL, '79787366138', 0, NULL);
INSERT INTO public.contractors VALUES (1521, 0, NULL, NULL, NULL, NULL, 231501001, '"КАМ КЕРАМИКА""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1522, 0, NULL, NULL, NULL, NULL, NULL, 'Камп-полимер ', NULL, NULL, '79780783020 Максим-А.', 0, NULL);
INSERT INTO public.contractors VALUES (1523, 1, NULL, NULL, NULL, NULL, NULL, 'Канар 79787287169', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1524, 1, NULL, NULL, NULL, NULL, NULL, 'Канатаев М.С. ', NULL, NULL, '7 978 861 12 80', 0, NULL);
INSERT INTO public.contractors VALUES (1525, 1, NULL, NULL, NULL, NULL, NULL, 'Канашкин Д.Э. ', NULL, NULL, '7 978 87 39 110', 0, NULL);
INSERT INTO public.contractors VALUES (1526, 0, NULL, NULL, NULL, NULL, NULL, 'Кандымов Эмир Юнусович ', NULL, NULL, '7 978 781 64 99', 0, NULL);
INSERT INTO public.contractors VALUES (1527, 0, NULL, NULL, NULL, NULL, NULL, 'Каневский В.В. ', NULL, NULL, '79787426848', 0, NULL);
INSERT INTO public.contractors VALUES (1528, 1, NULL, NULL, NULL, NULL, NULL, 'Канин И.В. ', NULL, NULL, '7 978 772 65 76', 0, NULL);
INSERT INTO public.contractors VALUES (1529, 0, NULL, NULL, NULL, NULL, NULL, 'Капитал Тревел Эдуард ', NULL, NULL, '7978 784-38-17 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (1530, 0, NULL, NULL, NULL, NULL, NULL, 'Капора', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1531, 0, NULL, NULL, NULL, NULL, NULL, 'КапРемСтрой ', NULL, NULL, '7978 258 01 58 Тристан', 0, NULL);
INSERT INTO public.contractors VALUES (1532, 0, NULL, NULL, NULL, NULL, NULL, 'Карабакиев Энвер ', NULL, NULL, '79787349010', 0, NULL);
INSERT INTO public.contractors VALUES (1533, 1, NULL, NULL, NULL, NULL, NULL, 'Карабут Л.В. ', NULL, NULL, '7 978 762 76 37', 0, NULL);
INSERT INTO public.contractors VALUES (1534, 1, NULL, NULL, NULL, NULL, NULL, 'Каракаш Алим Таирович ', NULL, NULL, '7978 272 33 32 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1535, 1, NULL, NULL, NULL, NULL, NULL, 'Каракаш Э.А. ', NULL, NULL, '7978 75 20 974', 0, NULL);
INSERT INTO public.contractors VALUES (1536, 1, NULL, NULL, NULL, NULL, NULL, 'Каралиев С.В, ', NULL, NULL, '7 978 8 948 174', 0, NULL);
INSERT INTO public.contractors VALUES (1537, 1, NULL, NULL, NULL, NULL, NULL, 'Караманов Э.О. ', NULL, NULL, '7978 722 54 61', 0, NULL);
INSERT INTO public.contractors VALUES (1538, 0, NULL, NULL, NULL, NULL, NULL, 'Карат  Александр (Техникс) - ', NULL, NULL, '7 978 846 24 39 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1539, 1, NULL, NULL, NULL, NULL, NULL, 'Каратеева ЗВ 79788532249', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1540, 0, NULL, NULL, NULL, NULL, NULL, 'Караушу ', NULL, NULL, '79789385236', 0, NULL);
INSERT INTO public.contractors VALUES (1541, 1, NULL, NULL, NULL, NULL, NULL, 'Карачинцев ДО 79787133501', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1542, 1, NULL, NULL, NULL, NULL, NULL, 'Карбовский В.Г. ', NULL, NULL, '7 978 039 47 21', 0, NULL);
INSERT INTO public.contractors VALUES (1543, 0, NULL, NULL, NULL, NULL, NULL, 'Карбовский Валентин ', NULL, NULL, '7 978 039 47 21', 0, NULL);
INSERT INTO public.contractors VALUES (1544, 0, NULL, NULL, NULL, NULL, 920101001, 'Карбон Строй ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1545, 1, NULL, NULL, NULL, NULL, NULL, 'Каргин И.В. ', NULL, NULL, '7 978 881 39 77', 0, NULL);
INSERT INTO public.contractors VALUES (1546, 0, NULL, NULL, NULL, NULL, NULL, 'Кардаков Виктор Питрович 8-978-8-333-102', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1547, 1, NULL, NULL, NULL, NULL, NULL, 'Карелина ЛА 79780046764', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1548, 0, NULL, NULL, NULL, NULL, NULL, 'Каримов Алексей Адипович ', NULL, NULL, '7 978 74 77 204', 0, NULL);
INSERT INTO public.contractors VALUES (1549, 1, NULL, NULL, NULL, NULL, NULL, 'Карицкий Игорь ', NULL, NULL, '7978 141 79 49', 0, NULL);
INSERT INTO public.contractors VALUES (1550, 0, NULL, NULL, NULL, NULL, NULL, 'Каричковская Н.В. ', NULL, NULL, '7 978 880 70 05', 0, NULL);
INSERT INTO public.contractors VALUES (1551, 1, NULL, NULL, NULL, NULL, NULL, 'Каричковский Д.В. ', NULL, NULL, '7978 74 66 998', 0, NULL);
INSERT INTO public.contractors VALUES (1552, 2, NULL, NULL, NULL, NULL, NULL, 'Кармазин Руслан (Евпатория) д.п. -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1553, 0, NULL, NULL, NULL, NULL, NULL, 'Карнаухов В.О. ', NULL, NULL, '7 978 748 45 05', 0, NULL);
INSERT INTO public.contractors VALUES (1554, 1, NULL, NULL, NULL, NULL, NULL, 'Карнаушенко АА 79780936087', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1555, 0, NULL, NULL, NULL, NULL, NULL, 'Карпенко А.И. ', NULL, NULL, '79787724042', 0, NULL);
INSERT INTO public.contractors VALUES (1556, 0, NULL, NULL, NULL, NULL, NULL, 'Карпенко Александр ', NULL, NULL, '79787455716', 0, NULL);
INSERT INTO public.contractors VALUES (1557, 1, NULL, NULL, NULL, NULL, NULL, 'Карпенко В.Ю. ', NULL, NULL, '7 978 82 18 714', 0, NULL);
INSERT INTO public.contractors VALUES (1558, 2, NULL, NULL, NULL, NULL, NULL, 'Карпенко Дмитрий Юрьевич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1559, 2, NULL, NULL, NULL, NULL, NULL, 'Карпенко Дмитрий Юрьевич, ( Андрей ', NULL, NULL, '7 978 022 77 66) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1560, 1, NULL, NULL, NULL, NULL, NULL, 'Карпенко ЛН 79787067291', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1561, 1, NULL, NULL, NULL, NULL, NULL, 'Карпенко С.В. ', NULL, NULL, '7978 791 96 22', 0, NULL);
INSERT INTO public.contractors VALUES (1562, 0, NULL, NULL, NULL, NULL, NULL, 'Карпенко Сергей Шинный центр Goodyear ', NULL, NULL, ' 7978 791 96 22', 0, NULL);
INSERT INTO public.contractors VALUES (1563, 1, NULL, NULL, NULL, NULL, NULL, 'Карпеченков Алексей Викторович ', NULL, NULL, '79150379498', 0, NULL);
INSERT INTO public.contractors VALUES (1564, 0, NULL, NULL, NULL, NULL, NULL, 'Карпинский Антон Викторович (д) ', NULL, NULL, '79788581647', 0, NULL);
INSERT INTO public.contractors VALUES (1565, 0, NULL, NULL, NULL, NULL, NULL, 'Карпов С.С. ', NULL, NULL, '7 978 756 01 23', 0, NULL);
INSERT INTO public.contractors VALUES (1566, 1, NULL, NULL, NULL, NULL, NULL, 'Карпусь С.С. ', NULL, NULL, '7 978 75 68 944', 0, NULL);
INSERT INTO public.contractors VALUES (1567, 0, NULL, NULL, NULL, NULL, NULL, 'Карсаков Д.В ', NULL, NULL, '79787552536', 0, NULL);
INSERT INTO public.contractors VALUES (1568, 0, NULL, NULL, NULL, NULL, NULL, 'Карсаков Д.В. ', NULL, NULL, '79787552536', 0, NULL);
INSERT INTO public.contractors VALUES (1569, 1, NULL, NULL, NULL, NULL, NULL, 'Каршин И.Б. ', NULL, NULL, '79787284260', 0, NULL);
INSERT INTO public.contractors VALUES (1570, 0, NULL, NULL, NULL, NULL, NULL, 'Карьер Мраморный ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1571, 1, NULL, NULL, NULL, NULL, NULL, 'Касаткин О.Ю. ', NULL, NULL, '7 978 121 73 19', 0, NULL);
INSERT INTO public.contractors VALUES (1572, 1, NULL, NULL, NULL, NULL, NULL, 'Каськов В.С. ', NULL, NULL, '7 978 837 86 86', 0, NULL);
INSERT INTO public.contractors VALUES (1573, 1, NULL, NULL, NULL, NULL, NULL, 'Касьянов Е.А. ', NULL, NULL, '79787286367', 0, NULL);
INSERT INTO public.contractors VALUES (1574, 1, NULL, NULL, NULL, NULL, NULL, 'Касьянов Женя ', NULL, NULL, '7978 032 31 51', 0, NULL);
INSERT INTO public.contractors VALUES (1575, 1, NULL, NULL, NULL, NULL, NULL, 'Касьянова ТВ 797871777454', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1576, 2, NULL, NULL, NULL, NULL, NULL, 'Катаев  ', NULL, NULL, '7 978 839 48 01 (д.п.) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1577, 2, NULL, NULL, NULL, NULL, NULL, 'Катаев ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1578, 1, NULL, NULL, NULL, NULL, NULL, 'Катаки ЕВ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1579, 1, NULL, NULL, NULL, NULL, NULL, 'Катаров А.И. ', NULL, NULL, '7 978 84 86 838', 0, NULL);
INSERT INTO public.contractors VALUES (1580, 0, NULL, NULL, NULL, NULL, NULL, 'Кателевский А.Н. ', NULL, NULL, '7 978 119 75 01', 0, NULL);
INSERT INTO public.contractors VALUES (1581, 1, NULL, NULL, NULL, NULL, NULL, 'Катилевский Н.Н ', NULL, NULL, '7978 119 75 01', 0, NULL);
INSERT INTO public.contractors VALUES (1582, 1, NULL, NULL, NULL, NULL, NULL, 'Катков А.С. ', NULL, NULL, '7978 786 36 21', 0, NULL);
INSERT INTO public.contractors VALUES (1583, 1, NULL, NULL, NULL, NULL, NULL, 'Кауфман Владимир ', NULL, NULL, '7 978 828 43 64', 0, NULL);
INSERT INTO public.contractors VALUES (1584, 1, NULL, NULL, NULL, NULL, NULL, 'Качковский А.С. ', NULL, NULL, '79787100250', 0, NULL);
INSERT INTO public.contractors VALUES (1585, 0, NULL, NULL, NULL, NULL, NULL, 'Кашин Игорь ', NULL, NULL, '7 978 72 38 566', 0, NULL);
INSERT INTO public.contractors VALUES (1586, 0, NULL, NULL, NULL, NULL, NULL, 'Каштан Интэрьер 79787402292 Анатолий ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1587, 0, NULL, NULL, NULL, NULL, NULL, 'Кашфединов Сабри ', NULL, NULL, '7 978 839 16 50', 0, NULL);
INSERT INTO public.contractors VALUES (1588, 0, NULL, NULL, NULL, NULL, NULL, 'Кашфединов Сарби 79788391650', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1589, 1, NULL, NULL, NULL, NULL, NULL, 'Квакин С.П. ', NULL, NULL, '7 978 75 60 511', 0, NULL);
INSERT INTO public.contractors VALUES (1590, 0, NULL, NULL, NULL, NULL, NULL, 'Квинтесс  д.п. ', NULL, NULL, '7978 141 -77-86-А. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1591, 1, NULL, NULL, NULL, NULL, NULL, 'Квитко А.И. ', NULL, NULL, '79787298943', 0, NULL);
INSERT INTO public.contractors VALUES (1592, 1, NULL, NULL, NULL, NULL, NULL, 'Квитко АВ 79787369130', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1593, 1, NULL, NULL, NULL, NULL, NULL, 'Кегелик Д.Ю. ', NULL, NULL, '7 978 75 36 080', 0, NULL);
INSERT INTO public.contractors VALUES (1594, 1, NULL, NULL, NULL, NULL, NULL, 'Кельдалиев Роллан (Евпатория)-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1595, 1, NULL, NULL, NULL, NULL, NULL, 'Кеньже ВА 79788559956', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1596, 1, NULL, NULL, NULL, NULL, NULL, 'Керяев П.П. ', NULL, NULL, '7 978 725 00 23', 0, NULL);
INSERT INTO public.contractors VALUES (1597, 0, NULL, NULL, NULL, NULL, NULL, 'КЖД 79788439446 ФГУП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1598, 0, NULL, NULL, NULL, NULL, NULL, 'Кизиев Е.А. ', NULL, NULL, ' 7 978 793 02 77', 0, NULL);
INSERT INTO public.contractors VALUES (1599, 1, NULL, NULL, NULL, NULL, NULL, 'Кика ВМ 79788199439', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1600, 2, NULL, NULL, NULL, NULL, NULL, 'Кильпиков Сергей Викторович, ', NULL, NULL, '7 9788886068 _Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1601, 1, NULL, NULL, NULL, NULL, NULL, 'Ким ', NULL, NULL, '79787834441', 0, NULL);
INSERT INTO public.contractors VALUES (1602, 0, NULL, NULL, NULL, NULL, NULL, 'Ким И.С. ', NULL, NULL, '7 978 75 82 013', 0, NULL);
INSERT INTO public.contractors VALUES (1603, 1, NULL, NULL, NULL, NULL, NULL, 'Ким Н.Н. ', NULL, NULL, '7 978 77 31 292', 0, NULL);
INSERT INTO public.contractors VALUES (1604, 1, NULL, NULL, NULL, NULL, NULL, 'Ким НА 79780319129', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1605, 1, NULL, NULL, NULL, NULL, NULL, 'Киналь А.Н, ', NULL, NULL, '7978 763 39 21', 0, NULL);
INSERT INTO public.contractors VALUES (1606, 1, NULL, NULL, NULL, NULL, NULL, 'Кинаш Александр ', NULL, NULL, '79787550458', 0, NULL);
INSERT INTO public.contractors VALUES (1607, 2, NULL, NULL, NULL, NULL, NULL, 'Кинторяк Сергей ', NULL, NULL, '7 978 839 60 99', 0, NULL);
INSERT INTO public.contractors VALUES (1608, 1, NULL, NULL, NULL, NULL, NULL, 'Кипрачев ПН ', NULL, NULL, '79787080891', 0, NULL);
INSERT INTO public.contractors VALUES (1609, 1, NULL, NULL, NULL, NULL, NULL, 'Киприянов АЮ 79787187633', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1610, 1, NULL, NULL, NULL, NULL, NULL, 'Киренкин ', NULL, NULL, '7 978 87 28 440', 0, NULL);
INSERT INTO public.contractors VALUES (1611, 1, NULL, NULL, NULL, NULL, NULL, 'Киридон Д.В. ', NULL, NULL, '7978049 55 05', 0, NULL);
INSERT INTO public.contractors VALUES (1612, 0, NULL, NULL, NULL, NULL, NULL, 'Кириенко А.Р. ', NULL, NULL, '7 978 065 89 95', 0, NULL);
INSERT INTO public.contractors VALUES (1613, 1, NULL, NULL, NULL, NULL, NULL, 'Кирилин АН 79781482458', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1614, 1, NULL, NULL, NULL, NULL, NULL, 'Кириллин АА 79787115153', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1615, 1, NULL, NULL, NULL, NULL, NULL, 'Кириллов В.А. ', NULL, NULL, '7 978 72 09 934', 0, NULL);
INSERT INTO public.contractors VALUES (1616, 1, NULL, NULL, NULL, NULL, NULL, 'Кирилов Андрей Викторович ', NULL, NULL, '7978 790 89 28', 0, NULL);
INSERT INTO public.contractors VALUES (1617, 0, NULL, NULL, NULL, NULL, NULL, 'Киричен', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1618, 0, NULL, NULL, NULL, NULL, NULL, 'Кириченко А.А. ', NULL, NULL, '79788237030', 0, NULL);
INSERT INTO public.contractors VALUES (1619, 1, NULL, NULL, NULL, NULL, NULL, 'Кириченко Ю.П. ', NULL, NULL, '7 978 76 75 709', 0, NULL);
INSERT INTO public.contractors VALUES (1620, 1, NULL, NULL, NULL, NULL, NULL, 'Киркиж М 79787273973', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1621, 0, NULL, NULL, NULL, NULL, NULL, 'Киронд С.И. ', NULL, NULL, '7978 767 05 49', 0, NULL);
INSERT INTO public.contractors VALUES (1622, 0, NULL, NULL, NULL, NULL, NULL, 'Кирух Александр ', NULL, NULL, '7 978 739 47 55', 0, NULL);
INSERT INTO public.contractors VALUES (1623, 1, NULL, NULL, NULL, NULL, NULL, 'Кирух В.Н. ', NULL, NULL, '7978 075 82 91', 0, NULL);
INSERT INTO public.contractors VALUES (1624, 1, NULL, NULL, NULL, NULL, NULL, 'Кирьякулов 79787521205', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1625, 0, NULL, NULL, NULL, NULL, NULL, 'Киселев А.И. ', NULL, NULL, '7 978 87 86 626', 0, NULL);
INSERT INTO public.contractors VALUES (1626, 1, NULL, NULL, NULL, NULL, NULL, 'Киселев Валерий', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1627, 1, NULL, NULL, NULL, NULL, NULL, 'Киселев Н.Н', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1628, 0, NULL, NULL, NULL, NULL, NULL, 'Киселев С.В. ', NULL, NULL, '7978 751 91 47', 0, NULL);
INSERT INTO public.contractors VALUES (1629, 1, NULL, NULL, NULL, NULL, NULL, 'Кисельников В.И. ', NULL, NULL, '7 978 759 23 92', 0, NULL);
INSERT INTO public.contractors VALUES (1630, 1, NULL, NULL, NULL, NULL, NULL, 'Кисира Г.А. ', NULL, NULL, '7978 718 08 11', 0, NULL);
INSERT INTO public.contractors VALUES (1631, 0, NULL, NULL, NULL, NULL, NULL, 'Кисличенко Владимир ', NULL, NULL, '7 978 85 77 344', 0, NULL);
INSERT INTO public.contractors VALUES (1632, 0, NULL, NULL, NULL, NULL, NULL, 'Кисс Сергей Павлович ', NULL, NULL, '79787989149', 0, NULL);
INSERT INTO public.contractors VALUES (1633, 1, NULL, NULL, NULL, NULL, NULL, 'Китаева Л.Л. ', NULL, NULL, '7978 869 88 32', 0, NULL);
INSERT INTO public.contractors VALUES (1634, 0, NULL, NULL, NULL, NULL, NULL, 'Киян Сергей ', NULL, NULL, '79788430039', 0, NULL);
INSERT INTO public.contractors VALUES (1635, 1, NULL, NULL, NULL, NULL, NULL, 'Кияненко А.А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1636, 0, NULL, NULL, NULL, NULL, NULL, 'Клачков С,В. ', NULL, NULL, '7 978 821 6606', 0, NULL);
INSERT INTO public.contractors VALUES (1637, 0, NULL, NULL, NULL, NULL, NULL, 'Клевцевич Д.В. ', NULL, NULL, '7978 8129917 (Севастополь)', 0, NULL);
INSERT INTO public.contractors VALUES (1638, 1, NULL, NULL, NULL, NULL, NULL, 'Клевцов А.С 7978-737-97-15', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1639, 1, NULL, NULL, NULL, NULL, NULL, 'Клевцов В.В. ', NULL, NULL, '79782151066', 0, NULL);
INSERT INTO public.contractors VALUES (1640, 1, NULL, NULL, NULL, NULL, NULL, 'Клевцов С.И. ', NULL, NULL, '79787678753', 0, NULL);
INSERT INTO public.contractors VALUES (1641, 1, NULL, NULL, NULL, NULL, NULL, 'Клевцова ТГ 79780469609', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1642, 1, NULL, NULL, NULL, NULL, NULL, 'Клейменов Л.И. ', NULL, NULL, '7 978 82 83 093', 0, NULL);
INSERT INTO public.contractors VALUES (1643, 0, NULL, NULL, NULL, NULL, NULL, 'Клепов Александр ', NULL, NULL, '79787809484', 0, NULL);
INSERT INTO public.contractors VALUES (1644, 1, NULL, NULL, NULL, NULL, NULL, 'Клепча АП 79788629807', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1645, 1, NULL, NULL, NULL, NULL, NULL, 'Клец А.П. ', NULL, NULL, '7 978 800 95 61', 0, NULL);
INSERT INTO public.contractors VALUES (1646, 1, NULL, NULL, NULL, NULL, NULL, 'Клешнев Р.С. ', NULL, NULL, '7 978 19 44 03', 0, NULL);
INSERT INTO public.contractors VALUES (1647, 1, NULL, NULL, NULL, NULL, NULL, 'Клещев ОЕ 79787139570', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1648, 0, NULL, NULL, NULL, NULL, NULL, 'Клименко А.И. ', NULL, NULL, '7978 862 20 84', 0, NULL);
INSERT INTO public.contractors VALUES (1649, 1, NULL, NULL, NULL, NULL, NULL, 'Клименко Д.В. ', NULL, NULL, '7 978 724 52 50', 0, NULL);
INSERT INTO public.contractors VALUES (1650, 0, NULL, NULL, NULL, NULL, NULL, 'Клименко Д.О. ', NULL, NULL, '79787630366', 0, NULL);
INSERT INTO public.contractors VALUES (1651, 0, NULL, NULL, NULL, NULL, NULL, 'Клименко ИП ', NULL, NULL, '79787414650', 0, NULL);
INSERT INTO public.contractors VALUES (1652, 1, NULL, NULL, NULL, NULL, NULL, 'Клименко ПВ 79787299413', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1653, 1, NULL, NULL, NULL, NULL, NULL, 'Клименко С.П. ', NULL, NULL, '7 978 70 84 282', 0, NULL);
INSERT INTO public.contractors VALUES (1654, 1, NULL, NULL, NULL, NULL, NULL, 'Климов СВ 89682706060', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1655, 1, NULL, NULL, NULL, NULL, NULL, 'Климошенко Л.А. ', NULL, NULL, '7912 435 67 40', 0, NULL);
INSERT INTO public.contractors VALUES (1656, 1, NULL, NULL, NULL, NULL, NULL, 'Климпарский КС 79788242814', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1657, 0, NULL, NULL, NULL, NULL, NULL, 'Клининг Сервис Крым', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1658, 0, NULL, NULL, NULL, NULL, NULL, 'Кличаный А.О', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1659, 0, NULL, NULL, NULL, NULL, NULL, 'Клищенко Анатолий ', NULL, NULL, '79788106670', 0, NULL);
INSERT INTO public.contractors VALUES (1660, 1, NULL, NULL, NULL, NULL, NULL, 'Клышко Р.А. ', NULL, NULL, '7978 73 8 0036', 0, NULL);
INSERT INTO public.contractors VALUES (1661, 0, NULL, NULL, NULL, NULL, 910201001, 'КМ И К° АО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1662, 0, NULL, NULL, NULL, NULL, 910201001, '"КМК"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1663, 1, NULL, NULL, NULL, NULL, NULL, 'Князев А.В. ', NULL, NULL, '7 978 7931 556', 0, NULL);
INSERT INTO public.contractors VALUES (1664, 1, NULL, NULL, NULL, NULL, NULL, 'Князев Александр Сергеевич ', NULL, NULL, '79787184494', 0, NULL);
INSERT INTO public.contractors VALUES (1665, 0, NULL, NULL, NULL, NULL, NULL, 'Князев Петр ', NULL, NULL, '7978 790 42 84', 0, NULL);
INSERT INTO public.contractors VALUES (1666, 1, NULL, NULL, NULL, NULL, NULL, 'Кобзаренко Н.И. ', NULL, NULL, '7978 841 64 75', 0, NULL);
INSERT INTO public.contractors VALUES (1667, 1, NULL, NULL, NULL, NULL, NULL, 'Кобин С.В. ', NULL, NULL, '7 978 75 13 552', 0, NULL);
INSERT INTO public.contractors VALUES (1668, 1, NULL, NULL, NULL, NULL, NULL, 'Коблашев И.Н. ', NULL, NULL, '79780532712', 0, NULL);
INSERT INTO public.contractors VALUES (1669, 1, NULL, NULL, NULL, NULL, NULL, 'Коблов ВЕ 79780665800', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1670, 1, NULL, NULL, NULL, NULL, NULL, 'Коблов ВЕ 79780665800', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1671, 0, NULL, NULL, NULL, NULL, NULL, 'Кобылянский Александр ', NULL, NULL, '79787510557', 0, NULL);
INSERT INTO public.contractors VALUES (1672, 1, NULL, NULL, NULL, NULL, NULL, 'Ковалев А.В. ', NULL, NULL, '7 978 79 02 500', 0, NULL);
INSERT INTO public.contractors VALUES (1673, 1, NULL, NULL, NULL, NULL, NULL, 'Ковалев А.С. ', NULL, NULL, '7 978 978 66 81', 0, NULL);
INSERT INTO public.contractors VALUES (1674, 0, NULL, NULL, NULL, NULL, NULL, 'Ковалев Роман', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1675, 1, NULL, NULL, NULL, NULL, NULL, 'Ковалева Т.В. ', NULL, NULL, '79787225906', 0, NULL);
INSERT INTO public.contractors VALUES (1676, 1, NULL, NULL, NULL, NULL, NULL, 'Коваленко АА 79787643182 79780412202', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1677, 1, NULL, NULL, NULL, NULL, NULL, 'Коваленко В.А. ', NULL, NULL, '7978 79 222 30', 0, NULL);
INSERT INTO public.contractors VALUES (1678, 1, NULL, NULL, NULL, NULL, NULL, 'Коваленко В.В. ', NULL, NULL, '7 978 877 29 01', 0, NULL);
INSERT INTO public.contractors VALUES (1679, 1, NULL, NULL, NULL, NULL, NULL, 'Коваленко Е.В. ', NULL, NULL, '79788839683', 0, NULL);
INSERT INTO public.contractors VALUES (1680, 1, NULL, NULL, NULL, NULL, NULL, 'Коваленко ИН ', NULL, NULL, '79787566503', 0, NULL);
INSERT INTO public.contractors VALUES (1681, 0, NULL, NULL, NULL, NULL, NULL, 'Коваленко М.С. ', NULL, NULL, '7978 735 44 17', 0, NULL);
INSERT INTO public.contractors VALUES (1682, 2, NULL, NULL, NULL, NULL, NULL, 'Коваленко С.В. ', NULL, NULL, '7 978 807 14 29 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1683, 0, NULL, NULL, NULL, NULL, NULL, 'Коваленко С.Г ', NULL, NULL, '79788568962', 0, NULL);
INSERT INTO public.contractors VALUES (1684, 2, NULL, NULL, NULL, NULL, NULL, 'Коваленко Сергей Владимирович- А.', NULL, 135584884, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1685, 1, NULL, NULL, NULL, NULL, NULL, 'Ковальчук В.В. ', NULL, NULL, '7 978 846 90 72', 0, NULL);
INSERT INTO public.contractors VALUES (1686, 1, NULL, NULL, NULL, NULL, NULL, 'Ковтун А.А. ', NULL, NULL, '7909 617 62 08', 0, NULL);
INSERT INTO public.contractors VALUES (1687, 0, NULL, NULL, NULL, NULL, NULL, 'Ковтун С.В ', NULL, NULL, '79787558920', 0, NULL);
INSERT INTO public.contractors VALUES (1688, 1, NULL, NULL, NULL, NULL, NULL, 'Ковтун Т.В. ', NULL, NULL, '7 978 773 90 70', 0, NULL);
INSERT INTO public.contractors VALUES (1689, 1, NULL, NULL, NULL, NULL, NULL, 'Ковязин ВВ 79787473701', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1690, 1, NULL, NULL, NULL, NULL, NULL, 'Коган ВВ 79780686833', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1691, 1, NULL, NULL, NULL, NULL, NULL, 'Кожекару ВМ 79788100402', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1692, 1, NULL, NULL, NULL, NULL, NULL, 'Кожухаров РМ 79781432564', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1693, 1, NULL, NULL, NULL, NULL, NULL, 'Кожухов О.В. ', NULL, NULL, '7 978 817 69 58', 0, NULL);
INSERT INTO public.contractors VALUES (1694, 1, NULL, NULL, NULL, NULL, NULL, 'Козак Владимир ', NULL, NULL, '7 978 108 04 74', 0, NULL);
INSERT INTO public.contractors VALUES (1695, 1, NULL, NULL, NULL, NULL, NULL, 'Козак Н.А. ', NULL, NULL, '7 978 204 9812', 0, NULL);
INSERT INTO public.contractors VALUES (1696, 1, NULL, NULL, NULL, NULL, NULL, 'Козачук ДА ', NULL, NULL, '79787674486', 0, NULL);
INSERT INTO public.contractors VALUES (1697, 1, NULL, NULL, NULL, NULL, NULL, 'Козел АИ 79091675575  9789859129 боря', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1698, 1, NULL, NULL, NULL, NULL, NULL, 'Козин Максим ', NULL, NULL, '79780464228 79780270056', 0, NULL);
INSERT INTO public.contractors VALUES (1699, 2, NULL, NULL, NULL, NULL, NULL, 'Козин Олег (Севастополь) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1700, 1, NULL, NULL, NULL, NULL, NULL, 'Козлов АВ 79787253703', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1701, 1, NULL, NULL, NULL, NULL, NULL, 'Козлов В.А. ', NULL, NULL, '7 978 815 74 39', 0, NULL);
INSERT INTO public.contractors VALUES (1702, 0, NULL, NULL, NULL, NULL, NULL, 'Козлов В.Н. ', NULL, NULL, '7 978 85 91 874', 0, NULL);
INSERT INTO public.contractors VALUES (1703, 0, NULL, NULL, NULL, NULL, NULL, 'Козловский Григорий Юрьевич ', NULL, NULL, '79781425719', 0, NULL);
INSERT INTO public.contractors VALUES (1704, 0, NULL, NULL, NULL, NULL, NULL, 'Козыревский М.А. ', NULL, NULL, '7978 838 0777', 0, NULL);
INSERT INTO public.contractors VALUES (1705, 1, NULL, NULL, NULL, NULL, NULL, 'Кокарев В.В. ', NULL, NULL, '7978 848 89 59', 0, NULL);
INSERT INTO public.contractors VALUES (1706, 0, NULL, NULL, NULL, NULL, NULL, 'КОККОЗ НУСРЕТ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1707, 1, NULL, NULL, NULL, NULL, NULL, 'Коккоз ЭИ 79787699637', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1708, 1, NULL, NULL, NULL, NULL, NULL, 'Колесник И А 79788326808', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1709, 0, NULL, NULL, NULL, NULL, NULL, 'Колесников Михаил (И) 8-978-744-47-69', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1710, 0, NULL, NULL, NULL, NULL, NULL, 'Колесников Михаил (Севастополь) - д.п.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1711, 1, NULL, NULL, NULL, NULL, NULL, 'Колесников Роман ', NULL, NULL, '7 978 721 75 68', 0, NULL);
INSERT INTO public.contractors VALUES (1712, 0, NULL, NULL, NULL, NULL, NULL, 'Колесников Сергей ', NULL, NULL, '7 978 215 76 44 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1713, 1, NULL, NULL, NULL, NULL, NULL, 'Колесников Ю.В. ', NULL, NULL, '7 978 857 92 90', 0, NULL);
INSERT INTO public.contractors VALUES (1714, 1, NULL, NULL, NULL, NULL, NULL, 'Колесниченко АВ 9788223714', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1715, 0, NULL, NULL, NULL, NULL, NULL, 'Колесниченко Вера Ивановна ', NULL, NULL, '79788530806', 0, NULL);
INSERT INTO public.contractors VALUES (1716, 1, NULL, NULL, NULL, NULL, NULL, 'Колесова Т.А. ', NULL, NULL, '7978 764 14 50', 0, NULL);
INSERT INTO public.contractors VALUES (1717, 1, NULL, NULL, NULL, NULL, NULL, 'Колобов Н.С. (И) 79781309358', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1718, 1, NULL, NULL, NULL, NULL, NULL, 'Колодяжный ВА 79787402116', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1719, 1, NULL, NULL, NULL, NULL, NULL, 'Коломийцев Александр ', NULL, NULL, '7 978 717 02 97', 0, NULL);
INSERT INTO public.contractors VALUES (1720, 0, NULL, NULL, NULL, NULL, NULL, 'Коломоец Андрей ', NULL, NULL, '79787309633', 0, NULL);
INSERT INTO public.contractors VALUES (1721, 0, NULL, NULL, NULL, NULL, NULL, 'Колосов А.А. ', NULL, NULL, '7 978 916 16 39', 0, NULL);
INSERT INTO public.contractors VALUES (1722, 1, NULL, NULL, NULL, NULL, NULL, 'Колот Н.Н. ', NULL, NULL, '7 978 86 51 510', 0, NULL);
INSERT INTO public.contractors VALUES (1723, 0, NULL, NULL, NULL, NULL, NULL, 'Колпаков Владимир ', NULL, NULL, '7978 731 77 62', 0, NULL);
INSERT INTO public.contractors VALUES (1724, 1, NULL, NULL, NULL, NULL, NULL, 'Кольцов О.Н. ', NULL, NULL, '7978 054 71 99', 0, NULL);
INSERT INTO public.contractors VALUES (1725, 1, NULL, NULL, NULL, NULL, NULL, 'Коля Цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1726, 1, NULL, NULL, NULL, NULL, NULL, 'Комар П.А. ', NULL, NULL, '7978 832 5332', 0, NULL);
INSERT INTO public.contractors VALUES (1727, 1, NULL, NULL, NULL, NULL, NULL, 'Комарницкий Д.А. ', NULL, NULL, '79787404575', 0, NULL);
INSERT INTO public.contractors VALUES (1728, 1, NULL, NULL, NULL, NULL, NULL, 'Комиссаров ГА 79787342425', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1729, 0, NULL, NULL, NULL, NULL, NULL, 'Компаниец Т.В. ', NULL, NULL, '7 978 824 21 41', 0, NULL);
INSERT INTO public.contractors VALUES (1730, 0, NULL, NULL, NULL, NULL, 910701001, 'КОМПАНИЯ ВЕЧНАЯ СТРОЙКА  ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1731, 0, NULL, NULL, NULL, NULL, NULL, 'Компания Гросса (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1732, 0, NULL, NULL, NULL, NULL, NULL, 'Компания Краски  Виктория ', NULL, NULL, '7978 867-29-75 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1733, 0, NULL, NULL, NULL, NULL, NULL, 'Комплексстрой Андрей ', NULL, NULL, '79788106732_д.п._Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1734, 0, NULL, NULL, NULL, NULL, NULL, 'КОМПРОМИСС кп (ИП Прасолов) ', NULL, NULL, '7978 723 60 45 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1735, 1, NULL, NULL, NULL, NULL, NULL, 'Кондратенко ЛН 89168345227', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1736, 2, NULL, NULL, NULL, NULL, NULL, 'Кондратьев Алексей Михайлович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1737, 1, NULL, NULL, NULL, NULL, NULL, 'Кондратьев В.Н. ', NULL, NULL, '7 978 706 00 58', 0, NULL);
INSERT INTO public.contractors VALUES (1738, 0, NULL, NULL, NULL, NULL, NULL, 'Конкурент Александра', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1739, 1, NULL, NULL, NULL, NULL, NULL, 'Коновалов А.Л. ', NULL, NULL, '7 978 74 31 778', 0, NULL);
INSERT INTO public.contractors VALUES (1740, 1, NULL, NULL, NULL, NULL, NULL, 'Коновалов А.Л. ', NULL, NULL, '79787431778', 0, NULL);
INSERT INTO public.contractors VALUES (1741, 0, NULL, NULL, NULL, NULL, NULL, 'Коновалов Е.А. ', NULL, NULL, '7 978 746 23 15', 0, NULL);
INSERT INTO public.contractors VALUES (1742, 1, NULL, NULL, NULL, NULL, NULL, 'Коновченко А.В. ', NULL, NULL, '7978 72 84 84 7', 0, NULL);
INSERT INTO public.contractors VALUES (1743, 1, NULL, NULL, NULL, NULL, NULL, 'Кононенко А', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1744, 1, NULL, NULL, NULL, NULL, NULL, 'Кононенко А.С. ', NULL, NULL, '79787027020', 0, NULL);
INSERT INTO public.contractors VALUES (1745, 1, NULL, NULL, NULL, NULL, NULL, 'Коноплев В.И. ', NULL, NULL, '79781256689', 0, NULL);
INSERT INTO public.contractors VALUES (1746, 1, NULL, NULL, NULL, NULL, NULL, 'Конофицкий С.Б. ', NULL, NULL, '7 978 79 83 749', 0, NULL);
INSERT INTO public.contractors VALUES (1747, 0, NULL, NULL, NULL, NULL, NULL, 'Константин 7978-738-26-49', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1748, 0, NULL, NULL, NULL, NULL, NULL, 'Константин Самойлов ', NULL, NULL, '7 978 893 67 26', 0, NULL);
INSERT INTO public.contractors VALUES (1749, 0, NULL, NULL, NULL, NULL, NULL, 'Константинов ', NULL, NULL, '7 978 722 72 79', 0, NULL);
INSERT INTO public.contractors VALUES (1750, 1, NULL, NULL, NULL, NULL, NULL, 'Констынченко А.Е. ', NULL, NULL, '7 978 714 30 34', 0, NULL);
INSERT INTO public.contractors VALUES (1751, 1, NULL, NULL, NULL, NULL, NULL, 'Конышев В.В. ', NULL, NULL, '79780057735', 0, NULL);
INSERT INTO public.contractors VALUES (1752, 1, NULL, NULL, NULL, NULL, NULL, 'Копалейшвили Д.Т. ', NULL, NULL, '7978 920 84 48', 0, NULL);
INSERT INTO public.contractors VALUES (1753, 0, NULL, NULL, NULL, NULL, NULL, 'Копылов Владимир Иванович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1754, 0, NULL, NULL, NULL, NULL, NULL, 'Копылов Владимир Иванович ', NULL, NULL, '7 978 78 33 819', 0, NULL);
INSERT INTO public.contractors VALUES (1755, 1, NULL, NULL, NULL, NULL, NULL, 'Копылов М.С. ', NULL, NULL, '7 978 8444 793', 0, NULL);
INSERT INTO public.contractors VALUES (1756, 0, NULL, NULL, NULL, NULL, NULL, 'Кораблин Михаил ', NULL, NULL, '79787072167', 0, NULL);
INSERT INTO public.contractors VALUES (1757, 1, NULL, NULL, NULL, NULL, NULL, 'Корженивский А.А. ', NULL, NULL, '7 978 734 05 00', 0, NULL);
INSERT INTO public.contractors VALUES (1758, 1, NULL, NULL, NULL, NULL, NULL, 'Корзин Р.А. ', NULL, NULL, '7 978 717 58 70 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1759, 1, NULL, NULL, NULL, NULL, NULL, 'Корзун В.С. ', NULL, NULL, '7 978 763 45 09', 0, NULL);
INSERT INTO public.contractors VALUES (1760, 1, NULL, NULL, NULL, NULL, NULL, 'Кориков И.Н. ', NULL, NULL, '7978 746 22 53', 0, NULL);
INSERT INTO public.contractors VALUES (1761, 1, NULL, NULL, NULL, NULL, NULL, 'Коринец А.Н. ', NULL, NULL, '7978 828 47 79', 0, NULL);
INSERT INTO public.contractors VALUES (1762, 1, NULL, NULL, NULL, NULL, NULL, 'Корниенко С.В. ', NULL, NULL, '7978 83 29 4 29', 0, NULL);
INSERT INTO public.contractors VALUES (1763, 1, NULL, NULL, NULL, NULL, NULL, 'Корнилов Александр ', NULL, NULL, '7978 73 77 310', 0, NULL);
INSERT INTO public.contractors VALUES (1764, 1, NULL, NULL, NULL, NULL, NULL, 'Корнилов ВВ 79782153623 (к.п.) ', NULL, NULL, '79785221424', 0, NULL);
INSERT INTO public.contractors VALUES (1765, 0, NULL, NULL, NULL, NULL, NULL, 'Корнилов И.В. 7 9780827343', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1766, 1, NULL, NULL, NULL, NULL, NULL, 'Корнилов НС 79788358973 (к.п)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1767, 0, NULL, NULL, NULL, NULL, NULL, 'Коробков Алексей ', NULL, NULL, '7 978 222 64 67', 0, NULL);
INSERT INTO public.contractors VALUES (1768, 1, NULL, NULL, NULL, NULL, NULL, 'Коробков Р.С. ', NULL, NULL, '7 978 751 86 48', 0, NULL);
INSERT INTO public.contractors VALUES (1769, 1, NULL, NULL, NULL, NULL, NULL, 'Коробов С.П. ', NULL, NULL, '7 978 78 95 345', 0, NULL);
INSERT INTO public.contractors VALUES (1770, 1, NULL, NULL, NULL, NULL, NULL, 'Коровко А.Д. ', NULL, NULL, '7 978 841 39 54', 0, NULL);
INSERT INTO public.contractors VALUES (1771, 1, NULL, NULL, NULL, NULL, NULL, 'Королев ВВ 79788785980', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1772, 2, NULL, NULL, NULL, NULL, NULL, 'Король Евгения (Евпатория)- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1773, 0, NULL, NULL, NULL, NULL, NULL, 'Корольков Евгений ', NULL, NULL, '79780816919', 0, NULL);
INSERT INTO public.contractors VALUES (1774, 1, NULL, NULL, NULL, NULL, NULL, 'Коронаев Н.Ю. ', NULL, NULL, '7 978 054 16 67', 0, NULL);
INSERT INTO public.contractors VALUES (1775, 1, NULL, NULL, NULL, NULL, NULL, 'Коротких Д.В. ', NULL, NULL, '7978 839 76 85', 0, NULL);
INSERT INTO public.contractors VALUES (1776, 1, NULL, NULL, NULL, NULL, NULL, 'Коротченко А.А. ', NULL, NULL, '7 978 848 01 19', 0, NULL);
INSERT INTO public.contractors VALUES (1777, 1, NULL, NULL, NULL, NULL, NULL, 'Корректировка', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1778, 1, NULL, NULL, NULL, NULL, NULL, 'Корчмарюк Д.В. ', NULL, NULL, '7 978 74 70 165', 0, NULL);
INSERT INTO public.contractors VALUES (1779, 0, NULL, NULL, NULL, NULL, NULL, 'Косач Сергей Николаевич ', NULL, NULL, '79788174906', 0, NULL);
INSERT INTO public.contractors VALUES (1780, 2, NULL, NULL, NULL, NULL, NULL, 'Косаченко Станислав Эдуардович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1781, 1, NULL, NULL, NULL, NULL, NULL, 'Кособродов Михаил ', NULL, NULL, '7 978 733 78 63', 0, NULL);
INSERT INTO public.contractors VALUES (1782, 1, NULL, NULL, NULL, NULL, NULL, 'Косов Евгений Викторович ', NULL, NULL, '7978 735 30 06', 0, NULL);
INSERT INTO public.contractors VALUES (1783, 1, NULL, NULL, NULL, NULL, NULL, 'Коссе Д.К. ', NULL, NULL, '7978 729 45 68', 0, NULL);
INSERT INTO public.contractors VALUES (1784, 1, NULL, NULL, NULL, NULL, NULL, 'Костенко ОС ', NULL, NULL, '79787686987', 0, NULL);
INSERT INTO public.contractors VALUES (1785, 1, NULL, NULL, NULL, NULL, NULL, 'Костенко С.Н. ', NULL, NULL, '7978 016 10 15', 0, NULL);
INSERT INTO public.contractors VALUES (1786, 1, NULL, NULL, NULL, NULL, NULL, 'Костенко Сергей ', NULL, NULL, '7978 827 67 91', 0, NULL);
INSERT INTO public.contractors VALUES (1787, 1, NULL, NULL, NULL, NULL, NULL, 'Костенко ЮА 79787195532', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1788, 0, NULL, NULL, NULL, NULL, NULL, 'Костинский А.С.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1789, 1, NULL, NULL, NULL, NULL, NULL, 'Костынюк РЕ 79780895892', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1790, 0, NULL, NULL, NULL, NULL, NULL, 'Костюк Сергей', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1791, 0, NULL, NULL, NULL, NULL, NULL, 'Костюк Сергей (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1792, 1, NULL, NULL, NULL, NULL, NULL, 'Костюкова Л.А. ', NULL, NULL, '7 978 063 52 27', 0, NULL);
INSERT INTO public.contractors VALUES (1793, 1, NULL, NULL, NULL, NULL, NULL, 'Косых О.Г. ', NULL, NULL, '79788521730', 0, NULL);
INSERT INTO public.contractors VALUES (1794, 0, NULL, NULL, NULL, NULL, NULL, 'Косюк Николай Ананьевич ', NULL, NULL, '79787081779', 0, NULL);
INSERT INTO public.contractors VALUES (1795, 1, NULL, NULL, NULL, NULL, NULL, 'Котилевский АА 79787748872', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1796, 1, NULL, NULL, NULL, NULL, NULL, 'Котлов С.В. ', NULL, NULL, '7 978 864 67 22', 0, NULL);
INSERT INTO public.contractors VALUES (1797, 1, NULL, NULL, NULL, NULL, NULL, 'Котлярчук СН 79782676206', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1798, 0, NULL, NULL, NULL, NULL, NULL, 'Котюков О.П. ', NULL, NULL, '7 978 701 58 72', 0, NULL);
INSERT INTO public.contractors VALUES (1799, 1, NULL, NULL, NULL, NULL, NULL, 'Коханец Игорь ', NULL, NULL, '7978 707 79 67', 0, NULL);
INSERT INTO public.contractors VALUES (1800, 1, NULL, NULL, NULL, NULL, NULL, 'Коц Г.В. ', NULL, NULL, '7 978 857 33 18', 0, NULL);
INSERT INTO public.contractors VALUES (1801, 1, NULL, NULL, NULL, NULL, NULL, 'Коцарь А.Г. ', NULL, NULL, '7978 111 72 56', 0, NULL);
INSERT INTO public.contractors VALUES (1802, 1, NULL, NULL, NULL, NULL, NULL, 'Кочетков АВ 79787063590', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1803, 2, NULL, NULL, NULL, NULL, NULL, 'Кочетов Н.А. ИП - А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1804, 1, NULL, NULL, NULL, NULL, NULL, 'Кочубеев В.Ю ', NULL, NULL, '79276456349', 0, NULL);
INSERT INTO public.contractors VALUES (1805, 1, NULL, NULL, NULL, NULL, NULL, 'Кошелев В.А. ', NULL, NULL, '7 978 79 30 152', 0, NULL);
INSERT INTO public.contractors VALUES (1806, 1, NULL, NULL, NULL, NULL, NULL, 'Кошелев С.В. ', NULL, NULL, '7978 708 63 30', 0, NULL);
INSERT INTO public.contractors VALUES (1807, 1, NULL, NULL, NULL, NULL, NULL, 'Кошель В.А. ', NULL, NULL, '7 918 005 66 44', 0, NULL);
INSERT INTO public.contractors VALUES (1808, 1, NULL, NULL, NULL, NULL, NULL, 'Кошкина В.А. ', NULL, NULL, '7 978 803 16 72', 0, NULL);
INSERT INTO public.contractors VALUES (1809, 1, NULL, NULL, NULL, NULL, NULL, 'Кравец А.Н. ', NULL, NULL, '7 978 026 68 67', 0, NULL);
INSERT INTO public.contractors VALUES (1810, 1, NULL, NULL, NULL, NULL, NULL, 'Кравец Алексей ', NULL, NULL, '7 978 026 68 67 (к.п) Ан', 0, NULL);
INSERT INTO public.contractors VALUES (1811, 2, NULL, NULL, NULL, NULL, NULL, 'Кравец Дмитрий Сергеевич, ', NULL, NULL, '7 978 143 34 59_ Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1812, 0, NULL, NULL, NULL, NULL, NULL, 'Кравец Павел ', NULL, NULL, '79892999700', 0, NULL);
INSERT INTO public.contractors VALUES (1813, 0, NULL, NULL, NULL, NULL, NULL, 'Кравцов А. ', NULL, NULL, '7 978 77 17 099', 0, NULL);
INSERT INTO public.contractors VALUES (1814, 0, NULL, NULL, NULL, NULL, NULL, 'Кравченко  Виктор Викторович', NULL, NULL, '79780608011', 0, NULL);
INSERT INTO public.contractors VALUES (1815, 1, NULL, NULL, NULL, NULL, NULL, 'Кравченко 79788735711', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1816, 1, NULL, NULL, NULL, NULL, NULL, 'Кравченко ВЛ 79787617335', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1817, 1, NULL, NULL, NULL, NULL, NULL, 'Кравченко И.В. 8-978-73-36-341', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1818, 1, NULL, NULL, NULL, NULL, NULL, 'Кравченко НД 79788601833 1097572', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1819, 0, NULL, NULL, NULL, NULL, NULL, 'Кравченко С.Ю. ', NULL, NULL, '7 978 792 85 80', 0, NULL);
INSERT INTO public.contractors VALUES (1820, 0, NULL, NULL, NULL, NULL, NULL, 'Кравчук А.П. ', NULL, NULL, '7 978 059 41 17', 0, NULL);
INSERT INTO public.contractors VALUES (1821, 1, NULL, NULL, NULL, NULL, NULL, 'Кравчук В.В. ', NULL, NULL, '79787074547', 0, NULL);
INSERT INTO public.contractors VALUES (1822, 1, NULL, NULL, NULL, NULL, NULL, 'Кравчук М.Н. ', NULL, NULL, '7978 711 27 60', 0, NULL);
INSERT INTO public.contractors VALUES (1823, 1, NULL, NULL, NULL, NULL, NULL, 'Краев Михаил ', NULL, NULL, '7978 761 35 06', 0, NULL);
INSERT INTO public.contractors VALUES (1824, 1, NULL, NULL, NULL, NULL, NULL, 'Крайнюков Г.Д. ', NULL, NULL, '79788175698', 0, NULL);
INSERT INTO public.contractors VALUES (1825, 1, NULL, NULL, NULL, NULL, NULL, 'Крайнюков Николай Федорович ', NULL, NULL, '7978 708 70 79', 0, NULL);
INSERT INTO public.contractors VALUES (1826, 0, NULL, NULL, NULL, NULL, NULL, 'КРАО (Обсерватория) ', NULL, NULL, '7 978 838 51 03 Анна', 0, NULL);
INSERT INTO public.contractors VALUES (1827, 1, NULL, NULL, NULL, NULL, NULL, 'Красиков Г.Б. ', NULL, NULL, '7 978 770 59 55', 0, NULL);
INSERT INTO public.contractors VALUES (1828, 1, NULL, NULL, NULL, NULL, NULL, 'Краснобаева Т.В. ', NULL, NULL, '7978 718 79 66', 0, NULL);
INSERT INTO public.contractors VALUES (1829, 1, NULL, NULL, NULL, NULL, NULL, 'Краснов Г.В. ', NULL, NULL, '7 978 74 34 818', 0, NULL);
INSERT INTO public.contractors VALUES (1830, 0, NULL, NULL, NULL, NULL, NULL, 'Краснов Г.В. ', NULL, NULL, '7 978 74 34 818', 0, NULL);
INSERT INTO public.contractors VALUES (1831, 2, NULL, NULL, NULL, NULL, NULL, 'Краснорудский Андрей  ', NULL, NULL, '79780102525 (д.п.-) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1832, 1, NULL, NULL, NULL, NULL, NULL, 'Красноруцкая Анжелика 8 914 717 18 49', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1833, 0, NULL, NULL, NULL, NULL, NULL, 'Кратько Дмитрий Андреевич ', NULL, NULL, '79788680781', 0, NULL);
INSERT INTO public.contractors VALUES (1834, 0, NULL, NULL, NULL, NULL, NULL, 'Кратько Константин Сергеевич 89195526333', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1835, 0, NULL, NULL, NULL, NULL, NULL, 'Кремнев В.А. ', NULL, NULL, '7 978 78 679 48', 0, NULL);
INSERT INTO public.contractors VALUES (1836, 0, NULL, NULL, NULL, NULL, 910201001, '"КРЕПЕЖНЫЕ ТЕХНОЛОГИИ"" _Константин ', NULL, NULL, '7 978 744 97 04_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (1837, 0, NULL, NULL, NULL, NULL, NULL, 'Крепёжные технологиии  Аронова Е.М. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1838, 0, NULL, NULL, NULL, NULL, NULL, 'Кречик С.А. ', NULL, NULL, '7 978 74 555 94', 0, NULL);
INSERT INTO public.contractors VALUES (1839, 1, NULL, NULL, NULL, NULL, NULL, 'Кривелев ДА 79781292455', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1840, 1, NULL, NULL, NULL, NULL, NULL, 'Кривенко О.В. ', NULL, NULL, '7 978 820 35 21', 0, NULL);
INSERT INTO public.contractors VALUES (1841, 1, NULL, NULL, NULL, NULL, NULL, 'Кривошеин О.И. ', NULL, NULL, ' 7978 77 07 052', 0, NULL);
INSERT INTO public.contractors VALUES (1842, 1, NULL, NULL, NULL, NULL, NULL, 'КРИВЧЕНКО АН  79787325265', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1843, 0, NULL, NULL, NULL, NULL, NULL, 'Криночкин Вадим ', NULL, NULL, ' 7978 771 72 25', 0, NULL);
INSERT INTO public.contractors VALUES (1844, 0, NULL, NULL, NULL, NULL, NULL, 'Криночкин Вадим Сергеевич ', NULL, NULL, '7 978 771 72 25', 0, NULL);
INSERT INTO public.contractors VALUES (1845, 0, NULL, NULL, NULL, NULL, 773401001, 'КРИНС ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1846, 0, NULL, NULL, NULL, NULL, NULL, 'Кристалл ', NULL, NULL, '79781300515', 0, NULL);
INSERT INTO public.contractors VALUES (1847, 1, NULL, NULL, NULL, NULL, NULL, 'Криштопин Н.П. ', NULL, NULL, '7 978 551 76 97', 0, NULL);
INSERT INTO public.contractors VALUES (1848, 0, NULL, NULL, NULL, NULL, NULL, 'Кровельные комплектации', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1849, 0, NULL, NULL, NULL, NULL, NULL, 'Кровельный мир (Родник Симферополь ', NULL, NULL, '7 978 218 9000) (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1850, 0, NULL, NULL, NULL, NULL, NULL, 'Кровельный Торговый Дом', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1851, 0, NULL, NULL, NULL, NULL, NULL, 'Кровельщик ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1852, 0, NULL, NULL, NULL, NULL, NULL, 'Кровля ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1853, 0, NULL, NULL, NULL, NULL, NULL, 'Кровля ', NULL, NULL, ' Алие ', 0, NULL);
INSERT INTO public.contractors VALUES (1854, 1, NULL, NULL, NULL, NULL, NULL, 'Кровля ', NULL, NULL, ' Эмиль ', 0, NULL);
INSERT INTO public.contractors VALUES (1855, 0, NULL, NULL, NULL, NULL, NULL, 'Кровля Игорь Феодосия д.п.-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1856, 1, NULL, NULL, NULL, NULL, NULL, 'Кровля Люкс Андрей Шевалгин ', NULL, NULL, '7 978 781 13 91 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1857, 0, NULL, NULL, NULL, NULL, NULL, 'Кровля плюс Евгений ', NULL, NULL, '7 978 746-06-08 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1858, 0, NULL, NULL, NULL, NULL, NULL, 'Кровля С Феодосия (д.п.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1859, 0, NULL, NULL, NULL, NULL, NULL, 'Кровля СтройМонтаж Крым -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1860, 2, NULL, NULL, NULL, NULL, NULL, 'Кровля Фасады Алушта.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1861, 1, NULL, NULL, NULL, NULL, NULL, 'КРОВЛЯЛИДЕР Виктор ', NULL, NULL, '7 978 134 19 70 (д.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1862, 0, NULL, NULL, NULL, NULL, 232001001, 'КРОВТЕХМАСТЕР, Дмитрий ', NULL, NULL, '7 978 257 38 11 (д.п.)  - Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1863, 0, NULL, NULL, NULL, NULL, NULL, 'Крон', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1864, 0, NULL, NULL, NULL, NULL, NULL, 'Крот Н.А. ', NULL, NULL, '79788753699', 0, NULL);
INSERT INTO public.contractors VALUES (1865, 1, NULL, NULL, NULL, NULL, NULL, 'Крот Николай Александрович ', NULL, NULL, '79788753699', 0, NULL);
INSERT INTO public.contractors VALUES (1866, 1, NULL, NULL, NULL, NULL, NULL, 'Кротков Д.Ю. ', NULL, NULL, '7 978 7 888 191', 0, NULL);
INSERT INTO public.contractors VALUES (1867, 1, NULL, NULL, NULL, NULL, NULL, 'Кротов Алексей Александрович ', NULL, NULL, '7978 77 27 360', 0, NULL);
INSERT INTO public.contractors VALUES (1868, 0, NULL, NULL, NULL, NULL, NULL, 'Крупко Александр (Красногвардейск)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1869, 0, NULL, NULL, NULL, NULL, NULL, 'Крупко Е.В. ', NULL, NULL, '797878778700', 0, NULL);
INSERT INTO public.contractors VALUES (1870, 1, NULL, NULL, NULL, NULL, NULL, 'Крутась В.Н. ', NULL, NULL, '79788258247', 0, NULL);
INSERT INTO public.contractors VALUES (1871, 1, NULL, NULL, NULL, NULL, NULL, 'Крутько 79787177724', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1872, 0, NULL, NULL, NULL, NULL, NULL, 'Крутько Александр ', NULL, NULL, '79787589294', 0, NULL);
INSERT INTO public.contractors VALUES (1873, 0, NULL, NULL, NULL, NULL, NULL, 'Кручиненко ИП ', NULL, NULL, '7 978 983 42 62', 0, NULL);
INSERT INTO public.contractors VALUES (1874, 0, NULL, NULL, NULL, NULL, NULL, 'Крыгин Вячеслав Геннадьевич ', NULL, NULL, '79889753555', 0, NULL);
INSERT INTO public.contractors VALUES (1875, 0, NULL, NULL, NULL, NULL, NULL, 'Крым Лидер', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1876, 0, NULL, NULL, NULL, NULL, NULL, 'Крым Лидер Групп', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1877, 0, NULL, NULL, NULL, NULL, NULL, 'Крым Люкс Дом 79787244705 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1878, 0, NULL, NULL, NULL, NULL, NULL, 'Крым Мост ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1879, 0, NULL, NULL, NULL, NULL, NULL, 'Крым Профсталь ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1880, 0, NULL, NULL, NULL, NULL, 910201001, 'КРЫМ СТРОЙ МОДУЛЬ- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1881, 0, NULL, NULL, NULL, NULL, NULL, 'Крым Тат Спец Строй (от Рады)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1882, 0, NULL, NULL, NULL, NULL, NULL, 'Крым-инвестстрой и компания КТ (Саки) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1883, 0, NULL, NULL, NULL, NULL, NULL, 'Крым-Пласт ', NULL, NULL, '7 978 814-42-33 Владимир', 0, NULL);
INSERT INTO public.contractors VALUES (1884, 0, NULL, NULL, NULL, NULL, NULL, 'Крым-Транс-Авто Бухарев Юрий Викторович ', NULL, NULL, '7 978 705 98-12', 0, NULL);
INSERT INTO public.contractors VALUES (1885, 0, NULL, NULL, NULL, NULL, NULL, 'Крым-Траст ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1886, 0, NULL, NULL, NULL, NULL, NULL, 'Крымавто ', NULL, NULL, '7 978 829 94 22 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1887, 0, NULL, NULL, NULL, NULL, NULL, 'Крымгазстрой ПАО ', NULL, NULL, '7 978 77 04 017', 0, NULL);
INSERT INTO public.contractors VALUES (1888, 0, NULL, NULL, NULL, NULL, 910201001, '"КРЫМДИЗАЙНПРОЕКТ"", Рафиль_Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1889, 0, NULL, NULL, NULL, NULL, 910201001, 'КРЫМДОРСТРОЙ ООО-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1890, 0, NULL, NULL, NULL, NULL, NULL, 'Крымзеленстрой ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1891, 0, NULL, NULL, NULL, NULL, NULL, 'КрымИнвест ПМК  ', NULL, NULL, '7 916 631 85 43 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1892, 0, NULL, NULL, NULL, NULL, NULL, 'Крыминвестплюс, Автордом ', NULL, NULL, '7 910 158 9115 Виктор - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1893, 0, NULL, NULL, NULL, NULL, NULL, 'КрымЛюксДом -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1894, 0, NULL, NULL, NULL, NULL, NULL, 'Крымская металлургическая компания ', NULL, NULL, '7 910 575 98 14 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (1895, 0, NULL, NULL, NULL, NULL, NULL, 'Крымская ТПК ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1896, 0, NULL, NULL, NULL, NULL, NULL, 'Крымский Вектор  ', NULL, NULL, '7 978 096 79 30 Алена ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1897, 1, NULL, NULL, NULL, NULL, NULL, 'Крымский Дом', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1898, 0, NULL, NULL, NULL, NULL, NULL, 'Крымский Экспресс ', NULL, NULL, '7 978 826 18 76 Сергей -А.', 0, NULL);
INSERT INTO public.contractors VALUES (1899, 0, NULL, NULL, NULL, NULL, NULL, 'Крымспецпрофиль ', NULL, NULL, '7 978 756 56 86', 0, NULL);
INSERT INTO public.contractors VALUES (1900, 0, NULL, NULL, NULL, NULL, NULL, 'КрымСпецСтрой', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1901, 0, NULL, NULL, NULL, NULL, 920101001, '"КРЫМСТРОЙАЛЬЯНС"", ', NULL, NULL, '7 978 567 89 67 Виталий_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (1902, 0, NULL, NULL, NULL, NULL, NULL, 'Крымтаксосервис', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1903, 0, NULL, NULL, NULL, NULL, 910901001, '"КРЫМТЕХКАРКАС"" _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1904, 0, NULL, NULL, NULL, NULL, NULL, 'Крымэлектромашторг ', NULL, NULL, '7 978 71 00 348 (д.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (1905, 0, NULL, NULL, NULL, NULL, 920101001, '"КРЫМЭТАЛОНСТРОЙ"" _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1906, 1, NULL, NULL, NULL, NULL, NULL, 'Крючек Александр Петрович ', NULL, NULL, '7978 77 23 068', 0, NULL);
INSERT INTO public.contractors VALUES (1907, 0, NULL, NULL, NULL, NULL, NULL, 'Крючек Александр Петрович ', NULL, NULL, '79787723069', 0, NULL);
INSERT INTO public.contractors VALUES (1908, 1, NULL, NULL, NULL, NULL, NULL, 'Крятов С.Н. ', NULL, NULL, '79787359000', 0, NULL);
INSERT INTO public.contractors VALUES (1909, 0, NULL, NULL, NULL, NULL, NULL, 'Крячко Александр ', NULL, NULL, '79788106890', 0, NULL);
INSERT INTO public.contractors VALUES (1910, 0, NULL, NULL, NULL, NULL, NULL, 'КСД Верден ', NULL, NULL, '7978 831 50 80', 0, NULL);
INSERT INTO public.contractors VALUES (1911, 0, NULL, NULL, NULL, NULL, NULL, 'Ксендзюк М.В. ', NULL, NULL, '7 978 798 15 31', 0, NULL);
INSERT INTO public.contractors VALUES (1912, 1, NULL, NULL, NULL, NULL, NULL, 'КСК ', NULL, NULL, '7 978 833 38 38 Артем ООО', 0, NULL);
INSERT INTO public.contractors VALUES (1913, 0, NULL, NULL, NULL, NULL, 772601001, '"КСТ"", Дарья ', NULL, NULL, '7 926 127 00 96 ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (1914, 0, NULL, NULL, NULL, NULL, NULL, 'Ктистопуло Руслан ', NULL, NULL, '7 978 858 12 15', 0, NULL);
INSERT INTO public.contractors VALUES (1915, 1, NULL, NULL, NULL, NULL, NULL, 'Кубрак А.В. ', NULL, NULL, '7 978 756 55 01', 0, NULL);
INSERT INTO public.contractors VALUES (1916, 0, NULL, NULL, NULL, NULL, NULL, 'Кубэкс Карго Сервис 79787655417 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1917, 1, NULL, NULL, NULL, NULL, NULL, 'Куватов Р.С. ', NULL, NULL, '7 978 025 27 38', 0, NULL);
INSERT INTO public.contractors VALUES (1918, 0, NULL, NULL, NULL, NULL, NULL, 'Кудаев Сергей ', NULL, NULL, '7 978 709 25 13', 0, NULL);
INSERT INTO public.contractors VALUES (1919, 1, NULL, NULL, NULL, NULL, NULL, 'Кудимом М.Н. 8978-831-54-55', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1920, 0, NULL, NULL, NULL, NULL, NULL, 'Кудлай К.А. ', NULL, NULL, '7 978 743 12 68', 0, NULL);
INSERT INTO public.contractors VALUES (1921, 1, NULL, NULL, NULL, NULL, NULL, 'Кудрявцев А.В. ', NULL, NULL, '7 999 995 68 79', 0, NULL);
INSERT INTO public.contractors VALUES (1922, 1, NULL, NULL, NULL, NULL, NULL, 'Кудрявцев А.С. ', NULL, NULL, '79788671139', 0, NULL);
INSERT INTO public.contractors VALUES (1923, 1, NULL, NULL, NULL, NULL, NULL, 'Кудряшов 79787728020', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1924, 1, NULL, NULL, NULL, NULL, NULL, 'Кудряшов В.А. ', NULL, NULL, '7 978 082 13 05', 0, NULL);
INSERT INTO public.contractors VALUES (1925, 1, NULL, NULL, NULL, NULL, NULL, 'Кузин ВС 79788309747', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1926, 1, NULL, NULL, NULL, NULL, NULL, 'Кузина ЛВ 79787383081', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1927, 1, NULL, NULL, NULL, NULL, NULL, 'Кузнецов А.В 7978-711-26-10', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1928, 0, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Александр ', NULL, NULL, '79780745616', 0, NULL);
INSERT INTO public.contractors VALUES (1929, 0, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Анатолий ', NULL, NULL, '7 978 764 94 40', 0, NULL);
INSERT INTO public.contractors VALUES (1930, 1, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Анатолий ', NULL, NULL, '7978 764 94 40', 0, NULL);
INSERT INTO public.contractors VALUES (1931, 1, NULL, NULL, NULL, NULL, NULL, 'Кузнецов В.В. ', NULL, NULL, '7 978 135 70 03', 0, NULL);
INSERT INTO public.contractors VALUES (1932, 0, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Е.В. ', NULL, NULL, '7 910 420 2016', 0, NULL);
INSERT INTO public.contractors VALUES (1933, 0, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Е.В. ', NULL, NULL, '7 978 72 67 401', 0, NULL);
INSERT INTO public.contractors VALUES (1934, 1, NULL, NULL, NULL, NULL, NULL, 'Кузнецов ОВ ', NULL, NULL, '79788345859', 0, NULL);
INSERT INTO public.contractors VALUES (1935, 0, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Олег ', NULL, NULL, '79788345859', 0, NULL);
INSERT INTO public.contractors VALUES (1936, 1, NULL, NULL, NULL, NULL, NULL, 'Кузнецов Сергей ', NULL, NULL, '7978 706 94 84', 0, NULL);
INSERT INTO public.contractors VALUES (1937, 1, NULL, NULL, NULL, NULL, NULL, 'Кузнецов СС ', NULL, NULL, '79788295173', 0, NULL);
INSERT INTO public.contractors VALUES (1938, 1, NULL, NULL, NULL, NULL, NULL, 'Кузьменко В.В, ', NULL, NULL, '7 978 731 21 45', 0, NULL);
INSERT INTO public.contractors VALUES (1939, 0, NULL, NULL, NULL, NULL, NULL, 'Кузьменко В.П. ', NULL, NULL, '7 978 864 16 87 (84)', 0, NULL);
INSERT INTO public.contractors VALUES (1940, 0, NULL, NULL, NULL, NULL, NULL, 'Кузьменко Д.С. ', NULL, NULL, '7978 752 72 13', 0, NULL);
INSERT INTO public.contractors VALUES (1941, 1, NULL, NULL, NULL, NULL, NULL, 'Кузьменко ОС 79787640498', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1942, 0, NULL, NULL, NULL, NULL, NULL, 'Кузьмин Денис ', NULL, NULL, '79782588284', 0, NULL);
INSERT INTO public.contractors VALUES (1943, 1, NULL, NULL, NULL, NULL, NULL, 'Кузьмин Михаил ', NULL, NULL, '7 978 736 07 02', 0, NULL);
INSERT INTO public.contractors VALUES (1944, 1, NULL, NULL, NULL, NULL, NULL, 'Кузьмич Сергей ', NULL, NULL, '7978 761 21 14', 0, NULL);
INSERT INTO public.contractors VALUES (1945, 1, NULL, NULL, NULL, NULL, NULL, 'Кузьмичев В.В. ', NULL, NULL, '7 978 748 28 20', 0, NULL);
INSERT INTO public.contractors VALUES (1946, 1, NULL, NULL, NULL, NULL, NULL, 'Кукалов В.И. ', NULL, NULL, '7 978 829 87 50', 0, NULL);
INSERT INTO public.contractors VALUES (1947, 1, NULL, NULL, NULL, NULL, NULL, 'Куксов Г.А. ', NULL, NULL, '7 978 754 64 79', 0, NULL);
INSERT INTO public.contractors VALUES (1948, 0, NULL, NULL, NULL, NULL, NULL, 'Кукулеско Е.С.(И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1949, 0, NULL, NULL, NULL, NULL, NULL, 'Кулагин Максим ', NULL, NULL, '79787570912', 0, NULL);
INSERT INTO public.contractors VALUES (1950, 1, NULL, NULL, NULL, NULL, NULL, 'Кулагин СА 79780390242', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1951, 0, NULL, NULL, NULL, NULL, NULL, 'Кулидин Е.И. ', NULL, NULL, '7978 862 21 34', 0, NULL);
INSERT INTO public.contractors VALUES (1952, 0, NULL, NULL, NULL, NULL, NULL, 'Куликов Денис ', NULL, NULL, '7 978 146 34 58', 0, NULL);
INSERT INTO public.contractors VALUES (1953, 1, NULL, NULL, NULL, NULL, NULL, 'Куликов РВ 79787714770 79780122664', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1954, 1, NULL, NULL, NULL, NULL, NULL, 'Куликов ЮС 79787560366', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1955, 0, NULL, NULL, NULL, NULL, NULL, 'Куликова Галина 89136645053', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1956, 0, NULL, NULL, NULL, NULL, NULL, 'Кулиничев Ю.А. ', NULL, NULL, '79787358410', 0, NULL);
INSERT INTO public.contractors VALUES (1957, 1, NULL, NULL, NULL, NULL, NULL, 'Кулиничев ЮА 79787358410', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1958, 1, NULL, NULL, NULL, NULL, NULL, 'Кулиш В.Н. ', NULL, NULL, '7 978 744 96 46', 0, NULL);
INSERT INTO public.contractors VALUES (1959, 0, NULL, NULL, NULL, NULL, NULL, 'Кульнев А.М. ', NULL, NULL, '7 978 718 01 05', 0, NULL);
INSERT INTO public.contractors VALUES (1960, 1, NULL, NULL, NULL, NULL, NULL, 'Кунов А 79788710664', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1961, 2, NULL, NULL, NULL, NULL, NULL, 'Купецкий Геннадий ', NULL, NULL, '7 978 805 86 36 ИП -А.', 0, NULL);
INSERT INTO public.contractors VALUES (1962, 1, NULL, NULL, NULL, NULL, NULL, 'Купленый А.С. ', NULL, NULL, '7 978 862 79 25', 0, NULL);
INSERT INTO public.contractors VALUES (1963, 1, NULL, NULL, NULL, NULL, NULL, 'Кураж М.В. ', NULL, NULL, '7 978 708 80 90 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (1964, 1, NULL, NULL, NULL, NULL, NULL, 'Куракин В.С. ', NULL, NULL, '7 978 752 03 28', 0, NULL);
INSERT INTO public.contractors VALUES (1965, 1, NULL, NULL, NULL, NULL, NULL, 'Кураков Олег -А. ', NULL, NULL, '7 978 75 85 344', 0, NULL);
INSERT INTO public.contractors VALUES (1966, 1, NULL, NULL, NULL, NULL, NULL, 'Курбан М.Я. ', NULL, NULL, '7 978 766 57 18', 0, NULL);
INSERT INTO public.contractors VALUES (1967, 1, NULL, NULL, NULL, NULL, NULL, 'Курбанов Р.Г. ', NULL, NULL, '7978 754 52 27', 0, NULL);
INSERT INTO public.contractors VALUES (1968, 1, NULL, NULL, NULL, NULL, NULL, 'Курбесова Л.Л. ', NULL, NULL, '79780074904', 0, NULL);
INSERT INTO public.contractors VALUES (1969, 1, NULL, NULL, NULL, NULL, NULL, 'Курганов А.Н. ', NULL, NULL, '7 978 728 10 57', 0, NULL);
INSERT INTO public.contractors VALUES (1970, 1, NULL, NULL, NULL, NULL, NULL, 'Куредин А.П. ', NULL, NULL, '7 978 843 98 02', 0, NULL);
INSERT INTO public.contractors VALUES (1971, 1, NULL, NULL, NULL, NULL, NULL, 'Куредин СА 79787451545', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1972, 1, NULL, NULL, NULL, NULL, NULL, 'Куренкин АВ 79787376488', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1973, 0, NULL, NULL, NULL, NULL, NULL, 'КУРИЛО (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1974, 1, NULL, NULL, NULL, NULL, NULL, 'Курило А.О. ', NULL, NULL, '7978 849 21 99', 0, NULL);
INSERT INTO public.contractors VALUES (1975, 0, NULL, NULL, NULL, NULL, NULL, 'Курило Андрей ', NULL, NULL, '79785968393', 0, NULL);
INSERT INTO public.contractors VALUES (1976, 1, NULL, NULL, NULL, NULL, NULL, 'Куркин В.П. ', NULL, NULL, '7978 136 82 50', 0, NULL);
INSERT INTO public.contractors VALUES (1977, 0, NULL, NULL, NULL, NULL, NULL, 'Курлов Р.Н. ', NULL, NULL, '7 978 844 63 72', 0, NULL);
INSERT INTO public.contractors VALUES (1978, 1, NULL, NULL, NULL, NULL, NULL, 'Курнавин АК 79788313125', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1979, 2, NULL, NULL, NULL, NULL, NULL, 'Куров Владимир ( Джанкой )-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1980, 1, NULL, NULL, NULL, NULL, NULL, 'Курочкин П.С. ', NULL, NULL, '7 978 7200 530', 0, NULL);
INSERT INTO public.contractors VALUES (1981, 0, NULL, NULL, NULL, NULL, NULL, 'Курс  79787881510 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1982, 1, NULL, NULL, NULL, NULL, NULL, 'Куртаметов Р.Р. ', NULL, NULL, '79112752565', 0, NULL);
INSERT INTO public.contractors VALUES (1983, 1, NULL, NULL, NULL, NULL, NULL, 'Куртаметов Сулейман ', NULL, NULL, '7 978 206 21 23', 0, NULL);
INSERT INTO public.contractors VALUES (1984, 1, NULL, NULL, NULL, NULL, NULL, 'Куртвапов Л 79788010056', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1985, 1, NULL, NULL, NULL, NULL, NULL, 'Куртмаметов МА 79787689006', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1986, 0, NULL, NULL, NULL, NULL, NULL, 'Куртсеитов Сейтвели ', NULL, NULL, '79788387125', 0, NULL);
INSERT INTO public.contractors VALUES (1987, 0, NULL, NULL, NULL, NULL, NULL, 'Куртумеров Д.О. ', NULL, NULL, '7 978 78 26 377', 0, NULL);
INSERT INTO public.contractors VALUES (1988, 0, NULL, NULL, NULL, NULL, NULL, 'Курячий В.И. ', NULL, NULL, '7 978 790 25 18', 0, NULL);
INSERT INTO public.contractors VALUES (1989, 0, NULL, NULL, NULL, NULL, NULL, 'Кутузов Роман Александрович ', NULL, NULL, '79788252444', 0, NULL);
INSERT INTO public.contractors VALUES (1990, 0, NULL, NULL, NULL, NULL, NULL, 'Кутьев Андрей ', NULL, NULL, '79787354010', 0, NULL);
INSERT INTO public.contractors VALUES (1991, 1, NULL, NULL, NULL, NULL, NULL, 'Кухарук А.В. ', NULL, NULL, '7978 759 07 15', 0, NULL);
INSERT INTO public.contractors VALUES (1992, 0, NULL, NULL, NULL, NULL, NULL, 'Куц Г.В. ', NULL, NULL, '7 978 857 33 18', 0, NULL);
INSERT INTO public.contractors VALUES (1993, 1, NULL, NULL, NULL, NULL, NULL, 'Куцевич И.В. ', NULL, NULL, '7978 77 47 609', 0, NULL);
INSERT INTO public.contractors VALUES (1994, 1, NULL, NULL, NULL, NULL, NULL, 'Кучеренко Л.И. ', NULL, NULL, '7978 06 92 144', 0, NULL);
INSERT INTO public.contractors VALUES (1995, 1, NULL, NULL, NULL, NULL, NULL, 'Кучук Т.И. ', NULL, NULL, '7 978 739 75 03, ', 0, NULL);
INSERT INTO public.contractors VALUES (1996, 1, NULL, NULL, NULL, NULL, NULL, 'Кушнаренко СА 79781315036', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1997, 2, NULL, NULL, NULL, NULL, NULL, 'КФХ Усеинов Б.Ш.  ', NULL, NULL, '7 978 837 57 70 Бахтияр ИП', 0, NULL);
INSERT INTO public.contractors VALUES (1998, 0, NULL, NULL, NULL, NULL, 910201001, 'КЭМС', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (1999, 0, NULL, NULL, NULL, NULL, NULL, 'КЭМС Виталий', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2000, 0, NULL, NULL, NULL, NULL, NULL, 'КЭМС Монтаж', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2001, 1, NULL, NULL, NULL, NULL, NULL, 'Лабунихин А.М. ', NULL, NULL, '7 978 718 74 86', 0, NULL);
INSERT INTO public.contractors VALUES (2002, 1, NULL, NULL, NULL, NULL, NULL, 'Лавренко Д.С. ', NULL, NULL, '7 978 822 61 97', 0, NULL);
INSERT INTO public.contractors VALUES (2003, 1, NULL, NULL, NULL, NULL, NULL, 'Лавреньтиев ПН 79788311744', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2004, 1, NULL, NULL, NULL, NULL, NULL, 'Лавров А.В. ', NULL, NULL, '7978 743 43 90', 0, NULL);
INSERT INTO public.contractors VALUES (2005, 0, NULL, NULL, NULL, NULL, NULL, 'Лавров Дмитрий ', NULL, NULL, ' 7 978  091 01 30_Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2006, 0, NULL, NULL, NULL, NULL, NULL, 'Лагутенко Юрий Александрович ', NULL, NULL, '79787697136', 0, NULL);
INSERT INTO public.contractors VALUES (2007, 1, NULL, NULL, NULL, NULL, NULL, 'Лазарев В.П. ', NULL, NULL, '7 978 70 59 220', 0, NULL);
INSERT INTO public.contractors VALUES (2008, 1, NULL, NULL, NULL, NULL, NULL, 'Лазаренко МВ 79787203330', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2009, 1, NULL, NULL, NULL, NULL, NULL, 'Лазареско И.Л. ', NULL, NULL, '7978 70 80 994', 0, NULL);
INSERT INTO public.contractors VALUES (2010, 1, NULL, NULL, NULL, NULL, NULL, 'Лазеба ЮН ', NULL, NULL, '79788290994', 0, NULL);
INSERT INTO public.contractors VALUES (2011, 1, NULL, NULL, NULL, NULL, NULL, 'Лазука Степан Владимирович ', NULL, NULL, '7978 74 58 427', 0, NULL);
INSERT INTO public.contractors VALUES (2012, 0, NULL, NULL, NULL, NULL, NULL, 'Лакон групп Наталья _ Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2013, 1, NULL, NULL, NULL, NULL, NULL, 'Лакун А.В. ', NULL, NULL, '7978 75 20 392', 0, NULL);
INSERT INTO public.contractors VALUES (2014, 2, NULL, NULL, NULL, NULL, NULL, 'Ламаш ИА  79787049612', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2015, 1, NULL, NULL, NULL, NULL, NULL, 'Ламберт ИА 79787934492', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2016, 0, NULL, NULL, NULL, NULL, NULL, 'Ланко А.В. ', NULL, NULL, '7 978 76 48 572', 0, NULL);
INSERT INTO public.contractors VALUES (2017, 1, NULL, NULL, NULL, NULL, NULL, 'Лапин Н.А ', NULL, NULL, '7978 806 35 17', 0, NULL);
INSERT INTO public.contractors VALUES (2018, 0, NULL, NULL, NULL, NULL, NULL, 'Ларин Александр ', NULL, NULL, '7 978 746 14 97 - Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2019, 1, NULL, NULL, NULL, NULL, NULL, 'Ласточкин АА 79788050109', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2020, 1, NULL, NULL, NULL, NULL, NULL, 'Лахматова Т.Ф. 8-978-039-35-42', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2021, 1, NULL, NULL, NULL, NULL, NULL, 'Лахно И.А', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2022, 1, NULL, NULL, NULL, NULL, NULL, 'Лачихин Н.П. ', NULL, NULL, '79787926651', 0, NULL);
INSERT INTO public.contractors VALUES (2023, 1, NULL, NULL, NULL, NULL, NULL, 'Лашко 79788784470', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2024, 1, NULL, NULL, NULL, NULL, NULL, 'Лашко АВ 79787078022', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2025, 1, NULL, NULL, NULL, NULL, NULL, 'Лашко Г.А. ', NULL, NULL, '7978 836 85 47', 0, NULL);
INSERT INTO public.contractors VALUES (2026, 1, NULL, NULL, NULL, NULL, NULL, 'Лебедев ВВ 79787114301', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2027, 0, NULL, NULL, NULL, NULL, NULL, 'Лебедев С.С. ', NULL, NULL, '7978 711-90-33', 0, NULL);
INSERT INTO public.contractors VALUES (2028, 1, NULL, NULL, NULL, NULL, NULL, 'Лебеденко А.В. ', NULL, NULL, '7 978 801 50 19', 0, NULL);
INSERT INTO public.contractors VALUES (2029, 1, NULL, NULL, NULL, NULL, NULL, 'Лебеденко А.В. ', NULL, NULL, '7 978 817 66 33', 0, NULL);
INSERT INTO public.contractors VALUES (2030, 1, NULL, NULL, NULL, NULL, NULL, 'Лебединский ОВ 79785047989', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2031, 0, NULL, NULL, NULL, NULL, NULL, 'Левак Симферополь', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2032, 1, NULL, NULL, NULL, NULL, NULL, 'Левандовский Валерий Сергеевич ', NULL, NULL, '7978 752 04 19', 0, NULL);
INSERT INTO public.contractors VALUES (2033, 0, NULL, NULL, NULL, NULL, NULL, 'Левин ', NULL, NULL, '7 978 806 32 63', 0, NULL);
INSERT INTO public.contractors VALUES (2034, 1, NULL, NULL, NULL, NULL, NULL, 'Левин Г.Г. ', NULL, NULL, '7 988 28 69 079', 0, NULL);
INSERT INTO public.contractors VALUES (2035, 1, NULL, NULL, NULL, NULL, NULL, 'Левицкая 79788382854', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2036, 0, NULL, NULL, NULL, NULL, NULL, 'Левон А.А. ', NULL, NULL, '79856153510', 0, NULL);
INSERT INTO public.contractors VALUES (2037, 1, NULL, NULL, NULL, NULL, NULL, 'Левцов А.С. ', NULL, NULL, '7 978 737 97 15', 0, NULL);
INSERT INTO public.contractors VALUES (2038, 1, NULL, NULL, NULL, NULL, NULL, 'Левченко  79787680729 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2039, 1, NULL, NULL, NULL, NULL, NULL, 'Левченко ВИ 79782062251', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2040, 1, NULL, NULL, NULL, NULL, NULL, 'Левченко Э.Л. ', NULL, NULL, '7978 815 16 96', 0, NULL);
INSERT INTO public.contractors VALUES (2041, 1, NULL, NULL, NULL, NULL, NULL, 'Левченко Ю.Ю ', NULL, NULL, '7 978 745 42 95', 0, NULL);
INSERT INTO public.contractors VALUES (2042, 1, NULL, NULL, NULL, NULL, NULL, 'Левша А.О. ', NULL, NULL, '7978 83 67 594', 0, NULL);
INSERT INTO public.contractors VALUES (2043, 1, NULL, NULL, NULL, NULL, NULL, 'Легерко А.В. ', NULL, NULL, '7978 846 07 09', 0, NULL);
INSERT INTO public.contractors VALUES (2044, 0, NULL, NULL, NULL, NULL, NULL, 'Легион АСК (д.п.) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2045, 1, NULL, NULL, NULL, NULL, NULL, 'Легков А.С. ', NULL, NULL, '7 978 828 5623', 0, NULL);
INSERT INTO public.contractors VALUES (2046, 0, NULL, NULL, NULL, NULL, NULL, 'Леди плюс', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2047, 0, NULL, NULL, NULL, NULL, NULL, 'Лена менеджер', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2048, 0, NULL, NULL, NULL, NULL, NULL, 'Ленур ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2049, 1, NULL, NULL, NULL, NULL, NULL, 'Лёня гибка', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2050, 1, NULL, NULL, NULL, NULL, NULL, 'Леня станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2051, 0, NULL, NULL, NULL, NULL, NULL, 'Леонид ', NULL, NULL, '79787067291', 0, NULL);
INSERT INTO public.contractors VALUES (2052, 0, NULL, NULL, NULL, NULL, NULL, 'Леонид Ялта (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2053, 0, NULL, NULL, NULL, NULL, NULL, 'Леонова Надежда Викторовна', NULL, NULL, '79788870645', 0, NULL);
INSERT INTO public.contractors VALUES (2054, 1, NULL, NULL, NULL, NULL, NULL, 'Леонтьев Г.В. ', NULL, NULL, '79787278577', 0, NULL);
INSERT INTO public.contractors VALUES (2055, 1, NULL, NULL, NULL, NULL, NULL, 'Леонтьев ИВ 79787400712', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2056, 1, NULL, NULL, NULL, NULL, NULL, 'Леонтьев МЮ 79780270224', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2057, 1, NULL, NULL, NULL, NULL, NULL, 'Лепкина В.И. ', NULL, NULL, '7 978 83 99 477', 0, NULL);
INSERT INTO public.contractors VALUES (2058, 1, NULL, NULL, NULL, NULL, NULL, 'Летучий С.В. ', NULL, NULL, '7 978 705 97 48', 0, NULL);
INSERT INTO public.contractors VALUES (2059, 1, NULL, NULL, NULL, NULL, NULL, 'Лешукова Н.Н. ', NULL, NULL, '7 978 85 66 496', 0, NULL);
INSERT INTO public.contractors VALUES (2060, 1, NULL, NULL, NULL, NULL, NULL, 'Лещенко В.П. ', NULL, NULL, '7978 7138 399', 0, NULL);
INSERT INTO public.contractors VALUES (2061, 0, NULL, NULL, NULL, NULL, NULL, 'Лещенко Г.Ф. ', NULL, NULL, '7 978 221 69 98', 0, NULL);
INSERT INTO public.contractors VALUES (2062, 1, NULL, NULL, NULL, NULL, NULL, 'Лещенко ЕА 79787414963', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2063, 0, NULL, NULL, NULL, NULL, NULL, 'Лещенко Максим ', NULL, NULL, '79787342422', 0, NULL);
INSERT INTO public.contractors VALUES (2064, 1, NULL, NULL, NULL, NULL, NULL, 'Лещук Д.Л. ', NULL, NULL, '7 978 71 99 011', 0, NULL);
INSERT INTO public.contractors VALUES (2065, 0, NULL, NULL, NULL, NULL, NULL, 'Лидер Кровли д.п. ', NULL, NULL, '7978 139 29 40 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2066, 0, NULL, NULL, NULL, NULL, NULL, 'Лиман  ', NULL, NULL, '7 978 223 55 30 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2067, 0, NULL, NULL, NULL, NULL, NULL, 'Лиморенко Б.Б. ', NULL, NULL, '7978 819 75 15', 0, NULL);
INSERT INTO public.contractors VALUES (2068, 0, NULL, NULL, NULL, NULL, NULL, 'Лиморенко Н.Г. ', NULL, NULL, '7 978 70 15 780', 0, NULL);
INSERT INTO public.contractors VALUES (2069, 1, NULL, NULL, NULL, NULL, NULL, 'Липилин А.Н. ', NULL, NULL, '7978 898 55 81', 0, NULL);
INSERT INTO public.contractors VALUES (2070, 1, NULL, NULL, NULL, NULL, NULL, 'Липинец В.Г. ', NULL, NULL, '79780053895', 0, NULL);
INSERT INTO public.contractors VALUES (2071, 1, NULL, NULL, NULL, NULL, NULL, 'Липпа ДЮ 79781451587', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2072, 0, NULL, NULL, NULL, NULL, NULL, 'ЛИРЕЙ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2073, 1, NULL, NULL, NULL, NULL, NULL, 'Лисевич ГК 79787263091', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2074, 0, NULL, NULL, NULL, NULL, NULL, 'Лисица Александр ', NULL, NULL, '7978 837-50-96 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2075, 2, NULL, NULL, NULL, NULL, NULL, 'Литвин Б.Н. ', NULL, NULL, '7 978 876 15 98_Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2076, 1, NULL, NULL, NULL, NULL, NULL, 'Литвиненко А.И. ', NULL, NULL, '7978 738 08 02', 0, NULL);
INSERT INTO public.contractors VALUES (2077, 1, NULL, NULL, NULL, NULL, NULL, 'Литвиненко О.А. ', NULL, NULL, '7978 738 08 07', 0, NULL);
INSERT INTO public.contractors VALUES (2078, 1, NULL, NULL, NULL, NULL, NULL, 'Литвиненко Ю.Г. ', NULL, NULL, '7 978 726 51 79', 0, NULL);
INSERT INTO public.contractors VALUES (2079, 1, NULL, NULL, NULL, NULL, NULL, 'Литвинов ДС 79780532942', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2080, 0, NULL, NULL, NULL, NULL, NULL, 'Литвинчук Д.В. ', NULL, NULL, '7978 746 57 27 д.п. (Севастополь)', 0, NULL);
INSERT INTO public.contractors VALUES (2081, 1, NULL, NULL, NULL, NULL, NULL, 'Литовченко АН 79787667659 6528959', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2082, 1, NULL, NULL, NULL, NULL, NULL, 'Лихошерстов Степан ', NULL, NULL, '7 978 091 03 07', 0, NULL);
INSERT INTO public.contractors VALUES (2083, 1, NULL, NULL, NULL, NULL, NULL, 'Лихтнер Л.А. ', NULL, NULL, '79787544631', 0, NULL);
INSERT INTO public.contractors VALUES (2084, 1, NULL, NULL, NULL, NULL, NULL, 'Лищенко АИ 79787785457', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2085, 1, NULL, NULL, NULL, NULL, NULL, 'Лобанов А.Р. ', NULL, NULL, '7 978 147 33 82', 0, NULL);
INSERT INTO public.contractors VALUES (2086, 1, NULL, NULL, NULL, NULL, NULL, 'Лобанов ИА 79787271193', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2087, 1, NULL, NULL, NULL, NULL, NULL, 'Лобанов Л. ', NULL, NULL, '79787875481', 0, NULL);
INSERT INTO public.contractors VALUES (2088, 1, NULL, NULL, NULL, NULL, NULL, 'Лобанов М.Е. ', NULL, NULL, '7 978 748 23 79', 0, NULL);
INSERT INTO public.contractors VALUES (2089, 1, NULL, NULL, NULL, NULL, NULL, 'Лобачев С.И. ', NULL, NULL, '7916 22 22 671', 0, NULL);
INSERT INTO public.contractors VALUES (2090, 1, NULL, NULL, NULL, NULL, NULL, 'Лобачева 79781472007', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2091, 1, NULL, NULL, NULL, NULL, NULL, 'Лобода МП 79787458424', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2092, 1, NULL, NULL, NULL, NULL, NULL, 'Лобода ПА 79789745006', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2093, 1, NULL, NULL, NULL, NULL, NULL, 'Лободин В.С. 8978 731 99 33', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2094, 2, NULL, NULL, NULL, NULL, NULL, 'Логвинчук ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2095, 1, NULL, NULL, NULL, NULL, NULL, 'Логинов Илья Александрович-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2096, 2, NULL, NULL, NULL, NULL, NULL, 'Логинова Т. А.  ИП Цемдолина', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2097, 1, NULL, NULL, NULL, NULL, NULL, 'Лозицкий В.Н. ', NULL, NULL, '7978 77 56 103', 0, NULL);
INSERT INTO public.contractors VALUES (2098, 1, NULL, NULL, NULL, NULL, NULL, 'Лозовой ОИ 79787431932', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2099, 1, NULL, NULL, NULL, NULL, NULL, 'Локотош СА 79787631006', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2100, 1, NULL, NULL, NULL, NULL, NULL, 'Лола СА 79785404115', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2101, 1, NULL, NULL, NULL, NULL, NULL, 'Ломакина Ю.П. ', NULL, NULL, '79787569762', 0, NULL);
INSERT INTO public.contractors VALUES (2102, 0, NULL, NULL, NULL, NULL, NULL, 'Лопушков В.Ю. ', NULL, NULL, '7 988 002 91 99', 0, NULL);
INSERT INTO public.contractors VALUES (2103, 0, NULL, NULL, NULL, NULL, NULL, 'Лоскутов А.Ю. ', NULL, NULL, '7 978 75 08 797', 0, NULL);
INSERT INTO public.contractors VALUES (2104, 0, NULL, NULL, NULL, NULL, NULL, 'Лось М.В. ', NULL, NULL, '7978 791 88 80', 0, NULL);
INSERT INTO public.contractors VALUES (2105, 0, NULL, NULL, NULL, NULL, NULL, 'Лоцман ', NULL, NULL, '79787832001 Андрей ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2106, 0, NULL, NULL, NULL, NULL, 910201001, 'ЛСТК-Групп ', NULL, NULL, '7 989 731 4111 Наталья (д.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (2107, 0, NULL, NULL, NULL, NULL, NULL, 'Лубенецкий В.В. ', NULL, NULL, '7 978 756 84 79', 0, NULL);
INSERT INTO public.contractors VALUES (2108, 1, NULL, NULL, NULL, NULL, NULL, 'Лубинец В.Д. ', NULL, NULL, '7978 7222 374', 0, NULL);
INSERT INTO public.contractors VALUES (2109, 1, NULL, NULL, NULL, NULL, NULL, 'Лубяной Юра ', NULL, NULL, '7 978 056 30 31 (д.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (2110, 1, NULL, NULL, NULL, NULL, NULL, 'Лужецкий Ю.А. ', NULL, NULL, '7 978 80 77 348', 0, NULL);
INSERT INTO public.contractors VALUES (2111, 0, NULL, NULL, NULL, NULL, NULL, 'Лузянин Н.Н. ', NULL, NULL, '7978 131 62 50', 0, NULL);
INSERT INTO public.contractors VALUES (2112, 1, NULL, NULL, NULL, NULL, NULL, 'Лукманов ЮГ 89871449000', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2113, 0, NULL, NULL, NULL, NULL, NULL, 'Лукьяненко Алексей ', NULL, NULL, '79781439545', 0, NULL);
INSERT INTO public.contractors VALUES (2114, 1, NULL, NULL, NULL, NULL, NULL, 'Лукьянов Алексей ', NULL, NULL, '79789396123', 0, NULL);
INSERT INTO public.contractors VALUES (2115, 1, NULL, NULL, NULL, NULL, NULL, 'Лукьянова Любовь ', NULL, NULL, '79787130912', 0, NULL);
INSERT INTO public.contractors VALUES (2116, 1, NULL, NULL, NULL, NULL, NULL, 'Луньков АИ ', NULL, NULL, '79788575956 79787109913', 0, NULL);
INSERT INTO public.contractors VALUES (2117, 1, NULL, NULL, NULL, NULL, NULL, 'Лупачев ВИ 79788387260', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2118, 0, NULL, NULL, NULL, NULL, NULL, 'Лупачев Владимир Ильич ', NULL, NULL, '7 978 720 35 08', 0, NULL);
INSERT INTO public.contractors VALUES (2119, 0, NULL, NULL, NULL, NULL, NULL, 'Лупинос А.В. ', NULL, NULL, '7 978 723 23 73', 0, NULL);
INSERT INTO public.contractors VALUES (2120, 1, NULL, NULL, NULL, NULL, NULL, 'Лусков И.Н. ', NULL, NULL, '7918 624 87 85', 0, NULL);
INSERT INTO public.contractors VALUES (2121, 0, NULL, NULL, NULL, NULL, NULL, 'Луцюк В.А. ', NULL, NULL, '79788165665', 0, NULL);
INSERT INTO public.contractors VALUES (2122, 1, NULL, NULL, NULL, NULL, NULL, 'Лущан Н.Н. ', NULL, NULL, '79787222595', 0, NULL);
INSERT INTO public.contractors VALUES (2123, 1, NULL, NULL, NULL, NULL, NULL, 'Лызлов Олег ', NULL, NULL, '7978 9002 27 20', 0, NULL);
INSERT INTO public.contractors VALUES (2124, 0, NULL, NULL, NULL, NULL, NULL, 'Лысаков  Сергей ', NULL, NULL, '7 918 187 56 55', 0, NULL);
INSERT INTO public.contractors VALUES (2125, 1, NULL, NULL, NULL, NULL, NULL, 'Лысакова Л.В 8-978-25-99-077', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2126, 0, NULL, NULL, NULL, NULL, NULL, 'Лысенко  (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2127, 0, NULL, NULL, NULL, NULL, NULL, 'Лысенко (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2128, 1, NULL, NULL, NULL, NULL, NULL, 'Лысенко 79781430509', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2129, 1, NULL, NULL, NULL, NULL, NULL, 'Лысенко А.С. ', NULL, NULL, '7 978 729 89 07', 0, NULL);
INSERT INTO public.contractors VALUES (2130, 1, NULL, NULL, NULL, NULL, NULL, 'Лысенко ВА 79787139505', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2131, 1, NULL, NULL, NULL, NULL, NULL, 'Лысов АС 79787209132', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2132, 1, NULL, NULL, NULL, NULL, NULL, 'Любарская И.В. ', NULL, NULL, '7978 753 67 32', 0, NULL);
INSERT INTO public.contractors VALUES (2133, 2, NULL, NULL, NULL, NULL, NULL, 'Любибратич Михаил Валентинович СтройМаг (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2134, 1, NULL, NULL, NULL, NULL, NULL, 'Любкевич ВН 79787720021', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2135, 1, NULL, NULL, NULL, NULL, NULL, 'Любченко А.В. ', NULL, NULL, '7978 746 97 19', 0, NULL);
INSERT INTO public.contractors VALUES (2136, 0, NULL, NULL, NULL, NULL, NULL, 'Любченко Александр ', NULL, NULL, '79787073668', 0, NULL);
INSERT INTO public.contractors VALUES (2137, 1, NULL, NULL, NULL, NULL, NULL, 'Людкевич Юрий Александрович ', NULL, NULL, '7978 89 62 414', 0, NULL);
INSERT INTO public.contractors VALUES (2138, 1, NULL, NULL, NULL, NULL, NULL, 'Людмила ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2139, 1, NULL, NULL, NULL, NULL, NULL, 'Люман ', NULL, NULL, '7 978 854 55 71', 0, NULL);
INSERT INTO public.contractors VALUES (2140, 0, NULL, NULL, NULL, NULL, NULL, 'Люманов ', NULL, NULL, '7 978 706 28 89', 0, NULL);
INSERT INTO public.contractors VALUES (2141, 1, NULL, NULL, NULL, NULL, NULL, 'Люманов Арсен ', NULL, NULL, '7978 79 14 939 (д.п) Ан', 0, NULL);
INSERT INTO public.contractors VALUES (2142, 1, NULL, NULL, NULL, NULL, NULL, 'Люмаренко Н.Г. ', NULL, NULL, '7 978 701 57 80', 0, NULL);
INSERT INTO public.contractors VALUES (2143, 1, NULL, NULL, NULL, NULL, NULL, 'Люсин МН 79787518263', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2144, 1, NULL, NULL, NULL, NULL, NULL, 'Лямина Н.И. ', NULL, NULL, '7978 018 61 75', 0, NULL);
INSERT INTO public.contractors VALUES (2145, 1, NULL, NULL, NULL, NULL, NULL, 'Лях Н.В. ', NULL, NULL, '7 978 771 77 48 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2146, 1, NULL, NULL, NULL, NULL, NULL, 'Ляхов В.А. ', NULL, NULL, '7 978 209 87 68', 0, NULL);
INSERT INTO public.contractors VALUES (2147, 1, NULL, NULL, NULL, NULL, NULL, 'Ляхов О.В. ', NULL, NULL, '7 978 723 00 35', 0, NULL);
INSERT INTO public.contractors VALUES (2148, 1, NULL, NULL, NULL, NULL, NULL, 'Ляшенко Наталья Томсовна ', NULL, NULL, '7978 77 29 807', 0, NULL);
INSERT INTO public.contractors VALUES (2149, 1, NULL, NULL, NULL, NULL, NULL, 'Ляшенко НЮ 79788053928', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2150, 1, NULL, NULL, NULL, NULL, NULL, 'Лященко Юрий ', NULL, NULL, '7978 71 806 49', 0, NULL);
INSERT INTO public.contractors VALUES (2151, 1, NULL, NULL, NULL, NULL, NULL, 'Мавлютов Мустафа ', NULL, NULL, '79780637920', 0, NULL);
INSERT INTO public.contractors VALUES (2152, 1, NULL, NULL, NULL, NULL, NULL, 'Маврин С.Н. ', NULL, NULL, '7 978 828 85 49', 0, NULL);
INSERT INTO public.contractors VALUES (2153, 0, NULL, NULL, NULL, NULL, NULL, 'Маг.Хозяин. (И) Ялта 8-978-781-32-53 Роман', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2154, 0, NULL, NULL, NULL, NULL, NULL, 'Магазин Деревяшка (Саки) ', NULL, NULL, '7978 077 49 70', 0, NULL);
INSERT INTO public.contractors VALUES (2155, 0, NULL, NULL, NULL, NULL, NULL, 'Магазин Крепеж', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2156, 2, NULL, NULL, NULL, NULL, NULL, 'Магазин Перестройка (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2157, 2, NULL, NULL, NULL, NULL, NULL, 'Магазин Севастополь', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2158, 0, NULL, NULL, NULL, NULL, NULL, 'Магазин Симферополь Глинки', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2159, 1, NULL, NULL, NULL, NULL, NULL, 'Магазин Феодосия', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2160, 0, NULL, NULL, NULL, NULL, NULL, 'Магазин Эпицентр Глинки', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2161, 1, NULL, NULL, NULL, NULL, NULL, 'Магдыч ДВ 79787402576', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2162, 1, NULL, NULL, NULL, NULL, NULL, 'Маглич ДВ 79787402576', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2163, 0, NULL, NULL, NULL, NULL, NULL, 'Магомедов Расул ', NULL, NULL, ' 7 978 257 16 11', 0, NULL);
INSERT INTO public.contractors VALUES (2164, 0, NULL, NULL, NULL, NULL, NULL, 'Мажаров Алексей ', NULL, NULL, '7 978 808 19 18', 0, NULL);
INSERT INTO public.contractors VALUES (2165, 1, NULL, NULL, NULL, NULL, NULL, 'Мазинов В.В. ', NULL, NULL, '7 978 722 62 43', 0, NULL);
INSERT INTO public.contractors VALUES (2166, 1, NULL, NULL, NULL, NULL, NULL, 'Мазлин А.И.', NULL, NULL, '79787064209', 0, NULL);
INSERT INTO public.contractors VALUES (2167, 0, NULL, NULL, NULL, NULL, NULL, 'Мазун С.Е. ', NULL, NULL, '7 978 735 72 89', 0, NULL);
INSERT INTO public.contractors VALUES (2168, 1, NULL, NULL, NULL, NULL, NULL, 'Мазур ', NULL, NULL, '7978 128 4230 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2169, 1, NULL, NULL, NULL, NULL, NULL, 'Мазур Н.М, ', NULL, NULL, '7978 133 12 75', 0, NULL);
INSERT INTO public.contractors VALUES (2170, 1, NULL, NULL, NULL, NULL, NULL, 'Мазур Н.С. ', NULL, NULL, '7 978 77 10 884', 0, NULL);
INSERT INTO public.contractors VALUES (2171, 0, NULL, NULL, NULL, NULL, NULL, 'Мазур Наталья ', NULL, NULL, '79781331275', 0, NULL);
INSERT INTO public.contractors VALUES (2172, 0, NULL, NULL, NULL, NULL, NULL, 'Майоров Юрий Александрович ', NULL, NULL, '79787540214', 0, NULL);
INSERT INTO public.contractors VALUES (2173, 1, NULL, NULL, NULL, NULL, NULL, 'Майстренко В.П. ', NULL, NULL, '7 978 807 52 65', 0, NULL);
INSERT INTO public.contractors VALUES (2174, 2, NULL, NULL, NULL, NULL, NULL, 'Майстренко ИН 79787725413  79158500321 вл вик ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2175, 1, NULL, NULL, NULL, NULL, NULL, 'Макаренко А.А. ', NULL, NULL, '7 978 870 34 70', 0, NULL);
INSERT INTO public.contractors VALUES (2176, 1, NULL, NULL, NULL, NULL, NULL, 'Макаренко АА79788703470', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2177, 1, NULL, NULL, NULL, NULL, NULL, 'Макаров ВА 79787397441', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2178, 1, NULL, NULL, NULL, NULL, NULL, 'Макаров И.А. ', NULL, NULL, '7978 123 04 17 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2179, 1, NULL, NULL, NULL, NULL, NULL, 'Макаров ПВ 79787504250', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2180, 1, NULL, NULL, NULL, NULL, NULL, 'Макеев АА 79788088464', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2181, 1, NULL, NULL, NULL, NULL, NULL, 'Макивский НН 79787060127', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2182, 1, NULL, NULL, NULL, NULL, NULL, 'Макиевский НВ 79787282298', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2183, 1, NULL, NULL, NULL, NULL, NULL, 'Макляк ВВ 79787521350', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2184, 1, NULL, NULL, NULL, NULL, NULL, 'Маковский В.А. ', NULL, NULL, '7978 067 70 27', 0, NULL);
INSERT INTO public.contractors VALUES (2185, 1, NULL, NULL, NULL, NULL, NULL, 'Макс станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2186, 1, NULL, NULL, NULL, NULL, NULL, 'Максименко В.В. ', NULL, NULL, '7 978 879 25 22', 0, NULL);
INSERT INTO public.contractors VALUES (2187, 1, NULL, NULL, NULL, NULL, NULL, 'Максименко Д.Н. ', NULL, NULL, '7 978 701 74 34', 0, NULL);
INSERT INTO public.contractors VALUES (2188, 0, NULL, NULL, NULL, NULL, NULL, 'Максимов Владимир ', NULL, NULL, '79788447797', 0, NULL);
INSERT INTO public.contractors VALUES (2189, 1, NULL, NULL, NULL, NULL, NULL, 'Максимов Г.И ', NULL, NULL, '7 978 050 47 79', 0, NULL);
INSERT INTO public.contractors VALUES (2190, 1, NULL, NULL, NULL, NULL, NULL, 'Максимов ЕВ 79787902717', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2191, 1, NULL, NULL, NULL, NULL, NULL, 'Максимова ЖН 79787894930', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2192, 0, NULL, NULL, NULL, NULL, NULL, 'Максимум ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2193, 0, NULL, NULL, NULL, NULL, 920401001, 'МАКСИМУМ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2194, 0, NULL, NULL, NULL, NULL, 910201001, '"МАКСИМУМ"", Иван Леонидович ', NULL, NULL, '79780810833 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (2195, 1, NULL, NULL, NULL, NULL, NULL, 'Максутов РР79787519513', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2196, 0, NULL, NULL, NULL, NULL, NULL, 'Максюта ', NULL, NULL, ' 7 978 136 30 75 _А.', 0, NULL);
INSERT INTO public.contractors VALUES (2197, 1, NULL, NULL, NULL, NULL, NULL, 'Макутов Эдем ', NULL, NULL, '7 978 856 00 59', 0, NULL);
INSERT INTO public.contractors VALUES (2198, 1, NULL, NULL, NULL, NULL, NULL, 'Макуха ВВ 79787255384', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2199, 0, NULL, NULL, NULL, NULL, NULL, 'Макухин С.В. ', NULL, NULL, '7 978 78 07 782', 0, NULL);
INSERT INTO public.contractors VALUES (2200, 1, NULL, NULL, NULL, NULL, NULL, 'Макухин СА ', NULL, NULL, '79787529080', 0, NULL);
INSERT INTO public.contractors VALUES (2201, 2, NULL, NULL, NULL, NULL, NULL, 'Малаева Ольга Александровна -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2202, 1, NULL, NULL, NULL, NULL, NULL, 'Малакеев АА 79787731186', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2203, 1, NULL, NULL, NULL, NULL, NULL, 'Малец А.В. ', NULL, NULL, '7 978 77 03 513', 0, NULL);
INSERT INTO public.contractors VALUES (2204, 1, NULL, NULL, NULL, NULL, NULL, 'Малий А.А. ', NULL, NULL, '7 978 870 37 32', 0, NULL);
INSERT INTO public.contractors VALUES (2205, 1, NULL, NULL, NULL, NULL, NULL, 'Малий ВМ 79788461209', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2206, 1, NULL, NULL, NULL, NULL, NULL, 'Малина ЮН 79787569311', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2207, 0, NULL, NULL, NULL, NULL, NULL, 'Малинова О.В. ', NULL, NULL, '7 978 84 22 917', 0, NULL);
INSERT INTO public.contractors VALUES (2208, 1, NULL, NULL, NULL, NULL, NULL, 'Малишевская Д.В., ', NULL, NULL, '7 978 262 29 66', 0, NULL);
INSERT INTO public.contractors VALUES (2209, 0, NULL, NULL, NULL, NULL, NULL, 'Маловичко Л.Л. ', NULL, NULL, '7 978 75 60 616', 0, NULL);
INSERT INTO public.contractors VALUES (2210, 1, NULL, NULL, NULL, NULL, NULL, 'Малышев 79787400637', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2211, 0, NULL, NULL, NULL, NULL, NULL, 'Малышевский Виталий ', NULL, NULL, '7 978 74 33 962', 0, NULL);
INSERT INTO public.contractors VALUES (2212, 1, NULL, NULL, NULL, NULL, NULL, 'Малышкина НА 89626771717 89626761717', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2213, 0, NULL, NULL, NULL, NULL, NULL, 'Мальнев Леонид (Севастополь)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2214, 1, NULL, NULL, NULL, NULL, NULL, 'Мальцев 79787380686', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2215, 1, NULL, NULL, NULL, NULL, NULL, 'Мальченко СС 79787238773', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2216, 1, NULL, NULL, NULL, NULL, NULL, 'Мамаев АА 79788834216.15', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2217, 1, NULL, NULL, NULL, NULL, NULL, 'Мамалат О.Н. ', NULL, NULL, '7978 827 10 30', 0, NULL);
INSERT INTO public.contractors VALUES (2218, 1, NULL, NULL, NULL, NULL, NULL, 'Мамбед Али ', NULL, NULL, '7 978 72 37 840', 0, NULL);
INSERT INTO public.contractors VALUES (2219, 1, NULL, NULL, NULL, NULL, NULL, 'Мамбедалиев И.Ф. ', NULL, NULL, '7978 72 37 840', 0, NULL);
INSERT INTO public.contractors VALUES (2220, 1, NULL, NULL, NULL, NULL, NULL, 'Мамбедиев ЛА 79781476300', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2221, 1, NULL, NULL, NULL, NULL, NULL, 'Мамбетов Алим ', NULL, NULL, '7 978 871 72 82', 0, NULL);
INSERT INTO public.contractors VALUES (2222, 1, NULL, NULL, NULL, NULL, NULL, 'Мамбетов АТ 79787568500', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2223, 1, NULL, NULL, NULL, NULL, NULL, 'Мамбетов Э.А. ', NULL, NULL, '7978 271 45 39', 0, NULL);
INSERT INTO public.contractors VALUES (2224, 1, NULL, NULL, NULL, NULL, NULL, 'Мамедов Р.А. ', NULL, NULL, '7 978 003 81 67', 0, NULL);
INSERT INTO public.contractors VALUES (2225, 0, NULL, NULL, NULL, NULL, NULL, 'Мамедов С.С. ', NULL, NULL, '7 978 773 77 10', 0, NULL);
INSERT INTO public.contractors VALUES (2226, 1, NULL, NULL, NULL, NULL, NULL, 'Мамедова Н.Н, ', NULL, NULL, '7 914 098 16 32', 0, NULL);
INSERT INTO public.contractors VALUES (2227, 0, NULL, NULL, NULL, NULL, NULL, 'Мамонова Галина Евгеньевна ', NULL, NULL, '7 978 835 32 39(38)', 0, NULL);
INSERT INTO public.contractors VALUES (2228, 1, NULL, NULL, NULL, NULL, NULL, 'Мамонтов И.А. ', NULL, NULL, '7 978 709 24 31', 0, NULL);
INSERT INTO public.contractors VALUES (2229, 1, NULL, NULL, NULL, NULL, NULL, 'Мамутов А.С. ', NULL, NULL, '7978 793 19 04', 0, NULL);
INSERT INTO public.contractors VALUES (2230, 1, NULL, NULL, NULL, NULL, NULL, 'Мамутов Ильяс ', NULL, NULL, '7978 715 92 52', 0, NULL);
INSERT INTO public.contractors VALUES (2231, 1, NULL, NULL, NULL, NULL, NULL, 'Мамутов К.К. ', NULL, NULL, '7 978 77 04 718', 0, NULL);
INSERT INTO public.contractors VALUES (2232, 1, NULL, NULL, NULL, NULL, NULL, 'Мамутов Р.Ш. ', NULL, NULL, '7 913 554 21 48', 0, NULL);
INSERT INTO public.contractors VALUES (2233, 1, NULL, NULL, NULL, NULL, NULL, 'Мамутов Э.А. ', NULL, NULL, '7 978 067 68 48', 0, NULL);
INSERT INTO public.contractors VALUES (2234, 1, NULL, NULL, NULL, NULL, NULL, 'Мамутов Э.М. 8-978-856-00-59', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2235, 1, NULL, NULL, NULL, NULL, NULL, 'Мамчич НС 79787339457', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2236, 2, NULL, NULL, NULL, NULL, NULL, 'Мамчур Константин Владимирович -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2237, 1, NULL, NULL, NULL, NULL, NULL, 'Мангул БС 79788609166', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2238, 0, NULL, NULL, NULL, NULL, NULL, 'Мандрик Т.Ю. ', NULL, NULL, '79787403722', 0, NULL);
INSERT INTO public.contractors VALUES (2239, 1, NULL, NULL, NULL, NULL, NULL, 'Манкиев МУ 79787718599', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2240, 1, NULL, NULL, NULL, NULL, NULL, 'Манойло АА 79781265980', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2241, 1, NULL, NULL, NULL, NULL, NULL, 'Марамзин ВА 79787527502', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2242, 1, NULL, NULL, NULL, NULL, NULL, 'Марат ', NULL, NULL, '79780986557', 0, NULL);
INSERT INTO public.contractors VALUES (2243, 1, NULL, NULL, NULL, NULL, NULL, 'Марачканич Виталий Николаевич ', NULL, NULL, '7978 84 67 931', 0, NULL);
INSERT INTO public.contractors VALUES (2244, 1, NULL, NULL, NULL, NULL, NULL, 'Маргульчак ВН 79787316352', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2245, 1, NULL, NULL, NULL, NULL, NULL, 'Маринянский ДМ 79787078157', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2246, 0, NULL, NULL, NULL, NULL, NULL, 'Мария Григорьевна ', NULL, NULL, '7 978 029 95 45 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2247, 1, NULL, NULL, NULL, NULL, NULL, 'Маркарян АА 79787653739', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2248, 1, NULL, NULL, NULL, NULL, NULL, 'Маркевич Э.Г. ', NULL, NULL, '7 978 781 59 46', 0, NULL);
INSERT INTO public.contractors VALUES (2249, 0, NULL, NULL, NULL, NULL, NULL, 'Маркелов Сергей (Саки) ИП (д.п.) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2250, 1, NULL, NULL, NULL, NULL, NULL, 'Маркин Ю.В. ', NULL, NULL, '7 978 751 05 33', 0, NULL);
INSERT INTO public.contractors VALUES (2251, 1, NULL, NULL, NULL, NULL, NULL, 'Марков МО 79781003395', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2252, 0, NULL, NULL, NULL, NULL, NULL, 'Марковская С.П.', NULL, NULL, '79787917456', 0, NULL);
INSERT INTO public.contractors VALUES (2253, 1, NULL, NULL, NULL, NULL, NULL, 'Марковская СП 7978791745   6', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2254, 1, NULL, NULL, NULL, NULL, NULL, 'Марковцев П.А. ', NULL, NULL, '7 978 7612 702', 0, NULL);
INSERT INTO public.contractors VALUES (2255, 0, NULL, NULL, NULL, NULL, NULL, 'Маркульча В.Н.', NULL, NULL, '79787316352', 0, NULL);
INSERT INTO public.contractors VALUES (2256, 1, NULL, NULL, NULL, NULL, NULL, 'Марлен д.п ', NULL, NULL, '79785859859', 0, NULL);
INSERT INTO public.contractors VALUES (2257, 1, NULL, NULL, NULL, NULL, NULL, 'Мароз М.Ю ', NULL, NULL, '79788573406', 0, NULL);
INSERT INTO public.contractors VALUES (2258, 0, NULL, NULL, NULL, NULL, NULL, 'Марочканич ', NULL, NULL, '79788467931', 0, NULL);
INSERT INTO public.contractors VALUES (2259, 0, NULL, NULL, NULL, NULL, NULL, 'Мартеросян А.В. ', NULL, NULL, '7 978 76 77 200', 0, NULL);
INSERT INTO public.contractors VALUES (2260, 1, NULL, NULL, NULL, NULL, NULL, 'Мартиросян Станислав ', NULL, NULL, '7978 863 62 56', 0, NULL);
INSERT INTO public.contractors VALUES (2261, 1, NULL, NULL, NULL, NULL, NULL, 'Мартыненко И.К. 89181586811', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2262, 0, NULL, NULL, NULL, NULL, NULL, 'Мартынов Ю.С. ', NULL, NULL, '7978 802 55 38', 0, NULL);
INSERT INTO public.contractors VALUES (2263, 2, NULL, NULL, NULL, NULL, NULL, 'Мартынов Юрий Владимирович ( ЗДМС ), Сергей ', NULL, NULL, '7 978 767 01 96 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2264, 1, NULL, NULL, NULL, NULL, NULL, 'Мартынюк А.А. ', NULL, NULL, '7978 720 98 84', 0, NULL);
INSERT INTO public.contractors VALUES (2265, 1, NULL, NULL, NULL, NULL, NULL, 'Мартынюк ИА 79787249093', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2266, 0, NULL, NULL, NULL, NULL, NULL, 'Марусенко Юрий ', NULL, NULL, '7 978 738 16 28', 0, NULL);
INSERT INTO public.contractors VALUES (2267, 1, NULL, NULL, NULL, NULL, NULL, 'Марущак И.И. ', NULL, NULL, '7978 82 41 821', 0, NULL);
INSERT INTO public.contractors VALUES (2268, 1, NULL, NULL, NULL, NULL, NULL, 'Марченко АА 79780412491', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2269, 1, NULL, NULL, NULL, NULL, NULL, 'Марченко В.В. ', NULL, NULL, '7 978 805 87 32', 0, NULL);
INSERT INTO public.contractors VALUES (2270, 1, NULL, NULL, NULL, NULL, NULL, 'Маршук Ю.М. ', NULL, NULL, '7 978 765 37 92', 0, NULL);
INSERT INTO public.contractors VALUES (2271, 1, NULL, NULL, NULL, NULL, NULL, 'Масковой Виктор АЛЕКСАНДРОВИЧ ', NULL, NULL, '79788087797', 0, NULL);
INSERT INTO public.contractors VALUES (2272, 1, NULL, NULL, NULL, NULL, NULL, 'Масливец М.П. ', NULL, NULL, '79787525384', 0, NULL);
INSERT INTO public.contractors VALUES (2273, 1, NULL, NULL, NULL, NULL, NULL, 'Маслов В.А. ', NULL, NULL, '7978 72 33 286', 0, NULL);
INSERT INTO public.contractors VALUES (2274, 1, NULL, NULL, NULL, NULL, NULL, 'Маслов ПА 79787339534', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2275, 0, NULL, NULL, NULL, NULL, NULL, 'Маслов. Алушта ул. Виноградная, 7а _ И. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2276, 2, NULL, NULL, NULL, NULL, NULL, 'Мастер Алушта', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2277, 1, NULL, NULL, NULL, NULL, NULL, 'Маташков А.В. ', NULL, NULL, '7 978 745 76 58', 0, NULL);
INSERT INTO public.contractors VALUES (2278, 0, NULL, NULL, NULL, NULL, NULL, 'Матвеев Виктор Миронович ', NULL, NULL, '79781201421', 0, NULL);
INSERT INTO public.contractors VALUES (2279, 0, NULL, NULL, NULL, NULL, NULL, 'Матвеева Е.Н. ', NULL, NULL, '7 978 145 52 17', 0, NULL);
INSERT INTO public.contractors VALUES (2280, 0, NULL, NULL, NULL, NULL, NULL, 'Матвиенко Сергей ', NULL, NULL, '7 978 7235299', 0, NULL);
INSERT INTO public.contractors VALUES (2281, 1, NULL, NULL, NULL, NULL, NULL, 'Матевосян АД 79787841119', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2282, 1, NULL, NULL, NULL, NULL, NULL, 'Матлашова ЕИ 797878055904', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2283, 1, NULL, NULL, NULL, NULL, NULL, 'Матрахов Максим ', NULL, NULL, '7 978 835 79 09', 0, NULL);
INSERT INTO public.contractors VALUES (2284, 2, NULL, NULL, NULL, NULL, NULL, 'Матрос  Руслан ', NULL, NULL, '7 978 708 52 93 _Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2285, 0, NULL, NULL, NULL, NULL, NULL, 'МАФ ', NULL, NULL, '7 978 048 03 28', 0, NULL);
INSERT INTO public.contractors VALUES (2286, 0, NULL, NULL, NULL, NULL, NULL, 'МАФ ', NULL, NULL, '7 978 048 03 28 ( И )', 0, NULL);
INSERT INTO public.contractors VALUES (2287, 0, NULL, NULL, NULL, NULL, NULL, 'Маханько А.Е. ', NULL, NULL, '7 978 22 24 707', 0, NULL);
INSERT INTO public.contractors VALUES (2288, 1, NULL, NULL, NULL, NULL, NULL, 'Махоткин Г.Г ', NULL, NULL, '79781270339', 0, NULL);
INSERT INTO public.contractors VALUES (2289, 1, NULL, NULL, NULL, NULL, NULL, 'Мацеба В.А. ', NULL, NULL, '79787826410', 0, NULL);
INSERT INTO public.contractors VALUES (2290, 0, NULL, NULL, NULL, NULL, NULL, 'Мачнев Вячеслав ', NULL, NULL, '79789397137', 0, NULL);
INSERT INTO public.contractors VALUES (2291, 1, NULL, NULL, NULL, NULL, NULL, 'Машко ВН 79780426072', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2292, 0, NULL, NULL, NULL, NULL, NULL, 'Мегаполисстрой 89139341306 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2293, 2, NULL, NULL, NULL, NULL, NULL, 'Мегдаль Николай Викторович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2294, 1, NULL, NULL, NULL, NULL, NULL, 'Медат ', NULL, NULL, '7978 742 86 13', 0, NULL);
INSERT INTO public.contractors VALUES (2295, 1, NULL, NULL, NULL, NULL, NULL, 'Медведева Татьяна Николаевна ', NULL, NULL, '79787223031', 0, NULL);
INSERT INTO public.contractors VALUES (2296, 1, NULL, NULL, NULL, NULL, NULL, 'МедВейстКрым ', NULL, NULL, '7 978 789 23 55 Денис ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2297, 0, NULL, NULL, NULL, NULL, NULL, 'Меджитов Усеин ', NULL, NULL, '7 978 012 5556', 0, NULL);
INSERT INTO public.contractors VALUES (2298, 0, NULL, NULL, NULL, NULL, 910201001, 'Медтехника ООО', NULL, 6878962, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2299, 1, NULL, NULL, NULL, NULL, NULL, 'Межлумян К.Р. ', NULL, NULL, '7 978 03 99 304', 0, NULL);
INSERT INTO public.contractors VALUES (2300, NULL, NULL, NULL, NULL, NULL, 235301001, 'Межрайонная ИФНС России № 10 по Краснодарскому краю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2301, NULL, NULL, NULL, NULL, NULL, 231001001, 'Межрайонная ИФНС России № 16 по Краснодарскому краю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2302, NULL, NULL, NULL, NULL, NULL, 237601001, 'Межрайонная ИФНС России № 17 по Краснодарскому краю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2303, NULL, NULL, NULL, NULL, NULL, 230301001, 'Межрайонная ИФНС России №9 по Краснодарскому краю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2304, 0, NULL, NULL, NULL, NULL, NULL, 'Мезга Владимир ', NULL, NULL, '7 987 5230794', 0, NULL);
INSERT INTO public.contractors VALUES (2305, 1, NULL, NULL, NULL, NULL, NULL, 'Мезинов А.А. ', NULL, NULL, '7 978 818 44 91 (д.п.) Крымск строит группа', 0, NULL);
INSERT INTO public.contractors VALUES (2306, 0, NULL, NULL, NULL, NULL, NULL, 'Мезько Михаил Станиславович ', NULL, NULL, '79787515558', 0, NULL);
INSERT INTO public.contractors VALUES (2307, 0, NULL, NULL, NULL, NULL, 230901001, 'МЕКАМ ООО - А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2308, 1, NULL, NULL, NULL, NULL, NULL, 'Мелешков АВ 79787680611', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2309, 1, NULL, NULL, NULL, NULL, NULL, 'Мелконов Л.Г. ', NULL, NULL, '7 978 890 83 45', 0, NULL);
INSERT INTO public.contractors VALUES (2310, 1, NULL, NULL, NULL, NULL, NULL, 'Мельник АМ 79782198026', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2311, 1, NULL, NULL, NULL, NULL, NULL, 'Мельник В.Л. ', NULL, NULL, '7 978 02 84 521', 0, NULL);
INSERT INTO public.contractors VALUES (2312, 0, NULL, NULL, NULL, NULL, NULL, 'Мельник Василий Анатольевич ', NULL, NULL, '7978 745 75 17', 0, NULL);
INSERT INTO public.contractors VALUES (2313, 1, NULL, NULL, NULL, NULL, NULL, 'Мельник П.Ф. ', NULL, NULL, '7 978 748 48 51', 0, NULL);
INSERT INTO public.contractors VALUES (2314, 0, NULL, NULL, NULL, NULL, NULL, 'Мельников ', NULL, NULL, '7 978 817 61 16', 0, NULL);
INSERT INTO public.contractors VALUES (2315, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников А.В. ', NULL, NULL, '7 978 783 20 13', 0, NULL);
INSERT INTO public.contractors VALUES (2316, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников Анатолий Петрович ', NULL, NULL, '7978 794 56 58', 0, NULL);
INSERT INTO public.contractors VALUES (2317, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников В.Е ', NULL, NULL, '79787317778 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (2318, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников В.И. ', NULL, NULL, '7 978 817 6116', 0, NULL);
INSERT INTO public.contractors VALUES (2319, 0, NULL, NULL, NULL, NULL, NULL, 'Мельников В.Н. ', NULL, NULL, '7 978 70 811 80', 0, NULL);
INSERT INTO public.contractors VALUES (2320, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников Д.С. ', NULL, NULL, '7978 743 8 153', 0, NULL);
INSERT INTO public.contractors VALUES (2321, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников МЛ 79785713649', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2322, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников СВ 79788171229', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2323, 1, NULL, NULL, NULL, NULL, NULL, 'Мельников Ю.А. ', NULL, NULL, '7 978 722 54 19', 0, NULL);
INSERT INTO public.contractors VALUES (2324, 1, NULL, NULL, NULL, NULL, NULL, 'Мельниченко Е.А. ', NULL, NULL, '79787524903', 0, NULL);
INSERT INTO public.contractors VALUES (2325, 0, NULL, NULL, NULL, NULL, NULL, 'Мельязов Дилявер ', NULL, NULL, '7 978 78 38 009', 0, NULL);
INSERT INTO public.contractors VALUES (2326, 1, NULL, NULL, NULL, NULL, NULL, 'Меметов Ильяс ', NULL, NULL, '7 978 268 85 24', 0, NULL);
INSERT INTO public.contractors VALUES (2327, 1, NULL, NULL, NULL, NULL, NULL, 'Меметов Ленур ', NULL, NULL, '7978 74 83 143 ДП (Ан)', 0, NULL);
INSERT INTO public.contractors VALUES (2328, 1, NULL, NULL, NULL, NULL, NULL, 'Меметов Мустафа ', NULL, NULL, '7 978 862 35 04', 0, NULL);
INSERT INTO public.contractors VALUES (2329, 1, NULL, NULL, NULL, NULL, NULL, 'Меметов Рустем ', NULL, NULL, '7 978 714 93 48', 0, NULL);
INSERT INTO public.contractors VALUES (2330, 0, NULL, NULL, NULL, NULL, NULL, 'Меметов С.М.', NULL, NULL, '79787855720', 0, NULL);
INSERT INTO public.contractors VALUES (2331, 1, NULL, NULL, NULL, NULL, NULL, 'Меметов Ф.Ш. ', NULL, NULL, '7 978 898 24 54', 0, NULL);
INSERT INTO public.contractors VALUES (2332, 1, NULL, NULL, NULL, NULL, NULL, 'Меметов Х 79788812778', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2333, 1, NULL, NULL, NULL, NULL, NULL, 'Меметулаев Э.И. ', NULL, NULL, '7978 06 006 96', 0, NULL);
INSERT INTO public.contractors VALUES (2334, 1, NULL, NULL, NULL, NULL, NULL, 'Менасанов Н.У. ', NULL, NULL, '7 978 79 255 46', 0, NULL);
INSERT INTO public.contractors VALUES (2335, 1, NULL, NULL, NULL, NULL, NULL, 'Мензатов Э. Д. ', NULL, NULL, '7 978 808 62 66', 0, NULL);
INSERT INTO public.contractors VALUES (2336, 1, NULL, NULL, NULL, NULL, NULL, 'Меншутин ЕВ 79787229929', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2337, 1, NULL, NULL, NULL, NULL, NULL, 'Меньшиков ВЕ 79787809523', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2338, 0, NULL, NULL, NULL, NULL, NULL, 'Мерквиладзе Илларион ', NULL, NULL, '79787273914', 0, NULL);
INSERT INTO public.contractors VALUES (2339, 0, NULL, NULL, NULL, NULL, NULL, 'Меркурий Элит Трейд ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2340, 0, NULL, NULL, NULL, NULL, NULL, 'Метаком', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2341, 1, NULL, NULL, NULL, NULL, NULL, 'Метаком Джанкой', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2342, 1, NULL, NULL, NULL, NULL, NULL, 'Метаком Красногвардейск', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2343, 0, NULL, NULL, NULL, NULL, NULL, 'Металлика 79781415551 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2344, 0, NULL, NULL, NULL, NULL, NULL, 'Металлкомплект  Тарас (Анна ', NULL, NULL, '7 978 842 05 66) ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2345, 0, NULL, NULL, NULL, NULL, 920101001, 'Металлкомплект ООО (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2346, 2, NULL, NULL, NULL, NULL, NULL, 'Металлпрофиль Андрей  Заливянский А.Ю. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2347, 1, NULL, NULL, NULL, NULL, NULL, 'Металлпрофиль Андрей 8978 022 77 55', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2348, 0, NULL, NULL, NULL, NULL, 502901001, 'Металобаза №1', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2349, 1, NULL, NULL, NULL, NULL, NULL, 'Мехоношин ДС 79780967278', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2350, 1, NULL, NULL, NULL, NULL, NULL, 'Мещук С.Ф. ', NULL, NULL, '7978 737 96 52', 0, NULL);
INSERT INTO public.contractors VALUES (2351, 1, NULL, NULL, NULL, NULL, NULL, 'Микиртычев Ю.П. ', NULL, NULL, '7978 933 34 98 Игорь', 0, NULL);
INSERT INTO public.contractors VALUES (2352, 1, NULL, NULL, NULL, NULL, NULL, 'Микиртычев ЮП 79184977795', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2353, 1, NULL, NULL, NULL, NULL, NULL, 'Микитан Р.Л. ', NULL, NULL, '7978 740 11 91', 0, NULL);
INSERT INTO public.contractors VALUES (2354, 1, NULL, NULL, NULL, NULL, NULL, 'Микишев АВ 79787395350', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2355, 0, NULL, NULL, NULL, NULL, NULL, 'Микляев Тимур ', NULL, NULL, '7 978 822 06 73', 0, NULL);
INSERT INTO public.contractors VALUES (2356, 1, NULL, NULL, NULL, NULL, NULL, 'Миламед В 79788985359', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2357, 1, NULL, NULL, NULL, NULL, NULL, 'Милищук Игорь ', NULL, NULL, '7 978 13 23 761', 0, NULL);
INSERT INTO public.contractors VALUES (2358, 1, NULL, NULL, NULL, NULL, NULL, 'Мильцин Дмитрий ', NULL, NULL, '7978 845 45 86', 0, NULL);
INSERT INTO public.contractors VALUES (2359, 1, NULL, NULL, NULL, NULL, NULL, 'Минеев В.И. ', NULL, NULL, '7 978 710 85 44', 0, NULL);
INSERT INTO public.contractors VALUES (2360, 1, NULL, NULL, NULL, NULL, NULL, 'Минеев И.К. ', NULL, NULL, '7978 861 04 64', 0, NULL);
INSERT INTO public.contractors VALUES (2361, 1, NULL, NULL, NULL, NULL, NULL, 'Минеев С.В. ', NULL, NULL, '7 978 201 00 12', 0, NULL);
INSERT INTO public.contractors VALUES (2362, 1, NULL, NULL, NULL, NULL, NULL, 'Миненко А.Ф. ', NULL, NULL, '7 978 7382 452', 0, NULL);
INSERT INTO public.contractors VALUES (2363, 1, NULL, NULL, NULL, NULL, NULL, 'Миняков АЮ 79782667920', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2364, 2, NULL, NULL, NULL, NULL, NULL, '"Мир Кровли "" Ялта. (И)"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2365, 2, NULL, NULL, NULL, NULL, NULL, 'Мир Кровли Александр.Алушта.(И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2366, 0, NULL, NULL, NULL, NULL, NULL, 'Миргородский Сергей Александрович ', NULL, NULL, '79788386053', 0, NULL);
INSERT INTO public.contractors VALUES (2367, 1, NULL, NULL, NULL, NULL, NULL, 'Мирзяев Тимур ', NULL, NULL, '7 978 08 70 464', 0, NULL);
INSERT INTO public.contractors VALUES (2368, 1, NULL, NULL, NULL, NULL, NULL, 'Мироненко 79787087139', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2369, 0, NULL, NULL, NULL, NULL, NULL, 'Миронов И.О. ', NULL, NULL, '7978 899 76 20', 0, NULL);
INSERT INTO public.contractors VALUES (2370, 1, NULL, NULL, NULL, NULL, NULL, 'Миронович Д.В. ', NULL, NULL, '7 978 832 60 08', 0, NULL);
INSERT INTO public.contractors VALUES (2371, 1, NULL, NULL, NULL, NULL, NULL, 'Мирончук Е.В. ', NULL, NULL, '7978 00 40 151 (к)', 0, NULL);
INSERT INTO public.contractors VALUES (2372, 0, NULL, NULL, NULL, NULL, NULL, 'Миронюк ', NULL, NULL, '79788629290', 0, NULL);
INSERT INTO public.contractors VALUES (2373, 1, NULL, NULL, NULL, NULL, NULL, 'Миронюк ОА 79788230714', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2374, 1, NULL, NULL, NULL, NULL, NULL, 'Мирошников А.А. ', NULL, NULL, '7978 852 44 28', 0, NULL);
INSERT INTO public.contractors VALUES (2375, 1, NULL, NULL, NULL, NULL, NULL, 'Мирошников А.Н. ', NULL, NULL, '7 978 74 84 359', 0, NULL);
INSERT INTO public.contractors VALUES (2376, 1, NULL, NULL, NULL, NULL, NULL, 'Мирошниченко ВН 79787826197', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2377, 1, NULL, NULL, NULL, NULL, NULL, 'Мирошниченко РВ 79788281050', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2378, 1, NULL, NULL, NULL, NULL, NULL, 'Мисинёв Д.В. ', NULL, NULL, '7 978 00 37 669', 0, NULL);
INSERT INTO public.contractors VALUES (2379, 1, NULL, NULL, NULL, NULL, NULL, 'Мистюк В.А. ', NULL, NULL, '7 978 704 44 97', 0, NULL);
INSERT INTO public.contractors VALUES (2380, 0, NULL, NULL, NULL, NULL, NULL, 'Митин В.В. ', NULL, NULL, '7 978 896 0003', 0, NULL);
INSERT INTO public.contractors VALUES (2381, 1, NULL, NULL, NULL, NULL, NULL, 'Митин С.В. ', NULL, NULL, '7 978 896 35 26', 0, NULL);
INSERT INTO public.contractors VALUES (2382, 0, NULL, NULL, NULL, NULL, NULL, 'Митько Алексей ', NULL, NULL, '7 978 725 68 19', 0, NULL);
INSERT INTO public.contractors VALUES (2383, 1, NULL, NULL, NULL, NULL, NULL, 'Митьков Л.Н. ', NULL, NULL, '7978 201 66 05', 0, NULL);
INSERT INTO public.contractors VALUES (2384, 1, NULL, NULL, NULL, NULL, NULL, 'Митяйкин А.О. 8-978-78-77-665', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2385, 0, NULL, NULL, NULL, NULL, NULL, 'Михаил ', NULL, NULL, '7978 723 13 14', 0, NULL);
INSERT INTO public.contractors VALUES (2386, 0, NULL, NULL, NULL, NULL, NULL, 'Михаил Павлович Евпатория (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2387, 1, NULL, NULL, NULL, NULL, NULL, 'Михайлов А.В. ', NULL, NULL, '7978 74 31 880', 0, NULL);
INSERT INTO public.contractors VALUES (2388, 0, NULL, NULL, NULL, NULL, NULL, 'Михайлов Андрей 79787406668', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2389, 1, NULL, NULL, NULL, NULL, NULL, 'Михайлов Е.В. ', NULL, NULL, '7978 920 76 59', 0, NULL);
INSERT INTO public.contractors VALUES (2390, 1, NULL, NULL, NULL, NULL, NULL, 'Михайлусов А.Е. ', NULL, NULL, '7 978 7 593 522', 0, NULL);
INSERT INTO public.contractors VALUES (2391, 1, NULL, NULL, NULL, NULL, NULL, 'Михайлусов АИ 79787593522', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2392, 1, NULL, NULL, NULL, NULL, NULL, 'Михайлюк Ю.М. ', NULL, NULL, '79788140036', 0, NULL);
INSERT INTO public.contractors VALUES (2393, 1, NULL, NULL, NULL, NULL, NULL, 'Михалев А.В. ', NULL, NULL, '7 978 757 01 38', 0, NULL);
INSERT INTO public.contractors VALUES (2394, 1, NULL, NULL, NULL, NULL, NULL, 'Михалев ВФ 79788441394', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2395, 0, NULL, NULL, NULL, NULL, NULL, 'Михальский В.В.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2396, 1, NULL, NULL, NULL, NULL, NULL, 'Михеева Т.Ю. ', NULL, NULL, '7978 895 42 36', 0, NULL);
INSERT INTO public.contractors VALUES (2397, 1, NULL, NULL, NULL, NULL, NULL, 'Мицуков А.С. ', NULL, NULL, '7978 817 04 02', 0, NULL);
INSERT INTO public.contractors VALUES (2398, 1, NULL, NULL, NULL, NULL, NULL, 'Мишинев НЕ 79788273769', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2399, 0, NULL, NULL, NULL, NULL, NULL, 'Мищенко ', NULL, NULL, '7 978 75 68 100', 0, NULL);
INSERT INTO public.contractors VALUES (2400, 1, NULL, NULL, NULL, NULL, NULL, 'Мищенко В.Н. ', NULL, NULL, '79787130034', 0, NULL);
INSERT INTO public.contractors VALUES (2401, 1, NULL, NULL, NULL, NULL, NULL, 'Мищенко Н.А. ', NULL, NULL, '7 978 74 76 121', 0, NULL);
INSERT INTO public.contractors VALUES (2402, 1, NULL, NULL, NULL, NULL, NULL, 'Мищенко Ю.В. ', NULL, NULL, '7978 85 95 301', 0, NULL);
INSERT INTO public.contractors VALUES (2403, 1, NULL, NULL, NULL, NULL, NULL, 'Мищук И.М.', NULL, NULL, '79780809785', 0, NULL);
INSERT INTO public.contractors VALUES (2404, 1, NULL, NULL, NULL, NULL, NULL, 'Мищук СФ 79787379652', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2405, 1, NULL, NULL, NULL, NULL, NULL, 'Мкртчян Г.М. ', NULL, NULL, '7989 22 95 414', 0, NULL);
INSERT INTO public.contractors VALUES (2406, 1, NULL, NULL, NULL, NULL, NULL, 'Млинцов Ф.В. ', NULL, NULL, '7 906 049 06 45', 0, NULL);
INSERT INTO public.contractors VALUES (2407, 1, NULL, NULL, NULL, NULL, NULL, 'Мовчанов 79787577506', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2408, 1, NULL, NULL, NULL, NULL, NULL, 'Могилянец П.В. ', NULL, NULL, '7978 773 66 04', 0, NULL);
INSERT INTO public.contractors VALUES (2409, 0, NULL, NULL, NULL, NULL, 910201001, 'Модуль-Крым ООО -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2410, 1, NULL, NULL, NULL, NULL, NULL, 'Можаев К.В. ', NULL, NULL, '79787074142', 0, NULL);
INSERT INTO public.contractors VALUES (2411, 1, NULL, NULL, NULL, NULL, NULL, 'Моисеев ВВ 79788158494', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2412, 0, NULL, NULL, NULL, NULL, NULL, 'Моисеенко Вячеслав ', NULL, NULL, '7 978 743 44 60', 0, NULL);
INSERT INTO public.contractors VALUES (2413, 0, NULL, NULL, NULL, NULL, NULL, 'Молчанов Алексей ', NULL, NULL, '7 978 752 08 92', 0, NULL);
INSERT INTO public.contractors VALUES (2414, 0, NULL, NULL, NULL, NULL, NULL, 'Момот Александр ', NULL, NULL, '7 978 857 54 70', 0, NULL);
INSERT INTO public.contractors VALUES (2415, 0, NULL, NULL, NULL, NULL, NULL, 'Момот Максим ', NULL, NULL, '79788155267', 0, NULL);
INSERT INTO public.contractors VALUES (2416, 1, NULL, NULL, NULL, NULL, NULL, 'Момот НП 79787112750', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2417, 0, NULL, NULL, NULL, NULL, NULL, 'Момот Сергей ', NULL, NULL, '7 978 815 5249', 0, NULL);
INSERT INTO public.contractors VALUES (2418, 0, NULL, NULL, NULL, NULL, NULL, 'Моногаров Сергей ', NULL, NULL, '79102073213', 0, NULL);
INSERT INTO public.contractors VALUES (2419, 0, NULL, NULL, NULL, NULL, NULL, 'Монолит', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2420, 0, NULL, NULL, NULL, NULL, 910201001, 'МОНОЛИТ-БЕТОН ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2421, 0, NULL, NULL, NULL, NULL, NULL, 'Монтажник ООО ', NULL, NULL, '79276456349 Владислав', 0, NULL);
INSERT INTO public.contractors VALUES (2422, 1, NULL, NULL, NULL, NULL, NULL, 'Моргун А.Г. ', NULL, NULL, '7 978 0634317', 0, NULL);
INSERT INTO public.contractors VALUES (2423, 0, NULL, NULL, NULL, NULL, NULL, 'Моргун Владимир Григорьевич ', NULL, NULL, '79787451027', 0, NULL);
INSERT INTO public.contractors VALUES (2424, 2, NULL, NULL, NULL, NULL, NULL, 'Моргунов Алексей Николаевич -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2425, 1, NULL, NULL, NULL, NULL, NULL, 'Моргунова ЮВ 79788071974', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2426, 0, NULL, NULL, NULL, NULL, NULL, 'Мороз И.В. ', NULL, NULL, '7 978 72 63 157', 0, NULL);
INSERT INTO public.contractors VALUES (2427, 1, NULL, NULL, NULL, NULL, NULL, 'Мороз Л.И. ', NULL, NULL, '7978 860 46 35', 0, NULL);
INSERT INTO public.contractors VALUES (2428, 0, NULL, NULL, NULL, NULL, NULL, 'Мороз М.Ю. ', NULL, NULL, '7978 857 34 06', 0, NULL);
INSERT INTO public.contractors VALUES (2429, 0, NULL, NULL, NULL, NULL, NULL, 'Морозов А.Г. ', NULL, NULL, '7 978 783 58 55', 0, NULL);
INSERT INTO public.contractors VALUES (2430, 1, NULL, NULL, NULL, NULL, NULL, 'Морозов О.Н. ', NULL, NULL, '7 978 148 54 05', 0, NULL);
INSERT INTO public.contractors VALUES (2431, 0, NULL, NULL, NULL, NULL, NULL, 'Морозов О.Н. ', NULL, NULL, '7 978 148 54 05', 0, NULL);
INSERT INTO public.contractors VALUES (2432, 0, NULL, NULL, NULL, NULL, NULL, 'Мосейчук Владимир ', NULL, NULL, '79787318034', 0, NULL);
INSERT INTO public.contractors VALUES (2433, 1, NULL, NULL, NULL, NULL, NULL, 'Мосиенко С.В. ', NULL, NULL, '7 978 83 16 407', 0, NULL);
INSERT INTO public.contractors VALUES (2434, 1, NULL, NULL, NULL, NULL, NULL, 'Москалев Ю.Ю. ', NULL, NULL, '7 978 109 71 39', 0, NULL);
INSERT INTO public.contractors VALUES (2435, 0, NULL, NULL, NULL, NULL, NULL, 'Москалева Александра', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2436, 1, NULL, NULL, NULL, NULL, NULL, 'Москаленко А.А. ', NULL, NULL, '7978 72 617 23', 0, NULL);
INSERT INTO public.contractors VALUES (2437, 1, NULL, NULL, NULL, NULL, NULL, 'Москалу И.А. ', NULL, NULL, '7 978 025 15 25', 0, NULL);
INSERT INTO public.contractors VALUES (2438, 1, NULL, NULL, NULL, NULL, NULL, 'Моспан Нонна Казимировна ', NULL, NULL, '7 978 86 54 510', 0, NULL);
INSERT INTO public.contractors VALUES (2439, 1, NULL, NULL, NULL, NULL, NULL, 'Мостовой СВ 79787546126', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2440, 1, NULL, NULL, NULL, NULL, NULL, 'Мосякин Д.С. ', NULL, NULL, '7 978 810 39 97', 0, NULL);
INSERT INTO public.contractors VALUES (2441, 1, NULL, NULL, NULL, NULL, NULL, 'Мотов СЮ 79787248033', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2442, 1, NULL, NULL, NULL, NULL, NULL, 'Моторный ПИ 79780493556', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2443, 0, NULL, NULL, NULL, NULL, NULL, 'Мощенко Олег (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2444, 2, NULL, NULL, NULL, NULL, NULL, 'Мощенко Олег Сергеевич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2445, 0, NULL, NULL, NULL, NULL, 910901001, 'МПК Скворцово ООО', NULL, 184224, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2446, 1, NULL, NULL, NULL, NULL, NULL, 'Мудрик Андрей ', NULL, NULL, '7978 02 40 168', 0, NULL);
INSERT INTO public.contractors VALUES (2447, 1, NULL, NULL, NULL, NULL, NULL, 'Мудриченков 8978-761-35-12', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2448, 1, NULL, NULL, NULL, NULL, NULL, 'Мудрый В.В. ', NULL, NULL, '79780036386', 0, NULL);
INSERT INTO public.contractors VALUES (2449, 0, NULL, NULL, NULL, NULL, NULL, 'Мудрый Ю.В. ', NULL, NULL, '79787620607', 0, NULL);
INSERT INTO public.contractors VALUES (2450, 1, NULL, NULL, NULL, NULL, NULL, 'Муждабаев А.С. ', NULL, NULL, '7 978 095 33 48', 0, NULL);
INSERT INTO public.contractors VALUES (2451, 0, NULL, NULL, NULL, NULL, NULL, 'Муждабаев И.Р. ', NULL, NULL, '79787757174', 0, NULL);
INSERT INTO public.contractors VALUES (2452, 0, NULL, NULL, NULL, NULL, NULL, 'Муждабаев Р.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2453, 0, NULL, NULL, NULL, NULL, NULL, 'Мужикян Э.А. ', NULL, NULL, '79787512717', 0, NULL);
INSERT INTO public.contractors VALUES (2454, 1, NULL, NULL, NULL, NULL, NULL, 'Музалевский НС 79780494837', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2455, 1, NULL, NULL, NULL, NULL, NULL, 'Музыка Олег ', NULL, NULL, '7 978 854 55 24', 0, NULL);
INSERT INTO public.contractors VALUES (2456, 1, NULL, NULL, NULL, NULL, NULL, 'Музыченко Алексей ', NULL, NULL, '7978 88 978 95', 0, NULL);
INSERT INTO public.contractors VALUES (2457, 0, NULL, NULL, NULL, NULL, NULL, 'Муравинец Александр Федорович ', NULL, NULL, '79788354835', 0, NULL);
INSERT INTO public.contractors VALUES (2458, 0, NULL, NULL, NULL, NULL, NULL, '"Мурад ""Зилико"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2459, 1, NULL, NULL, NULL, NULL, NULL, 'Мурадаселов М.Э. ', NULL, NULL, '7 978 715 07 99', 0, NULL);
INSERT INTO public.contractors VALUES (2460, 1, NULL, NULL, NULL, NULL, NULL, 'Мурадосилов МК 79788571856', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2461, 1, NULL, NULL, NULL, NULL, NULL, 'Муратов М.В. ', NULL, NULL, '7 978 765 64 80', 0, NULL);
INSERT INTO public.contractors VALUES (2462, 1, NULL, NULL, NULL, NULL, NULL, 'Муратов Э.А. ', NULL, NULL, '7 978 785 79 07', 0, NULL);
INSERT INTO public.contractors VALUES (2463, 1, NULL, NULL, NULL, NULL, NULL, 'Мурачев 9789139582', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2464, 1, NULL, NULL, NULL, NULL, NULL, 'Мурашковский А.С. ', NULL, NULL, '7978 810 36 18', 0, NULL);
INSERT INTO public.contractors VALUES (2465, 1, NULL, NULL, NULL, NULL, NULL, 'Мурейко Игорь ', NULL, NULL, '7978 70 73 194', 0, NULL);
INSERT INTO public.contractors VALUES (2466, 0, NULL, NULL, NULL, NULL, NULL, 'Мурко Леонид Иванович ', NULL, NULL, '7 978 011 36 94', 0, NULL);
INSERT INTO public.contractors VALUES (2467, 1, NULL, NULL, NULL, NULL, NULL, 'Мурко Леонид Иванович ', NULL, NULL, '7 978 011 36 94 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2468, 1, NULL, NULL, NULL, NULL, NULL, 'Муртазаев ', NULL, NULL, '7 978 75 47 001', 0, NULL);
INSERT INTO public.contractors VALUES (2469, 1, NULL, NULL, NULL, NULL, NULL, 'Мурченко И.В. ', NULL, NULL, '7 978 708 13 98 (97)', 0, NULL);
INSERT INTO public.contractors VALUES (2470, 1, NULL, NULL, NULL, NULL, NULL, 'Мусеев Рафаэль ', NULL, NULL, '7978 144 41 23_А. д.п.', 0, NULL);
INSERT INTO public.contractors VALUES (2471, 1, NULL, NULL, NULL, NULL, NULL, 'Мусийченко Р.В. ', NULL, NULL, '7 978 754 62 98', 0, NULL);
INSERT INTO public.contractors VALUES (2472, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафа кровельщик (дил.пр.) ', NULL, NULL, '7 978 862 35 04 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2473, 0, NULL, NULL, NULL, NULL, NULL, 'Мустафаев ', NULL, NULL, '79788864829', 0, NULL);
INSERT INTO public.contractors VALUES (2474, 2, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Али - Рефат ', NULL, NULL, '7978 822 16 60 (50) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2475, 0, NULL, NULL, NULL, NULL, NULL, 'Мустафаев В.У. ', NULL, NULL, '7 978 7 35 35 50', 0, NULL);
INSERT INTO public.contractors VALUES (2476, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев З.З. ', NULL, NULL, '7978 05 17 096', 0, NULL);
INSERT INTO public.contractors VALUES (2477, 0, NULL, NULL, NULL, NULL, NULL, 'Мустафаев М.И. ', NULL, NULL, '79787060089', 0, NULL);
INSERT INTO public.contractors VALUES (2478, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Н.О. ', NULL, NULL, '7 978 82 60 414', 0, NULL);
INSERT INTO public.contractors VALUES (2479, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев О.Ф. ', NULL, NULL, '7 978 745 70 42', 0, NULL);
INSERT INTO public.contractors VALUES (2480, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Р.Н. ', NULL, NULL, '7978 840 11 13', 0, NULL);
INSERT INTO public.contractors VALUES (2481, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Ремзи ', NULL, NULL, '7978 773 28 48', 0, NULL);
INSERT INTO public.contractors VALUES (2482, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев ТА 79788864829', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2483, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Ф.Д. ', NULL, NULL, '7 978 80 280 34', 0, NULL);
INSERT INTO public.contractors VALUES (2484, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Э.Д. ', NULL, NULL, '7 978 810 15 61', 0, NULL);
INSERT INTO public.contractors VALUES (2485, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаев Якуб ', NULL, NULL, '7978 870 40 67', 0, NULL);
INSERT INTO public.contractors VALUES (2486, 1, NULL, NULL, NULL, NULL, NULL, 'Мустафаем В.Ф', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2487, 1, NULL, NULL, NULL, NULL, NULL, 'Мусулевская С.А. ', NULL, NULL, '79787344165', 0, NULL);
INSERT INTO public.contractors VALUES (2488, 1, NULL, NULL, NULL, NULL, NULL, 'Мухаметзянов А.Ф. ', NULL, NULL, '7978 057 89 90', 0, NULL);
INSERT INTO public.contractors VALUES (2489, 0, NULL, NULL, NULL, NULL, NULL, 'Мухтаров Сервер ', NULL, NULL, '79781247577', 0, NULL);
INSERT INTO public.contractors VALUES (2490, 1, NULL, NULL, NULL, NULL, NULL, 'Мущинин СВ 79788004618', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2491, 1, NULL, NULL, NULL, NULL, NULL, 'Мыльников А 79780548963', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2492, 1, NULL, NULL, NULL, NULL, NULL, 'Мыслицкий Денис Иванович ', NULL, NULL, '79780280105', 0, NULL);
INSERT INTO public.contractors VALUES (2493, 1, NULL, NULL, NULL, NULL, NULL, 'Мыцык Д.И. ', NULL, NULL, '79787568925', 0, NULL);
INSERT INTO public.contractors VALUES (2494, 1, NULL, NULL, NULL, NULL, NULL, 'Мягкий Н.А. ', NULL, NULL, '7 978 850 24 46 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2495, 0, NULL, NULL, NULL, NULL, NULL, 'Мялковский Д.М. ', NULL, NULL, '7 978 800 79 18', 0, NULL);
INSERT INTO public.contractors VALUES (2496, 1, NULL, NULL, NULL, NULL, NULL, 'Мясников В.Б. ', NULL, NULL, '7978 836 832 1', 0, NULL);
INSERT INTO public.contractors VALUES (2497, 1, NULL, NULL, NULL, NULL, NULL, 'на склад', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2498, 1, NULL, NULL, NULL, NULL, NULL, 'Набиев Решат ', NULL, NULL, '79104881433', 0, NULL);
INSERT INTO public.contractors VALUES (2499, 1, NULL, NULL, NULL, NULL, NULL, 'Набойченко А.А. ', NULL, NULL, '7 978 70 78 004', 0, NULL);
INSERT INTO public.contractors VALUES (2500, 1, NULL, NULL, NULL, NULL, NULL, 'Набокова Л.П ', NULL, NULL, '7978 805 41 39', 0, NULL);
INSERT INTO public.contractors VALUES (2501, 1, NULL, NULL, NULL, NULL, NULL, 'Набокова О.Н. ', NULL, NULL, '79787516915', 0, NULL);
INSERT INTO public.contractors VALUES (2502, 0, NULL, NULL, NULL, NULL, NULL, 'Нагаев', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2503, 1, NULL, NULL, NULL, NULL, NULL, 'Нагаев А.П. ', NULL, NULL, '7978 853 81 17', 0, NULL);
INSERT INTO public.contractors VALUES (2504, 0, NULL, NULL, NULL, NULL, NULL, 'Нагайчук А', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2505, 2, NULL, NULL, NULL, NULL, NULL, 'Нагорный ', NULL, NULL, '7978 733 93 11 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2506, 1, NULL, NULL, NULL, NULL, NULL, 'Нагорный Р.Н. ', NULL, NULL, '7978 76 50 415', 0, NULL);
INSERT INTO public.contractors VALUES (2507, 1, NULL, NULL, NULL, NULL, NULL, 'Нагорнюк Максим ', NULL, NULL, '7978 859 93 23', 0, NULL);
INSERT INTO public.contractors VALUES (2508, 1, NULL, NULL, NULL, NULL, NULL, 'Надопта И.И. ', NULL, NULL, '7978 75 00 951', 0, NULL);
INSERT INTO public.contractors VALUES (2509, 1, NULL, NULL, NULL, NULL, NULL, 'Назарена С.Ф. ', NULL, NULL, '79787455193', 0, NULL);
INSERT INTO public.contractors VALUES (2510, 1, NULL, NULL, NULL, NULL, NULL, 'Назаренко В.В', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2511, 1, NULL, NULL, NULL, NULL, NULL, 'Назаренко СЕ 79787873941', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2512, 1, NULL, NULL, NULL, NULL, NULL, 'Назаров А.Ю. (заборы) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2513, 1, NULL, NULL, NULL, NULL, NULL, 'Назаров С.В. ', NULL, NULL, ' 7 978 741 77 08', 0, NULL);
INSERT INTO public.contractors VALUES (2514, 1, NULL, NULL, NULL, NULL, NULL, 'Найденов С.Н. ', NULL, NULL, '7978 707 999 8', 0, NULL);
INSERT INTO public.contractors VALUES (2515, 1, NULL, NULL, NULL, NULL, NULL, 'Найденок ЮЕ 79787228393 90', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2516, 1, NULL, NULL, NULL, NULL, NULL, 'Налбандян ГГ 79787822668', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2517, 1, NULL, NULL, NULL, NULL, NULL, 'Налча И.Г. ', NULL, NULL, '7978 80 999 58', 0, NULL);
INSERT INTO public.contractors VALUES (2518, 1, NULL, NULL, NULL, NULL, NULL, 'Напрюшкин КА 79780595155', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2519, 1, NULL, NULL, NULL, NULL, NULL, 'Нарижный А.Н. ', NULL, NULL, '7978 754 08 91', 0, NULL);
INSERT INTO public.contractors VALUES (2520, 0, NULL, NULL, NULL, NULL, NULL, 'Нариман (от Сейрана)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2521, 1, NULL, NULL, NULL, NULL, NULL, 'Наседкин А.С. ', NULL, NULL, '7 978 074 32 95', 0, NULL);
INSERT INTO public.contractors VALUES (2522, 1, NULL, NULL, NULL, NULL, NULL, 'Насенников Павел ', NULL, NULL, '7 978 205-65-25', 0, NULL);
INSERT INTO public.contractors VALUES (2524, 1, NULL, NULL, NULL, NULL, NULL, 'Наследов А.А. ', NULL, NULL, '7 978 882 87 53', 0, NULL);
INSERT INTO public.contractors VALUES (2525, 1, NULL, NULL, NULL, NULL, NULL, 'Насыров Р.Д ', NULL, NULL, '7 978 768 43 97', 0, NULL);
INSERT INTO public.contractors VALUES (2526, 0, NULL, NULL, NULL, NULL, NULL, 'Наталья Алушта 89165784820', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2527, 0, NULL, NULL, NULL, NULL, NULL, 'Наталья Давыдовка (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2528, 0, NULL, NULL, NULL, NULL, NULL, 'Науменко Александр ', NULL, NULL, '79788557865', 0, NULL);
INSERT INTO public.contractors VALUES (2529, 0, NULL, NULL, NULL, NULL, NULL, 'Науменко В.П. (Джанкой) ', NULL, NULL, '7978 809 83 79', 0, NULL);
INSERT INTO public.contractors VALUES (2530, 1, NULL, NULL, NULL, NULL, NULL, 'Наумнюк ЮС 79788330070', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2531, 1, NULL, NULL, NULL, NULL, NULL, 'Наумов АВ 79787228335', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2532, 1, NULL, NULL, NULL, NULL, NULL, 'Небесный Петр Юрьевич ', NULL, NULL, '79787195530', 0, NULL);
INSERT INTO public.contractors VALUES (2533, 0, NULL, NULL, NULL, NULL, NULL, 'Нева Каскад 0656056838 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2534, 1, NULL, NULL, NULL, NULL, NULL, 'Невгодовская Р.В 8-978-825-59-57', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2535, 1, NULL, NULL, NULL, NULL, NULL, 'Невгодовская Раиса Васильевна ', NULL, NULL, '7 978 825 59 57', 0, NULL);
INSERT INTO public.contractors VALUES (2536, 1, NULL, NULL, NULL, NULL, NULL, 'Неверовский В.С. ', NULL, NULL, '7 978 744 06 28', 0, NULL);
INSERT INTO public.contractors VALUES (2537, 1, NULL, NULL, NULL, NULL, NULL, 'Невредов Н.Г. ', NULL, NULL, '7 978 78 06 838', 0, NULL);
INSERT INTO public.contractors VALUES (2538, 1, NULL, NULL, NULL, NULL, NULL, 'Невский Д.А. ', NULL, NULL, '7 978 753 81 79', 0, NULL);
INSERT INTO public.contractors VALUES (2539, 1, NULL, NULL, NULL, NULL, NULL, 'Недбай МИ 79780629941', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2540, 1, NULL, NULL, NULL, NULL, NULL, 'Недвига Р.Ю. ', NULL, NULL, '7978 86 23 708', 0, NULL);
INSERT INTO public.contractors VALUES (2541, 1, NULL, NULL, NULL, NULL, NULL, 'Недоступа Д.В. ', NULL, NULL, '7 978 748 37 89', 0, NULL);
INSERT INTO public.contractors VALUES (2542, 2, NULL, NULL, NULL, NULL, NULL, 'Недугова Ольга Леонидовна (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2543, 1, NULL, NULL, NULL, NULL, NULL, 'Неелов 79787084505', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2544, 1, NULL, NULL, NULL, NULL, NULL, 'Некрашевич В.Л. ', NULL, NULL, '79787445724', 0, NULL);
INSERT INTO public.contractors VALUES (2545, 1, NULL, NULL, NULL, NULL, NULL, 'Нелипа О.В. ', NULL, NULL, '7 978 107 44 59', 0, NULL);
INSERT INTO public.contractors VALUES (2546, 1, NULL, NULL, NULL, NULL, NULL, 'Нелипа СА79785716580', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2547, 1, NULL, NULL, NULL, NULL, NULL, 'Неметулаев Р.А. ', NULL, NULL, '7 978 708 99 43', 0, NULL);
INSERT INTO public.contractors VALUES (2548, 0, NULL, NULL, NULL, NULL, NULL, 'Неметуллаев Э.Р. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2549, 1, NULL, NULL, NULL, NULL, NULL, 'Немцев ВМ 79780134787', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2550, 1, NULL, NULL, NULL, NULL, NULL, 'Ненчинский Александр ', NULL, NULL, '7978 72 77 658', 0, NULL);
INSERT INTO public.contractors VALUES (2551, 1, NULL, NULL, NULL, NULL, NULL, 'Непийко АА 79780774202', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2552, 1, NULL, NULL, NULL, NULL, NULL, 'Нерсесян С.О. ', NULL, NULL, '7 978 003 76 20', 0, NULL);
INSERT INTO public.contractors VALUES (2553, 1, NULL, NULL, NULL, NULL, NULL, 'Несененко Ю.В. ', NULL, NULL, '7 978 75 49 733', 0, NULL);
INSERT INTO public.contractors VALUES (2554, 1, NULL, NULL, NULL, NULL, NULL, 'Нескародов А.А. ', NULL, NULL, '7 978 775 68 24', 0, NULL);
INSERT INTO public.contractors VALUES (2555, 1, NULL, NULL, NULL, NULL, NULL, 'Нестер Алексей Николаевич ', NULL, NULL, '79898006009', 0, NULL);
INSERT INTO public.contractors VALUES (2556, 1, NULL, NULL, NULL, NULL, NULL, 'Нестеренко АА 79788697473', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2557, 0, NULL, NULL, NULL, NULL, NULL, 'Нестеренко Алексей ', NULL, NULL, '7 978 00 52 504', 0, NULL);
INSERT INTO public.contractors VALUES (2558, 1, NULL, NULL, NULL, NULL, NULL, 'Нестеров А.Е. ', NULL, NULL, '7978 979 11 04', 0, NULL);
INSERT INTO public.contractors VALUES (2559, 1, NULL, NULL, NULL, NULL, NULL, 'Нестеров П.Н. ', NULL, NULL, '7 978 806 34 33', 0, NULL);
INSERT INTO public.contractors VALUES (2560, 0, NULL, NULL, NULL, NULL, NULL, 'Нестеров Ю.В. ', NULL, NULL, '7 978 758 03 74', 0, NULL);
INSERT INTO public.contractors VALUES (2561, 1, NULL, NULL, NULL, NULL, NULL, 'Нестеров Ю.В. ', NULL, NULL, '7 978 78 41 545', 0, NULL);
INSERT INTO public.contractors VALUES (2562, 1, NULL, NULL, NULL, NULL, NULL, 'Нестратов Д.М. ', NULL, NULL, '7 978 215 36 99', 0, NULL);
INSERT INTO public.contractors VALUES (2563, 0, NULL, NULL, NULL, NULL, NULL, 'Нетреба Игорь (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2564, 1, NULL, NULL, NULL, NULL, NULL, 'Нетяга Владимир ', NULL, NULL, '7978 772 81 98', 0, NULL);
INSERT INTO public.contractors VALUES (2565, 0, NULL, NULL, NULL, NULL, NULL, 'Нефедов А.В. ', NULL, NULL, '7 978 823 39 50', 0, NULL);
INSERT INTO public.contractors VALUES (2566, 1, NULL, NULL, NULL, NULL, NULL, 'Нехай С.П. ', NULL, NULL, '7 978 757 09 30', 0, NULL);
INSERT INTO public.contractors VALUES (2567, 1, NULL, NULL, NULL, NULL, NULL, 'Нечаев 79782606011', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2568, 1, NULL, NULL, NULL, NULL, NULL, 'Нечепуренко Д.А, ', NULL, NULL, '79787298294', 0, NULL);
INSERT INTO public.contractors VALUES (2569, 1, NULL, NULL, NULL, NULL, NULL, 'Низеев А.А. ', NULL, NULL, '7978 770 63 28', 0, NULL);
INSERT INTO public.contractors VALUES (2570, 1, NULL, NULL, NULL, NULL, NULL, 'Низовский М.В. ', NULL, NULL, '7978 731 36 88', 0, NULL);
INSERT INTO public.contractors VALUES (2571, 0, NULL, NULL, NULL, NULL, NULL, 'Ника Крым ', NULL, NULL, '7 978 713 85 75 Николай _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2572, 1, NULL, NULL, NULL, NULL, NULL, 'Никандрова В.А. ', NULL, NULL, '7978 738 26 50', 0, NULL);
INSERT INTO public.contractors VALUES (2573, 1, NULL, NULL, NULL, NULL, NULL, 'Никитенко А.М. ', NULL, NULL, '7 978 840 29 11', 0, NULL);
INSERT INTO public.contractors VALUES (2574, 1, NULL, NULL, NULL, NULL, NULL, 'Никитенко В.В. ', NULL, NULL, '7 978 737 93 19', 0, NULL);
INSERT INTO public.contractors VALUES (2575, 1, NULL, NULL, NULL, NULL, NULL, 'Никитенков Д.В. ', NULL, NULL, '7 978 004 55 74', 0, NULL);
INSERT INTO public.contractors VALUES (2576, 1, NULL, NULL, NULL, NULL, NULL, 'Никитин ДС 79788180808', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2577, 1, NULL, NULL, NULL, NULL, NULL, 'Никитина Л.Д. ', NULL, NULL, '7978 82 77 194', 0, NULL);
INSERT INTO public.contractors VALUES (2578, 1, NULL, NULL, NULL, NULL, NULL, 'Никитченко А.Б. ', NULL, NULL, '79780129520', 0, NULL);
INSERT INTO public.contractors VALUES (2579, 1, NULL, NULL, NULL, NULL, NULL, 'Никитюк АИ 79788378324', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2580, 1, NULL, NULL, NULL, NULL, NULL, 'Никифорова М.П. ', NULL, NULL, '7 978 064 85 93', 0, NULL);
INSERT INTO public.contractors VALUES (2581, 1, NULL, NULL, NULL, NULL, NULL, 'Никишин Н.Н. ', NULL, NULL, '79788170473', 0, NULL);
INSERT INTO public.contractors VALUES (2582, 0, NULL, NULL, NULL, NULL, NULL, 'Николаев А.П. ', NULL, NULL, '79787419077', 0, NULL);
INSERT INTO public.contractors VALUES (2583, 1, NULL, NULL, NULL, NULL, NULL, 'Николаев Л.Н. ', NULL, NULL, '7978 896 58 90', 0, NULL);
INSERT INTO public.contractors VALUES (2584, 0, NULL, NULL, NULL, NULL, NULL, 'Николаевский ТК -А.  ', NULL, NULL, '7978  843 2602', 0, NULL);
INSERT INTO public.contractors VALUES (2585, 1, NULL, NULL, NULL, NULL, NULL, 'Николаенко', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2586, 0, NULL, NULL, NULL, NULL, NULL, 'Николаенко М.Г. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2587, 1, NULL, NULL, NULL, NULL, NULL, 'Николаенко С.Н. ', NULL, NULL, '7 978 744 624 1', 0, NULL);
INSERT INTO public.contractors VALUES (2588, 1, NULL, NULL, NULL, NULL, NULL, 'Николаенко С.Н. ', NULL, NULL, '7978 744 6241 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2589, 0, NULL, NULL, NULL, NULL, NULL, 'Николай ', NULL, NULL, '7 978 732 63 22', 0, NULL);
INSERT INTO public.contractors VALUES (2590, 0, NULL, NULL, NULL, NULL, NULL, 'Николай Корзинкин 2900472@npksm.ru', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2591, 1, NULL, NULL, NULL, NULL, NULL, 'Николай С.А', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2592, 1, NULL, NULL, NULL, NULL, NULL, 'Николай Севастополь 8978-045-99-79', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2593, 0, NULL, NULL, NULL, NULL, NULL, 'Николай станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2594, 1, NULL, NULL, NULL, NULL, NULL, 'Николюк СН 79260747764', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2595, 1, NULL, NULL, NULL, NULL, NULL, 'Никонов И.И. ', NULL, NULL, '7978 744 96 50', 0, NULL);
INSERT INTO public.contractors VALUES (2596, 1, NULL, NULL, NULL, NULL, NULL, 'Никора МО 79785669266', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2597, 0, NULL, NULL, NULL, NULL, NULL, 'Никорян А. ', NULL, NULL, '79785720219', 0, NULL);
INSERT INTO public.contractors VALUES (2598, 0, NULL, NULL, NULL, 1831170846, 183101001, '"НИКОС"" _Константин ', NULL, NULL, '7 978 939 95 45 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (2599, 0, NULL, NULL, NULL, NULL, NULL, 'Никулин Валерий ', NULL, NULL, '79787298889', 0, NULL);
INSERT INTO public.contractors VALUES (2600, 1, NULL, NULL, NULL, NULL, NULL, 'Ниметулаев ЭД 79787717678', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2601, 0, NULL, NULL, NULL, NULL, NULL, 'НЛМК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2602, 0, NULL, NULL, NULL, NULL, NULL, 'Нова Строй', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2603, 0, NULL, NULL, NULL, NULL, NULL, 'Новак В.Г. ', NULL, NULL, '7 978 260 38 94', 0, NULL);
INSERT INTO public.contractors VALUES (2604, 1, NULL, NULL, NULL, NULL, NULL, 'Новак Ю.А. ', NULL, NULL, '7 978 7451 397', 0, NULL);
INSERT INTO public.contractors VALUES (2605, 0, NULL, NULL, NULL, NULL, NULL, 'Новатор , Суханек Владимир ', NULL, NULL, '79780470010 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2606, 0, NULL, NULL, NULL, NULL, 910201001, '"НОВАЦЕНТР К"", Гипермаркет № 2 Севастополь_Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2607, 0, NULL, NULL, NULL, NULL, 910201001, '"НОВАЦЕНТР К"", Гипермаркет № 3 Севастополь_Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2608, 0, NULL, NULL, NULL, NULL, 910201001, '"НОВАЦЕНТР К"", Гипермаркет № 4 Симферополь_Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2609, 2, NULL, NULL, NULL, NULL, NULL, 'Новачук Н.С. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2610, 1, NULL, NULL, NULL, NULL, NULL, 'Новиков АВ 79787874724', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2611, 1, NULL, NULL, NULL, NULL, NULL, 'Новиков Александр ', NULL, NULL, '7 978 754 54 77', 0, NULL);
INSERT INTO public.contractors VALUES (2612, 1, NULL, NULL, NULL, NULL, NULL, 'Новиков Александр ', NULL, NULL, '7978 83 40 998', 0, NULL);
INSERT INTO public.contractors VALUES (2613, 2, NULL, NULL, NULL, NULL, NULL, 'Новиков В. Н. ИП БЕЛОРЕЧЕНСК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2614, 1, NULL, NULL, NULL, NULL, NULL, 'Новиков В.Н. ', NULL, NULL, '7 978 815 60 36', 0, NULL);
INSERT INTO public.contractors VALUES (2615, 1, NULL, NULL, NULL, NULL, NULL, 'Новиков ВА ', NULL, NULL, '79788710035', 0, NULL);
INSERT INTO public.contractors VALUES (2616, 1, NULL, NULL, NULL, NULL, NULL, 'Новиков ОА 79780071852', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2617, 1, NULL, NULL, NULL, NULL, NULL, 'Новицкий 79788159390', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2618, 1, NULL, NULL, NULL, NULL, NULL, 'Новицкий А.А. ', NULL, NULL, '7 978 815 93 90', 0, NULL);
INSERT INTO public.contractors VALUES (2619, 1, NULL, NULL, NULL, NULL, NULL, 'Новицкий ВН 79787524685', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2620, 0, NULL, NULL, NULL, NULL, NULL, 'Новоандреевское  ', NULL, NULL, '7 989 835 73 45 Роман ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2621, 1, NULL, NULL, NULL, NULL, NULL, 'Новорчук Денис Юрьевич ', NULL, NULL, '79787138337', 0, NULL);
INSERT INTO public.contractors VALUES (2622, 0, NULL, NULL, NULL, NULL, NULL, 'Новые Стройматерьалы (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2623, 0, NULL, NULL, NULL, NULL, 910201001, '"НОВЫЕ ТЕХНОЛОГИИ"", Сергей 7978 74 30 662- Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2624, 1, NULL, NULL, NULL, NULL, NULL, 'Норик', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2625, 1, NULL, NULL, NULL, NULL, NULL, 'Носатов Г.К. ', NULL, NULL, '7 978 067 53 04', 0, NULL);
INSERT INTO public.contractors VALUES (2626, 0, NULL, NULL, NULL, NULL, NULL, 'Носик Владимир ', NULL, NULL, '79787477798', 0, NULL);
INSERT INTO public.contractors VALUES (2627, 1, NULL, NULL, NULL, NULL, NULL, 'Носов АА 79788175938', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2628, 1, NULL, NULL, NULL, NULL, NULL, 'Носульский Н.Н. ', NULL, NULL, '7978 863 47 20', 0, NULL);
INSERT INTO public.contractors VALUES (2629, 0, NULL, NULL, NULL, NULL, NULL, 'НПП Аксион ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2630, 0, NULL, NULL, NULL, NULL, NULL, 'НПЦ Кровля _ Сергей _ Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2631, 1, NULL, NULL, NULL, NULL, NULL, 'Нугаев М.Р. ', NULL, NULL, '7 978 871 04 80', 0, NULL);
INSERT INTO public.contractors VALUES (2632, 0, NULL, NULL, NULL, NULL, NULL, 'Нужды завода', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2633, 1, NULL, NULL, NULL, NULL, NULL, 'Нурмамбетов С.К. ', NULL, NULL, '7 978 77 155 97', 0, NULL);
INSERT INTO public.contractors VALUES (2634, 1, NULL, NULL, NULL, NULL, NULL, 'Нурмамедов Р.Т. ', NULL, NULL, '7 978 79 31 877', 0, NULL);
INSERT INTO public.contractors VALUES (2635, 0, NULL, NULL, NULL, NULL, NULL, 'Нурманбетов Сервер ', NULL, NULL, '79787715597', 0, NULL);
INSERT INTO public.contractors VALUES (2636, 1, NULL, NULL, NULL, NULL, NULL, 'Нэрсесян С.О. ', NULL, NULL, '79780037620', 0, NULL);
INSERT INTO public.contractors VALUES (2637, 1, NULL, NULL, NULL, NULL, NULL, 'Облещенко С.Г. ', NULL, NULL, '7978 747 00 96', 0, NULL);
INSERT INTO public.contractors VALUES (2638, 1, NULL, NULL, NULL, NULL, NULL, 'Обозинский В.Л. ', NULL, NULL, '7978 841 42 78', 0, NULL);
INSERT INTO public.contractors VALUES (2639, 0, NULL, NULL, NULL, NULL, NULL, 'Оборин М.К. ', NULL, NULL, '7 978 81 59 860', 0, NULL);
INSERT INTO public.contractors VALUES (2640, 1, NULL, NULL, NULL, NULL, NULL, 'Обронов АГ 79787528382', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2641, 1, NULL, NULL, NULL, NULL, NULL, 'Овечкин РЛ 79780777540', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2642, 1, NULL, NULL, NULL, NULL, NULL, 'Овсиенко Александ ', NULL, NULL, '79788352152', 0, NULL);
INSERT INTO public.contractors VALUES (2643, 1, NULL, NULL, NULL, NULL, NULL, 'Овсяник ТФ 79780070194', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2644, 1, NULL, NULL, NULL, NULL, NULL, 'Овчарук А.А. ', NULL, NULL, '7978 83 66 098', 0, NULL);
INSERT INTO public.contractors VALUES (2645, 1, NULL, NULL, NULL, NULL, NULL, 'Овчарук С.В. ', NULL, NULL, '7 978 745 16 47', 0, NULL);
INSERT INTO public.contractors VALUES (2646, 1, NULL, NULL, NULL, NULL, NULL, 'Овчинников А.Д. ', NULL, NULL, '7 978 718 37 50', 0, NULL);
INSERT INTO public.contractors VALUES (2647, 1, NULL, NULL, NULL, NULL, NULL, 'Овчинникова Елена ', NULL, NULL, '7 978 219 06 63', 0, NULL);
INSERT INTO public.contractors VALUES (2648, 1, NULL, NULL, NULL, NULL, NULL, 'Огарков НС ', NULL, NULL, '79788791016', 0, NULL);
INSERT INTO public.contractors VALUES (2649, 1, NULL, NULL, NULL, NULL, NULL, 'Оглезнев Д.В. ', NULL, NULL, '79194651441', 0, NULL);
INSERT INTO public.contractors VALUES (2650, 0, NULL, NULL, NULL, NULL, NULL, 'Огнева Мария ', NULL, NULL, '7 978 821 4736', 0, NULL);
INSERT INTO public.contractors VALUES (2651, 1, NULL, NULL, NULL, NULL, NULL, 'Одарченко Эдуард ', NULL, NULL, '79787182577', 0, NULL);
INSERT INTO public.contractors VALUES (2652, 1, NULL, NULL, NULL, NULL, NULL, 'Ожизневская О.А. ', NULL, NULL, '7 978 75 29 579', 0, NULL);
INSERT INTO public.contractors VALUES (2653, 1, NULL, NULL, NULL, NULL, NULL, 'Оксененко ИВ 79787705679', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2654, 1, NULL, NULL, NULL, NULL, NULL, 'Оксененко Игорь Николаевич ', NULL, NULL, '7978 72 05 449', 0, NULL);
INSERT INTO public.contractors VALUES (2655, 2, NULL, NULL, NULL, NULL, NULL, 'Оксенюк Александр Викторович, Нижнегорский Саша ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2656, 1, NULL, NULL, NULL, NULL, NULL, 'Олег ', NULL, NULL, '7 978 723 00 35', 0, NULL);
INSERT INTO public.contractors VALUES (2657, 1, NULL, NULL, NULL, NULL, NULL, 'Олег ', NULL, NULL, '7 978 76 56 205', 0, NULL);
INSERT INTO public.contractors VALUES (2658, 0, NULL, NULL, NULL, NULL, NULL, 'Олег Веселовка Евпатория ', NULL, NULL, '7 978 702 58 33_Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2659, 0, NULL, NULL, NULL, NULL, NULL, 'Олег Мороз ', NULL, NULL, '7 978 8272960 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2660, 0, NULL, NULL, NULL, NULL, NULL, 'Олег Мощенко', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2661, 1, NULL, NULL, NULL, NULL, NULL, 'Олег от Антона', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2662, 0, NULL, NULL, NULL, NULL, NULL, 'Олег Сергеевич (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2663, 1, NULL, NULL, NULL, NULL, NULL, 'Олег цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2664, 0, NULL, NULL, NULL, NULL, NULL, 'Олег.Кровля Фасады (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2665, 1, NULL, NULL, NULL, NULL, NULL, 'Олейник В.М. ', NULL, NULL, '7 978 713 8197', 0, NULL);
INSERT INTO public.contractors VALUES (2666, 0, NULL, NULL, NULL, NULL, NULL, 'Олейник С.А. ', NULL, NULL, '7 978 8333 443', 0, NULL);
INSERT INTO public.contractors VALUES (2667, 1, NULL, NULL, NULL, NULL, NULL, 'Олейников НИ 79788304512', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2668, 1, NULL, NULL, NULL, NULL, NULL, 'Олейников ЮН ', NULL, NULL, '79787079548', 0, NULL);
INSERT INTO public.contractors VALUES (2669, 1, NULL, NULL, NULL, NULL, NULL, 'Олесик М.В. ', NULL, NULL, '7 978 810 20 83', 0, NULL);
INSERT INTO public.contractors VALUES (2670, 0, NULL, NULL, NULL, NULL, NULL, 'Олимов Абдулла ', NULL, NULL, '7 978 118 41 22', 0, NULL);
INSERT INTO public.contractors VALUES (2671, 1, NULL, NULL, NULL, NULL, NULL, 'Олишевский Ю.Н. ', NULL, NULL, '7978 788 60 08', 0, NULL);
INSERT INTO public.contractors VALUES (2672, 1, NULL, NULL, NULL, NULL, NULL, 'Омельяненко В.Ю. ', NULL, NULL, '7 978 77 20 665', 0, NULL);
INSERT INTO public.contractors VALUES (2673, 0, NULL, NULL, NULL, NULL, NULL, 'Онипко Виталий ', NULL, NULL, '7 978 719 13 10', 0, NULL);
INSERT INTO public.contractors VALUES (2674, 1, NULL, NULL, NULL, NULL, NULL, 'Онипченко АЛ 79788157438', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2675, 0, NULL, NULL, NULL, NULL, NULL, 'Онищенко А ', NULL, NULL, '79788168575', 0, NULL);
INSERT INTO public.contractors VALUES (2676, 1, NULL, NULL, NULL, NULL, NULL, 'Онищук О.В. ', NULL, NULL, '7 978 79 72 096 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (2677, 1, NULL, NULL, NULL, NULL, NULL, 'ООВО УЭУ ', NULL, NULL, '7 978 788 37 31 Александр АНО', 0, NULL);
INSERT INTO public.contractors VALUES (2678, 0, NULL, NULL, NULL, NULL, 910201001, '"ООВО"" ""Университет экономики и управления"", ', NULL, NULL, '7 978 788 37 31 Александр АНО"', 0, NULL);
INSERT INTO public.contractors VALUES (2679, 0, NULL, NULL, NULL, NULL, 910201001, 'ООО  «ГРОНА-ГЛОБАЛ»', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2680, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""Автостар"" ', NULL, NULL, '79780634751 Виталий"', 0, NULL);
INSERT INTO public.contractors VALUES (2681, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""Глобал Трейд"" ', NULL, NULL, '79781403011"', 0, NULL);
INSERT INTO public.contractors VALUES (2682, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""Крымская кровельная компания"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2683, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""СК ""Вектор"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2684, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""Строй-Джонс"" ', NULL, NULL, '79787749747"', 0, NULL);
INSERT INTO public.contractors VALUES (2685, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""Термика-Профи"" ', NULL, NULL, '7 978 142 15 08"', 0, NULL);
INSERT INTO public.contractors VALUES (2686, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ""Элитстройальянс"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2687, 0, NULL, NULL, NULL, NULL, 920401001, 'ООО «ДОРОЖНИК»', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2688, 0, NULL, NULL, NULL, NULL, NULL, 'ООО «МЕТТРАНСТЕРМИНАЛ»', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2689, 0, NULL, NULL, NULL, NULL, 910201001, 'ООО «ЧНГ ГАЗИФИКАЦИЯ»', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2690, 0, NULL, NULL, NULL, NULL, NULL, 'ООО Винал Люкс', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2691, 0, NULL, NULL, NULL, NULL, NULL, 'ООО Дебют', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2692, 0, NULL, NULL, NULL, NULL, NULL, '"ООО Орион"" ', NULL, NULL, '7 978 743 03 04 Павел"', 0, NULL);
INSERT INTO public.contractors VALUES (2693, 0, NULL, NULL, NULL, NULL, NULL, 'ООО Респект ', NULL, NULL, '7 978 74 15 035', 0, NULL);
INSERT INTO public.contractors VALUES (2694, 0, NULL, NULL, NULL, NULL, NULL, 'ООО РУФ Фоам', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2695, 0, NULL, NULL, NULL, NULL, NULL, '"ООО ТД ""Минерал""', NULL, NULL, '79789626085"', 0, NULL);
INSERT INTO public.contractors VALUES (2696, 0, NULL, NULL, NULL, NULL, NULL, '"ООО""Беатриче"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2697, 0, NULL, NULL, NULL, NULL, NULL, '"ООО""НКС РК"""', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2698, 1, NULL, NULL, NULL, NULL, NULL, 'ОП Сварог 1 ', NULL, NULL, '7978 034 08 70 Владимир', 0, NULL);
INSERT INTO public.contractors VALUES (2699, 1, NULL, NULL, NULL, NULL, NULL, 'Опимах ЮС 79782052094', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2700, 1, NULL, NULL, NULL, NULL, NULL, 'Орбита ', NULL, NULL, '7 978 7 366 355 Саркиз ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2701, 1, NULL, NULL, NULL, NULL, NULL, 'Орест Бунчак д.п. ', NULL, NULL, '7 978 840 25 38', 0, NULL);
INSERT INTO public.contractors VALUES (2702, 0, NULL, NULL, NULL, NULL, NULL, 'Орехов В.И. ', NULL, NULL, '7 978 85 69 208', 0, NULL);
INSERT INTO public.contractors VALUES (2703, 0, NULL, NULL, NULL, NULL, NULL, 'Орехов Вячеслав ', NULL, NULL, '7 978 85 69 208', 0, NULL);
INSERT INTO public.contractors VALUES (2704, 1, NULL, NULL, NULL, NULL, NULL, 'Оржаковский АА 79787251524', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2705, 2, NULL, NULL, NULL, NULL, NULL, 'Оржаховский Сергей Анатольевич ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2706, 1, NULL, NULL, NULL, NULL, NULL, 'Орион 79788623025 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2707, 1, NULL, NULL, NULL, NULL, NULL, 'Орлов Алексей ', NULL, NULL, '7 978 806 22 93', 0, NULL);
INSERT INTO public.contractors VALUES (2708, 0, NULL, NULL, NULL, NULL, NULL, 'Орлов Е.В. ', NULL, NULL, '7 978 720 43 69', 0, NULL);
INSERT INTO public.contractors VALUES (2709, 1, NULL, NULL, NULL, NULL, NULL, 'Орлов И.А. ', NULL, NULL, '7 978 728 75 23', 0, NULL);
INSERT INTO public.contractors VALUES (2710, 2, NULL, NULL, NULL, NULL, NULL, 'Орлов Сергей Владимирович (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2711, 1, NULL, NULL, NULL, NULL, NULL, 'Осадчев А.В. ', NULL, NULL, '7 978 81 78 910', 0, NULL);
INSERT INTO public.contractors VALUES (2712, 1, NULL, NULL, NULL, NULL, NULL, 'Осипенко ВВ 79787874200', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2713, 0, NULL, NULL, NULL, NULL, NULL, 'Осипенко Олег Юрьевич ', NULL, NULL, '7 978 7900 996 _А.', 0, NULL);
INSERT INTO public.contractors VALUES (2714, 1, NULL, NULL, NULL, NULL, NULL, 'Осипов ВА 79788494634', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2715, 1, NULL, NULL, NULL, NULL, NULL, 'Осипов Ю.В', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2716, 1, NULL, NULL, NULL, NULL, NULL, 'Осипчук А.В. ', NULL, NULL, '7978 729 60 94', 0, NULL);
INSERT INTO public.contractors VALUES (2717, 0, NULL, NULL, NULL, NULL, NULL, 'ОСК Южный скат 79780296595 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2718, 0, NULL, NULL, NULL, NULL, NULL, 'Осман водитель', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2719, 1, NULL, NULL, NULL, NULL, NULL, 'Османов 79788780102', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2720, 1, NULL, NULL, NULL, NULL, NULL, 'Османов А.М. ', NULL, NULL, '7978 798 75 28', 0, NULL);
INSERT INTO public.contractors VALUES (2721, 1, NULL, NULL, NULL, NULL, NULL, 'Османов Азиз ', NULL, NULL, '7 978 768 77 25 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2722, 0, NULL, NULL, NULL, NULL, NULL, 'Османов Ахтем', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2723, 1, NULL, NULL, NULL, NULL, NULL, 'Османов АЭ 79787928625', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2724, 1, NULL, NULL, NULL, NULL, NULL, 'Османов Р.Р, ', NULL, NULL, '7 978 7906 324', 0, NULL);
INSERT INTO public.contractors VALUES (2725, 1, NULL, NULL, NULL, NULL, NULL, 'Османов Решат ', NULL, NULL, '7978 264-44-86 д.п. - А.', 0, NULL);
INSERT INTO public.contractors VALUES (2726, 1, NULL, NULL, NULL, NULL, NULL, 'Османов Юсуф ', NULL, NULL, '7 978 822 06 86', 0, NULL);
INSERT INTO public.contractors VALUES (2727, 0, NULL, NULL, NULL, NULL, NULL, 'Остапенко Е.А. ', NULL, NULL, '79788097001', 0, NULL);
INSERT INTO public.contractors VALUES (2728, 1, NULL, NULL, NULL, NULL, NULL, 'Остапенко ЕА 79788097001', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2729, 1, NULL, NULL, NULL, NULL, NULL, 'Остапенко Р.А. ', NULL, NULL, '79780382557', 0, NULL);
INSERT INTO public.contractors VALUES (2730, 0, NULL, NULL, NULL, NULL, NULL, 'Остапчук А.Т. ', NULL, NULL, '79892147899', 0, NULL);
INSERT INTO public.contractors VALUES (2731, 1, NULL, NULL, NULL, NULL, NULL, 'Остров П.И. ', NULL, NULL, '7978 727 85 38', 0, NULL);
INSERT INTO public.contractors VALUES (2732, 1, NULL, NULL, NULL, NULL, NULL, 'Островский ВВ ', NULL, NULL, '79788290966', 0, NULL);
INSERT INTO public.contractors VALUES (2733, 1, NULL, NULL, NULL, NULL, NULL, 'Остяков А.Л. 8 922 250 60 64', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2734, 1, NULL, NULL, NULL, NULL, NULL, 'Оськин Юрий Петрович ', NULL, NULL, '7 978 753 1052', 0, NULL);
INSERT INTO public.contractors VALUES (2735, 0, NULL, NULL, NULL, NULL, NULL, 'Офицеров А.А. ', NULL, NULL, '7 978 785 77 94', 0, NULL);
INSERT INTO public.contractors VALUES (2736, 1, NULL, NULL, NULL, NULL, NULL, 'Охременко В.И. ', NULL, NULL, '7978 723 49 26', 0, NULL);
INSERT INTO public.contractors VALUES (2737, 0, NULL, NULL, NULL, NULL, NULL, 'Павел ', NULL, NULL, '7 978 955 00 01', 0, NULL);
INSERT INTO public.contractors VALUES (2738, 0, NULL, NULL, NULL, NULL, NULL, 'Павел ', NULL, NULL, '7978 735 20 07', 0, NULL);
INSERT INTO public.contractors VALUES (2739, 0, NULL, NULL, NULL, NULL, NULL, 'Павел ', NULL, NULL, '79782287339', 0, NULL);
INSERT INTO public.contractors VALUES (2740, 0, NULL, NULL, NULL, NULL, NULL, 'Павел от Влада', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2741, 0, NULL, NULL, NULL, NULL, NULL, 'Павел Спивак ', NULL, NULL, '79787244954', 0, NULL);
INSERT INTO public.contractors VALUES (2742, 1, NULL, NULL, NULL, NULL, NULL, 'Павленко Эмир ', NULL, NULL, '7978 848 31 61', 0, NULL);
INSERT INTO public.contractors VALUES (2743, 1, NULL, NULL, NULL, NULL, NULL, 'Павличенко В.Н. ', NULL, NULL, '7 978 034 40 79', 0, NULL);
INSERT INTO public.contractors VALUES (2744, 0, NULL, NULL, NULL, NULL, NULL, 'Павлов Петр Александрович ', NULL, NULL, '7 978 782 10 71', 0, NULL);
INSERT INTO public.contractors VALUES (2745, 0, NULL, NULL, NULL, NULL, NULL, 'Павлов Р.В. ', NULL, NULL, '7 978 78 13 101', 0, NULL);
INSERT INTO public.contractors VALUES (2746, 1, NULL, NULL, NULL, NULL, NULL, 'Павлович Руслан ', NULL, NULL, '7 978 888 38 03', 0, NULL);
INSERT INTO public.contractors VALUES (2747, 1, NULL, NULL, NULL, NULL, NULL, 'Павловский Александр Валерьевич ', NULL, NULL, '79788212330', 0, NULL);
INSERT INTO public.contractors VALUES (2748, 1, NULL, NULL, NULL, NULL, NULL, 'Павловский ВВ 79781499374', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2749, 1, NULL, NULL, NULL, NULL, NULL, 'Павлюков Дмитрий Владимирович ', NULL, NULL, '7978 830 777 1', 0, NULL);
INSERT INTO public.contractors VALUES (2750, 1, NULL, NULL, NULL, NULL, NULL, 'Падышев А.М. ', NULL, NULL, '7 978 86 82 118', 0, NULL);
INSERT INTO public.contractors VALUES (2751, 0, NULL, NULL, NULL, NULL, NULL, 'Паер А.Н. ', NULL, NULL, '7 978 810 20 42', 0, NULL);
INSERT INTO public.contractors VALUES (2752, 0, NULL, NULL, NULL, NULL, NULL, 'Паер А.Н. ', NULL, NULL, '79788100242', 0, NULL);
INSERT INTO public.contractors VALUES (2753, 1, NULL, NULL, NULL, NULL, NULL, 'Пакулин М.В кп 7978-764-29-89', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2754, 1, NULL, NULL, NULL, NULL, NULL, 'Пакулин М.В. ', NULL, NULL, '7 978 764 29 89', 0, NULL);
INSERT INTO public.contractors VALUES (2755, 2, NULL, NULL, NULL, NULL, NULL, 'Палёный Артём Викторович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2756, 1, NULL, NULL, NULL, NULL, NULL, 'Палий ВИ 79788252407', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2757, 0, NULL, NULL, NULL, NULL, 910201001, 'ПАЛЛАДИУМ ЭНЕРГО ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2758, 0, NULL, NULL, NULL, NULL, 910201001, '"ПАЛЛАДИУМ ЭНЕРГО"", Валерий Дахнов ', NULL, NULL, '7 978 024 01 74 ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (2759, 0, NULL, NULL, NULL, NULL, NULL, 'Пальчиковский С.В. ', NULL, NULL, '7 978 756 63 46', 0, NULL);
INSERT INTO public.contractors VALUES (2760, 1, NULL, NULL, NULL, NULL, NULL, 'Паляница Сергей Владимирович ', NULL, NULL, '79787106601', 0, NULL);
INSERT INTO public.contractors VALUES (2761, 0, NULL, NULL, NULL, NULL, NULL, 'ПАН-СТРОЙ ООО ', NULL, NULL, '79787139657', 0, NULL);
INSERT INTO public.contractors VALUES (2762, 1, NULL, NULL, NULL, NULL, NULL, 'Панарин В.А. ', NULL, NULL, '7978 73 07 312', 0, NULL);
INSERT INTO public.contractors VALUES (2763, 0, NULL, NULL, NULL, NULL, NULL, 'Панасенко А.А. ', NULL, NULL, '79780837797', 0, NULL);
INSERT INTO public.contractors VALUES (2764, 0, NULL, NULL, NULL, NULL, NULL, 'Панаско Сергей ', NULL, NULL, '7 978 741 48 72', 0, NULL);
INSERT INTO public.contractors VALUES (2765, 1, NULL, NULL, NULL, NULL, NULL, 'Паничкин А 79787498680', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2766, 0, NULL, NULL, NULL, NULL, NULL, 'Пансионат Солнечный 79787402116 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2767, 1, NULL, NULL, NULL, NULL, NULL, 'Пантин Ю.А. кп ', NULL, NULL, '7 978 70 322 62', 0, NULL);
INSERT INTO public.contractors VALUES (2768, 2, NULL, NULL, NULL, NULL, NULL, 'Пануров ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2769, 1, NULL, NULL, NULL, NULL, NULL, 'Панферов Сергей ', NULL, NULL, '7978 760 37 05', 0, NULL);
INSERT INTO public.contractors VALUES (2770, 1, NULL, NULL, NULL, NULL, NULL, 'Панфилова Виктория Владимировна', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2771, 1, NULL, NULL, NULL, NULL, NULL, 'Паньшин И.И. ', NULL, NULL, '7 978 766 52 31', 0, NULL);
INSERT INTO public.contractors VALUES (2772, 0, NULL, NULL, NULL, NULL, NULL, '"ПАО ""МАСCАНДРА"" (И)"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2773, 1, NULL, NULL, NULL, NULL, NULL, 'Парамонов ВЛ 79788834428', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2774, 1, NULL, NULL, NULL, NULL, NULL, 'Пармонов М.О ', NULL, NULL, '79788935368', 0, NULL);
INSERT INTO public.contractors VALUES (2775, 0, NULL, NULL, NULL, NULL, NULL, 'Партнер 79787815949 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2776, 0, NULL, NULL, NULL, NULL, NULL, 'Партнер 89265365283 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2777, 0, NULL, NULL, NULL, NULL, NULL, 'Партнер Строй Нурик (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2778, 1, NULL, NULL, NULL, NULL, NULL, 'Парус Д.А. ', NULL, NULL, '7978 712 59 96', 0, NULL);
INSERT INTO public.contractors VALUES (2779, 0, NULL, NULL, NULL, NULL, NULL, 'Парфенов Василий ', NULL, NULL, '7 978 825 37 17', 0, NULL);
INSERT INTO public.contractors VALUES (2780, 1, NULL, NULL, NULL, NULL, NULL, 'Парфенов Е 79787504131', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2781, 0, NULL, NULL, NULL, NULL, NULL, 'Пархоменко ', NULL, NULL, '79788617476', 0, NULL);
INSERT INTO public.contractors VALUES (2782, 1, NULL, NULL, NULL, NULL, NULL, 'Пархоменко А.А. ', NULL, NULL, '7 978 757 00 32', 0, NULL);
INSERT INTO public.contractors VALUES (2783, 1, NULL, NULL, NULL, NULL, NULL, 'Пархоменко АИ 79785725689', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2784, 0, NULL, NULL, NULL, NULL, NULL, 'Пархоменко О.В. ', NULL, NULL, '7 978 041 71 45', 0, NULL);
INSERT INTO public.contractors VALUES (2785, 1, NULL, NULL, NULL, NULL, NULL, 'Паршиков В.В. ', NULL, NULL, '79787581734', 0, NULL);
INSERT INTO public.contractors VALUES (2786, 0, NULL, NULL, NULL, NULL, NULL, 'Пасенко Дмитрий Владимирович ', NULL, NULL, '79823049207', 0, NULL);
INSERT INTO public.contractors VALUES (2787, 0, NULL, NULL, NULL, NULL, NULL, 'Пасечник А. ', NULL, NULL, '7 978 762 86 33', 0, NULL);
INSERT INTO public.contractors VALUES (2788, 0, NULL, NULL, NULL, NULL, NULL, 'Патлакова Н.Н. ', NULL, NULL, '7 978 052 83 87', 0, NULL);
INSERT INTO public.contractors VALUES (2789, 1, NULL, NULL, NULL, NULL, NULL, 'Пахалюк Н.П. ', NULL, NULL, '7 978 86 22 652', 0, NULL);
INSERT INTO public.contractors VALUES (2790, 1, NULL, NULL, NULL, NULL, NULL, 'Пахомов АМ 79787338623', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2791, 1, NULL, NULL, NULL, NULL, NULL, 'Пацера И.А. ', NULL, NULL, '79787472883 (4)', 0, NULL);
INSERT INTO public.contractors VALUES (2792, 1, NULL, NULL, NULL, NULL, NULL, 'Пацора А.В. ', NULL, NULL, '7978 74 83 671 (К.П)', 0, NULL);
INSERT INTO public.contractors VALUES (2793, 1, NULL, NULL, NULL, NULL, NULL, 'Паша цех', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2794, 1, NULL, NULL, NULL, NULL, NULL, 'Пашапур ', NULL, NULL, '7 978 745 5012', 0, NULL);
INSERT INTO public.contractors VALUES (2795, 1, NULL, NULL, NULL, NULL, NULL, 'Пашкевич 79787557861', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2796, 1, NULL, NULL, NULL, NULL, NULL, 'Пашко Леонид', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2797, 1, NULL, NULL, NULL, NULL, NULL, 'Пашков А.Е. ', NULL, NULL, '7985 792 58 79', 0, NULL);
INSERT INTO public.contractors VALUES (2798, 0, NULL, NULL, NULL, NULL, NULL, '"Пашков Антон ""Периметр"" ', NULL, NULL, '7978 501 19 60"', 0, NULL);
INSERT INTO public.contractors VALUES (2799, 0, NULL, NULL, NULL, NULL, NULL, 'Пашков В.П. ', NULL, NULL, '7978 837 1290(Севастополь)', 0, NULL);
INSERT INTO public.contractors VALUES (2800, 1, NULL, NULL, NULL, NULL, NULL, 'Пашуля Е.Б. ', NULL, NULL, '7 978 861 67 58', 0, NULL);
INSERT INTO public.contractors VALUES (2801, 0, NULL, NULL, NULL, NULL, NULL, 'Пащенко Андрей ', NULL, NULL, '79167301047', 0, NULL);
INSERT INTO public.contractors VALUES (2802, 1, NULL, NULL, NULL, NULL, NULL, 'Педерсен ЭБ 79788615402', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2803, 1, NULL, NULL, NULL, NULL, NULL, 'Пелюх В.А. ', NULL, NULL, '7978743 70 77', 0, NULL);
INSERT INTO public.contractors VALUES (2804, 0, NULL, NULL, NULL, NULL, NULL, 'Пенетрон Крым  ', NULL, NULL, '7 978 79 20 320 Ольга ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2805, 0, NULL, NULL, NULL, NULL, NULL, 'Первая инжиниринговая компания _Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2806, 0, NULL, NULL, NULL, NULL, 590201001, '"ПЕРВАЯ ЭНЕРГЕТИЧЕСКАЯ КОМПАНИЯ"" _Михаил ', NULL, NULL, '79788389121_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (2807, 0, NULL, NULL, NULL, NULL, NULL, 'Первомайское Владимир Иванович ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2808, 1, NULL, NULL, NULL, NULL, NULL, 'Перепелица А. ', NULL, NULL, '7978 756 60 48 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2809, 1, NULL, NULL, NULL, NULL, NULL, 'Пересыпкина Л.В. ', NULL, NULL, '79788576078', 0, NULL);
INSERT INTO public.contractors VALUES (2810, 1, NULL, NULL, NULL, NULL, NULL, 'Перминова С.И. ', NULL, NULL, '7 978 788 59 72', 0, NULL);
INSERT INTO public.contractors VALUES (2811, 1, NULL, NULL, NULL, NULL, NULL, 'Пермякова М.В. ', NULL, NULL, '7 978 701 45 63', 0, NULL);
INSERT INTO public.contractors VALUES (2812, 1, NULL, NULL, NULL, NULL, NULL, 'Перова А.Г. ', NULL, NULL, '7 978 76 79 278', 0, NULL);
INSERT INTO public.contractors VALUES (2813, 0, NULL, NULL, NULL, NULL, NULL, 'Персонал Дмитрий (А.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2814, 0, NULL, NULL, NULL, NULL, 910301001, '"ПЕРСПЕКТИВА"", ', NULL, NULL, '7978 704 8992 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (2815, 1, NULL, NULL, NULL, NULL, NULL, 'Перунов И.Ю ', NULL, NULL, '79787902433', 0, NULL);
INSERT INTO public.contractors VALUES (2816, 0, NULL, NULL, NULL, NULL, NULL, 'Першников Владимир ', NULL, NULL, '79780340870', 0, NULL);
INSERT INTO public.contractors VALUES (2817, 0, NULL, NULL, NULL, NULL, NULL, 'Пестов Сергей Николаевич ', NULL, NULL, '79185567301', 0, NULL);
INSERT INTO public.contractors VALUES (2818, 0, NULL, NULL, NULL, NULL, NULL, 'Петр ', NULL, NULL, '79785780394', 0, NULL);
INSERT INTO public.contractors VALUES (2819, 1, NULL, NULL, NULL, NULL, NULL, 'Петр Иванович ', NULL, NULL, '7 978 706 23 06', 0, NULL);
INSERT INTO public.contractors VALUES (2820, 1, NULL, NULL, NULL, NULL, NULL, 'Петр Стройсистемы', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2821, 0, NULL, NULL, NULL, NULL, NULL, 'Петракова Д.В.  ', NULL, NULL, '7978 719 04 44 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (2822, 0, NULL, NULL, NULL, NULL, NULL, 'Петраковский А.В. ', NULL, NULL, '7 915 503 80 91', 0, NULL);
INSERT INTO public.contractors VALUES (2823, 1, NULL, NULL, NULL, NULL, NULL, 'Петренко Александр ', NULL, NULL, '7978 780 84 75', 0, NULL);
INSERT INTO public.contractors VALUES (2824, 1, NULL, NULL, NULL, NULL, NULL, 'Петров А.И. ', NULL, NULL, '7 978 837 11 53', 0, NULL);
INSERT INTO public.contractors VALUES (2825, 0, NULL, NULL, NULL, NULL, NULL, 'Петров А.С. ', NULL, NULL, '7978 047 82 05-А.', 0, NULL);
INSERT INTO public.contractors VALUES (2826, 0, NULL, NULL, NULL, NULL, NULL, 'Петров О.А. ', NULL, NULL, '79787620113', 0, NULL);
INSERT INTO public.contractors VALUES (2827, 1, NULL, NULL, NULL, NULL, NULL, 'Петров Петр Петрович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2828, 0, NULL, NULL, NULL, NULL, NULL, 'Петров С.А. ', NULL, NULL, '7 978 205 82 93', 0, NULL);
INSERT INTO public.contractors VALUES (2829, 1, NULL, NULL, NULL, NULL, NULL, 'Петров С.А. ', NULL, NULL, '79789120829', 0, NULL);
INSERT INTO public.contractors VALUES (2830, 1, NULL, NULL, NULL, NULL, NULL, 'Петрович М.О. ', NULL, NULL, '79780331578', 0, NULL);
INSERT INTO public.contractors VALUES (2831, 1, NULL, NULL, NULL, NULL, NULL, 'Петровский ОА 79788432593', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2832, 1, NULL, NULL, NULL, NULL, NULL, 'Петросян Л.Л. ', NULL, NULL, '7 978 220 50 01', 0, NULL);
INSERT INTO public.contractors VALUES (2833, 1, NULL, NULL, NULL, NULL, NULL, 'Петрусенко Ю.В. ', NULL, NULL, '7978 894 14 56', 0, NULL);
INSERT INTO public.contractors VALUES (2834, 1, NULL, NULL, NULL, NULL, NULL, 'Петрусян Гарик Артурович ', NULL, NULL, '79787085974', 0, NULL);
INSERT INTO public.contractors VALUES (2835, 1, NULL, NULL, NULL, NULL, NULL, 'Петрушкин Д.Ю. ', NULL, NULL, '7978 74 392 70', 0, NULL);
INSERT INTO public.contractors VALUES (2836, 1, NULL, NULL, NULL, NULL, NULL, 'Петухов АН 79787437552', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2837, 1, NULL, NULL, NULL, NULL, NULL, 'Петухов Сергей Генадьевич ', NULL, NULL, '7978 836 47 59', 0, NULL);
INSERT INTO public.contractors VALUES (2838, 1, NULL, NULL, NULL, NULL, NULL, 'Петьросян Г.Р. ', NULL, NULL, '7 919 00 28 649', 0, NULL);
INSERT INTO public.contractors VALUES (2839, 0, NULL, NULL, NULL, NULL, NULL, 'Печерский В.И. ', NULL, NULL, '7 978 826 10 91', 0, NULL);
INSERT INTO public.contractors VALUES (2840, 1, NULL, NULL, NULL, NULL, NULL, 'Печугин В.И. ', NULL, NULL, '7 978 22 15 872', 0, NULL);
INSERT INTO public.contractors VALUES (2841, 1, NULL, NULL, NULL, NULL, NULL, 'Печугин Д.М. ', NULL, NULL, '7978 75 28 499', 0, NULL);
INSERT INTO public.contractors VALUES (2842, 1, NULL, NULL, NULL, NULL, NULL, 'Пешиходько Н.Н. ', NULL, NULL, '7978 790 10 24', 0, NULL);
INSERT INTO public.contractors VALUES (2843, 1, NULL, NULL, NULL, NULL, NULL, 'Пивнев 79781403197', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2844, 0, NULL, NULL, NULL, NULL, NULL, '"Пивобезалкогольный комбинат ""Крым"" АО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2845, 1, NULL, NULL, NULL, NULL, NULL, 'Пивоваренко Виталий ', NULL, NULL, '7978 709 23 43', 0, NULL);
INSERT INTO public.contractors VALUES (2846, 1, NULL, NULL, NULL, NULL, NULL, 'Пивошенко 79788140916', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2847, 1, NULL, NULL, NULL, NULL, NULL, 'Пикулев А.И. ', NULL, NULL, '7978 72 60 992', 0, NULL);
INSERT INTO public.contractors VALUES (2848, 2, NULL, NULL, NULL, NULL, NULL, 'Пилипенко Олег Анатольевич (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2849, 1, NULL, NULL, NULL, NULL, NULL, 'Пилунский Н. ', NULL, NULL, '7 978 82 88 900', 0, NULL);
INSERT INTO public.contractors VALUES (2850, 0, NULL, NULL, NULL, NULL, NULL, 'Пилюченко Оксана Владимировна ', NULL, NULL, '79788537795', 0, NULL);
INSERT INTO public.contractors VALUES (2851, 0, NULL, NULL, NULL, NULL, NULL, 'Пинчук Г.В. ', NULL, NULL, '79788326265/4', 0, NULL);
INSERT INTO public.contractors VALUES (2852, 1, NULL, NULL, NULL, NULL, NULL, 'Пирка К.А. ', NULL, NULL, '7978 799 80 66', 0, NULL);
INSERT INTO public.contractors VALUES (2853, 0, NULL, NULL, NULL, NULL, NULL, 'Пирог А.А. ', NULL, NULL, '7  978 7 056548', 0, NULL);
INSERT INTO public.contractors VALUES (2854, 1, NULL, NULL, NULL, NULL, NULL, 'Пирог А.А. ', NULL, NULL, '7 978 7 056 548', 0, NULL);
INSERT INTO public.contractors VALUES (2855, 1, NULL, NULL, NULL, NULL, NULL, 'Писарев А.В. ', NULL, NULL, '7 978 846 97 45', 0, NULL);
INSERT INTO public.contractors VALUES (2856, 1, NULL, NULL, NULL, NULL, NULL, 'Писарев А.Г. ', NULL, NULL, '79787235073', 0, NULL);
INSERT INTO public.contractors VALUES (2857, 0, NULL, NULL, NULL, NULL, NULL, 'Письменная Н.К. ', NULL, NULL, '7978 845 94 11', 0, NULL);
INSERT INTO public.contractors VALUES (2858, 0, NULL, NULL, NULL, NULL, NULL, 'Письменный А.В. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2859, 1, NULL, NULL, NULL, NULL, NULL, 'Пиченжи Д.С. ', NULL, NULL, '7978 82 69 705', 0, NULL);
INSERT INTO public.contractors VALUES (2860, 1, NULL, NULL, NULL, NULL, NULL, 'Пичка Д.В. ', NULL, NULL, '7 978 75 86 021', 0, NULL);
INSERT INTO public.contractors VALUES (2861, 2, NULL, NULL, NULL, NULL, NULL, 'Пичкур Игорь (Евпатория)-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2862, 2, NULL, NULL, NULL, NULL, NULL, 'Пищенко Виталий Александрович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2863, 0, NULL, NULL, NULL, NULL, 910201001, 'ПКФ ГОЛАН ООО - А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2864, 0, NULL, NULL, NULL, NULL, NULL, 'ПКФ ДАГ  ', NULL, NULL, '7 978 706 42 38 Владимир Петрович ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2865, 0, NULL, NULL, NULL, NULL, NULL, 'Платонов А.И. ', NULL, NULL, '7 978 106 5001', 0, NULL);
INSERT INTO public.contractors VALUES (2866, 1, NULL, NULL, NULL, NULL, NULL, 'Плахотник 79787524679', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2867, 1, NULL, NULL, NULL, NULL, NULL, 'Плахотный В.Н. ', NULL, NULL, '7 978 82 364 28', 0, NULL);
INSERT INTO public.contractors VALUES (2868, 1, NULL, NULL, NULL, NULL, NULL, 'Плахотный Дмитрий Сергеевич ', NULL, NULL, '7978 764 03 54', 0, NULL);
INSERT INTO public.contractors VALUES (2869, 1, NULL, NULL, NULL, NULL, NULL, 'Плеванюк Г.Е. ', NULL, NULL, '79781094823', 0, NULL);
INSERT INTO public.contractors VALUES (2870, 0, NULL, NULL, NULL, NULL, NULL, 'Плевко А.П. ', NULL, NULL, '7 978 735 77 69', 0, NULL);
INSERT INTO public.contractors VALUES (2871, 1, NULL, NULL, NULL, NULL, NULL, 'Плескань ЮВ 79781489834', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2872, 1, NULL, NULL, NULL, NULL, NULL, 'Плещев В.В. ', NULL, NULL, '7 978 800 64 92', 0, NULL);
INSERT INTO public.contractors VALUES (2873, 1, NULL, NULL, NULL, NULL, NULL, 'Плоский С.В. ', NULL, NULL, '7 978 82 83 640', 0, NULL);
INSERT INTO public.contractors VALUES (2874, 1, NULL, NULL, NULL, NULL, NULL, 'Плотников Л.И. ', NULL, NULL, '7 978 846 07 36', 0, NULL);
INSERT INTO public.contractors VALUES (2875, 0, NULL, NULL, NULL, NULL, NULL, 'Плотников С.В. ', NULL, NULL, '7 978 77 36 892', 0, NULL);
INSERT INTO public.contractors VALUES (2876, 1, NULL, NULL, NULL, NULL, NULL, 'Плюта А.А. ', NULL, NULL, '7 978 724 28 62', 0, NULL);
INSERT INTO public.contractors VALUES (2877, 1, NULL, NULL, NULL, NULL, NULL, 'ПНК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2878, 1, NULL, NULL, NULL, NULL, NULL, 'Повстяной В.Г. ', NULL, NULL, '7 978 758 93 51', 0, NULL);
INSERT INTO public.contractors VALUES (2879, 0, NULL, NULL, NULL, NULL, NULL, 'Погодин И.М. ', NULL, NULL, '7 978 707 95 24', 0, NULL);
INSERT INTO public.contractors VALUES (2880, 0, NULL, NULL, NULL, NULL, NULL, 'Погосян Артур Эдуардович ', NULL, NULL, '79789626085', 0, NULL);
INSERT INTO public.contractors VALUES (2881, 1, NULL, NULL, NULL, NULL, NULL, 'Погребной В.В. ', NULL, NULL, '7 978 83 74 969', 0, NULL);
INSERT INTO public.contractors VALUES (2882, 1, NULL, NULL, NULL, NULL, NULL, 'Погребов АС 79780180406', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2883, 0, NULL, NULL, NULL, NULL, NULL, 'Подгородецкий СВ ', NULL, NULL, '79788230189', 0, NULL);
INSERT INTO public.contractors VALUES (2884, 1, NULL, NULL, NULL, NULL, NULL, 'Подковырин А.А., ', NULL, NULL, '7 978 82 71 007', 0, NULL);
INSERT INTO public.contractors VALUES (2885, 1, NULL, NULL, NULL, NULL, NULL, 'Подковырин Г.А. ', NULL, NULL, '7 978 787 44 32', 0, NULL);
INSERT INTO public.contractors VALUES (2886, 0, NULL, NULL, NULL, NULL, NULL, 'Подолько Павел ', NULL, NULL, '79787978748', 0, NULL);
INSERT INTO public.contractors VALUES (2887, 1, NULL, NULL, NULL, NULL, NULL, 'Подосинников 79787436536', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2888, 1, NULL, NULL, NULL, NULL, NULL, 'Подчасов ВО 79785950725', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2889, 0, NULL, NULL, NULL, NULL, NULL, 'Пожстрой-Юг ', NULL, NULL, '7 978 911 0011 Владимир', 0, NULL);
INSERT INTO public.contractors VALUES (2890, 0, NULL, NULL, NULL, NULL, NULL, 'Поздняков О.В. ', NULL, NULL, '7978 848 50 90', 0, NULL);
INSERT INTO public.contractors VALUES (2891, 1, NULL, NULL, NULL, NULL, NULL, 'Покаместова Е.Н. ', NULL, NULL, '7 978 029 83 77', 0, NULL);
INSERT INTO public.contractors VALUES (2892, 1, NULL, NULL, NULL, NULL, NULL, 'Покатаев ВВ 79788422976', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2893, 0, NULL, NULL, NULL, NULL, NULL, 'Покатский О.В.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2894, 1, NULL, NULL, NULL, NULL, NULL, 'Полехин В.Р. ', NULL, NULL, '7 978 78 89 216', 0, NULL);
INSERT INTO public.contractors VALUES (2895, 1, NULL, NULL, NULL, NULL, NULL, 'Полещук АС 79788303059', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2896, 1, NULL, NULL, NULL, NULL, NULL, 'Ползиков Андрей ', NULL, NULL, '7 978 745 75 99', 0, NULL);
INSERT INTO public.contractors VALUES (2897, 0, NULL, NULL, NULL, NULL, NULL, 'Полиенко Е.Б. ', NULL, NULL, '7 978 705 95 29', 0, NULL);
INSERT INTO public.contractors VALUES (2898, 0, NULL, NULL, NULL, NULL, NULL, 'Полиенко Юрий Валерьевич ', NULL, NULL, '79787059529', 0, NULL);
INSERT INTO public.contractors VALUES (2899, 0, NULL, NULL, NULL, NULL, NULL, 'Полищук Андрей ', NULL, NULL, '7 978 705 88 73', 0, NULL);
INSERT INTO public.contractors VALUES (2900, 1, NULL, NULL, NULL, NULL, NULL, 'Половченко А.В. ', NULL, NULL, '79780143925', 0, NULL);
INSERT INTO public.contractors VALUES (2901, 1, NULL, NULL, NULL, NULL, NULL, 'Полоник В.Ф. ', NULL, NULL, '7 978 70 58 059', 0, NULL);
INSERT INTO public.contractors VALUES (2902, 0, NULL, NULL, NULL, NULL, NULL, 'Полторацкий ', NULL, NULL, '7 978 71 39 574', 0, NULL);
INSERT INTO public.contractors VALUES (2903, 1, NULL, NULL, NULL, NULL, NULL, 'Полывьян Н.О. ', NULL, NULL, '7978 841 62 48', 0, NULL);
INSERT INTO public.contractors VALUES (2904, 1, NULL, NULL, NULL, NULL, NULL, 'Полывяная Ольга Валерьевна ', NULL, NULL, '7978 003 56 60', 0, NULL);
INSERT INTO public.contractors VALUES (2905, 1, NULL, NULL, NULL, NULL, NULL, 'Польский 79788428560', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2906, 1, NULL, NULL, NULL, NULL, NULL, 'Поляков А.А. ', NULL, NULL, '7978 71 066 03', 0, NULL);
INSERT INTO public.contractors VALUES (2907, 1, NULL, NULL, NULL, NULL, NULL, 'Поляков Антон Викторович ', NULL, NULL, '7978 719 49 70', 0, NULL);
INSERT INTO public.contractors VALUES (2908, 1, NULL, NULL, NULL, NULL, NULL, 'Поляков С.А. ', NULL, NULL, '7 978 733 04 68', 0, NULL);
INSERT INTO public.contractors VALUES (2909, 1, NULL, NULL, NULL, NULL, NULL, 'Поляков Сергей Юрьевич ', NULL, NULL, '7978 739 64 38', 0, NULL);
INSERT INTO public.contractors VALUES (2910, 2, NULL, NULL, NULL, NULL, NULL, 'Полякова С. В. ИП КРЫМСК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2911, 1, NULL, NULL, NULL, NULL, NULL, 'Полянский АИ 79787811662', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2912, 1, NULL, NULL, NULL, NULL, NULL, 'Пометий РВ  (к п)79782146291', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2913, 1, NULL, NULL, NULL, NULL, NULL, 'Пономарев ДВ 79785563851', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2914, 0, NULL, NULL, NULL, NULL, NULL, 'Пономаренко Александр ', NULL, NULL, '79787727387', 0, NULL);
INSERT INTO public.contractors VALUES (2915, 1, NULL, NULL, NULL, NULL, NULL, 'Пономаренко АН 79780900887', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2916, 0, NULL, NULL, NULL, NULL, NULL, 'Пономаренко Оксана Васильевна ', NULL, NULL, '79788332478', 0, NULL);
INSERT INTO public.contractors VALUES (2917, 1, NULL, NULL, NULL, NULL, NULL, 'Попов АВ 79890800048', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2918, 1, NULL, NULL, NULL, NULL, NULL, 'Попов В.А. ', NULL, NULL, '7 978 830 44 53', 0, NULL);
INSERT INTO public.contractors VALUES (2919, 1, NULL, NULL, NULL, NULL, NULL, 'Попов В.А. ', NULL, NULL, '79788108204', 0, NULL);
INSERT INTO public.contractors VALUES (2920, 1, NULL, NULL, NULL, NULL, NULL, 'Попов Вятчесла (к.п.) ', NULL, NULL, '79787579577', 0, NULL);
INSERT INTO public.contractors VALUES (2921, 1, NULL, NULL, NULL, NULL, NULL, 'Попов И.В. ', NULL, NULL, '7 978 82 71 998', 0, NULL);
INSERT INTO public.contractors VALUES (2922, 1, NULL, NULL, NULL, NULL, NULL, 'Попов Павел ', NULL, NULL, '7 978 036 23 99', 0, NULL);
INSERT INTO public.contractors VALUES (2923, 1, NULL, NULL, NULL, NULL, NULL, 'Попов Р.В. ', NULL, NULL, '7978 81 400 63', 0, NULL);
INSERT INTO public.contractors VALUES (2924, 1, NULL, NULL, NULL, NULL, NULL, 'Попова Л,Н. ', NULL, NULL, '7978 817 45 58', 0, NULL);
INSERT INTO public.contractors VALUES (2925, 1, NULL, NULL, NULL, NULL, NULL, 'Поповчук Нина ', NULL, NULL, '7 978 73 80 697', 0, NULL);
INSERT INTO public.contractors VALUES (2926, 0, NULL, NULL, NULL, NULL, NULL, 'Попсуй Михаил Анатольевич ', NULL, NULL, '79781466376', 0, NULL);
INSERT INTO public.contractors VALUES (2927, 1, NULL, NULL, NULL, NULL, NULL, 'Порсин В.Н. ', NULL, NULL, '7 978 764 93 63', 0, NULL);
INSERT INTO public.contractors VALUES (2928, 0, NULL, NULL, NULL, NULL, NULL, 'Порт Пусан ', NULL, NULL, '7978727 3111 Денис- А.', 0, NULL);
INSERT INTO public.contractors VALUES (2929, 1, NULL, NULL, NULL, NULL, NULL, 'Портянко ОВ 79787498330', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2930, 1, NULL, NULL, NULL, NULL, NULL, 'Порфирова Л.А. ', NULL, NULL, '7978 89 05 801', 0, NULL);
INSERT INTO public.contractors VALUES (2931, 1, NULL, NULL, NULL, NULL, NULL, '"Поставшик:				 Завозина Екатерина Олеговна																											 																														"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2932, 1, NULL, NULL, NULL, NULL, NULL, 'Посунько А.В. ', NULL, NULL, '7 978 86 38 735', 0, NULL);
INSERT INTO public.contractors VALUES (2933, 0, NULL, NULL, NULL, NULL, NULL, 'Посунько А.В. ', NULL, NULL, '79780875140', 0, NULL);
INSERT INTO public.contractors VALUES (2934, 1, NULL, NULL, NULL, NULL, NULL, 'Посылайко В.А. ', NULL, NULL, '7 978 809 96 26', 0, NULL);
INSERT INTO public.contractors VALUES (2935, 0, NULL, NULL, NULL, NULL, NULL, 'Потапенко Сергей ', NULL, NULL, '7 978 729 42 56', 0, NULL);
INSERT INTO public.contractors VALUES (2936, 1, NULL, NULL, NULL, NULL, NULL, 'Потапов И.А. ', NULL, NULL, '79782570164', 0, NULL);
INSERT INTO public.contractors VALUES (2937, 1, NULL, NULL, NULL, NULL, NULL, 'Потриденнный Анатолий ', NULL, NULL, '7978 76 36 802', 0, NULL);
INSERT INTO public.contractors VALUES (2938, 1, NULL, NULL, NULL, NULL, NULL, 'Почкун С.Н. ', NULL, NULL, '7 978 806 455 2', 0, NULL);
INSERT INTO public.contractors VALUES (2939, 0, NULL, NULL, NULL, NULL, NULL, 'Поярков В.П. ', NULL, NULL, '7 978 835 66 38', 0, NULL);
INSERT INTO public.contractors VALUES (2940, 0, NULL, NULL, NULL, NULL, NULL, 'ПП Конус ', NULL, NULL, '79787130353 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2941, 0, NULL, NULL, NULL, NULL, NULL, 'Правдивец Андрей Вячеславович ', NULL, NULL, '79781101823', 0, NULL);
INSERT INTO public.contractors VALUES (2942, 1, NULL, NULL, NULL, NULL, NULL, 'Правосуд Евгений Иванович ', NULL, NULL, '7918 339 33 00', 0, NULL);
INSERT INTO public.contractors VALUES (2943, 1, NULL, NULL, NULL, NULL, NULL, 'Працюк ВМ 79788575617', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2944, 1, NULL, NULL, NULL, NULL, NULL, 'Предигер АА 79787215057', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2945, 1, NULL, NULL, NULL, NULL, NULL, 'Преступов Вячеслав ', NULL, NULL, ' 7978 799 67 52 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (2946, 1, NULL, NULL, NULL, NULL, NULL, 'Прибылов А.В. ', NULL, NULL, '7978 267 56 19', 0, NULL);
INSERT INTO public.contractors VALUES (2947, 2, NULL, NULL, NULL, NULL, NULL, 'Прибыткин Валерий Леонидович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2948, 1, NULL, NULL, NULL, NULL, NULL, 'Привиден ДА 79787508626', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2949, 1, NULL, NULL, NULL, NULL, NULL, 'Приз Игорь Львович ', NULL, NULL, '7 978 719 15 68', 0, NULL);
INSERT INTO public.contractors VALUES (2950, 1, NULL, NULL, NULL, NULL, NULL, 'Приймак А.П. ', NULL, NULL, '7978 116 76 02', 0, NULL);
INSERT INTO public.contractors VALUES (2951, 1, NULL, NULL, NULL, NULL, NULL, 'Приметов А.В. ', NULL, NULL, '7 978 261 53 51', 0, NULL);
INSERT INTO public.contractors VALUES (2952, 0, NULL, NULL, NULL, NULL, NULL, 'Примчук А.Н. ', NULL, NULL, '7 978 77 30 160', 0, NULL);
INSERT INTO public.contractors VALUES (2953, 0, NULL, NULL, NULL, NULL, NULL, 'ПРИОРИТЕТ А  Сергей ', NULL, NULL, '7978 126 24-34 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2954, 1, NULL, NULL, NULL, NULL, NULL, 'Присакарь ВК 79787752479', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2955, 1, NULL, NULL, NULL, NULL, NULL, 'Приступа В.А. ', NULL, NULL, '7 978 799 67 52', 0, NULL);
INSERT INTO public.contractors VALUES (2956, 1, NULL, NULL, NULL, NULL, NULL, 'Приходько А.А. ', NULL, NULL, '7 978 744 58 83', 0, NULL);
INSERT INTO public.contractors VALUES (2957, 1, NULL, NULL, NULL, NULL, NULL, 'Приходько А.П. ', NULL, NULL, '7978 70 88 776', 0, NULL);
INSERT INTO public.contractors VALUES (2958, 1, NULL, NULL, NULL, NULL, NULL, 'Приходько ЕЕ 79787021717', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2959, 1, NULL, NULL, NULL, NULL, NULL, 'Причко ВА 79788005019', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2960, 0, NULL, NULL, NULL, NULL, NULL, 'Приятное свидание', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2961, 2, NULL, NULL, NULL, NULL, NULL, 'Приятное Свидание (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2962, 0, NULL, NULL, NULL, NULL, NULL, 'Прогрессия Владимир -д.п.-А. ', NULL, NULL, '7978 960 46 35', 0, NULL);
INSERT INTO public.contractors VALUES (2963, 0, NULL, NULL, NULL, NULL, NULL, 'Продсервис ', NULL, NULL, '79292008507', 0, NULL);
INSERT INTO public.contractors VALUES (2964, 0, NULL, NULL, NULL, NULL, NULL, 'Прокопчук Валерий (Гвардейское) - А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2965, 0, NULL, NULL, NULL, NULL, NULL, 'Промдорснаб ООО ', NULL, NULL, '7 978 106 13 97', 0, NULL);
INSERT INTO public.contractors VALUES (2966, 0, NULL, NULL, NULL, NULL, NULL, 'Промпарк Александр ', NULL, NULL, '7 978 851 89 46 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2967, 0, NULL, NULL, NULL, NULL, NULL, 'ПромСтройИнвест -А. ', NULL, NULL, '7978725-95-01 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2968, 0, NULL, NULL, NULL, NULL, NULL, 'Промстройпроэкт  79780510673 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2969, 0, NULL, NULL, NULL, NULL, NULL, 'Промторг ООО ', NULL, NULL, '7 978 788 07 55', 0, NULL);
INSERT INTO public.contractors VALUES (2970, 1, NULL, NULL, NULL, NULL, NULL, 'Пронских Р.Б. ', NULL, NULL, '7978 09 99 015', 0, NULL);
INSERT INTO public.contractors VALUES (2971, 1, NULL, NULL, NULL, NULL, NULL, 'Пронькин АВ 79780936040', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2972, 1, NULL, NULL, NULL, NULL, NULL, 'Прораб Андрей ', NULL, NULL, '7 978 706 52 76', 0, NULL);
INSERT INTO public.contractors VALUES (2973, 0, NULL, NULL, NULL, NULL, NULL, 'Проскурякова Ангелина Степановна ', NULL, NULL, '7 978 789 03 37', 0, NULL);
INSERT INTO public.contractors VALUES (2974, 0, NULL, NULL, NULL, NULL, NULL, 'ПРОСПЕРО-ЮГ  Илья Владимирович ', NULL, NULL, '7 978 852 85 00 _Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (2975, 0, NULL, NULL, NULL, NULL, NULL, 'просчет', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2976, 1, NULL, NULL, NULL, NULL, NULL, 'Протько В.П. ', NULL, NULL, '7 978 745 15 53', 0, NULL);
INSERT INTO public.contractors VALUES (2977, 0, NULL, NULL, NULL, NULL, NULL, '"Профессионалстрой"" ', NULL, NULL, '7978 833 00 08 (77) ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (2978, 0, NULL, NULL, NULL, NULL, NULL, 'Профи (д.п.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2979, 0, NULL, NULL, NULL, NULL, NULL, 'Профильдрев-Крым Леонид ', NULL, NULL, '7 978 554 2615 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (2980, 0, NULL, NULL, NULL, NULL, NULL, 'Профильные системы ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2981, 0, NULL, NULL, NULL, NULL, 910901001, '"ПРОФМОДУЛЬ-ЮГ""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2982, 1, NULL, NULL, NULL, NULL, NULL, 'Прохоренко АА 79788029725', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2983, 0, NULL, NULL, NULL, NULL, NULL, 'Прохоренко Василий ', NULL, NULL, '79788261127', 0, NULL);
INSERT INTO public.contractors VALUES (2984, 1, NULL, NULL, NULL, NULL, NULL, 'Прохоров Д.В. ', NULL, NULL, '7978 853 36 48', 0, NULL);
INSERT INTO public.contractors VALUES (2985, 0, NULL, NULL, NULL, NULL, NULL, 'Прохоров Дмитрий Владимирович ', NULL, NULL, '79788101043', 0, NULL);
INSERT INTO public.contractors VALUES (2986, 1, NULL, NULL, NULL, NULL, NULL, 'Проценко С.Р. ', NULL, NULL, '79780627724', 0, NULL);
INSERT INTO public.contractors VALUES (2987, 1, NULL, NULL, NULL, NULL, NULL, 'Процюк В.Н. 8-978-857-56-17', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2988, 1, NULL, NULL, NULL, NULL, NULL, 'Прошин А.В. ', NULL, NULL, '7 978 867 10 26', 0, NULL);
INSERT INTO public.contractors VALUES (2989, 2, NULL, NULL, NULL, NULL, NULL, 'Прудников А.М (маг. ТЕМП). ул. Русская 54', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2990, 1, NULL, NULL, NULL, NULL, NULL, 'Прудников А.Н. ', NULL, NULL, '7 978 71 59 302', 0, NULL);
INSERT INTO public.contractors VALUES (2991, 1, NULL, NULL, NULL, NULL, NULL, 'Прялко Н.Н ', NULL, NULL, '79782608530', 0, NULL);
INSERT INTO public.contractors VALUES (2992, 0, NULL, NULL, NULL, NULL, NULL, 'Птащенко А.В. ', NULL, NULL, '79787074744', 0, NULL);
INSERT INTO public.contractors VALUES (2993, 1, NULL, NULL, NULL, NULL, NULL, 'Пугаева ЛИ 79788314821', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2994, 1, NULL, NULL, NULL, NULL, NULL, 'Пудов А.А. ', NULL, NULL, '79782565605', 0, NULL);
INSERT INTO public.contractors VALUES (2995, 0, NULL, NULL, NULL, NULL, NULL, 'Пузин А.Е. ', NULL, NULL, ' 7978 756 68 02', 0, NULL);
INSERT INTO public.contractors VALUES (2996, 1, NULL, NULL, NULL, NULL, NULL, 'Пума А.К. ', NULL, NULL, '79780210238', 0, NULL);
INSERT INTO public.contractors VALUES (2997, 1, NULL, NULL, NULL, NULL, NULL, 'Пуп В.Н. ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2998, 1, NULL, NULL, NULL, NULL, NULL, 'Пупок В.И. 8-978-666-66-66', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (2999, 1, NULL, NULL, NULL, NULL, NULL, 'Пургин ВН 79787991798', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3000, 0, NULL, NULL, NULL, NULL, NULL, 'Пустовалов Александр ', NULL, NULL, '7 978 971 79 90', 0, NULL);
INSERT INTO public.contractors VALUES (3001, 2, NULL, NULL, NULL, NULL, NULL, 'Пустовая Н. В. ИП Тимашевск', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3002, 0, NULL, NULL, NULL, NULL, NULL, 'Пустовит Сергей ', NULL, NULL, '7 978 041 38 63', 0, NULL);
INSERT INTO public.contractors VALUES (3003, 1, NULL, NULL, NULL, NULL, NULL, 'Путилин НГ 79787072568', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3004, 0, NULL, NULL, NULL, NULL, NULL, 'Пучкаев С.И. ', NULL, NULL, '7 978 706 98 21', 0, NULL);
INSERT INTO public.contractors VALUES (3005, 0, NULL, NULL, NULL, NULL, NULL, 'Пушкар В.И. ', NULL, NULL, '79787312120', 0, NULL);
INSERT INTO public.contractors VALUES (3006, 1, NULL, NULL, NULL, NULL, NULL, 'Пчельников И.В. ', NULL, NULL, '7 978 736 753 1', 0, NULL);
INSERT INTO public.contractors VALUES (3007, 1, NULL, NULL, NULL, NULL, NULL, 'Пшеничных А.В. ', NULL, NULL, '7 978 766 63 05', 0, NULL);
INSERT INTO public.contractors VALUES (3008, 0, NULL, NULL, NULL, NULL, NULL, 'Пшепарук Александр Семенович ', NULL, NULL, '79788558855', 0, NULL);
INSERT INTO public.contractors VALUES (3009, 1, NULL, NULL, NULL, NULL, NULL, 'Пырх А.К. ', NULL, NULL, '7 978 868 32 31', 0, NULL);
INSERT INTO public.contractors VALUES (3010, 1, NULL, NULL, NULL, NULL, NULL, 'Пянковская Т.И. ', NULL, NULL, '7978 876 00 26 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3011, 0, NULL, NULL, NULL, NULL, NULL, 'Пятериков В.В. ', NULL, NULL, '7 978 723 08 06', 0, NULL);
INSERT INTO public.contractors VALUES (3012, 1, NULL, NULL, NULL, NULL, NULL, 'Пятериков Д.О. ', NULL, NULL, '7 978 822 79 07', 0, NULL);
INSERT INTO public.contractors VALUES (3013, 1, NULL, NULL, NULL, NULL, NULL, 'Пятых Е.Н. ', NULL, NULL, '7978 753 64 11', 0, NULL);
INSERT INTO public.contractors VALUES (3014, 1, NULL, NULL, NULL, NULL, NULL, 'Равликовский В.В. ', NULL, NULL, '7 978 75 169 76', 0, NULL);
INSERT INTO public.contractors VALUES (3015, 1, NULL, NULL, NULL, NULL, NULL, 'Рагимов Ф.Г. ', NULL, NULL, '7 978 09 06 777', 0, NULL);
INSERT INTO public.contractors VALUES (3016, 1, NULL, NULL, NULL, NULL, NULL, 'Рагульский ИЭ 79787891715', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3017, 2, NULL, NULL, NULL, NULL, NULL, 'Рада', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3018, 0, NULL, NULL, NULL, NULL, NULL, 'радуга', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3019, 1, NULL, NULL, NULL, NULL, NULL, 'Радченко А.Г. ', NULL, NULL, '7978 799 43 56', 0, NULL);
INSERT INTO public.contractors VALUES (3020, 0, NULL, NULL, NULL, NULL, NULL, 'Радченко В.О. ', NULL, NULL, '7 978 723 93 11', 0, NULL);
INSERT INTO public.contractors VALUES (3021, 1, NULL, NULL, NULL, NULL, NULL, 'Радченко И 79787550025', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3022, 1, NULL, NULL, NULL, NULL, NULL, 'Разгонов Г.А. ', NULL, NULL, '7978 844 78 85', 0, NULL);
INSERT INTO public.contractors VALUES (3023, 1, NULL, NULL, NULL, NULL, NULL, 'Раззаков СС 79782640682 79788675387', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3024, 1, NULL, NULL, NULL, NULL, NULL, 'Раив Д.Н. ', NULL, NULL, '7978 898 56 95', 0, NULL);
INSERT INTO public.contractors VALUES (3025, 1, NULL, NULL, NULL, NULL, NULL, 'Раип ', NULL, NULL, '79788455453', 0, NULL);
INSERT INTO public.contractors VALUES (3026, 2, NULL, NULL, NULL, NULL, NULL, 'Райков Виталий Витальевич ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3027, 1, NULL, NULL, NULL, NULL, NULL, 'Райхель СА 79265288578', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3028, 1, NULL, NULL, NULL, NULL, NULL, 'Ракша О.В. ', NULL, NULL, '7 978 735 81 59', 0, NULL);
INSERT INTO public.contractors VALUES (3029, 0, NULL, NULL, NULL, NULL, NULL, 'Ракща А.А. ', NULL, NULL, '7978 782 82 18 Андрей ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3030, 1, NULL, NULL, NULL, NULL, NULL, 'Ралдугин В.Л. ', NULL, NULL, '7 978 793 0009', 0, NULL);
INSERT INTO public.contractors VALUES (3031, 1, NULL, NULL, NULL, NULL, NULL, 'Распутина ОП 79788324132', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3032, 1, NULL, NULL, NULL, NULL, NULL, 'Рассохин ВС79788336827', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3033, 1, NULL, NULL, NULL, NULL, NULL, 'Растопин Дмитрий ', NULL, NULL, '7 978 892 89 11', 0, NULL);
INSERT INTO public.contractors VALUES (3034, 1, NULL, NULL, NULL, NULL, NULL, 'Расторгуев А.В. ', NULL, NULL, '7 978 72 92 134', 0, NULL);
INSERT INTO public.contractors VALUES (3035, 1, NULL, NULL, NULL, NULL, NULL, 'Ратушный Роман ', NULL, NULL, '79788602228 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (3036, 0, NULL, NULL, NULL, NULL, NULL, 'Рахматов С. ', NULL, NULL, '7 978 74 57 836', 0, NULL);
INSERT INTO public.contractors VALUES (3037, 1, NULL, NULL, NULL, NULL, NULL, 'Рачинский В.В. ', NULL, NULL, '7 978 79 15 79 6', 0, NULL);
INSERT INTO public.contractors VALUES (3038, 1, NULL, NULL, NULL, NULL, NULL, 'Рашитов Э.Д. ', NULL, NULL, '7 978 850 48 29', 0, NULL);
INSERT INTO public.contractors VALUES (3039, 1, NULL, NULL, NULL, NULL, NULL, 'Ращектаев МИ 79788312761', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3040, 0, NULL, NULL, NULL, NULL, NULL, 'РБК Сервис ', NULL, NULL, '7985 025 91 33 Лев', 0, NULL);
INSERT INTO public.contractors VALUES (3041, 0, NULL, NULL, NULL, NULL, NULL, 'РБУ-КОМПЛЕКТ 79787467237 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3042, 1, NULL, NULL, NULL, NULL, NULL, 'Ребро ЕП ', NULL, NULL, '79782235530', 0, NULL);
INSERT INTO public.contractors VALUES (3043, 0, NULL, NULL, NULL, NULL, NULL, 'Ребрунов Константин ', NULL, NULL, '79787541413', 0, NULL);
INSERT INTO public.contractors VALUES (3044, 1, NULL, NULL, NULL, NULL, NULL, 'Рева СА 79780542623', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3045, 1, NULL, NULL, NULL, NULL, NULL, 'Ревтов Сергей Николаевич ', NULL, NULL, '79787582922', 0, NULL);
INSERT INTO public.contractors VALUES (3046, 0, NULL, NULL, NULL, NULL, NULL, 'Резанов Алексей Вадимович ', NULL, NULL, '79787553646', 0, NULL);
INSERT INTO public.contractors VALUES (3047, 0, NULL, NULL, NULL, NULL, NULL, 'Резаханов Александр ', NULL, NULL, '7 978 11 07 800', 0, NULL);
INSERT INTO public.contractors VALUES (3048, 1, NULL, NULL, NULL, NULL, NULL, 'Резвый Д.А. ', NULL, NULL, '7 978 818 58 04', 0, NULL);
INSERT INTO public.contractors VALUES (3049, 1, NULL, NULL, NULL, NULL, NULL, 'Резник А.В. ', NULL, NULL, '7 978 843 20 04', 0, NULL);
INSERT INTO public.contractors VALUES (3050, 0, NULL, NULL, NULL, NULL, NULL, 'Резник Дмитрий ', NULL, NULL, '7 978 848 33 90', 0, NULL);
INSERT INTO public.contractors VALUES (3051, 1, NULL, NULL, NULL, NULL, NULL, 'Резниченко Ю.Л. ', NULL, NULL, '7 978 810 24 10', 0, NULL);
INSERT INTO public.contractors VALUES (3052, 1, NULL, NULL, NULL, NULL, NULL, 'Резьник АИ 79787118707', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3053, 1, NULL, NULL, NULL, NULL, NULL, 'Рейх Артур', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3054, 0, NULL, NULL, NULL, NULL, NULL, 'Рекламная продукция', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3055, 0, NULL, NULL, NULL, NULL, NULL, 'Рекламное агенство Форсаж', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3056, 0, NULL, NULL, NULL, NULL, NULL, 'Ременюк М.А. ', NULL, NULL, '79780952884', 0, NULL);
INSERT INTO public.contractors VALUES (3057, 0, NULL, NULL, NULL, NULL, NULL, 'Реметов А.В. ', NULL, NULL, '7 978 261 53 51', 0, NULL);
INSERT INTO public.contractors VALUES (3058, 0, NULL, NULL, NULL, NULL, NULL, 'Ремстрой 79782198101 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3059, 1, NULL, NULL, NULL, NULL, NULL, 'Ремыга И.В. ', NULL, NULL, '7978 844 76 04', 0, NULL);
INSERT INTO public.contractors VALUES (3060, 0, NULL, NULL, NULL, NULL, NULL, 'Репалова Татьяна Николаевна ', NULL, NULL, '79788156144', 0, NULL);
INSERT INTO public.contractors VALUES (3061, 1, NULL, NULL, NULL, NULL, NULL, 'Реут О 79788906079', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3062, 0, NULL, NULL, NULL, NULL, NULL, 'Рефат (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3063, 1, NULL, NULL, NULL, NULL, NULL, 'Решат ', NULL, NULL, '7 978 823 17 37', 0, NULL);
INSERT INTO public.contractors VALUES (3064, 1, NULL, NULL, NULL, NULL, NULL, 'Решатов Рустем ', NULL, NULL, '7 978 843 54 30 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3065, 0, NULL, NULL, NULL, NULL, NULL, 'Решетников Алексей ', NULL, NULL, '79787454671', 0, NULL);
INSERT INTO public.contractors VALUES (3066, 0, NULL, NULL, NULL, NULL, NULL, 'Решетников Иван ', NULL, NULL, '79787857956', 0, NULL);
INSERT INTO public.contractors VALUES (3067, 1, NULL, NULL, NULL, NULL, NULL, 'Решетников Ю.В. ', NULL, NULL, '7 978 70 60 997', 0, NULL);
INSERT INTO public.contractors VALUES (3068, 1, NULL, NULL, NULL, NULL, NULL, 'Решитько В.М. ', NULL, NULL, '79787691355', 0, NULL);
INSERT INTO public.contractors VALUES (3069, 1, NULL, NULL, NULL, NULL, NULL, 'Ржавский Б.М. ', NULL, NULL, '7 978 821 52 89', 0, NULL);
INSERT INTO public.contractors VALUES (3070, 1, NULL, NULL, NULL, NULL, NULL, 'Ритерна ', NULL, NULL, '7 978 773 40 38 Вадим ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3071, 0, NULL, NULL, NULL, NULL, NULL, 'РКЦ-Юг', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3072, 0, NULL, NULL, NULL, NULL, 910201001, '"РКЦ-ЮГ"" (д.п.) _Л ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3073, 0, NULL, NULL, NULL, NULL, 910201001, '"РКЦ-ЮГ"", Полунин Виктор РКЦ ', NULL, NULL, '7 978 757 02 52 (д.п.) - Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3074, 1, NULL, NULL, NULL, NULL, NULL, 'Рогаль Ф.Ф. ', NULL, NULL, '7978 705 12 14', 0, NULL);
INSERT INTO public.contractors VALUES (3075, 1, NULL, NULL, NULL, NULL, NULL, 'Рогальский В.В. ', NULL, NULL, '7 978 85 91 082', 0, NULL);
INSERT INTO public.contractors VALUES (3076, 1, NULL, NULL, NULL, NULL, NULL, 'Рогов СО 79788534665', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3077, 0, NULL, NULL, NULL, NULL, NULL, 'Рогова Ольга/Владимир ', NULL, NULL, '79781362290', 0, NULL);
INSERT INTO public.contractors VALUES (3078, 1, NULL, NULL, NULL, NULL, NULL, 'Рогожкин А.Н. ', NULL, NULL, '7 978 013 28 68', 0, NULL);
INSERT INTO public.contractors VALUES (3079, 0, NULL, NULL, NULL, NULL, NULL, 'Родак ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3080, 1, NULL, NULL, NULL, NULL, NULL, 'Родичев В.И. ', NULL, NULL, '7978 7170 263', 0, NULL);
INSERT INTO public.contractors VALUES (3081, 0, NULL, NULL, NULL, NULL, NULL, 'Родкин Олег', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3082, 0, NULL, NULL, NULL, NULL, NULL, 'Родник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3083, 0, NULL, NULL, NULL, NULL, NULL, 'Родник  83532436160 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3084, 0, NULL, NULL, NULL, NULL, NULL, 'Родничок', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3085, 1, NULL, NULL, NULL, NULL, NULL, 'Роженков О.В. ', NULL, NULL, '7 978 209 79 83', 0, NULL);
INSERT INTO public.contractors VALUES (3086, 1, NULL, NULL, NULL, NULL, NULL, 'Рожков А.А. ', NULL, NULL, '7978 8307 259', 0, NULL);
INSERT INTO public.contractors VALUES (3087, 0, NULL, NULL, NULL, NULL, NULL, 'Рожков Александр ', NULL, NULL, '79788307259', 0, NULL);
INSERT INTO public.contractors VALUES (3088, 1, NULL, NULL, NULL, NULL, NULL, 'Розанов В. ', NULL, NULL, '7978 716 14 19', 0, NULL);
INSERT INTO public.contractors VALUES (3089, 0, NULL, NULL, NULL, NULL, NULL, 'Розмирский Д.В. ', NULL, NULL, '7 978 708 78 41', 0, NULL);
INSERT INTO public.contractors VALUES (3090, 1, NULL, NULL, NULL, NULL, NULL, 'Розница Крым', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3091, 0, NULL, NULL, NULL, NULL, NULL, 'Розница Крым', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3092, 0, NULL, NULL, NULL, NULL, NULL, 'Розничный покупатель', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3093, 1, NULL, NULL, NULL, NULL, NULL, 'Роман 89184995899', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3094, 0, NULL, NULL, NULL, NULL, NULL, 'Роман Легион-А. д.п.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3095, 0, NULL, NULL, NULL, NULL, NULL, 'Романенко Дмитрий ', NULL, NULL, '7 978 791 14 56', 0, NULL);
INSERT INTO public.contractors VALUES (3096, 1, NULL, NULL, NULL, NULL, NULL, 'Романов Сергей ', NULL, NULL, '7978 79 346 81', 0, NULL);
INSERT INTO public.contractors VALUES (3097, 0, NULL, NULL, NULL, NULL, NULL, 'Романовская Ирина Николаевна ', NULL, NULL, '79787315440', 0, NULL);
INSERT INTO public.contractors VALUES (3098, 1, NULL, NULL, NULL, NULL, NULL, 'Романча И.А. ', NULL, NULL, '7978 73 216 81', 0, NULL);
INSERT INTO public.contractors VALUES (3099, 1, NULL, NULL, NULL, NULL, NULL, 'Романчук И.В. ', NULL, NULL, '7 978 838 57 97', 0, NULL);
INSERT INTO public.contractors VALUES (3100, 1, NULL, NULL, NULL, NULL, NULL, 'Романюк А.С. ', NULL, NULL, '7 978 044 94 85', 0, NULL);
INSERT INTO public.contractors VALUES (3101, 1, NULL, NULL, NULL, NULL, NULL, 'Ромашов С.А., ', NULL, NULL, '7 978 74 34807', 0, NULL);
INSERT INTO public.contractors VALUES (3102, 0, NULL, NULL, NULL, NULL, NULL, 'Роскошный дом', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3103, 1, NULL, NULL, NULL, NULL, NULL, 'Росла  (Татьяна ', NULL, NULL, '7978 762 62 52 д.п.) ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3104, 0, NULL, NULL, NULL, NULL, NULL, 'Ростехкровля', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3105, 0, NULL, NULL, NULL, NULL, 616101001, '"РОСТОВОБЛСТРОЙ"", Михаил ', NULL, NULL, '7 904 345 3090_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3106, 0, NULL, NULL, NULL, NULL, NULL, 'РСК 79182589957 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3107, 0, NULL, NULL, NULL, NULL, NULL, 'РСК ООО ', NULL, NULL, '7978 22 400 52 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3108, 0, NULL, NULL, NULL, NULL, 910601001, 'РСКОРИОН ООО -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3109, 0, NULL, NULL, NULL, NULL, NULL, 'РСТ  ', NULL, NULL, '7 978 090 21 47 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3110, 0, NULL, NULL, NULL, NULL, 260701001, '"РСТ"" _Мурад _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3111, 1, NULL, NULL, NULL, NULL, NULL, 'Рубанов Виталий ', NULL, NULL, '7978 89 37 849', 0, NULL);
INSERT INTO public.contractors VALUES (3112, 1, NULL, NULL, NULL, NULL, NULL, 'Рубель ИВ 79780248612', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3113, 1, NULL, NULL, NULL, NULL, NULL, 'Рубцов Николай ', NULL, NULL, '7978 726 31 12', 0, NULL);
INSERT INTO public.contractors VALUES (3114, 2, NULL, NULL, NULL, NULL, NULL, 'Рубцова Наталия Алексеевна (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3115, 0, NULL, NULL, NULL, NULL, NULL, 'Рудаков Н.И. ', NULL, NULL, '7 978 761 98 06', 0, NULL);
INSERT INTO public.contractors VALUES (3116, 1, NULL, NULL, NULL, NULL, NULL, 'Рудакова С.А. ', NULL, NULL, '7978 737 73 39', 0, NULL);
INSERT INTO public.contractors VALUES (3117, 1, NULL, NULL, NULL, NULL, NULL, 'Руденко А.В. ', NULL, NULL, '7 978 78 09 123', 0, NULL);
INSERT INTO public.contractors VALUES (3118, 1, NULL, NULL, NULL, NULL, NULL, 'Рудницкий А.С. ', NULL, NULL, '7 978 747 61 57', 0, NULL);
INSERT INTO public.contractors VALUES (3119, 1, NULL, NULL, NULL, NULL, NULL, 'Рудык В.И. ', NULL, NULL, '79782128959', 0, NULL);
INSERT INTO public.contractors VALUES (3120, 1, NULL, NULL, NULL, NULL, NULL, 'Рудь В.П. ', NULL, NULL, '7 978 76 84 391', 0, NULL);
INSERT INTO public.contractors VALUES (3121, 1, NULL, NULL, NULL, NULL, NULL, 'Рудякова Надежда Анатольевна ', NULL, NULL, '79787319115', 0, NULL);
INSERT INTO public.contractors VALUES (3122, 0, NULL, NULL, NULL, NULL, NULL, 'Рузаев ', NULL, NULL, '7 978 81 70 648', 0, NULL);
INSERT INTO public.contractors VALUES (3123, 0, NULL, NULL, NULL, NULL, 910301001, 'Рулетка 24 (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3124, 1, NULL, NULL, NULL, NULL, NULL, 'Рульков Михаил (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3125, 1, NULL, NULL, NULL, NULL, NULL, 'Румянцев В.В. ', NULL, NULL, '7978 802 71 15', 0, NULL);
INSERT INTO public.contractors VALUES (3126, 1, NULL, NULL, NULL, NULL, NULL, 'Румянцев В.В. ', NULL, NULL, '7978 802 71 15', 0, NULL);
INSERT INTO public.contractors VALUES (3127, 1, NULL, NULL, NULL, NULL, NULL, 'Русанов Е.А. ', NULL, NULL, '79787091745', 0, NULL);
INSERT INTO public.contractors VALUES (3128, 1, NULL, NULL, NULL, NULL, NULL, 'Русин В.Н. ', NULL, NULL, '7978 705 99 63', 0, NULL);
INSERT INTO public.contractors VALUES (3129, 0, NULL, NULL, NULL, NULL, NULL, 'Руслан ', NULL, NULL, '7 978 886 33 01', 0, NULL);
INSERT INTO public.contractors VALUES (3130, 1, NULL, NULL, NULL, NULL, NULL, 'Руслан знакомый влада', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3131, 1, NULL, NULL, NULL, NULL, NULL, 'Русняков А.Б. ', NULL, NULL, '7978 715 22 05', 0, NULL);
INSERT INTO public.contractors VALUES (3132, 0, NULL, NULL, NULL, NULL, NULL, 'Русский двор ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3133, 1, NULL, NULL, NULL, NULL, NULL, 'Рустамов А.С. ', NULL, NULL, '7978 712 83 58', 0, NULL);
INSERT INTO public.contractors VALUES (3134, 0, NULL, NULL, NULL, NULL, NULL, 'Рустем ', NULL, NULL, '7 978 935 1827 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3135, 1, NULL, NULL, NULL, NULL, NULL, 'Рустем станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3136, 0, NULL, NULL, NULL, NULL, NULL, 'Рустем Элит Строй -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3137, 0, NULL, NULL, NULL, NULL, NULL, 'Руфф Мастер ', NULL, NULL, '7978 783 1924 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3138, 1, NULL, NULL, NULL, NULL, NULL, 'Рыбак Антон Валерьевич ', NULL, NULL, '79787338715', 0, NULL);
INSERT INTO public.contractors VALUES (3139, 1, NULL, NULL, NULL, NULL, NULL, 'Рыбалко Валентин Григорьевич ', NULL, NULL, '7978 710 71 50', 0, NULL);
INSERT INTO public.contractors VALUES (3140, 1, NULL, NULL, NULL, NULL, NULL, 'Рыбачок В.С. ', NULL, NULL, '7 978 76 24 268', 0, NULL);
INSERT INTO public.contractors VALUES (3141, 1, NULL, NULL, NULL, NULL, NULL, 'Рыженко 79780187754', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3142, 1, NULL, NULL, NULL, NULL, NULL, 'Рыженко ЕИ 79787613432', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3143, 1, NULL, NULL, NULL, NULL, NULL, 'Рыженко Н.Н ', NULL, NULL, '79787437133', 0, NULL);
INSERT INTO public.contractors VALUES (3144, 0, NULL, NULL, NULL, NULL, NULL, 'Рысухин Артем Викторович ', NULL, NULL, '79787311552', 0, NULL);
INSERT INTO public.contractors VALUES (3145, 1, NULL, NULL, NULL, NULL, NULL, 'Рычков С.А. ', NULL, NULL, '7978 725 27 11', 0, NULL);
INSERT INTO public.contractors VALUES (3146, 1, NULL, NULL, NULL, NULL, NULL, 'Рышкова Т.М. ', NULL, NULL, '7 978 782 83 19', 0, NULL);
INSERT INTO public.contractors VALUES (3147, 1, NULL, NULL, NULL, NULL, NULL, 'Рябинский О.Г. ', NULL, NULL, '7978 830 35 39', 0, NULL);
INSERT INTO public.contractors VALUES (3148, 1, NULL, NULL, NULL, NULL, NULL, 'Рябков И.В.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3149, 0, NULL, NULL, NULL, NULL, NULL, 'Рябков Игорь', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3150, 0, NULL, NULL, NULL, NULL, NULL, 'Рябошапко А.Л. ', NULL, NULL, '79788031773', 0, NULL);
INSERT INTO public.contractors VALUES (3151, 0, NULL, NULL, NULL, NULL, NULL, 'Рябцев Никита Михайлович ', NULL, NULL, '7 978 083 11 90 _А.', 0, NULL);
INSERT INTO public.contractors VALUES (3152, 1, NULL, NULL, NULL, NULL, NULL, 'Рябчик Алексей ', NULL, NULL, '7 978 764 01 18', 0, NULL);
INSERT INTO public.contractors VALUES (3153, 1, NULL, NULL, NULL, NULL, NULL, 'Рябчун АГ 79780405877', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3154, 1, NULL, NULL, NULL, NULL, NULL, 'Рясенец Г.Н. ', NULL, NULL, '7 978 722 73 95 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (3155, 1, NULL, NULL, NULL, NULL, NULL, 'с.Софиевка', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3156, 1, NULL, NULL, NULL, NULL, NULL, 'Сабадаж И.И. ', NULL, NULL, '79781255028', 0, NULL);
INSERT INTO public.contractors VALUES (3157, 1, NULL, NULL, NULL, NULL, NULL, 'Сабадаж СВ 79782234324', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3158, 0, NULL, NULL, NULL, NULL, NULL, 'Сабастьян Иван ', NULL, NULL, '79787952208', 0, NULL);
INSERT INTO public.contractors VALUES (3159, 1, NULL, NULL, NULL, NULL, NULL, 'Сабреков Р.Х ', NULL, NULL, '7 909 716 08 40', 0, NULL);
INSERT INTO public.contractors VALUES (3160, 1, NULL, NULL, NULL, NULL, NULL, 'Сабуренко Г.В. ', NULL, NULL, '7 978 72 32 380', 0, NULL);
INSERT INTO public.contractors VALUES (3161, 1, NULL, NULL, NULL, NULL, NULL, 'Саввопуло В.А. ', NULL, NULL, '7 978 745 15 97', 0, NULL);
INSERT INTO public.contractors VALUES (3162, 2, NULL, NULL, NULL, NULL, NULL, 'Савельев Владимир Александрович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3163, 0, NULL, NULL, NULL, NULL, NULL, 'Савенко Н.А. ', NULL, NULL, '7 978 019 84 76', 0, NULL);
INSERT INTO public.contractors VALUES (3164, 2, NULL, NULL, NULL, NULL, NULL, 'Савенков 89788553586 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3165, 2, NULL, NULL, NULL, NULL, NULL, 'Савенкова АВ 79788553586 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3166, 1, NULL, NULL, NULL, NULL, NULL, 'Савин Ю.Э. ', NULL, NULL, '7 978 878 07 41', 0, NULL);
INSERT INTO public.contractors VALUES (3167, 1, NULL, NULL, NULL, NULL, NULL, 'Савчук Е.В. ', NULL, NULL, '7 978 74 70 119', 0, NULL);
INSERT INTO public.contractors VALUES (3168, 1, NULL, NULL, NULL, NULL, NULL, 'Савчук С.Н. ', NULL, NULL, '7 978 872 58 10', 0, NULL);
INSERT INTO public.contractors VALUES (3169, 1, NULL, NULL, NULL, NULL, NULL, 'Сагалаев Ю.И. ', NULL, NULL, '7 978 206 96 58', 0, NULL);
INSERT INTO public.contractors VALUES (3170, 2, NULL, NULL, NULL, NULL, NULL, 'Садиев Илимдар Исмаилович(Евпатория) ИП- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3171, 1, NULL, NULL, NULL, NULL, NULL, 'Садовский Б.В. ', NULL, NULL, '7 978 73 42 502', 0, NULL);
INSERT INTO public.contractors VALUES (3172, 1, NULL, NULL, NULL, NULL, NULL, 'Саенко Валерия ', NULL, NULL, '7978 900 19 22(Севастополь)', 0, NULL);
INSERT INTO public.contractors VALUES (3173, 1, NULL, NULL, NULL, NULL, NULL, 'Сазонов А 89117382424', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3174, 1, NULL, NULL, NULL, NULL, NULL, 'Сазонов А.А. ', NULL, NULL, '7 978 144 17 12', 0, NULL);
INSERT INTO public.contractors VALUES (3175, 1, NULL, NULL, NULL, NULL, NULL, 'Саиоделкин ВС 79788065692', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3176, 1, NULL, NULL, NULL, NULL, NULL, 'Сайгушев РИ 79788887983', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3177, 1, NULL, NULL, NULL, NULL, NULL, 'Сайдаметов Асан ', NULL, NULL, '7 978 807 80 06', 0, NULL);
INSERT INTO public.contractors VALUES (3178, 0, NULL, NULL, NULL, NULL, NULL, 'Сайненко А,И. ', NULL, NULL, '7 978 79 155 74', 0, NULL);
INSERT INTO public.contractors VALUES (3179, 1, NULL, NULL, NULL, NULL, NULL, 'Сайчук И.С. ', NULL, NULL, '7978 025 02 77', 0, NULL);
INSERT INTO public.contractors VALUES (3180, 1, NULL, NULL, NULL, NULL, NULL, 'Сакунов В.Е. ', NULL, NULL, '7978 78 15 15 3', 0, NULL);
INSERT INTO public.contractors VALUES (3181, 0, NULL, NULL, NULL, NULL, NULL, 'Салимов Руслан', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3182, 1, NULL, NULL, NULL, NULL, NULL, 'Салядинов Э.У. ', NULL, NULL, '7978 84 92 168', 0, NULL);
INSERT INTO public.contractors VALUES (3183, 0, NULL, NULL, NULL, NULL, NULL, 'Саметдинов Ф.У. ', NULL, NULL, '7978 01 09 277', 0, NULL);
INSERT INTO public.contractors VALUES (3184, 1, NULL, NULL, NULL, NULL, NULL, 'Самиева ГР 79780490521', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3185, 1, NULL, NULL, NULL, NULL, NULL, 'Самойленко И.Н. ', NULL, NULL, '7 978 831 0227', 0, NULL);
INSERT INTO public.contractors VALUES (3186, 1, NULL, NULL, NULL, NULL, NULL, 'Самокиш Ю.К. ', NULL, NULL, '7978 700 57 08', 0, NULL);
INSERT INTO public.contractors VALUES (3187, 1, NULL, NULL, NULL, NULL, NULL, 'Самородов М.В. ', NULL, NULL, '7978 84 93 583', 0, NULL);
INSERT INTO public.contractors VALUES (3188, 0, NULL, NULL, NULL, NULL, 910101001, '"САНАТОРИЙ ""СЛАВУТИЧ"", Николай ', NULL, NULL, '7 978 73 11 009_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3189, 1, NULL, NULL, NULL, NULL, NULL, 'Сандул СГ 79788031364', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3190, 1, NULL, NULL, NULL, NULL, NULL, 'Сандулов С.П. ', NULL, NULL, '7 978 85 66 094', 0, NULL);
INSERT INTO public.contractors VALUES (3191, 0, NULL, NULL, NULL, NULL, NULL, 'Сандулов С.П. ', NULL, NULL, '7 978 85 66 094', 0, NULL);
INSERT INTO public.contractors VALUES (3192, 0, NULL, NULL, NULL, NULL, NULL, 'Санжапов Наиль ', NULL, NULL, '79787130732', 0, NULL);
INSERT INTO public.contractors VALUES (3193, 1, NULL, NULL, NULL, NULL, NULL, 'Сансядло ИН 79788556499', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3194, 1, NULL, NULL, NULL, NULL, NULL, 'Сансядло ИН 79788556499', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3195, 1, NULL, NULL, NULL, NULL, NULL, 'Сапарбаев А.К, ', NULL, NULL, '7978 829 65 19', 0, NULL);
INSERT INTO public.contractors VALUES (3196, 1, NULL, NULL, NULL, NULL, NULL, 'Сапатый А.Ф. ', NULL, NULL, '7 978 76 24 180 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3197, 1, NULL, NULL, NULL, NULL, NULL, 'Сапега А.П. ', NULL, NULL, '7 978 73 83 532', 0, NULL);
INSERT INTO public.contractors VALUES (3198, 1, NULL, NULL, NULL, NULL, NULL, 'Сапожинский ВП 79788285099', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3199, 2, NULL, NULL, NULL, NULL, NULL, 'Сапожников Андрей Евгеньевич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3200, 1, NULL, NULL, NULL, NULL, NULL, 'Саппаров ТТ 7781407639', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3201, 1, NULL, NULL, NULL, NULL, NULL, 'Сапронов М.Э ', NULL, NULL, '7 978 083 92 95', 0, NULL);
INSERT INTO public.contractors VALUES (3202, 0, NULL, NULL, NULL, NULL, NULL, 'Сапрунов Владимир ', NULL, NULL, '79787510374', 0, NULL);
INSERT INTO public.contractors VALUES (3203, 1, NULL, NULL, NULL, NULL, NULL, 'Сапрыкин', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3204, 1, NULL, NULL, NULL, NULL, NULL, 'Сапрыкин А.В. ', NULL, NULL, '7-978-756-74-77', 0, NULL);
INSERT INTO public.contractors VALUES (3205, 0, NULL, NULL, NULL, NULL, NULL, 'Сапрыкина Ольга Вячеславовна ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3206, 1, NULL, NULL, NULL, NULL, NULL, 'Сапсай Юрий ', NULL, NULL, '7978 743 15 17', 0, NULL);
INSERT INTO public.contractors VALUES (3207, 1, NULL, NULL, NULL, NULL, NULL, 'Сапыцкий И.Н. ', NULL, NULL, '7 978 766 55 67', 0, NULL);
INSERT INTO public.contractors VALUES (3208, 0, NULL, NULL, NULL, NULL, NULL, 'Саргсян С.О. ', NULL, NULL, '7978 75 64 943', 0, NULL);
INSERT INTO public.contractors VALUES (3209, 0, NULL, NULL, NULL, NULL, NULL, 'Сардарьян В.В. ', NULL, NULL, '7 978 814 42 33', 0, NULL);
INSERT INTO public.contractors VALUES (3210, 0, NULL, NULL, NULL, NULL, NULL, 'Саутерн  978-003-97-58 ( И ) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3211, 1, NULL, NULL, NULL, NULL, NULL, 'Сафиулин 79780912677', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3212, 1, NULL, NULL, NULL, NULL, NULL, 'Сафонов ВА 79781329392', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3213, 1, NULL, NULL, NULL, NULL, NULL, 'Сафронов Михаил ', NULL, NULL, '7 978 729 52 82', 0, NULL);
INSERT INTO public.contractors VALUES (3214, 1, NULL, NULL, NULL, NULL, NULL, 'Сафронова М.В. ', NULL, NULL, '7 978 71 44 688', 0, NULL);
INSERT INTO public.contractors VALUES (3215, 0, NULL, NULL, NULL, NULL, NULL, 'Сафрончук В.В. ', NULL, NULL, '7 978 71 38 193', 0, NULL);
INSERT INTO public.contractors VALUES (3216, 1, NULL, NULL, NULL, NULL, NULL, 'Сахно А.В. ', NULL, NULL, '7 978 815 98 99', 0, NULL);
INSERT INTO public.contractors VALUES (3217, 1, NULL, NULL, NULL, NULL, NULL, 'Сахно Артем ', NULL, NULL, '7 978 815 98 99 (к.п.)', 0, NULL);
INSERT INTO public.contractors VALUES (3218, 1, NULL, NULL, NULL, NULL, NULL, 'Сахнюк Д.Н. ', NULL, NULL, '7 978 046 85 39', 0, NULL);
INSERT INTO public.contractors VALUES (3219, 0, NULL, NULL, NULL, NULL, NULL, 'Сахнюк Дмитрий ', NULL, NULL, '7 978 046 85 39', 0, NULL);
INSERT INTO public.contractors VALUES (3220, 0, NULL, NULL, NULL, NULL, NULL, 'Саша водитель', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3221, 1, NULL, NULL, NULL, NULL, NULL, 'Саша гибщик', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3222, 1, NULL, NULL, NULL, NULL, NULL, 'Саша Зекин Гибщике', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3223, 0, NULL, NULL, NULL, NULL, NULL, 'Саша Крымэталонстрой', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3224, 0, NULL, NULL, NULL, NULL, NULL, 'Саша Нижнегорский', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3225, 1, NULL, NULL, NULL, NULL, NULL, 'Саша Нижнегорский', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3226, 0, NULL, NULL, NULL, NULL, NULL, 'Саша станочник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3227, 0, NULL, NULL, NULL, NULL, NULL, 'Сашаян Васпур ', NULL, NULL, '79787245573', 0, NULL);
INSERT INTO public.contractors VALUES (3228, 1, NULL, NULL, NULL, NULL, NULL, 'Саяпин СВ 79781453122', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3229, 0, NULL, NULL, NULL, NULL, NULL, 'Сбербанк ПАО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3230, 0, NULL, NULL, NULL, NULL, NULL, 'Сваренко В. ', NULL, NULL, '79788242925', 0, NULL);
INSERT INTO public.contractors VALUES (3231, 0, NULL, NULL, NULL, NULL, 910201001, '"СВЕТ-ЛАЙН"" _Роман ', NULL, NULL, '7 905 926 58 88 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3232, 0, NULL, NULL, NULL, NULL, NULL, 'Светозарова А.Е. ', NULL, NULL, '79780849818', 0, NULL);
INSERT INTO public.contractors VALUES (3233, 0, NULL, NULL, NULL, NULL, NULL, 'Свистунов В.Н. ', NULL, NULL, '7 978 840 30 46', 0, NULL);
INSERT INTO public.contractors VALUES (3234, 1, NULL, NULL, NULL, NULL, NULL, 'Свищук А.И. ', NULL, NULL, '7 978 744 95 72', 0, NULL);
INSERT INTO public.contractors VALUES (3235, 1, NULL, NULL, NULL, NULL, NULL, 'Святкин ЕА 79787483982', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3236, 0, NULL, NULL, NULL, NULL, NULL, 'Свято-Никольский храм 79154440093', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3237, 0, NULL, NULL, NULL, NULL, NULL, 'Святослав от Влада ', NULL, NULL, '7 978 104 78 54', 0, NULL);
INSERT INTO public.contractors VALUES (3238, 1, NULL, NULL, NULL, NULL, NULL, 'Священник Александр ', NULL, NULL, '7978 121 31 57', 0, NULL);
INSERT INTO public.contractors VALUES (3239, 0, NULL, NULL, NULL, NULL, NULL, 'Севас-Дом СК д.п. (Севастополь) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3240, 0, NULL, NULL, NULL, NULL, NULL, 'Севастополь Виталий -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3241, 1, NULL, NULL, NULL, NULL, NULL, 'Севастьянова Л.Ю. ', NULL, NULL, '7 978 851 36 31', 0, NULL);
INSERT INTO public.contractors VALUES (3242, 0, NULL, NULL, NULL, NULL, NULL, 'СЕГАДА 79787232907 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3243, 0, NULL, NULL, NULL, NULL, 701701001, '"СЕГМЕНТ"" Николай ', NULL, NULL, '7 913 866 53 80_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3244, 2, NULL, NULL, NULL, NULL, NULL, 'Седаков ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3245, 0, NULL, NULL, NULL, NULL, NULL, 'Сединкин О.О. ', NULL, NULL, '7 978 8929 172', 0, NULL);
INSERT INTO public.contractors VALUES (3246, 1, NULL, NULL, NULL, NULL, NULL, 'Седов Д.И. ', NULL, NULL, '7 978 810 14 91', 0, NULL);
INSERT INTO public.contractors VALUES (3247, 1, NULL, NULL, NULL, NULL, NULL, 'Седов Д.И.', NULL, NULL, '7978 810 14 91', 0, NULL);
INSERT INTO public.contractors VALUES (3248, 0, NULL, NULL, NULL, NULL, NULL, 'Сеидиропуло Г.И. ', NULL, NULL, '7 978 729 97 85', 0, NULL);
INSERT INTO public.contractors VALUES (3249, 1, NULL, NULL, NULL, NULL, NULL, 'Сеитбекиров 79788735158', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3250, 1, NULL, NULL, NULL, NULL, NULL, 'Сеитджалилов Т.И. ', NULL, NULL, '7978 751 73 23', 0, NULL);
INSERT INTO public.contractors VALUES (3251, 0, NULL, NULL, NULL, NULL, NULL, 'Сеитджелилов Р.С. ', NULL, NULL, '7 978 706 13 28', 0, NULL);
INSERT INTO public.contractors VALUES (3252, 0, NULL, NULL, NULL, NULL, NULL, 'Сеитмеров Февзи', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3253, 0, NULL, NULL, NULL, NULL, NULL, 'Сеитмеров Февзи (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3254, 1, NULL, NULL, NULL, NULL, NULL, 'Сеитумеров М.Э. ', NULL, NULL, '7978 206 64 35', 0, NULL);
INSERT INTO public.contractors VALUES (3255, 1, NULL, NULL, NULL, NULL, NULL, 'Сеитхалилов Р.С. ', NULL, NULL, '7978 768 00 29', 0, NULL);
INSERT INTO public.contractors VALUES (3256, 0, NULL, NULL, NULL, NULL, NULL, 'Сеитхалилов Т.О. ', NULL, NULL, '7978 8209081', 0, NULL);
INSERT INTO public.contractors VALUES (3257, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдалиев Д.С. ', NULL, NULL, '7 978 732 000 1', 0, NULL);
INSERT INTO public.contractors VALUES (3258, 0, NULL, NULL, NULL, NULL, NULL, 'Сейдаметов  Э.С', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3259, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметов И.А. ', NULL, NULL, '79788141887', 0, NULL);
INSERT INTO public.contractors VALUES (3260, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметов РИ 79787244940', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3261, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметов РИ 79788279399', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3262, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметов Эльдар Эскендерович ', NULL, NULL, '79787931291', 0, NULL);
INSERT INTO public.contractors VALUES (3263, 0, NULL, NULL, NULL, NULL, NULL, 'Сейдаметова ', NULL, NULL, '7 978 806 28 13', 0, NULL);
INSERT INTO public.contractors VALUES (3264, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметова ЗЭ 79787476645', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3265, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметова ЗЭ 79787931287', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3266, 1, NULL, NULL, NULL, NULL, NULL, 'Сейдаметова ФЭ 79787137860', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3267, 1, NULL, NULL, NULL, NULL, NULL, 'Сейляметов Мустафа ', NULL, NULL, '79780530387', 0, NULL);
INSERT INTO public.contractors VALUES (3268, 0, NULL, NULL, NULL, NULL, NULL, 'Сейран ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3269, 1, NULL, NULL, NULL, NULL, NULL, 'Сейт-Джелилов А.Р. ', NULL, NULL, '7 978 731 19 59, ', 0, NULL);
INSERT INTO public.contractors VALUES (3270, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтавлаев С.С. ', NULL, NULL, '79787858294', 0, NULL);
INSERT INTO public.contractors VALUES (3271, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтапсиев НД 79788998964', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3272, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтасанов К.Э. ', NULL, NULL, '7978 832 98 67', 0, NULL);
INSERT INTO public.contractors VALUES (3273, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтвалиев Э.Д.  ', NULL, NULL, '7 978 797 14 13 (д.п.) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3274, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтджелилов 79782298443', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3275, 0, NULL, NULL, NULL, NULL, NULL, 'Сейтосманова Ленора (д.п.) - Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3276, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтумеров ЗР 79788211643', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3277, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтумеров Н.С. ', NULL, NULL, '7978 840 04 94', 0, NULL);
INSERT INTO public.contractors VALUES (3278, 1, NULL, NULL, NULL, NULL, NULL, 'Сейтумеров НС 79788400494', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3279, 0, NULL, NULL, NULL, NULL, NULL, 'Сейчак В.Н. ', NULL, NULL, '7 978 862 18 90', 0, NULL);
INSERT INTO public.contractors VALUES (3280, 1, NULL, NULL, NULL, NULL, NULL, 'Секачев С.Е 7978-08-12-132', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3281, 1, NULL, NULL, NULL, NULL, NULL, 'Селедцов С.Н. ', NULL, NULL, '7 978 861 36 25', 0, NULL);
INSERT INTO public.contractors VALUES (3282, 0, NULL, NULL, NULL, NULL, NULL, 'Селиванова Марина ', NULL, NULL, '79781351245', 0, NULL);
INSERT INTO public.contractors VALUES (3283, 0, NULL, NULL, NULL, NULL, NULL, 'Селиверстова Ирина ', NULL, NULL, '79787204623', 0, NULL);
INSERT INTO public.contractors VALUES (3284, 0, NULL, NULL, NULL, NULL, NULL, 'Семейко В.Ю. ', NULL, NULL, '7978 7163 722', 0, NULL);
INSERT INTO public.contractors VALUES (3285, 0, NULL, NULL, NULL, NULL, NULL, 'Семененко Сергей ', NULL, NULL, '79788439809', 0, NULL);
INSERT INTO public.contractors VALUES (3286, 1, NULL, NULL, NULL, NULL, NULL, 'Семенов Д.В. ', NULL, NULL, '79885662000', 0, NULL);
INSERT INTO public.contractors VALUES (3287, 1, NULL, NULL, NULL, NULL, NULL, 'Семенов Е.В. ', NULL, NULL, '79782062281', 0, NULL);
INSERT INTO public.contractors VALUES (3288, 1, NULL, NULL, NULL, NULL, NULL, 'Семенов И.В. ', NULL, NULL, '7 978 095 65 10', 0, NULL);
INSERT INTO public.contractors VALUES (3289, 0, NULL, NULL, NULL, NULL, NULL, 'Семенов Игорь ', NULL, NULL, '79782274515', 0, NULL);
INSERT INTO public.contractors VALUES (3290, 1, NULL, NULL, NULL, NULL, NULL, 'Семенов НД 79780036418', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3291, 0, NULL, NULL, NULL, NULL, NULL, 'Семенов Т.Ю. ', NULL, NULL, '7 978 08 56 419', 0, NULL);
INSERT INTO public.contractors VALUES (3292, 0, NULL, NULL, NULL, NULL, NULL, 'Семенов Юрий Тимофеевич ', NULL, NULL, '79780856419', 0, NULL);
INSERT INTO public.contractors VALUES (3293, 0, NULL, NULL, NULL, NULL, NULL, 'Семенюк Д.А. ', NULL, NULL, '79788946485', 0, NULL);
INSERT INTO public.contractors VALUES (3294, 1, NULL, NULL, NULL, NULL, NULL, 'Семкив ЮА 79787840405', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3295, 1, NULL, NULL, NULL, NULL, NULL, 'Семкин ВН ', NULL, NULL, '79787241691', 0, NULL);
INSERT INTO public.contractors VALUES (3296, 1, NULL, NULL, NULL, NULL, NULL, 'Септаров Ш.Р. ', NULL, NULL, '7978 838 20 95', 0, NULL);
INSERT INTO public.contractors VALUES (3297, 0, NULL, NULL, NULL, NULL, NULL, 'Сервер ', NULL, NULL, '7978 021 95 44', 0, NULL);
INSERT INTO public.contractors VALUES (3298, 0, NULL, NULL, NULL, NULL, NULL, 'Сергеев ', NULL, NULL, '7 978 770 6037', 0, NULL);
INSERT INTO public.contractors VALUES (3299, 1, NULL, NULL, NULL, NULL, NULL, 'Сергеев И.М. ', NULL, NULL, '7978 850 37 12', 0, NULL);
INSERT INTO public.contractors VALUES (3300, 1, NULL, NULL, NULL, NULL, NULL, 'Сергеев К.А. ', NULL, NULL, '7978 094 10 13', 0, NULL);
INSERT INTO public.contractors VALUES (3301, 1, NULL, NULL, NULL, NULL, NULL, 'Сергеев Петр Иванович ', NULL, NULL, '7978 75 21 029', 0, NULL);
INSERT INTO public.contractors VALUES (3302, 1, NULL, NULL, NULL, NULL, NULL, 'Сергеев ПИ 79787521026', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3303, 1, NULL, NULL, NULL, NULL, NULL, 'Сергеев Ю.М. ', NULL, NULL, '7 978 75 116 20', 0, NULL);
INSERT INTO public.contractors VALUES (3304, 0, NULL, NULL, NULL, NULL, NULL, 'Сергей ', NULL, NULL, '7 978 787 39 41', 0, NULL);
INSERT INTO public.contractors VALUES (3305, 1, NULL, NULL, NULL, NULL, NULL, 'Сергей 79787459014', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3306, 1, NULL, NULL, NULL, NULL, NULL, 'Сергей Васильевич 8-978-855-99-05', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3307, 0, NULL, NULL, NULL, NULL, NULL, 'Сергей Евгеньевич (от ЗДМС) ', NULL, NULL, '7 978 772 56 14 _Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3308, 1, NULL, NULL, NULL, NULL, NULL, 'Сергей колбасы ', NULL, NULL, '79787252711', 0, NULL);
INSERT INTO public.contractors VALUES (3309, 1, NULL, NULL, NULL, NULL, NULL, 'Сергей кровельщик ', NULL, NULL, '7 988 561 58 08', 0, NULL);
INSERT INTO public.contractors VALUES (3310, 1, NULL, NULL, NULL, NULL, NULL, 'Сергей от Влада 89780547259', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3311, 1, NULL, NULL, NULL, NULL, NULL, 'Сергей.С.А 8-978-738-26-62', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3312, 1, NULL, NULL, NULL, NULL, NULL, 'Сергиенко В.А. ', NULL, NULL, '79788792643', 0, NULL);
INSERT INTO public.contractors VALUES (3313, 1, NULL, NULL, NULL, NULL, NULL, 'Сергиенко В.И. ', NULL, NULL, '7 978 004 23 53', 0, NULL);
INSERT INTO public.contractors VALUES (3314, 1, NULL, NULL, NULL, NULL, NULL, 'Сергиенко ДА 79788347751', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3315, 1, NULL, NULL, NULL, NULL, NULL, 'Сергиенко ЕВ 79788164032', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3316, 1, NULL, NULL, NULL, NULL, NULL, 'Сердцева С.А. ', NULL, NULL, '7 978 888 27 10 (09)', 0, NULL);
INSERT INTO public.contractors VALUES (3317, 1, NULL, NULL, NULL, NULL, NULL, 'Сердюк П.А. ', NULL, NULL, '7 978 728 58 45', 0, NULL);
INSERT INTO public.contractors VALUES (3318, 1, NULL, NULL, NULL, NULL, NULL, 'Сердюк ПА 79787285845', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3319, 1, NULL, NULL, NULL, NULL, NULL, 'Сердюк СС 79787112054', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3320, 1, NULL, NULL, NULL, NULL, NULL, 'Сердюченко ИГ 79787284791', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3321, 0, NULL, NULL, NULL, NULL, NULL, 'Серегин В.А. ', NULL, NULL, '7978 820 31 65', 0, NULL);
INSERT INTO public.contractors VALUES (3322, 0, NULL, NULL, NULL, NULL, NULL, 'Серегин Сергей ', NULL, NULL, '79787702924', 0, NULL);
INSERT INTO public.contractors VALUES (3323, 1, NULL, NULL, NULL, NULL, NULL, 'Серков ДП 79788576204', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3324, 0, NULL, NULL, NULL, NULL, NULL, 'Серновский Богдан ', NULL, NULL, '79780433617', 0, NULL);
INSERT INTO public.contractors VALUES (3325, 0, NULL, NULL, NULL, NULL, NULL, 'Серов Эдуард- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3326, 1, NULL, NULL, NULL, NULL, NULL, 'Сероштан А.С, ', NULL, NULL, '7 985 003 90 95', 0, NULL);
INSERT INTO public.contractors VALUES (3327, 1, NULL, NULL, NULL, NULL, NULL, 'Серый С.Е. ', NULL, NULL, '7 978 813 07 06', 0, NULL);
INSERT INTO public.contractors VALUES (3328, 1, NULL, NULL, NULL, NULL, NULL, 'Сеттаров Руслан ', NULL, NULL, '7978 214 30 11 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3329, 2, NULL, NULL, NULL, NULL, NULL, 'Сефералиев.Л. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3330, 1, NULL, NULL, NULL, NULL, NULL, 'Сеферовский 79780787808', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3331, 0, NULL, NULL, NULL, NULL, NULL, 'Сефершаев Э.С. ', NULL, NULL, '7978 764 30 52', 0, NULL);
INSERT INTO public.contractors VALUES (3332, 0, NULL, NULL, NULL, NULL, NULL, 'СЖСК Омкс', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3333, 0, NULL, NULL, NULL, NULL, 920401001, 'СЗМК ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3334, 0, NULL, NULL, NULL, NULL, 910601001, '"СИБСТРОЙКОМПЛЕКТ"", ', NULL, NULL, '7978 209 3585 (д.п.) _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3335, 1, NULL, NULL, NULL, NULL, NULL, 'Сиваков А.В. ', NULL, NULL, '7 978 810 33 61', 0, NULL);
INSERT INTO public.contractors VALUES (3336, 1, NULL, NULL, NULL, NULL, NULL, 'Сивков В.В. ', NULL, NULL, '7 978 841 28 00', 0, NULL);
INSERT INTO public.contractors VALUES (3337, 1, NULL, NULL, NULL, NULL, NULL, 'Сиволонский 79787896940', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3338, 1, NULL, NULL, NULL, NULL, NULL, 'Сивун С.В. ', NULL, NULL, '7978 052 52 47', 0, NULL);
INSERT INTO public.contractors VALUES (3339, 1, NULL, NULL, NULL, NULL, NULL, 'Сидоренко А.А. ', NULL, NULL, '7 978 723 37 93', 0, NULL);
INSERT INTO public.contractors VALUES (3340, 0, NULL, NULL, NULL, NULL, NULL, 'Сидоренко Алексей ', NULL, NULL, ' 7978 811 52 03', 0, NULL);
INSERT INTO public.contractors VALUES (3341, 1, NULL, NULL, NULL, NULL, NULL, 'Сидоренко Артем ', NULL, NULL, '7 978 774 89 00', 0, NULL);
INSERT INTO public.contractors VALUES (3342, 1, NULL, NULL, NULL, NULL, NULL, 'Сидоренко Кристина ', NULL, NULL, '7 978 80 67 982', 0, NULL);
INSERT INTO public.contractors VALUES (3343, 1, NULL, NULL, NULL, NULL, NULL, 'Сидоренко Н.Г ', NULL, NULL, '79787538243', 0, NULL);
INSERT INTO public.contractors VALUES (3344, 1, NULL, NULL, NULL, NULL, NULL, 'Сидоренко СН 79787617462', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3345, 0, NULL, NULL, NULL, NULL, NULL, 'Сидорко Владислав ', NULL, NULL, '79787727675', 0, NULL);
INSERT INTO public.contractors VALUES (3346, 1, NULL, NULL, NULL, NULL, NULL, 'Сидоров С.Н. ', NULL, NULL, '79787309416', 0, NULL);
INSERT INTO public.contractors VALUES (3347, 1, NULL, NULL, NULL, NULL, NULL, 'Сидорова 79787317819', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3348, 1, NULL, NULL, NULL, NULL, NULL, 'Сидякина ЕА 79782734894', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3349, 0, NULL, NULL, NULL, NULL, NULL, 'Сизакор АО ', NULL, NULL, '7 978 767 04 90 Константин', 0, NULL);
INSERT INTO public.contractors VALUES (3350, 0, NULL, NULL, NULL, NULL, NULL, 'Сизов Владимир (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3351, 1, NULL, NULL, NULL, NULL, NULL, 'Сильченков А.Ф. ', NULL, NULL, '7 978 865 44 34', 0, NULL);
INSERT INTO public.contractors VALUES (3352, 0, NULL, NULL, NULL, NULL, NULL, 'Симанков Павел ', NULL, NULL, '7978 002 68 77', 0, NULL);
INSERT INTO public.contractors VALUES (3353, 0, NULL, NULL, NULL, NULL, NULL, 'Симич Игорь ', NULL, NULL, '79787685022', 0, NULL);
INSERT INTO public.contractors VALUES (3354, 1, NULL, NULL, NULL, NULL, NULL, 'Симонян ОМ 79787237721', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3355, 0, NULL, NULL, NULL, NULL, 910201001, 'СИМСТРОЙТОРГ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3356, 0, NULL, NULL, NULL, NULL, NULL, 'Симферопольская строительная компания Владимир ', NULL, NULL, '7 978 278 69 65', 0, NULL);
INSERT INTO public.contractors VALUES (3357, 1, NULL, NULL, NULL, NULL, NULL, 'Симчук Б.В. ', NULL, NULL, '7 978 757 41 89', 0, NULL);
INSERT INTO public.contractors VALUES (3358, 1, NULL, NULL, NULL, NULL, NULL, 'Синильников СА 79183607585', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3359, 0, NULL, NULL, NULL, NULL, NULL, 'СИП-Крым  ', NULL, NULL, '7 978 032 93 45 Павел ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3360, 1, NULL, NULL, NULL, NULL, NULL, 'Сироклин В.В. ', NULL, NULL, '7 978 752 45 35', 0, NULL);
INSERT INTO public.contractors VALUES (3361, 1, NULL, NULL, NULL, NULL, NULL, 'Сирота Сергей Николаевич ', NULL, NULL, '79788682504', 0, NULL);
INSERT INTO public.contractors VALUES (3362, 1, NULL, NULL, NULL, NULL, NULL, 'Сироткин АА 79787893105', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3363, 1, NULL, NULL, NULL, NULL, NULL, 'Сифляев Л.С. ', NULL, NULL, '7 978 80 75 341', 0, NULL);
INSERT INTO public.contractors VALUES (3364, 1, NULL, NULL, NULL, NULL, NULL, 'Сицин Д.В. ', NULL, NULL, '79787460185', 0, NULL);
INSERT INTO public.contractors VALUES (3365, 0, NULL, NULL, NULL, NULL, 920101001, '"СК ""АЛЬФА"" _Роман ', NULL, NULL, '7 978 856 4676_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3366, 0, NULL, NULL, NULL, NULL, 910201001, '"СК ""ЮЖНЫЙ ВЕКТОР"", ', NULL, NULL, '7 978 081 47 58 Евгений (д.п.) - Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3367, 1, NULL, NULL, NULL, NULL, NULL, 'СК ', NULL, NULL, '7978 996 9000 Петр ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3368, 0, NULL, NULL, NULL, NULL, NULL, 'СК БАЗИС ', NULL, NULL, '7987 043 05 05 Магомед', 0, NULL);
INSERT INTO public.contractors VALUES (3369, 0, NULL, NULL, NULL, NULL, NULL, 'СК СТРОЙЖИЛПОДРЯД (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3370, 0, NULL, NULL, NULL, NULL, NULL, 'СК Юг ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3371, 0, NULL, NULL, NULL, NULL, 910201001, 'СК Южный Формат ООО', NULL, 19183279, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3372, 0, NULL, NULL, NULL, NULL, NULL, 'Скалозуб Анатолий ', NULL, NULL, '79780068780', 0, NULL);
INSERT INTO public.contractors VALUES (3373, 0, NULL, NULL, NULL, NULL, NULL, 'Скворцов И.А. ', NULL, NULL, '79787885805', 0, NULL);
INSERT INTO public.contractors VALUES (3374, 0, NULL, NULL, NULL, NULL, NULL, 'Скичко И.В. ', NULL, NULL, ' 7 978 215 49 07', 0, NULL);
INSERT INTO public.contractors VALUES (3375, 1, NULL, NULL, NULL, NULL, NULL, 'Скокова Н.Ю ', NULL, NULL, '79787479841', 0, NULL);
INSERT INTO public.contractors VALUES (3376, 1, NULL, NULL, NULL, NULL, NULL, 'Скоринко Сергей Петрович ', NULL, NULL, '7978 75 19 201', 0, NULL);
INSERT INTO public.contractors VALUES (3377, 1, NULL, NULL, NULL, NULL, NULL, 'Скороход И.В. ', NULL, NULL, '79785641169', 0, NULL);
INSERT INTO public.contractors VALUES (3378, 2, NULL, NULL, NULL, NULL, NULL, 'Скороходов ДВ 79787509400 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3379, 2, NULL, NULL, NULL, NULL, NULL, 'Скрынник А.В. -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3380, 1, NULL, NULL, NULL, NULL, NULL, 'Скрябин ВА 79787293137(К.П)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3381, 0, NULL, NULL, NULL, NULL, 910201001, '"СКС""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3382, 1, NULL, NULL, NULL, NULL, NULL, 'Скупейко Н.Н. ', NULL, NULL, '7978 094 10 13', 0, NULL);
INSERT INTO public.contractors VALUES (3383, 0, NULL, NULL, NULL, NULL, NULL, 'Слабко Э.А. ', NULL, NULL, '79787215380', 0, NULL);
INSERT INTO public.contractors VALUES (3384, 0, NULL, NULL, NULL, NULL, NULL, 'Слава', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3385, 0, NULL, NULL, NULL, NULL, NULL, 'Славик гибщик', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3386, 1, NULL, NULL, NULL, NULL, NULL, 'Сластья Е.А. ', NULL, NULL, '7 978 107 73 09', 0, NULL);
INSERT INTO public.contractors VALUES (3387, 2, NULL, NULL, NULL, NULL, NULL, 'Слезко Денис (д.п.) ', NULL, NULL, '7 978 725 00 87 - Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3388, 0, NULL, NULL, NULL, NULL, NULL, 'Слепоглазов Вячеслав Михайлович ', NULL, NULL, '79787151690', 0, NULL);
INSERT INTO public.contractors VALUES (3389, 1, NULL, NULL, NULL, NULL, NULL, 'Слесаревский П.Н. ', NULL, NULL, '7978 828 10 99', 0, NULL);
INSERT INTO public.contractors VALUES (3390, 1, NULL, NULL, NULL, NULL, NULL, 'Сливченко В.В. ', NULL, NULL, '7978 770 37 69', 0, NULL);
INSERT INTO public.contractors VALUES (3391, 1, NULL, NULL, NULL, NULL, NULL, 'Слободченко В.Н. ', NULL, NULL, '7 978 73 15 961', 0, NULL);
INSERT INTO public.contractors VALUES (3392, 1, NULL, NULL, NULL, NULL, NULL, 'Слободян А.А. ', NULL, NULL, '7 978 218 60 76', 0, NULL);
INSERT INTO public.contractors VALUES (3393, 1, NULL, NULL, NULL, NULL, NULL, 'Слободян ВВ 79787624716', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3394, 2, NULL, NULL, NULL, NULL, NULL, 'Слюсарев А. И. ИП ТЕМРЮК', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3395, 2, NULL, NULL, NULL, NULL, NULL, 'Слюсаренко А.А.(Саки) ИП -А. ', NULL, NULL, '7978 703 06 43', 0, NULL);
INSERT INTO public.contractors VALUES (3396, 0, NULL, NULL, NULL, NULL, NULL, 'Слюсаренко Р.В. ', NULL, NULL, '79787461147', 0, NULL);
INSERT INTO public.contractors VALUES (3397, 0, NULL, NULL, NULL, NULL, NULL, 'Слюсаренко Роман Васильевич ', NULL, NULL, '7 978 746 11 47', 0, NULL);
INSERT INTO public.contractors VALUES (3398, 0, NULL, NULL, NULL, NULL, NULL, 'Слюсарь Ю.А. ', NULL, NULL, '7 978 869 81 89', 0, NULL);
INSERT INTO public.contractors VALUES (3399, 0, NULL, NULL, NULL, NULL, NULL, 'СМ Трейд ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3400, 1, NULL, NULL, NULL, NULL, NULL, 'Смаилов В.Г. ', NULL, NULL, '79780692404', 0, NULL);
INSERT INTO public.contractors VALUES (3401, 1, NULL, NULL, NULL, NULL, NULL, 'Смаилов Э.Ш. ', NULL, NULL, '7 978 71 22 142', 0, NULL);
INSERT INTO public.contractors VALUES (3402, 0, NULL, NULL, NULL, NULL, NULL, 'Смайлов Решат ', NULL, NULL, '79788410889', 0, NULL);
INSERT INTO public.contractors VALUES (3403, 1, NULL, NULL, NULL, NULL, NULL, 'Смаль Александр Яковлевич ', NULL, NULL, '7 978 019 15 47 (пгт Никита, Ялта, ЮБШ, 36)', 0, NULL);
INSERT INTO public.contractors VALUES (3404, 1, NULL, NULL, NULL, NULL, NULL, 'Смаль Ю.Ф. ', NULL, NULL, '7978 85 84 771', 0, NULL);
INSERT INTO public.contractors VALUES (3405, 0, NULL, NULL, NULL, NULL, NULL, 'Смарт Фабрикс 79788177762 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3406, 0, NULL, NULL, NULL, NULL, NULL, 'Смарт-Кровля (Глинки,80) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3407, 0, NULL, NULL, NULL, NULL, 616301001, '"СМАРТ"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3408, 1, NULL, NULL, NULL, NULL, NULL, 'Сметанников А.В. ', NULL, NULL, '7 978 77 36 418', 0, NULL);
INSERT INTO public.contractors VALUES (3409, 1, NULL, NULL, NULL, NULL, NULL, 'Смирнов А.А. ', NULL, NULL, '7 978 003 89 83', 0, NULL);
INSERT INTO public.contractors VALUES (3410, 1, NULL, NULL, NULL, NULL, NULL, 'Смирнов А.В. ', NULL, NULL, '79787469323', 0, NULL);
INSERT INTO public.contractors VALUES (3411, 2, NULL, NULL, NULL, NULL, NULL, 'Смирнов Артём Владимирович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3412, 1, NULL, NULL, NULL, NULL, NULL, 'Смирнов Виктор ', NULL, NULL, '7978 708 52 27', 0, NULL);
INSERT INTO public.contractors VALUES (3413, 1, NULL, NULL, NULL, NULL, NULL, 'Смирнов И.О. ', NULL, NULL, '7 978 106 75 03', 0, NULL);
INSERT INTO public.contractors VALUES (3414, 0, NULL, NULL, NULL, NULL, NULL, 'Смирнов О.В. ', NULL, NULL, '7 978 829 78 67', 0, NULL);
INSERT INTO public.contractors VALUES (3415, 1, NULL, NULL, NULL, NULL, NULL, 'Смирнов Руслан Васильевич ', NULL, NULL, '7978 770 54 78', 0, NULL);
INSERT INTO public.contractors VALUES (3416, 1, NULL, NULL, NULL, NULL, NULL, 'Смирнов С.Г. ', NULL, NULL, '7978 127 95 66', 0, NULL);
INSERT INTO public.contractors VALUES (3417, 2, NULL, NULL, NULL, NULL, NULL, 'Смирнова О. (Евпатория) ИП -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3418, 0, NULL, NULL, NULL, NULL, NULL, 'Смоленко В.М. ', NULL, NULL, '79788636265', 0, NULL);
INSERT INTO public.contractors VALUES (3419, 1, NULL, NULL, NULL, NULL, NULL, 'Смоляров В.Е. ', NULL, NULL, '7985 006 4050 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3420, 0, NULL, NULL, NULL, NULL, NULL, 'СМплюс 79781415552 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3421, 0, NULL, NULL, NULL, NULL, NULL, 'СМУ-13 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3422, 0, NULL, NULL, NULL, NULL, NULL, 'СМУ-17 ', NULL, NULL, '7 915 089 13 00', 0, NULL);
INSERT INTO public.contractors VALUES (3423, 0, NULL, NULL, NULL, NULL, NULL, 'СМУ-8 (7 978 262 29 66)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3424, 1, NULL, NULL, NULL, NULL, NULL, 'Смутило ВВ 79788165471  79886528991', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3425, 1, NULL, NULL, NULL, NULL, NULL, 'Смыгачёв В.В. ', NULL, NULL, '7 978 75 111 92', 0, NULL);
INSERT INTO public.contractors VALUES (3426, 0, NULL, NULL, NULL, NULL, NULL, 'Снабсервис  Антон ', NULL, NULL, '7 978 787 76 65_ Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3427, 1, NULL, NULL, NULL, NULL, NULL, 'Снитко АА 79880806261', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3428, 1, NULL, NULL, NULL, NULL, NULL, 'Снопко ВИ 79787918630', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3429, 1, NULL, NULL, NULL, NULL, NULL, 'Собакин Александр Викторович ', NULL, NULL, '79782035108', 0, NULL);
INSERT INTO public.contractors VALUES (3430, 2, NULL, NULL, NULL, NULL, NULL, 'Собещанский ВН 79787431789 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3431, 1, NULL, NULL, NULL, NULL, NULL, 'Собко Денис (водитель)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3432, 1, NULL, NULL, NULL, NULL, NULL, 'Собко ИА 79788355651', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3433, 0, NULL, NULL, NULL, NULL, NULL, 'Соболев О.Ю. ', NULL, NULL, '79788164630', 0, NULL);
INSERT INTO public.contractors VALUES (3434, 2, NULL, NULL, NULL, NULL, NULL, 'Соболь Виктор Владимирович (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3435, 1, NULL, NULL, NULL, NULL, NULL, 'Соболь ВН 79781138005', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3436, 0, NULL, NULL, NULL, NULL, NULL, 'Собутинский Н.В. ', NULL, NULL, '7 978 22 74 238', 0, NULL);
INSERT INTO public.contractors VALUES (3437, 2, NULL, NULL, NULL, NULL, NULL, 'Собчук Григорий Владимирович, ', NULL, NULL, '7 978 84 13 555 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3438, 1, NULL, NULL, NULL, NULL, NULL, 'Собянин К.В. ', NULL, NULL, '7 978 78 22 176', 0, NULL);
INSERT INTO public.contractors VALUES (3439, 0, NULL, NULL, NULL, NULL, NULL, 'Созидание ', NULL, NULL, '7978 257 24 83 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3440, 0, NULL, NULL, NULL, NULL, 910201001, 'СОЗИДАНИЕ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3441, 0, NULL, NULL, NULL, NULL, NULL, 'Сокол А.Ф. ', NULL, NULL, '7 978 754 99 61', 0, NULL);
INSERT INTO public.contractors VALUES (3442, 1, NULL, NULL, NULL, NULL, NULL, 'Соколенко А.А. ', NULL, NULL, '7 978 708 6374', 0, NULL);
INSERT INTO public.contractors VALUES (3443, 1, NULL, NULL, NULL, NULL, NULL, 'Соколенко С.А. ', NULL, NULL, '7978 81 60 839', 0, NULL);
INSERT INTO public.contractors VALUES (3444, 2, NULL, NULL, NULL, NULL, NULL, 'Соколов  79787256863 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3445, 1, NULL, NULL, NULL, NULL, NULL, 'Соколов А.Н. ', NULL, NULL, '7 978 84 78 598', 0, NULL);
INSERT INTO public.contractors VALUES (3446, 1, NULL, NULL, NULL, NULL, NULL, 'Соколов Дмитрий ', NULL, NULL, '7 978 062 93 77', 0, NULL);
INSERT INTO public.contractors VALUES (3447, 1, NULL, NULL, NULL, NULL, NULL, 'Соколов Игорь ', NULL, NULL, '7978 815 36 64 (д.п)', 0, NULL);
INSERT INTO public.contractors VALUES (3448, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев А.Б. ', NULL, NULL, '7978 76 47 360', 0, NULL);
INSERT INTO public.contractors VALUES (3449, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев А.И. ', NULL, NULL, '79885214790', 0, NULL);
INSERT INTO public.contractors VALUES (3450, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев В 79788240276', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3451, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев ОМ 79787754243', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3452, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев С.В. ', NULL, NULL, '7 978 707 15 25', 0, NULL);
INSERT INTO public.contractors VALUES (3453, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев Э.М. ', NULL, NULL, '79787370091', 0, NULL);
INSERT INTO public.contractors VALUES (3454, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьев ЭМ 79787370095', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3455, 1, NULL, NULL, NULL, NULL, NULL, 'Соловьева Е.И. ', NULL, NULL, '7 978 715 94 77', 0, NULL);
INSERT INTO public.contractors VALUES (3456, 1, NULL, NULL, NULL, NULL, NULL, 'Солодкин А.В. ', NULL, NULL, '7 978 8007024', 0, NULL);
INSERT INTO public.contractors VALUES (3457, 1, NULL, NULL, NULL, NULL, NULL, 'Солодкин КМ 79787318060', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3458, 1, NULL, NULL, NULL, NULL, NULL, 'Солодкин Н.А. ', NULL, NULL, '7 978 808 70 28', 0, NULL);
INSERT INTO public.contractors VALUES (3459, 1, NULL, NULL, NULL, NULL, NULL, 'Солодуха С.В. ', NULL, NULL, '7 978 866 02 63', 0, NULL);
INSERT INTO public.contractors VALUES (3460, 1, NULL, NULL, NULL, NULL, NULL, 'Соломаха М.А., ', NULL, NULL, '7 978 835 4004', 0, NULL);
INSERT INTO public.contractors VALUES (3461, 0, NULL, NULL, NULL, NULL, NULL, 'Соломаха С.Н. ', NULL, NULL, '7 978 7978 031', 0, NULL);
INSERT INTO public.contractors VALUES (3462, 1, NULL, NULL, NULL, NULL, NULL, 'Соломин Александ Витальевич ', NULL, NULL, '7978 78 904 71', 0, NULL);
INSERT INTO public.contractors VALUES (3463, 1, NULL, NULL, NULL, NULL, NULL, 'Соломин И.И. ', NULL, NULL, '7978 748 42 29', 0, NULL);
INSERT INTO public.contractors VALUES (3464, 1, NULL, NULL, NULL, NULL, NULL, 'Соломонов ЕН 79788607135', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3465, 1, NULL, NULL, NULL, NULL, NULL, 'Соломонова ЛВ 79788927080', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3466, 2, NULL, NULL, NULL, NULL, NULL, 'Солощенко Максим (Комфорт) ', NULL, NULL, '7 978 740 14 80 (д.п.) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3467, 1, NULL, NULL, NULL, NULL, NULL, 'Сонин В.А. ', NULL, NULL, '7 978 78 17 526', 0, NULL);
INSERT INTO public.contractors VALUES (3468, 1, NULL, NULL, NULL, NULL, NULL, 'Сопильник 79787519028', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3469, 1, NULL, NULL, NULL, NULL, NULL, 'Сопин А.А. ', NULL, NULL, '7978 833 26 94', 0, NULL);
INSERT INTO public.contractors VALUES (3470, 1, NULL, NULL, NULL, NULL, NULL, 'Сорокин АВ 79788914234', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3471, 1, NULL, NULL, NULL, NULL, NULL, 'Сорокин В.И. ', NULL, NULL, '79788528350', 0, NULL);
INSERT INTO public.contractors VALUES (3472, 1, NULL, NULL, NULL, NULL, NULL, 'Сорокин ИГ 79788545456', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3473, 1, NULL, NULL, NULL, NULL, NULL, 'Сорокин ИН 89189150224', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3474, 1, NULL, NULL, NULL, NULL, NULL, 'Сорокин К.Ю', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3475, 1, NULL, NULL, NULL, NULL, NULL, 'Сорокун А.Н. ', NULL, NULL, '7 978 709 24 17', 0, NULL);
INSERT INTO public.contractors VALUES (3476, 1, NULL, NULL, NULL, NULL, NULL, 'Сосненко О.А. ', NULL, NULL, '7978 70 63 700', 0, NULL);
INSERT INTO public.contractors VALUES (3477, 1, NULL, NULL, NULL, NULL, NULL, 'Сотников А.В. ', NULL, NULL, '7 978 040 19 24', 0, NULL);
INSERT INTO public.contractors VALUES (3478, 1, NULL, NULL, NULL, NULL, NULL, 'Сотников А.В. ', NULL, NULL, '7 978 215 16 82', 0, NULL);
INSERT INTO public.contractors VALUES (3479, 1, NULL, NULL, NULL, NULL, NULL, 'Сотула В.В. ', NULL, NULL, '7978 77 20 300', 0, NULL);
INSERT INTO public.contractors VALUES (3480, 1, NULL, NULL, NULL, NULL, NULL, 'Софу БА 79787286696 Энвер', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3481, 0, NULL, NULL, NULL, NULL, NULL, 'Соцкий Сервер Диляверович ', NULL, NULL, '79788277800', 0, NULL);
INSERT INTO public.contractors VALUES (3482, 0, NULL, NULL, NULL, NULL, NULL, 'Союз Энерго', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3483, 0, NULL, NULL, NULL, NULL, NULL, 'Спасение  ', NULL, NULL, '7 978 756 94 25 Юлия ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3484, 1, NULL, NULL, NULL, NULL, NULL, 'Спасенко АФ 79787379407', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3485, 0, NULL, NULL, NULL, NULL, NULL, 'Спектор А.Б. ', NULL, NULL, '7 978 830 75 30', 0, NULL);
INSERT INTO public.contractors VALUES (3486, 0, NULL, NULL, NULL, NULL, NULL, 'Спектор ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3487, 0, NULL, NULL, NULL, NULL, NULL, 'Спектр ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3488, 0, NULL, NULL, NULL, 2130114066, 213001001, 'СПЕЦСТАЛЬКОНСТРУКЦИЯ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3489, 0, NULL, NULL, NULL, NULL, 616301001, '"СПЕЦСТРОЙ""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3490, 0, NULL, NULL, NULL, NULL, NULL, 'СпецСтройМеханизация', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3491, 0, NULL, NULL, NULL, NULL, NULL, 'СпецСтройЮГ ', NULL, NULL, '79181731858 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3492, 1, NULL, NULL, NULL, NULL, NULL, 'Спивак П.А, ', NULL, NULL, '7978 724 49 54', 0, NULL);
INSERT INTO public.contractors VALUES (3493, 0, NULL, NULL, NULL, NULL, NULL, 'Спица Сергей ', NULL, NULL, '7978 78 22 603 (д)', 0, NULL);
INSERT INTO public.contractors VALUES (3494, 1, NULL, NULL, NULL, NULL, NULL, 'Спицин В 79787748960  50', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3495, 2, NULL, NULL, NULL, NULL, NULL, 'Спичак О. В.  ВАРЕНИКОВСКАЯ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3496, 0, NULL, NULL, NULL, NULL, NULL, '"СПК ""Надежда"" ', NULL, NULL, '7 978 74 73 269 Светлана Петровна"', 0, NULL);
INSERT INTO public.contractors VALUES (3497, 1, NULL, NULL, NULL, NULL, NULL, 'Спода Борис Николаевич ', NULL, NULL, '79788501028', 0, NULL);
INSERT INTO public.contractors VALUES (3498, 0, NULL, NULL, NULL, NULL, NULL, 'Спорт Инвест ООО -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3499, 0, NULL, NULL, NULL, NULL, 910201001, '"СПП ГИДРОИЗОЛЯЦИЯ"", Павел _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3500, 0, NULL, NULL, NULL, NULL, 910201001, '"СПП ГИДРОИЗОЛЯЦИЯ"", Павел ', NULL, NULL, '7 918 086 4581 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3501, 1, NULL, NULL, NULL, NULL, NULL, 'Срибный ИМ 79787227379', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3502, 0, NULL, NULL, NULL, NULL, NULL, 'ССК ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3503, 0, NULL, NULL, NULL, NULL, 910201001, '"ССК"", Владимир ', NULL, NULL, '7 978 134 7970_ Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3504, 0, NULL, NULL, NULL, NULL, NULL, 'ССС ', NULL, NULL, '7 978 758 83 95 Валерий ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3505, 1, NULL, NULL, NULL, NULL, NULL, 'Ставер С.А. ', NULL, NULL, '79787267964', 0, NULL);
INSERT INTO public.contractors VALUES (3506, 1, NULL, NULL, NULL, NULL, NULL, 'Стадник А.М. ', NULL, NULL, '7978 73 43 588', 0, NULL);
INSERT INTO public.contractors VALUES (3507, 0, NULL, NULL, NULL, NULL, NULL, 'Сталькрепеж 9945555557', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3508, 0, NULL, NULL, NULL, NULL, NULL, 'Стандарт Девелопмент 8919 407 95 15 Николай ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3509, 0, NULL, NULL, NULL, NULL, NULL, 'Стандарт РТИ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3510, 1, NULL, NULL, NULL, NULL, NULL, 'Станецкий Н.В. ', NULL, NULL, '7 978 720 82 12', 0, NULL);
INSERT INTO public.contractors VALUES (3511, 1, NULL, NULL, NULL, NULL, NULL, 'Станислав Савицкий  ', NULL, NULL, '7 978 775 40 44 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3512, 1, NULL, NULL, NULL, NULL, NULL, 'Станкевич АА 79787033527', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3513, 1, NULL, NULL, NULL, NULL, NULL, 'Стариков В.А. ', NULL, NULL, '7 978 70 60 135', 0, NULL);
INSERT INTO public.contractors VALUES (3514, 1, NULL, NULL, NULL, NULL, NULL, 'Стариков В.М. ', NULL, NULL, '7914 855 80 46', 0, NULL);
INSERT INTO public.contractors VALUES (3515, 1, NULL, NULL, NULL, NULL, NULL, 'Старкова ЕВ 79787401127', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3516, 1, NULL, NULL, NULL, NULL, NULL, 'Стародуб ИИ 79787825724', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3517, 0, NULL, NULL, NULL, NULL, 910201001, 'Стартек Юг ООО', NULL, 746432, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3518, 1, NULL, NULL, NULL, NULL, NULL, 'Старченко Е.В. ', NULL, NULL, '7 978 810 50 37', 0, NULL);
INSERT INTO public.contractors VALUES (3519, 1, NULL, NULL, NULL, NULL, NULL, 'Старыгин Игорь ', NULL, NULL, '7978 723 34 83', 0, NULL);
INSERT INTO public.contractors VALUES (3520, 0, NULL, NULL, NULL, NULL, NULL, 'Стасюк Дмитрий Вячеславович (з) ', NULL, NULL, '79787238115', 0, NULL);
INSERT INTO public.contractors VALUES (3521, 0, NULL, NULL, NULL, NULL, NULL, 'Стасюк Л.П. ', NULL, NULL, '7 978 844 94 60', 0, NULL);
INSERT INTO public.contractors VALUES (3522, 0, NULL, NULL, NULL, NULL, NULL, 'Сташкив.Д.Я (И) ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3523, 0, NULL, NULL, NULL, NULL, NULL, 'Стеблий О.И. ', NULL, NULL, '7 978 849 12 65', 0, NULL);
INSERT INTO public.contractors VALUES (3524, 1, NULL, NULL, NULL, NULL, NULL, 'Степа Джанкой', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3525, 1, NULL, NULL, NULL, NULL, NULL, 'Степаненко АВ 79782260454', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3526, 1, NULL, NULL, NULL, NULL, NULL, 'Степаненко АЛ 79787299822', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3527, 1, NULL, NULL, NULL, NULL, NULL, 'Степаненков СП 79818835261', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3528, 0, NULL, NULL, NULL, NULL, NULL, 'Степанов В.Г. ', NULL, NULL, '79787248155/33', 0, NULL);
INSERT INTO public.contractors VALUES (3529, 1, NULL, NULL, NULL, NULL, NULL, 'Степанов В.Н. ', NULL, NULL, '7978 736 09 61', 0, NULL);
INSERT INTO public.contractors VALUES (3530, 1, NULL, NULL, NULL, NULL, NULL, 'Степанов И.В. ', NULL, NULL, '7978 873 39 47', 0, NULL);
INSERT INTO public.contractors VALUES (3531, 1, NULL, NULL, NULL, NULL, NULL, 'Степанов С.Д. ', NULL, NULL, '7978 709 11 03', 0, NULL);
INSERT INTO public.contractors VALUES (3532, 1, NULL, NULL, NULL, NULL, NULL, 'Степанов С.Е. ', NULL, NULL, '7978 806 15 68', 0, NULL);
INSERT INTO public.contractors VALUES (3533, 0, NULL, NULL, NULL, NULL, NULL, 'Степанченко Игорь ', NULL, NULL, '79787564394', 0, NULL);
INSERT INTO public.contractors VALUES (3534, 1, NULL, NULL, NULL, NULL, NULL, 'Степанык В.М. ', NULL, NULL, '7978 86 98 417', 0, NULL);
INSERT INTO public.contractors VALUES (3535, 1, NULL, NULL, NULL, NULL, NULL, 'Стецурин 79787312021', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3536, 1, NULL, NULL, NULL, NULL, NULL, 'Стецурин Д.Н. ', NULL, NULL, '7 978 831 20 21', 0, NULL);
INSERT INTO public.contractors VALUES (3537, 1, NULL, NULL, NULL, NULL, NULL, 'Стецюк НА 79787182019', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3538, 0, NULL, NULL, NULL, NULL, NULL, 'СТИМУЛ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3619, 1, NULL, NULL, NULL, NULL, NULL, 'Сысоев Э ', NULL, NULL, '79780132602', 0, NULL);
INSERT INTO public.contractors VALUES (3539, 0, NULL, NULL, NULL, NULL, NULL, 'СТМ-СТРОЙ  Шибанов Владимир ', NULL, NULL, '7 978 017 23 96 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3540, 0, NULL, NULL, NULL, NULL, NULL, '"СТМ-Строй""  ', NULL, NULL, '7 988 345 76 41 ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3541, 1, NULL, NULL, NULL, NULL, NULL, 'Стойков Е.В. ', NULL, NULL, '79782088780', 0, NULL);
INSERT INTO public.contractors VALUES (3542, 0, NULL, NULL, NULL, NULL, NULL, 'СТОЙКОМФОРТ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3543, 1, NULL, NULL, NULL, NULL, NULL, 'Столяренко В.Г. ', NULL, NULL, '7 978 84 65 257', 0, NULL);
INSERT INTO public.contractors VALUES (3544, 1, NULL, NULL, NULL, NULL, NULL, 'Столярчук ФВ 79787920082', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3545, 1, NULL, NULL, NULL, NULL, NULL, 'Стороженко Ю.И', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3546, 1, NULL, NULL, NULL, NULL, NULL, 'Сторожук Николай (пр) ', NULL, NULL, '7 978 846 45 01', 0, NULL);
INSERT INTO public.contractors VALUES (3547, 1, NULL, NULL, NULL, NULL, NULL, 'Стратан Валерий Семенович ', NULL, NULL, '7978 790 37 86', 0, NULL);
INSERT INTO public.contractors VALUES (3548, 0, NULL, NULL, NULL, NULL, NULL, 'Стратиенко Владимир ', NULL, NULL, '79780607720', 0, NULL);
INSERT INTO public.contractors VALUES (3549, 1, NULL, NULL, NULL, NULL, NULL, 'Стрембовский А.П. ', NULL, NULL, '7 978 733 91 20', 0, NULL);
INSERT INTO public.contractors VALUES (3550, 0, NULL, NULL, NULL, NULL, NULL, 'Стрембовский А.П. ', NULL, NULL, '7 978 733 91 20', 0, NULL);
INSERT INTO public.contractors VALUES (3551, 0, NULL, NULL, NULL, NULL, NULL, 'Строитель 41 3652693081 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3552, 0, NULL, NULL, NULL, NULL, NULL, 'Строитель-41 ', NULL, NULL, '7 978 747 60 30 Валентина Серафимовна ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3553, 0, NULL, NULL, NULL, NULL, 910201001, 'СТРОИТЕЛЬНАЯ КОМПАНИЯ БАЗИС ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3554, 0, NULL, NULL, NULL, NULL, 920101001, '"СТРОИТЕЛЬНО-ПРАВОВАЯ КОМПАНИЯ"" _Петр ', NULL, NULL, ' 978 0062820_Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3555, 0, NULL, NULL, NULL, NULL, NULL, 'Строй Дом (Маяковского) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3556, 0, NULL, NULL, NULL, NULL, NULL, 'Строй Сиб Игорь', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3557, 0, NULL, NULL, NULL, NULL, 732901001, '"СТРОЙ-ПРОФИЛЬ"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3558, 0, NULL, NULL, NULL, NULL, NULL, '"СТРОЙ-ПРОФИЛЬ"", Никита Двоинов  ', NULL, NULL, '7 987 636 99 49 (д.п.) - Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3559, 0, NULL, NULL, NULL, NULL, NULL, 'Стройбаза Крым ООО ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3560, 0, NULL, NULL, NULL, NULL, 910201001, '"СТРОЙГАЗКОМПЛЕКТ-2001""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3561, 0, NULL, NULL, NULL, NULL, NULL, 'Стройгарантремонт ', NULL, NULL, '79880887222', 0, NULL);
INSERT INTO public.contractors VALUES (3562, 2, NULL, NULL, NULL, NULL, NULL, 'Стройдом Раздольное  Бугера Татьяна Валерьевна _Л. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3563, 0, NULL, NULL, NULL, NULL, NULL, 'Стройка-Крым д.п. -А. (ООО)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3564, 0, NULL, NULL, NULL, NULL, NULL, 'Стройкапитал Виталий ', NULL, NULL, '7 915 737 0686', 0, NULL);
INSERT INTO public.contractors VALUES (3565, 0, NULL, NULL, NULL, NULL, 910201001, 'СТРОЙКОМПЛЕКС ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3566, 0, NULL, NULL, NULL, NULL, NULL, 'Стройкомфорт ', NULL, NULL, '7 978 810 11 13', 0, NULL);
INSERT INTO public.contractors VALUES (3567, 0, NULL, NULL, NULL, NULL, NULL, 'СтройЛидер ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3568, 0, NULL, NULL, NULL, NULL, NULL, 'Строймаг (Севастополь) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3569, 0, NULL, NULL, NULL, NULL, 920401001, 'СТРОЙМАГ ООО (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3570, 0, NULL, NULL, NULL, NULL, NULL, 'Строймаркет ЛТД (от Рады)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3571, 0, NULL, NULL, NULL, NULL, 910201001, 'СТРОЙМОДУЛЬ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3572, 0, NULL, NULL, NULL, NULL, NULL, 'СтройМонтаж ', NULL, NULL, '79780375955 Александр ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3573, 0, NULL, NULL, NULL, NULL, NULL, 'Строймонтажинвест 79789553729 Вячеслав', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3574, 0, NULL, NULL, NULL, NULL, NULL, 'Строймонтажсевис-юг ООО 707 49 56 ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3575, 0, NULL, NULL, NULL, NULL, NULL, 'Стройпроект  ', NULL, NULL, '7 978 768 0368 Владимир Александрович ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3576, 0, NULL, NULL, NULL, NULL, NULL, 'СтройСистемы', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3577, 0, NULL, NULL, NULL, NULL, NULL, 'Стройсистемы', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3578, 0, NULL, NULL, NULL, NULL, NULL, 'Стройсистемы (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3579, 0, NULL, NULL, NULL, NULL, 910201001, '"СТРОЙСНАБСЕРВИС"" (И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3580, 0, NULL, NULL, NULL, NULL, NULL, 'Стройцентр Ялта (И) ', NULL, NULL, '7(989)757-01-57', 0, NULL);
INSERT INTO public.contractors VALUES (3581, 0, NULL, NULL, NULL, NULL, NULL, 'СтройЭлектромонтаж Крым  ', NULL, NULL, '7 978 039 47 21 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3582, 1, NULL, NULL, NULL, NULL, NULL, 'Строкач Н 89194079515 дп', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3583, 0, NULL, NULL, NULL, NULL, NULL, 'Строком ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3584, 0, NULL, NULL, NULL, NULL, NULL, 'Стротан В.С. ', NULL, NULL, '79787903786', 0, NULL);
INSERT INTO public.contractors VALUES (3585, 0, NULL, NULL, NULL, NULL, NULL, 'Струняшев Алексей ', NULL, NULL, '79787553150', 0, NULL);
INSERT INTO public.contractors VALUES (3586, 1, NULL, NULL, NULL, NULL, NULL, 'Стрючков СВ 79787913836', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3587, 0, NULL, NULL, NULL, NULL, 910301001, 'СТС-КРЫМ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3588, 1, NULL, NULL, NULL, NULL, NULL, 'Стукало Л.О. ', NULL, NULL, '7 978 772 43 44', 0, NULL);
INSERT INTO public.contractors VALUES (3589, 1, NULL, NULL, NULL, NULL, NULL, 'Стукан В.М. ', NULL, NULL, '7 978 046 43 55', 0, NULL);
INSERT INTO public.contractors VALUES (3590, 1, NULL, NULL, NULL, NULL, NULL, 'Ступнева О.В. ', NULL, NULL, '7978 747 59 14', 0, NULL);
INSERT INTO public.contractors VALUES (3591, 1, NULL, NULL, NULL, NULL, NULL, 'Сувалов Ю.В. ', NULL, NULL, '7 978 05 17 033', 0, NULL);
INSERT INTO public.contractors VALUES (3592, 1, NULL, NULL, NULL, NULL, NULL, 'Суглобов Д.А. ', NULL, NULL, '7 978 787 14 37', 0, NULL);
INSERT INTO public.contractors VALUES (3593, 1, NULL, NULL, NULL, NULL, NULL, 'Суздалев КВ 79787922728', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3594, 1, NULL, NULL, NULL, NULL, NULL, 'Суинов А.Р. ', NULL, NULL, '7978 077 93 95', 0, NULL);
INSERT INTO public.contractors VALUES (3595, 1, NULL, NULL, NULL, NULL, NULL, 'Сулайманов М.У. ', NULL, NULL, '7 978 982 66 50', 0, NULL);
INSERT INTO public.contractors VALUES (3596, 0, NULL, NULL, NULL, NULL, NULL, 'Сулайманов Эльдар ', NULL, NULL, '7 978 8572018', 0, NULL);
INSERT INTO public.contractors VALUES (3597, 0, NULL, NULL, NULL, NULL, NULL, 'Сулейманов Белял  ', NULL, NULL, '7 978 787 74 14', 0, NULL);
INSERT INTO public.contractors VALUES (3598, 0, NULL, NULL, NULL, NULL, NULL, 'Сулеманов Ремзи ', NULL, NULL, '79787918272', 0, NULL);
INSERT INTO public.contractors VALUES (3599, 1, NULL, NULL, NULL, NULL, NULL, 'Султанбеев В.В, ', NULL, NULL, '7 978 77 12 320 А (к)', 0, NULL);
INSERT INTO public.contractors VALUES (3600, 1, NULL, NULL, NULL, NULL, NULL, 'Султанов М.А. ', NULL, NULL, '7 978 730 97 69', 0, NULL);
INSERT INTO public.contractors VALUES (3601, 0, NULL, NULL, NULL, NULL, NULL, 'Султанов Р.Н. ', NULL, NULL, '7978 757 06 19', 0, NULL);
INSERT INTO public.contractors VALUES (3602, 1, NULL, NULL, NULL, NULL, NULL, 'Супрун В.Я. ', NULL, NULL, '7 978 715 84 94', 0, NULL);
INSERT INTO public.contractors VALUES (3603, 1, NULL, NULL, NULL, NULL, NULL, 'Супрунов Александр Анатольевич ', NULL, NULL, '7978 734 34 10', 0, NULL);
INSERT INTO public.contractors VALUES (3604, 0, NULL, NULL, NULL, NULL, NULL, 'Сурков С.А. ', NULL, NULL, '79787230207', 0, NULL);
INSERT INTO public.contractors VALUES (3605, 0, NULL, NULL, NULL, NULL, NULL, 'Суров Иван ', NULL, NULL, '79787657412', 0, NULL);
INSERT INTO public.contractors VALUES (3606, 0, NULL, NULL, NULL, NULL, NULL, 'Сусану И.В. ', NULL, NULL, '7 978 870 50 99', 0, NULL);
INSERT INTO public.contractors VALUES (3607, 0, NULL, NULL, NULL, NULL, NULL, 'Сусану С.В. ', NULL, NULL, '7 978 870 50 99', 0, NULL);
INSERT INTO public.contractors VALUES (3608, 1, NULL, NULL, NULL, NULL, NULL, 'Суфьянов Сабри ', NULL, NULL, '7 978 707 89 67', 0, NULL);
INSERT INTO public.contractors VALUES (3609, 0, NULL, NULL, NULL, NULL, NULL, 'Сухарев В.Д. ', NULL, NULL, '7978 727 48 38', 0, NULL);
INSERT INTO public.contractors VALUES (3610, 1, NULL, NULL, NULL, NULL, NULL, 'Сухинин ВА ', NULL, NULL, '79788499095', 0, NULL);
INSERT INTO public.contractors VALUES (3611, 0, NULL, NULL, NULL, NULL, NULL, 'Сухоруков Д.Г. ', NULL, NULL, '79781113973', 0, NULL);
INSERT INTO public.contractors VALUES (3612, 1, NULL, NULL, NULL, NULL, NULL, 'Сухорученко С.В. ', NULL, NULL, '7978 749 88 58', 0, NULL);
INSERT INTO public.contractors VALUES (3613, 1, NULL, NULL, NULL, NULL, NULL, 'Сухоручко 79782066788', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3614, 1, NULL, NULL, NULL, NULL, NULL, 'Сушков ДВ 79787234073', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3615, 0, NULL, NULL, NULL, NULL, NULL, 'СЧ Истейтсервис ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3616, 1, NULL, NULL, NULL, NULL, NULL, 'Съедин К.Э. ', NULL, NULL, '7978 773 16 15', 0, NULL);
INSERT INTO public.contractors VALUES (3617, 1, NULL, NULL, NULL, NULL, NULL, 'Сыков ВВ 79787361153', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3618, 1, NULL, NULL, NULL, NULL, NULL, 'Сыритко Г.Г. ', NULL, NULL, '79788166578', 0, NULL);
INSERT INTO public.contractors VALUES (3620, 0, NULL, NULL, NULL, NULL, NULL, 'Сычев М.Ю. ', NULL, NULL, '7 978 75 81 882', 0, NULL);
INSERT INTO public.contractors VALUES (3621, 0, NULL, NULL, NULL, NULL, NULL, 'СЭЗ ООО ', NULL, NULL, '79788329429 Сергей', 0, NULL);
INSERT INTO public.contractors VALUES (3622, 0, NULL, NULL, NULL, NULL, NULL, 'Сюсюрченко Н.Г. ', NULL, NULL, '7 978 8589382', 0, NULL);
INSERT INTO public.contractors VALUES (3623, 0, NULL, NULL, NULL, NULL, NULL, 'Табунщик Александр ', NULL, NULL, '79788464565', 0, NULL);
INSERT INTO public.contractors VALUES (3624, 0, NULL, NULL, NULL, NULL, NULL, 'Таврида ', NULL, NULL, '79789503132 Колпаков Роман Владимирович ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3625, 0, NULL, NULL, NULL, NULL, 910201001, 'ТАВРИДА ГРУП, ', NULL, NULL, '7 978 259 20 43 Елена (д.п.) - Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3626, 0, NULL, NULL, NULL, NULL, NULL, 'Таврида Моторс ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3627, 1, NULL, NULL, NULL, NULL, NULL, 'Тадевасян А 79788269146', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3628, 0, NULL, NULL, NULL, NULL, 910201001, '"ТАЙФУН КРЫМ""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3629, 1, NULL, NULL, NULL, NULL, NULL, 'Такоян Р.С. ', NULL, NULL, '7978 898 61 99', 0, NULL);
INSERT INTO public.contractors VALUES (3630, 0, NULL, NULL, NULL, NULL, NULL, 'Талалаев В.А. ', NULL, NULL, '7 978 73 094 12', 0, NULL);
INSERT INTO public.contractors VALUES (3631, 2, NULL, NULL, NULL, NULL, NULL, 'Тамашов Юрий Александрович', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3632, 1, NULL, NULL, NULL, NULL, NULL, 'Танашевич ВВ 79787566036', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3633, 1, NULL, NULL, NULL, NULL, NULL, 'Танашевич ВВ 79787566036', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3634, 1, NULL, NULL, NULL, NULL, NULL, 'Тандура Вадим ', NULL, NULL, '7 913 978 83 34', 0, NULL);
INSERT INTO public.contractors VALUES (3635, 1, NULL, NULL, NULL, NULL, NULL, 'Танюхин Д.А. ', NULL, NULL, '7 978 857 99 16', 0, NULL);
INSERT INTO public.contractors VALUES (3636, 1, NULL, NULL, NULL, NULL, NULL, 'Тарадин 79787746163', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3637, 1, NULL, NULL, NULL, NULL, NULL, 'Таранник РВ 79780191821', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3638, 1, NULL, NULL, NULL, NULL, NULL, 'Тарасенко В.Н. ', NULL, NULL, '79787130068', 0, NULL);
INSERT INTO public.contractors VALUES (3639, 1, NULL, NULL, NULL, NULL, NULL, 'Тарасенко В.О. ', NULL, NULL, '7 978 721 66 81', 0, NULL);
INSERT INTO public.contractors VALUES (3640, 1, NULL, NULL, NULL, NULL, NULL, 'Тарасюк РВ 79787556903', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3641, 1, NULL, NULL, NULL, NULL, NULL, 'Тарыцэ Дмитрий Васильевич ', NULL, NULL, '79788214999', 0, NULL);
INSERT INTO public.contractors VALUES (3642, 1, NULL, NULL, NULL, NULL, NULL, 'Тафинцев Е.Л. ', NULL, NULL, '7978 74 98 541', 0, NULL);
INSERT INTO public.contractors VALUES (3643, 1, NULL, NULL, NULL, NULL, NULL, 'Ташев 79780777185', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3644, 1, NULL, NULL, NULL, NULL, NULL, 'Ташеф Ф.М. ', NULL, NULL, '7978 035 31 91 (92)', 0, NULL);
INSERT INTO public.contractors VALUES (3645, 0, NULL, NULL, NULL, NULL, NULL, 'ТвойСипДом ', NULL, NULL, '79780535277', 0, NULL);
INSERT INTO public.contractors VALUES (3646, 0, NULL, NULL, NULL, NULL, 911001001, '"ТД БЕЛАРУС ЭКСПОРТ"" _Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3647, 0, NULL, NULL, NULL, NULL, NULL, 'ТД Контраст Юрий (д.п.) - Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3648, 0, NULL, NULL, NULL, NULL, 920401001, 'ТД ПРОГРЕСС ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3649, 0, NULL, NULL, NULL, NULL, NULL, 'ТД Ренесанс Трейд Крым 79787527547 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3650, 0, NULL, NULL, NULL, NULL, NULL, 'ТД Фрегат (Заминов) 8978 740 18 19 Сергей', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3651, 1, NULL, NULL, NULL, NULL, NULL, 'Тейфуков 79788815677', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3652, 1, NULL, NULL, NULL, NULL, NULL, 'Тейфуков ТС 79780333492', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3653, 1, NULL, NULL, NULL, NULL, NULL, 'Тейфуков Эрвин ', NULL, NULL, '7 978 82 888 97', 0, NULL);
INSERT INTO public.contractors VALUES (3654, 0, NULL, NULL, NULL, NULL, NULL, 'Текома ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3655, 2, NULL, NULL, NULL, NULL, NULL, 'Текотева Анна Олеговна-А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3656, 1, NULL, NULL, NULL, NULL, NULL, 'Телепнев АВ 79787675292', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3657, 1, NULL, NULL, NULL, NULL, NULL, 'Тельнов Руслан ', NULL, NULL, '7978 735 39 80', 0, NULL);
INSERT INTO public.contractors VALUES (3658, 1, NULL, NULL, NULL, NULL, NULL, 'Тельный АВ 79788301653', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3659, 0, NULL, NULL, NULL, NULL, NULL, 'Темиркаев Аким (И) 89788552721', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3660, 1, NULL, NULL, NULL, NULL, NULL, 'Темчук Т.А. ', NULL, NULL, '7978 746 95 20', 0, NULL);
INSERT INTO public.contractors VALUES (3661, 0, NULL, NULL, NULL, NULL, NULL, 'Теплострой Евпатория', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3662, 0, NULL, NULL, NULL, NULL, NULL, 'Теплостройсервис ', NULL, NULL, '7 978 229 63 06 Андрей', 0, NULL);
INSERT INTO public.contractors VALUES (3663, 0, NULL, NULL, NULL, NULL, NULL, 'Тера Инвест  (И) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3664, 0, NULL, NULL, NULL, NULL, NULL, 'Терехов А.Н. ', NULL, NULL, '7 978 81 76 622', 0, NULL);
INSERT INTO public.contractors VALUES (3665, 1, NULL, NULL, NULL, NULL, NULL, 'Терехов О.О, ', NULL, NULL, '7 978 75 17 100', 0, NULL);
INSERT INTO public.contractors VALUES (3666, 1, NULL, NULL, NULL, NULL, NULL, 'Терещенко А.В. ', NULL, NULL, '7978 802 97 08', 0, NULL);
INSERT INTO public.contractors VALUES (3667, 1, NULL, NULL, NULL, NULL, NULL, 'Терещенко С 79787466021', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3668, 1, NULL, NULL, NULL, NULL, NULL, 'Терещук С.П. ', NULL, NULL, '7 978 7309878', 0, NULL);
INSERT INTO public.contractors VALUES (3669, 0, NULL, NULL, NULL, NULL, NULL, 'Термотерра ', NULL, NULL, '79787909459', 0, NULL);
INSERT INTO public.contractors VALUES (3670, 0, NULL, NULL, NULL, NULL, NULL, 'Термоэффект ООО ', NULL, NULL, '7 978 75 10 169 Игорь', 0, NULL);
INSERT INTO public.contractors VALUES (3671, 0, NULL, NULL, NULL, NULL, NULL, 'Тернавский Н.Ф. ', NULL, NULL, '7978 8854459', 0, NULL);
INSERT INTO public.contractors VALUES (3672, 1, NULL, NULL, NULL, NULL, NULL, 'Теряев 79787144026', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3673, 0, NULL, NULL, NULL, NULL, NULL, 'ТЕТА фирма ', NULL, NULL, '7 978 983 08 20 Владимир', 0, NULL);
INSERT INTO public.contractors VALUES (3674, 0, NULL, NULL, NULL, NULL, NULL, 'Техникс  ', NULL, NULL, '7 978 846 24 39 Александр ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3675, 1, NULL, NULL, NULL, NULL, NULL, 'Техно Вектор 898209069227 ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3676, 0, NULL, NULL, NULL, NULL, NULL, 'Техноблок-Строй (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3677, 0, NULL, NULL, NULL, NULL, NULL, 'Технодом Ершов Александр ( И.)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3678, 0, NULL, NULL, NULL, NULL, NULL, 'Технодом Ершов Александр (д.п.) - И.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3679, 1, NULL, NULL, NULL, NULL, NULL, 'Техноконсалт-Юг, ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3680, 0, NULL, NULL, NULL, NULL, 910201001, 'Технологии Качества Плюс Рает ', NULL, 15753811, '79787594580 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3681, 0, NULL, NULL, NULL, NULL, 910201001, 'Технологии Качества Рает ', NULL, NULL, '7 978 759 45 80', 0, NULL);
INSERT INTO public.contractors VALUES (3682, 0, NULL, NULL, NULL, NULL, NULL, 'Технологии Качества, Осман, ', NULL, NULL, '7 978 78 79 600 - Л. ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3683, 0, NULL, NULL, NULL, NULL, NULL, 'Технониколь', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3684, 0, NULL, NULL, NULL, NULL, NULL, 'Техностиль', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3685, 0, NULL, NULL, NULL, NULL, NULL, 'Техноцентр  ', NULL, NULL, '7978 829 87 50 Василий Иванович ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3686, 0, NULL, NULL, NULL, NULL, 771701001, '"ТЖБС"" _ Л. ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3687, 0, NULL, NULL, NULL, NULL, NULL, 'Тиара Кровельный центр -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3688, 0, NULL, NULL, NULL, NULL, NULL, 'Тилюпа О.А. ', NULL, NULL, '7 978 13 11 137', 0, NULL);
INSERT INTO public.contractors VALUES (3689, 1, NULL, NULL, NULL, NULL, NULL, 'Тимановская Н.В. ', NULL, NULL, '7978 70 32 855', 0, NULL);
INSERT INTO public.contractors VALUES (3690, 1, NULL, NULL, NULL, NULL, NULL, 'Тимашев О.Н. ', NULL, NULL, '7978 810 24 01', 0, NULL);
INSERT INTO public.contractors VALUES (3691, 0, NULL, NULL, NULL, NULL, NULL, 'Тимеркаев Аким ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3692, 1, NULL, NULL, NULL, NULL, NULL, 'Тимофеев 79787180743', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3693, 1, NULL, NULL, NULL, NULL, NULL, 'Тимофеева Ю.Г. ', NULL, NULL, '7978 79 19 814', 0, NULL);
INSERT INTO public.contractors VALUES (3694, 1, NULL, NULL, NULL, NULL, NULL, 'Тимохин СВ 79181531133', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3695, 1, NULL, NULL, NULL, NULL, NULL, 'Тимошенко 79788113138', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3696, 1, NULL, NULL, NULL, NULL, NULL, 'Тимошенко А.В. ', NULL, NULL, '7 978 004 68 73', 0, NULL);
INSERT INTO public.contractors VALUES (3697, 1, NULL, NULL, NULL, NULL, NULL, 'Тимошенко Олег ', NULL, NULL, '7 978 869 74 91', 0, NULL);
INSERT INTO public.contractors VALUES (3698, 1, NULL, NULL, NULL, NULL, NULL, 'Тимошенко Р.В. ', NULL, NULL, '7978 76 11 767', 0, NULL);
INSERT INTO public.contractors VALUES (3699, 0, NULL, NULL, NULL, NULL, NULL, 'Тимошенко Юрий', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3700, 0, NULL, NULL, NULL, NULL, NULL, 'Тимощенко А.В. ', NULL, NULL, '7978 845 42 90 (Севастополь)', 0, NULL);
INSERT INTO public.contractors VALUES (3701, 1, NULL, NULL, NULL, NULL, NULL, 'Тимченко Е.Н 8978-740-21-23', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3702, 1, NULL, NULL, NULL, NULL, NULL, 'Тисняк Д.А. ', NULL, NULL, '7 978 751 16 90', 0, NULL);
INSERT INTO public.contractors VALUES (3703, 1, NULL, NULL, NULL, NULL, NULL, 'Титаренко М.Г. ', NULL, NULL, '7 978 704 86 43', 0, NULL);
INSERT INTO public.contractors VALUES (3704, 1, NULL, NULL, NULL, NULL, NULL, 'Титков Д.Н. ', NULL, NULL, '7978 75 111 49', 0, NULL);
INSERT INTO public.contractors VALUES (3705, 1, NULL, NULL, NULL, NULL, NULL, 'Титов В.Е. ', NULL, NULL, '7 978 731 30 65', 0, NULL);
INSERT INTO public.contractors VALUES (3706, 1, NULL, NULL, NULL, NULL, NULL, 'Титов О 79787275808', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3707, 1, NULL, NULL, NULL, NULL, NULL, 'Титов О.А. ', NULL, NULL, '7978 843 00 39', 0, NULL);
INSERT INTO public.contractors VALUES (3708, 0, NULL, NULL, NULL, NULL, NULL, 'Титов Эдуард Николаевич ', NULL, NULL, '79782221986', 0, NULL);
INSERT INTO public.contractors VALUES (3709, 1, NULL, NULL, NULL, NULL, NULL, 'Титоренко ИС 79788397809 08', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3710, 1, NULL, NULL, NULL, NULL, NULL, 'Тихенко Сергей Анатольевич ', NULL, NULL, '79782072825', 0, NULL);
INSERT INTO public.contractors VALUES (3711, 2, NULL, NULL, NULL, NULL, NULL, 'Тиховский Артур Валерьевич', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3712, 1, NULL, NULL, NULL, NULL, NULL, 'Тихонов АА 79788711102', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3713, 1, NULL, NULL, NULL, NULL, NULL, 'Тихонов АВ 7978792425', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3714, 0, NULL, NULL, NULL, NULL, NULL, 'Тихонов Г.В. ', NULL, NULL, '7 978 715 78 27', 0, NULL);
INSERT INTO public.contractors VALUES (3715, 1, NULL, NULL, NULL, NULL, NULL, 'Тищенко А.А. ', NULL, NULL, '7978 762 61 48', 0, NULL);
INSERT INTO public.contractors VALUES (3716, 0, NULL, NULL, NULL, NULL, NULL, 'Тищенко Дмитрий Васильевич ', NULL, NULL, '79787365692', 0, NULL);
INSERT INTO public.contractors VALUES (3717, 1, NULL, NULL, NULL, NULL, NULL, 'Тищенко С.М. ', NULL, NULL, '7978 728 07 52', 0, NULL);
INSERT INTO public.contractors VALUES (3718, 2, NULL, NULL, NULL, NULL, NULL, 'Тищенко Ю.П. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3719, 0, NULL, NULL, NULL, NULL, 910201001, '"ТК ВАШ ДОМ""(И) ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3720, 1, NULL, NULL, NULL, NULL, NULL, 'Ткач С.В. ', NULL, NULL, '7978 74 600 36', 0, NULL);
INSERT INTO public.contractors VALUES (3721, 0, NULL, NULL, NULL, NULL, NULL, 'Ткаченко В.К. ', NULL, NULL, '7 978 831 85 98', 0, NULL);
INSERT INTO public.contractors VALUES (3722, 1, NULL, NULL, NULL, NULL, NULL, 'Ткаченко Н.Н. ', NULL, NULL, '7978 77 69 904', 0, NULL);
INSERT INTO public.contractors VALUES (3723, 0, NULL, NULL, NULL, NULL, NULL, 'Ткачук Анатолий ', NULL, NULL, '79789460047', 0, NULL);
INSERT INTO public.contractors VALUES (3724, 1, NULL, NULL, NULL, NULL, NULL, 'Ткачук В.В. ', NULL, NULL, '7918 119 41 21', 0, NULL);
INSERT INTO public.contractors VALUES (3725, 1, NULL, NULL, NULL, NULL, NULL, 'Ткачук С.С, ', NULL, NULL, '7 978 841 77 54', 0, NULL);
INSERT INTO public.contractors VALUES (3726, 1, NULL, NULL, NULL, NULL, NULL, 'Тлустов ИВ 79787440920', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3727, 2, NULL, NULL, NULL, NULL, NULL, 'Тлюстангелова И.Г. ', NULL, NULL, '7978 77 049 40 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3728, 0, NULL, NULL, NULL, NULL, NULL, 'Товстуха А.В.', NULL, NULL, '79780148085', 0, NULL);
INSERT INTO public.contractors VALUES (3729, 0, NULL, NULL, NULL, NULL, NULL, 'Токарев Владимир ', NULL, NULL, '7 978 774 9731', 0, NULL);
INSERT INTO public.contractors VALUES (3730, 1, NULL, NULL, NULL, NULL, NULL, 'Токмаков А ', NULL, NULL, '7 918 146 01 50', 0, NULL);
INSERT INTO public.contractors VALUES (3731, 1, NULL, NULL, NULL, NULL, NULL, 'Толмачев АА 79787078608', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3732, 1, NULL, NULL, NULL, NULL, NULL, 'Толстиков ИВ 79787291442', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3733, 0, NULL, NULL, NULL, NULL, NULL, 'Толстиков Максим ', NULL, NULL, '7 978 777 59 05', 0, NULL);
INSERT INTO public.contractors VALUES (3734, 1, NULL, NULL, NULL, NULL, NULL, 'Толстов СА 79788725267', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3735, 1, NULL, NULL, NULL, NULL, NULL, 'Томащик М.А. ', NULL, NULL, '7 978 75 27 460', 0, NULL);
INSERT INTO public.contractors VALUES (3736, 0, NULL, NULL, NULL, NULL, NULL, 'Томенчук В.Г. ', NULL, NULL, '7 978 777 19 75', 0, NULL);
INSERT INTO public.contractors VALUES (3737, 1, NULL, NULL, NULL, NULL, NULL, 'Тонников И.П. ', NULL, NULL, '7 978 089 65 75', 0, NULL);
INSERT INTO public.contractors VALUES (3738, 0, NULL, NULL, NULL, NULL, NULL, 'Топорков В.Г. ', NULL, NULL, '79788832745', 0, NULL);
INSERT INTO public.contractors VALUES (3739, 1, NULL, NULL, NULL, NULL, NULL, 'Топчик Эдем ', NULL, NULL, '7978 219 66 28', 0, NULL);
INSERT INTO public.contractors VALUES (3740, 0, NULL, NULL, NULL, NULL, NULL, '"Торговый Дом ""Альбус ООО"', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3741, NULL, NULL, NULL, NULL, NULL, 232301001, 'ТОРМ Межрайонной ИФНС России № 17 по Краснодарскому краю в Абинском районе Краснодарского края', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3742, NULL, NULL, NULL, NULL, NULL, 231401001, 'ТОРМ Межрайонной ИФНС России № 18 по Краснодарскому краю в г. Лабинске Краснодарского края', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3743, 1, NULL, NULL, NULL, NULL, NULL, 'Тороков Юрий ', NULL, NULL, '7978 73 72 401', 0, NULL);
INSERT INTO public.contractors VALUES (3744, 0, NULL, NULL, NULL, NULL, NULL, 'Торопов Д.В. ', NULL, NULL, '7 978 084 45 01', 0, NULL);
INSERT INTO public.contractors VALUES (3745, 1, NULL, NULL, NULL, NULL, NULL, 'Торопчин АИ 79787230203', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3746, 1, NULL, NULL, NULL, NULL, NULL, 'Торский ДВ ', NULL, NULL, '79787158254', 0, NULL);
INSERT INTO public.contractors VALUES (3747, 0, NULL, NULL, NULL, NULL, NULL, 'Торчило Александр ', NULL, NULL, '7 918 541 98 89', 0, NULL);
INSERT INTO public.contractors VALUES (3748, 1, NULL, NULL, NULL, NULL, NULL, 'Тофан А.Т. ', NULL, NULL, '7 978 77 15 297', 0, NULL);
INSERT INTO public.contractors VALUES (3749, 1, NULL, NULL, NULL, NULL, NULL, 'Травкин К.И. ', NULL, NULL, '7 978 7232 965', 0, NULL);
INSERT INTO public.contractors VALUES (3750, 0, NULL, NULL, NULL, NULL, 561201001, 'ТРАНС СЕРВИС ИМЭКС ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3751, 0, NULL, NULL, NULL, NULL, NULL, 'Транс Энерго Строй ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3752, 0, NULL, NULL, NULL, NULL, 910201001, 'ТРАНСЭНЕРГОСТРОЙ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3753, 0, NULL, NULL, NULL, NULL, NULL, 'Траст групп Евгений ', NULL, NULL, '7 968 693 15 26 - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3754, 1, NULL, NULL, NULL, NULL, NULL, 'Трафимов А.А. ', NULL, NULL, '7978 745 98 29', 0, NULL);
INSERT INTO public.contractors VALUES (3755, 0, NULL, NULL, NULL, NULL, NULL, 'Трейд Алиянс', NULL, NULL, ' 8978 09 99 015 Роман ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3756, 0, NULL, NULL, NULL, NULL, NULL, 'Трест СЗЭМ ', NULL, NULL, '7 495 120 60 70 Елена - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3757, 0, NULL, NULL, NULL, NULL, NULL, 'Третий Дом ', NULL, NULL, '7 978 753 31 57 Медат', 0, NULL);
INSERT INTO public.contractors VALUES (3758, 0, NULL, NULL, NULL, NULL, NULL, 'Третий Дом ', NULL, NULL, '7978 847 44 36 Григорий', 0, NULL);
INSERT INTO public.contractors VALUES (3759, 0, NULL, NULL, NULL, NULL, 616801001, 'ТРЕТИЙ ДОМ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3760, 0, NULL, NULL, NULL, NULL, NULL, 'Третьяков Анатолий ', NULL, NULL, '79787927081', 0, NULL);
INSERT INTO public.contractors VALUES (3761, 1, NULL, NULL, NULL, NULL, NULL, 'Третьяков ВВ 79788163536', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3762, 1, NULL, NULL, NULL, NULL, NULL, 'Третьяков С.Ю. ', NULL, NULL, '79780497909', 0, NULL);
INSERT INTO public.contractors VALUES (3763, 0, NULL, NULL, NULL, NULL, NULL, 'Тришкин Юрий Эдуардович ', NULL, NULL, '79787450845', 0, NULL);
INSERT INTO public.contractors VALUES (3764, 1, NULL, NULL, NULL, NULL, NULL, 'Трофименко А.В. ', NULL, NULL, '7 978 100 87 26', 0, NULL);
INSERT INTO public.contractors VALUES (3765, 1, NULL, NULL, NULL, NULL, NULL, 'Трофимов РР 79782798868', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3766, 1, NULL, NULL, NULL, NULL, NULL, 'Троц А.О. ', NULL, NULL, '7 978 8 502 630', 0, NULL);
INSERT INTO public.contractors VALUES (3767, 0, NULL, NULL, NULL, NULL, NULL, 'Троцан Виктор (Евпатория) ', NULL, NULL, '7978 719 59 93', 0, NULL);
INSERT INTO public.contractors VALUES (3768, 1, NULL, NULL, NULL, NULL, NULL, 'Трошин Д.Ю. ', NULL, NULL, '7 978 110 98 75', 0, NULL);
INSERT INTO public.contractors VALUES (3769, 1, NULL, NULL, NULL, NULL, NULL, 'Трошин И.Ю. ', NULL, NULL, '7978 772 38 18', 0, NULL);
INSERT INTO public.contractors VALUES (3770, 1, NULL, NULL, NULL, NULL, NULL, 'Трошкин АВ 79787986932', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3771, 1, NULL, NULL, NULL, NULL, NULL, 'Трубяков П.Л. ', NULL, NULL, '7978 750 85 97', 0, NULL);
INSERT INTO public.contractors VALUES (3772, 1, NULL, NULL, NULL, NULL, NULL, 'Труков С.С. ', NULL, NULL, '7 978 77 42 970', 0, NULL);
INSERT INTO public.contractors VALUES (3773, 1, NULL, NULL, NULL, NULL, NULL, 'Трусов АА 79788441612', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3774, 1, NULL, NULL, NULL, NULL, NULL, 'Труханов Г.Д ', NULL, NULL, '7978 214 91 04', 0, NULL);
INSERT INTO public.contractors VALUES (3775, 2, NULL, NULL, NULL, NULL, NULL, 'Труханович Сергей Викторович, ', NULL, NULL, '79787670196_Л. ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3776, 1, NULL, NULL, NULL, NULL, NULL, 'Трухачев 79787196691', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3777, 0, NULL, NULL, NULL, NULL, NULL, 'Трухов С.С. ', NULL, NULL, '7 978 77 42 970', 0, NULL);
INSERT INTO public.contractors VALUES (3778, 1, NULL, NULL, NULL, NULL, NULL, 'Трушкин Н.Н. ', NULL, NULL, '7978 729 89 10', 0, NULL);
INSERT INTO public.contractors VALUES (3779, 1, NULL, NULL, NULL, NULL, NULL, 'Тряпишко В.М. ', NULL, NULL, '7 978 713 88 04', 0, NULL);
INSERT INTO public.contractors VALUES (3780, 0, NULL, NULL, NULL, NULL, NULL, 'ТсК ', NULL, NULL, '7 978 718 27 00 Виталий Григорьевич ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3781, 0, NULL, NULL, NULL, NULL, NULL, 'ТСК ПИК ООО ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3782, 1, NULL, NULL, NULL, NULL, NULL, 'Тузов О.В. ', NULL, NULL, '7978 733 87 66', 0, NULL);
INSERT INTO public.contractors VALUES (3783, 1, NULL, NULL, NULL, NULL, NULL, 'Тукалов С 79892302143', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3784, 1, NULL, NULL, NULL, NULL, NULL, 'Туманова ИЕ 79787290177', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3785, 1, NULL, NULL, NULL, NULL, NULL, 'Тумасов А.О. ', NULL, NULL, '7 978 845 10 12', 0, NULL);
INSERT INTO public.contractors VALUES (3786, 1, NULL, NULL, NULL, NULL, NULL, 'Туник НА 79788819524', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3787, 1, NULL, NULL, NULL, NULL, NULL, 'Тупалов Ю ', NULL, NULL, '79787750709', 0, NULL);
INSERT INTO public.contractors VALUES (3788, 1, NULL, NULL, NULL, NULL, NULL, 'Тур ПИ 79781157316', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3789, 1, NULL, NULL, NULL, NULL, NULL, 'Турлаков С.В. ', NULL, NULL, '79788300844', 0, NULL);
INSERT INTO public.contractors VALUES (3790, 1, NULL, NULL, NULL, NULL, NULL, 'Турулев ЯА 79789510631', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3791, 1, NULL, NULL, NULL, NULL, NULL, 'Турусов РИ ', NULL, NULL, '79782570645', 0, NULL);
INSERT INTO public.contractors VALUES (3792, 1, NULL, NULL, NULL, NULL, NULL, 'Турчевский Р.А. ', NULL, NULL, '7978 713 42 00', 0, NULL);
INSERT INTO public.contractors VALUES (3793, 0, NULL, NULL, NULL, NULL, NULL, 'Турчик ', NULL, NULL, '7 978 766 07 97', 0, NULL);
INSERT INTO public.contractors VALUES (3794, 1, NULL, NULL, NULL, NULL, NULL, 'Турчина СН 79780787869', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3795, 1, NULL, NULL, NULL, NULL, NULL, 'Тучков ВН ', NULL, NULL, '79788329292', 0, NULL);
INSERT INTO public.contractors VALUES (3796, 1, NULL, NULL, NULL, NULL, NULL, 'Тучкова Е.В 7978 -755-00-39', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3797, 1, NULL, NULL, NULL, NULL, NULL, 'Тушевский М.П. ', NULL, NULL, '7 978 106 27 88', 0, NULL);
INSERT INTO public.contractors VALUES (3798, 1, NULL, NULL, NULL, NULL, NULL, 'Тыква Е.И. ', NULL, NULL, '7 978 731 56 35', 0, NULL);
INSERT INTO public.contractors VALUES (3799, 0, NULL, NULL, NULL, NULL, NULL, 'Тымкив Елена Викторовна (Евпатория) -А. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3800, 1, NULL, NULL, NULL, NULL, NULL, 'Тышко ВС 79787284922', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3801, 1, NULL, NULL, NULL, NULL, NULL, 'Тэст', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3802, 1, NULL, NULL, NULL, NULL, NULL, 'Тюменцев Сергей ', NULL, NULL, '7978 847 10 89', 0, NULL);
INSERT INTO public.contractors VALUES (3803, 1, NULL, NULL, NULL, NULL, NULL, 'Тюменцев СН 79788471089', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3804, 1, NULL, NULL, NULL, NULL, NULL, 'Тютин Юра ', NULL, NULL, '7 978 70 88 712', 0, NULL);
INSERT INTO public.contractors VALUES (3805, 1, NULL, NULL, NULL, NULL, NULL, 'Тягульский Р.С. ', NULL, NULL, '7978 896 00 13', 0, NULL);
INSERT INTO public.contractors VALUES (3806, 1, NULL, NULL, NULL, NULL, NULL, 'Тяско ДС 79781026536', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3807, 0, NULL, NULL, NULL, NULL, NULL, 'Убайдуллаев ', NULL, NULL, '7 978 789 0013', 0, NULL);
INSERT INTO public.contractors VALUES (3808, 1, NULL, NULL, NULL, NULL, NULL, 'Убрагимов Р 79787644887', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3809, 1, NULL, NULL, NULL, NULL, NULL, 'Угня Виталий Анатольевич ', NULL, NULL, '79787131462', 0, NULL);
INSERT INTO public.contractors VALUES (3810, 0, NULL, NULL, NULL, NULL, NULL, 'УД Сотников Александр Александрович ', NULL, NULL, '79788737061', 0, NULL);
INSERT INTO public.contractors VALUES (3811, 0, NULL, NULL, NULL, NULL, NULL, 'Уйван Ю.О.', NULL, NULL, '7978 850 33 17', 0, NULL);
INSERT INTO public.contractors VALUES (3812, 1, NULL, NULL, NULL, NULL, NULL, 'Уличкин Ю.И. ', NULL, NULL, '79788324848', 0, NULL);
INSERT INTO public.contractors VALUES (3813, 1, NULL, NULL, NULL, NULL, NULL, 'Ульяницкий ВВ 79787341052', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3814, 0, NULL, NULL, NULL, NULL, NULL, 'Умеров А.М. ', NULL, NULL, '7 978 830 98 90', 0, NULL);
INSERT INTO public.contractors VALUES (3815, 0, NULL, NULL, NULL, NULL, NULL, 'Умеров А.Р.', NULL, NULL, '79780808978 ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3816, 0, NULL, NULL, NULL, NULL, NULL, 'Умеров Р. Бахчисарай. ( И ) 978-852-69-18 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3817, 1, NULL, NULL, NULL, NULL, NULL, 'Умеров Р.А. ', NULL, NULL, '7978 809 81 08', 0, NULL);
INSERT INTO public.contractors VALUES (3818, 1, NULL, NULL, NULL, NULL, NULL, 'Умеров С.Р. ', NULL, NULL, '7 978 844 17 58', 0, NULL);
INSERT INTO public.contractors VALUES (3819, 1, NULL, NULL, NULL, NULL, NULL, 'Умеров Э. ', NULL, NULL, '7 918 488 58 22', 0, NULL);
INSERT INTO public.contractors VALUES (3820, 1, NULL, NULL, NULL, NULL, NULL, 'Умеров Э.Ю. ', NULL, NULL, '7 978 74 00 715', 0, NULL);
INSERT INTO public.contractors VALUES (3821, 0, NULL, NULL, NULL, NULL, NULL, 'Умерова И.Н. ', NULL, NULL, '79781048342', 0, NULL);
INSERT INTO public.contractors VALUES (3822, 1, NULL, NULL, NULL, NULL, NULL, 'Уразов Роман ', NULL, NULL, '7978 849-00-83 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3823, 2, NULL, NULL, NULL, NULL, NULL, 'Урсол И.В. ( Джанкой) -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3824, 0, NULL, NULL, NULL, NULL, NULL, 'Урчик В.И. ', NULL, NULL, '7988 968 68 96', 0, NULL);
INSERT INTO public.contractors VALUES (3825, 1, NULL, NULL, NULL, NULL, NULL, 'Урчик ВИ 79889686896', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3826, 0, NULL, NULL, NULL, NULL, NULL, 'Урядова Елена', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3827, 1, NULL, NULL, NULL, NULL, NULL, 'Урянский АН 79787541317', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3828, 0, NULL, NULL, NULL, NULL, NULL, 'Усев Ю.Г. ', NULL, NULL, '7 978 74 98 410', 0, NULL);
INSERT INTO public.contractors VALUES (3829, 1, NULL, NULL, NULL, NULL, NULL, 'Усеинов АЭ 79787482419', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3830, 1, NULL, NULL, NULL, NULL, NULL, 'Усеинов НС 79788878968', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3831, 1, NULL, NULL, NULL, NULL, NULL, 'Усеинов Р 79788637961', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3832, 0, NULL, NULL, NULL, NULL, NULL, 'Усеинов Р.Р. ', NULL, NULL, '7978 863 79 65', 0, NULL);
INSERT INTO public.contractors VALUES (3833, 1, NULL, NULL, NULL, NULL, NULL, 'Усеинов Т.У. ', NULL, NULL, '7 978 801 78 84', 0, NULL);
INSERT INTO public.contractors VALUES (3834, 1, NULL, NULL, NULL, NULL, NULL, 'Усеинов ТУ 79788017884', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3835, 0, NULL, NULL, NULL, NULL, NULL, 'Усенова Азиза ', NULL, NULL, '7 978 75 34 202', 0, NULL);
INSERT INTO public.contractors VALUES (3836, 1, NULL, NULL, NULL, NULL, NULL, 'Усик В.П. ', NULL, NULL, '7 978 88 14 260', 0, NULL);
INSERT INTO public.contractors VALUES (3837, 1, NULL, NULL, NULL, NULL, NULL, 'Усик Ю.В. ', NULL, NULL, '7 978 72 28 281', 0, NULL);
INSERT INTO public.contractors VALUES (3838, 1, NULL, NULL, NULL, NULL, NULL, 'Усманов Л.М. ', NULL, NULL, '7 978 031 39 52', 0, NULL);
INSERT INTO public.contractors VALUES (3839, 1, NULL, NULL, NULL, NULL, NULL, 'Усманов Р.Б. ', NULL, NULL, '7 978 837 37 07', 0, NULL);
INSERT INTO public.contractors VALUES (3840, 1, NULL, NULL, NULL, NULL, NULL, 'Усманов Р.Э. ', NULL, NULL, '79787987663', 0, NULL);
INSERT INTO public.contractors VALUES (3841, 0, NULL, NULL, NULL, NULL, NULL, 'Усманов У.Э. ', NULL, NULL, '7 978 737 93 58', 0, NULL);
INSERT INTO public.contractors VALUES (3842, 1, NULL, NULL, NULL, NULL, NULL, 'Усманский В.А. ', NULL, NULL, '7978 833 02 43', 0, NULL);
INSERT INTO public.contractors VALUES (3843, 1, NULL, NULL, NULL, NULL, NULL, 'Усольцева Жанна Алексеевна ', NULL, NULL, '7 978 753 00 16', 0, NULL);
INSERT INTO public.contractors VALUES (3844, 1, NULL, NULL, NULL, NULL, NULL, 'Устабаши ЕВ 79781488790', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3845, 0, NULL, NULL, NULL, NULL, NULL, 'Устименко Сергей ', NULL, NULL, '7 978 714 43 64', 0, NULL);
INSERT INTO public.contractors VALUES (3846, 1, NULL, NULL, NULL, NULL, NULL, 'Устинов АВ 79787036084', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3847, 0, NULL, NULL, NULL, NULL, NULL, 'Ухман Г.А. ', NULL, NULL, '7 978 7455119', 0, NULL);
INSERT INTO public.contractors VALUES (3848, 1, NULL, NULL, NULL, NULL, NULL, 'Ушаков АФ 79780069903', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3849, 2, NULL, NULL, NULL, NULL, NULL, 'Ушакова Оксана Анатольевна', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3850, 1, NULL, NULL, NULL, NULL, NULL, 'Ушанов Р.О. ', NULL, NULL, '7978 72 55 880', 0, NULL);
INSERT INTO public.contractors VALUES (3851, 1, NULL, NULL, NULL, NULL, NULL, 'Фадеев АА 79787546581', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3852, 1, NULL, NULL, NULL, NULL, NULL, 'Фадеев АП ', NULL, NULL, '79788330366', 0, NULL);
INSERT INTO public.contractors VALUES (3853, 0, NULL, NULL, NULL, NULL, NULL, 'Фазилов Р.Н. ', NULL, NULL, ' 7978 77762 21', 0, NULL);
INSERT INTO public.contractors VALUES (3854, 0, NULL, NULL, NULL, NULL, NULL, 'Фазилов Р.Т. ', NULL, NULL, '7 978 759 45 50', 0, NULL);
INSERT INTO public.contractors VALUES (3855, 1, NULL, NULL, NULL, NULL, NULL, 'Фазилов Р.Т. ', NULL, NULL, '7 978 759 45 50', 0, NULL);
INSERT INTO public.contractors VALUES (3856, 1, NULL, NULL, NULL, NULL, NULL, 'Фазылов Д.З.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3857, 1, NULL, NULL, NULL, NULL, NULL, 'Фазылов М.Э. 8 918 242 11 61', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3858, 0, NULL, NULL, NULL, NULL, NULL, 'Фаизулаев Р.П. ', NULL, NULL, '7 978 061 41 34', 0, NULL);
INSERT INTO public.contractors VALUES (3859, 1, NULL, NULL, NULL, NULL, NULL, 'Файзулаев Р.П. ', NULL, NULL, '7978 061 41 34', 0, NULL);
INSERT INTO public.contractors VALUES (3860, 1, NULL, NULL, NULL, NULL, NULL, 'Файзулин И.Н. ', NULL, NULL, '7 978 79 99 152', 0, NULL);
INSERT INTO public.contractors VALUES (3861, 1, NULL, NULL, NULL, NULL, NULL, 'Фалько Э.В. ', NULL, NULL, '7 978 78 77 437', 0, NULL);
INSERT INTO public.contractors VALUES (3862, 1, NULL, NULL, NULL, NULL, NULL, 'Фандеев ДД 79788734151', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3863, 0, NULL, NULL, NULL, NULL, 526201001, 'ФАРУС ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3864, 1, NULL, NULL, NULL, NULL, NULL, 'Фатахтинов Ю.В. ', NULL, NULL, '7978 73 22 903', 0, NULL);
INSERT INTO public.contractors VALUES (3865, 1, NULL, NULL, NULL, NULL, NULL, 'Февзиев С.Р. ', NULL, NULL, '7978 766 19 62', 0, NULL);
INSERT INTO public.contractors VALUES (3866, 1, NULL, NULL, NULL, NULL, NULL, 'Федин Виталий ', NULL, NULL, '7 985 171 12 26', 0, NULL);
INSERT INTO public.contractors VALUES (3867, 0, NULL, NULL, NULL, NULL, NULL, 'Федонкин Александр ', NULL, NULL, '7 978 764 53 83', 0, NULL);
INSERT INTO public.contractors VALUES (3868, 0, NULL, NULL, NULL, NULL, NULL, 'Федор Родник', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3869, 2, NULL, NULL, NULL, NULL, NULL, 'Федоренко Сергей Александрович (Федоренко Олег)_Л. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3870, 1, NULL, NULL, NULL, NULL, NULL, 'Федорков АС 79787566048', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3871, 1, NULL, NULL, NULL, NULL, NULL, 'Федоров АО 79787874409', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3872, 0, NULL, NULL, NULL, NULL, NULL, 'Федоров В.Л. ', NULL, NULL, '7978 712-46-40', 0, NULL);
INSERT INTO public.contractors VALUES (3873, 1, NULL, NULL, NULL, NULL, NULL, 'Федоров ВВ 79787916684', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3874, 1, NULL, NULL, NULL, NULL, NULL, 'Федорченко М.С. ', NULL, NULL, '7978 760 20 44', 0, NULL);
INSERT INTO public.contractors VALUES (3875, 0, NULL, NULL, NULL, NULL, NULL, 'Федорченко Эдуард Михайлович ', NULL, NULL, '79787558481', 0, NULL);
INSERT INTO public.contractors VALUES (3876, 0, NULL, NULL, NULL, NULL, NULL, 'Федотов И.В. ', NULL, NULL, '7 978 78 17 415', 0, NULL);
INSERT INTO public.contractors VALUES (3877, 0, NULL, NULL, NULL, NULL, NULL, 'Федотов ИН ', NULL, NULL, '79787252883', 0, NULL);
INSERT INTO public.contractors VALUES (3878, 1, NULL, NULL, NULL, NULL, NULL, 'Федотова А.М. ', NULL, NULL, '7978 80 99 161', 0, NULL);
INSERT INTO public.contractors VALUES (3879, 0, NULL, NULL, NULL, NULL, NULL, 'Федченко Алексей Юрьевич ', NULL, NULL, '79787292159', 0, NULL);
INSERT INTO public.contractors VALUES (3880, 1, NULL, NULL, NULL, NULL, NULL, 'Фенюк О.В. ', NULL, NULL, '7 978 279 52 62 (дил.пр)', 0, NULL);
INSERT INTO public.contractors VALUES (3881, 0, NULL, NULL, NULL, NULL, NULL, 'Феттаев Э.Ш. ', NULL, NULL, '7 978 840 97 72', 0, NULL);
INSERT INTO public.contractors VALUES (3882, 1, NULL, NULL, NULL, NULL, NULL, 'Феферов ОВ 79103120052', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3883, 0, NULL, NULL, NULL, NULL, NULL, 'Фил ГУП РК КМП Ялтинский торговый порт 79780427022', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3884, 1, NULL, NULL, NULL, NULL, NULL, 'Филатов ГВ 79787074165', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3885, 1, NULL, NULL, NULL, NULL, NULL, 'Филатов О.В. ', NULL, NULL, '79780314833 (к.п)', 0, NULL);
INSERT INTO public.contractors VALUES (3886, 1, NULL, NULL, NULL, NULL, NULL, 'Филатов СВ 79787222787', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3887, 1, NULL, NULL, NULL, NULL, NULL, 'Филатова 79780051378 81', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3888, NULL, NULL, NULL, NULL, NULL, 230901001, 'Филиал 4 ГУ – Краснодарского регионального отделения ФСС РФ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3889, NULL, NULL, NULL, NULL, NULL, 230901001, 'Филиал ГУ – Краснодарского регионального отделения ФСС РФ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3890, 1, NULL, NULL, NULL, NULL, NULL, 'Филимонов А.В, ', NULL, NULL, '7 978 737 72 88', 0, NULL);
INSERT INTO public.contractors VALUES (3891, 1, NULL, NULL, NULL, NULL, NULL, 'Филипов Игорь Иванович  ', NULL, NULL, '79787509973', 0, NULL);
INSERT INTO public.contractors VALUES (3892, 0, NULL, NULL, NULL, NULL, NULL, 'Филиппов В.И. ', NULL, NULL, '79781484744', 0, NULL);
INSERT INTO public.contractors VALUES (3893, 1, NULL, NULL, NULL, NULL, NULL, 'Филонич Александр ', NULL, NULL, '7 978 215 69 89', 0, NULL);
INSERT INTO public.contractors VALUES (3894, 1, NULL, NULL, NULL, NULL, NULL, 'Фиминых ОА 79788299180', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3895, 0, NULL, NULL, NULL, NULL, 910201001, 'ФИРМА Леди', NULL, NULL, ' (И)', 0, NULL);
INSERT INTO public.contractors VALUES (3896, 0, NULL, NULL, NULL, NULL, 910201001, 'ФИРМА СЭЛМА ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3897, 1, NULL, NULL, NULL, NULL, NULL, 'Фирсов Алексей ', NULL, NULL, '7 978 816 57 53 (К.П)', 0, NULL);
INSERT INTO public.contractors VALUES (3898, 1, NULL, NULL, NULL, NULL, NULL, 'Фисун Л.В. ', NULL, NULL, '7 978 72 000 74', 0, NULL);
INSERT INTO public.contractors VALUES (3899, 1, NULL, NULL, NULL, NULL, NULL, 'Фисюк И.М. ', NULL, NULL, '7 978 047 69 98', 0, NULL);
INSERT INTO public.contractors VALUES (3900, 0, NULL, NULL, NULL, NULL, NULL, 'ФКУ ИК-1 УФСИН России ', NULL, NULL, '79788497606', 0, NULL);
INSERT INTO public.contractors VALUES (3901, 1, NULL, NULL, NULL, NULL, NULL, 'ФКУ ОК УФСИН России 8978 877 43 17', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3902, 0, NULL, NULL, NULL, NULL, NULL, 'ФОКС ООО -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3903, 1, NULL, NULL, NULL, NULL, NULL, 'Фомин 79780386779', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3904, 1, NULL, NULL, NULL, NULL, NULL, 'Фомин А.Ф. ', NULL, NULL, '7 978 719 729 2', 0, NULL);
INSERT INTO public.contractors VALUES (3905, 1, NULL, NULL, NULL, NULL, NULL, 'Фомин Д.В. ', NULL, NULL, '7978 857 37 33', 0, NULL);
INSERT INTO public.contractors VALUES (3906, 0, NULL, NULL, NULL, NULL, NULL, 'Фомин Павел ', NULL, NULL, '79781300515', 0, NULL);
INSERT INTO public.contractors VALUES (3907, 0, NULL, NULL, NULL, NULL, NULL, 'Фомина М.В. ', NULL, NULL, '79787857650', 0, NULL);
INSERT INTO public.contractors VALUES (3908, 1, NULL, NULL, NULL, NULL, NULL, 'Фомкин С.Л. ', NULL, NULL, '7 978 707 27 67', 0, NULL);
INSERT INTO public.contractors VALUES (3909, 0, NULL, NULL, NULL, NULL, 920201001, 'Фордевинд ООО', NULL, 234100, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3910, 0, NULL, NULL, NULL, NULL, NULL, 'Форпост (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3911, 1, NULL, NULL, NULL, NULL, NULL, 'Франко А.В. ', NULL, NULL, '7978 80754312 СМС!', 0, NULL);
INSERT INTO public.contractors VALUES (3912, 1, NULL, NULL, NULL, NULL, NULL, 'Фрик Г.Б. ', NULL, NULL, '7978 136 89 38', 0, NULL);
INSERT INTO public.contractors VALUES (3913, 1, NULL, NULL, NULL, NULL, NULL, 'Фролочкин НК 79788312236', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3914, 1, NULL, NULL, NULL, NULL, NULL, 'Фрулкова А.Ф. ', NULL, NULL, '7978 810 00 13 -А.', 0, NULL);
INSERT INTO public.contractors VALUES (3915, 1, NULL, NULL, NULL, NULL, NULL, 'Фуглев ФФ 79781083542', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3916, 0, NULL, NULL, NULL, NULL, NULL, 'Фурса Е. ', NULL, NULL, '7 978 821 48 60', 0, NULL);
INSERT INTO public.contractors VALUES (3917, 1, NULL, NULL, NULL, NULL, NULL, 'Фурсов Виктор ', NULL, NULL, '7978 871 19 62', 0, NULL);
INSERT INTO public.contractors VALUES (3918, 0, NULL, NULL, NULL, NULL, NULL, 'Фурсов Юрий 978-791-43-08 (И)', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3919, 0, NULL, NULL, NULL, NULL, NULL, 'Фурсов Юрий Владимирович т.89788332728 (от НПЦ Кровля Сергей) _Л.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3920, 0, NULL, NULL, NULL, NULL, NULL, 'Футбольный клуб Таврия', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3921, 0, NULL, NULL, NULL, NULL, NULL, 'Хаиров А. ', NULL, NULL, '7 978 78 99 416', 0, NULL);
INSERT INTO public.contractors VALUES (3922, 1, NULL, NULL, NULL, NULL, NULL, 'Хайбулаев С.С. ', NULL, NULL, '79788579910', 0, NULL);
INSERT INTO public.contractors VALUES (3923, 1, NULL, NULL, NULL, NULL, NULL, 'Хайбулаев СС 79787730418', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3924, 0, NULL, NULL, NULL, NULL, NULL, 'Хайбуллаев Э.Р. ', NULL, NULL, '79787434845', 0, NULL);
INSERT INTO public.contractors VALUES (3925, 1, NULL, NULL, NULL, NULL, NULL, 'Хайдаров Эрнес ', NULL, NULL, '7 978 836 33 52', 0, NULL);
INSERT INTO public.contractors VALUES (3926, 1, NULL, NULL, NULL, NULL, NULL, 'Халаш С.В. ', NULL, NULL, '7 978 745 47 35', 0, NULL);
INSERT INTO public.contractors VALUES (3927, 1, NULL, NULL, NULL, NULL, NULL, 'Халилов А.Э. ', NULL, NULL, '7 978 86 82 079', 0, NULL);
INSERT INTO public.contractors VALUES (3928, 0, NULL, NULL, NULL, NULL, NULL, 'Халилов Алим ', NULL, NULL, '79787380008', 0, NULL);
INSERT INTO public.contractors VALUES (3929, 1, NULL, NULL, NULL, NULL, NULL, 'Халилов Ахтем  -А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3930, 1, NULL, NULL, NULL, NULL, NULL, 'Халилов АЭ ', NULL, NULL, '79788362150', 0, NULL);
INSERT INTO public.contractors VALUES (3931, 0, NULL, NULL, NULL, NULL, NULL, 'Халилов Вилен ', NULL, NULL, '79788645307', 0, NULL);
INSERT INTO public.contractors VALUES (3932, 1, NULL, NULL, NULL, NULL, NULL, 'Халява Михаил ', NULL, NULL, '7978 718 72 56', 0, NULL);
INSERT INTO public.contractors VALUES (3933, 1, NULL, NULL, NULL, NULL, NULL, 'Харачих Э.Р. ', NULL, NULL, '7 978 79 16 681', 0, NULL);
INSERT INTO public.contractors VALUES (3934, 1, NULL, NULL, NULL, NULL, NULL, 'Харламов В.Ю. ', NULL, NULL, '7 978 821 91 87', 0, NULL);
INSERT INTO public.contractors VALUES (3935, 0, NULL, NULL, NULL, NULL, NULL, 'Харочкин П.А. ', NULL, NULL, '7 978 722 83 01', 0, NULL);
INSERT INTO public.contractors VALUES (3936, 1, NULL, NULL, NULL, NULL, NULL, 'Харченко Андрей Валерьевич ', NULL, NULL, '7978 866 82 16', 0, NULL);
INSERT INTO public.contractors VALUES (3937, 1, NULL, NULL, NULL, NULL, NULL, 'Харченко П.П. ', NULL, NULL, '79787510906', 0, NULL);
INSERT INTO public.contractors VALUES (3938, 1, NULL, NULL, NULL, NULL, NULL, 'Харчук БН 79788241204', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3939, 0, NULL, NULL, NULL, NULL, NULL, 'Харчук Богдан ', NULL, NULL, '79788241204', 0, NULL);
INSERT INTO public.contractors VALUES (3940, 1, NULL, NULL, NULL, NULL, NULL, 'Хасьянов НР 79788701048', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3941, 1, NULL, NULL, NULL, NULL, NULL, 'Хатыбов Р.Р. ', NULL, NULL, '79787189277', 0, NULL);
INSERT INTO public.contractors VALUES (3942, 2, NULL, NULL, NULL, NULL, NULL, 'Хафизов Эмиль (Саки)- А.', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3943, 0, NULL, NULL, NULL, NULL, NULL, 'Хачатарян Х.О. ', NULL, NULL, '7978 709 15 60', 0, NULL);
INSERT INTO public.contractors VALUES (3944, 1, NULL, NULL, NULL, NULL, NULL, 'Хвостенко А.В. ', NULL, NULL, '7978 743 07 73', 0, NULL);
INSERT INTO public.contractors VALUES (3945, 0, NULL, NULL, NULL, NULL, NULL, 'Хижняк Василий Петрович ', NULL, NULL, '79788852764', 0, NULL);
INSERT INTO public.contractors VALUES (3946, 1, NULL, NULL, NULL, NULL, NULL, 'Хижняков В.В. ', NULL, NULL, '7 978 808 76 44', 0, NULL);
INSERT INTO public.contractors VALUES (3947, 1, NULL, NULL, NULL, NULL, NULL, 'Хилевич СН 79788182670', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3948, 1, NULL, NULL, NULL, NULL, NULL, 'Хилько Сергей А ', NULL, NULL, '79788464914', 0, NULL);
INSERT INTO public.contractors VALUES (3949, 0, NULL, NULL, NULL, NULL, NULL, 'Хильченко Артем ', NULL, NULL, '7 978 751 05 41', 0, NULL);
INSERT INTO public.contractors VALUES (3950, 1, NULL, NULL, NULL, NULL, NULL, 'Химпромстрой', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3951, 0, NULL, NULL, NULL, NULL, 910701001, '"ХИМПРОМСТРОЙ"" _Максим ', NULL, NULL, '7 913 901 41 42 _Л. ООО"', 0, NULL);
INSERT INTO public.contractors VALUES (3952, 1, NULL, NULL, NULL, NULL, NULL, 'Хлебников АН 79787091662', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3953, 1, NULL, NULL, NULL, NULL, NULL, 'Хмелев А.В. ', NULL, NULL, '7978 831 46 97', 0, NULL);
INSERT INTO public.contractors VALUES (3954, 1, NULL, NULL, NULL, NULL, NULL, 'Хмель Е.Ю. ', NULL, NULL, '79780814758', 0, NULL);
INSERT INTO public.contractors VALUES (3955, 1, NULL, NULL, NULL, NULL, NULL, 'Хмельницкий А.М. ', NULL, NULL, '79788354848', 0, NULL);
INSERT INTO public.contractors VALUES (3956, 1, NULL, NULL, NULL, NULL, NULL, 'Хмуровская Е.А. 8-978-78-33-829', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3957, 0, NULL, NULL, NULL, NULL, NULL, 'Хович В.С. ', NULL, NULL, '797878137956', 0, NULL);
INSERT INTO public.contractors VALUES (3958, 1, NULL, NULL, NULL, NULL, NULL, 'Ходич (Костя ', NULL, NULL, '7 978 72 53 247) ИП', 0, NULL);
INSERT INTO public.contractors VALUES (3959, 2, NULL, NULL, NULL, NULL, NULL, 'Ходич Олег Владимирович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3960, 0, NULL, NULL, NULL, NULL, NULL, 'Ходус Сергей ', NULL, NULL, '79787699871', 0, NULL);
INSERT INTO public.contractors VALUES (3961, 1, NULL, NULL, NULL, NULL, NULL, 'Ходыкин Д.С. 8-978-55-16-777', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3962, 1, NULL, NULL, NULL, NULL, NULL, 'Ходырев В.В. ', NULL, NULL, '7978 715 90 80', 0, NULL);
INSERT INTO public.contractors VALUES (3963, 0, NULL, NULL, NULL, NULL, 920301001, 'ХОЗТОВАРЫ ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3964, 0, NULL, NULL, NULL, NULL, NULL, 'ХОЛОДОВ (И) ул.Шабалина, 10,А оф 8 ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3965, 1, NULL, NULL, NULL, NULL, NULL, 'Хоменко 79787296251', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3966, 1, NULL, NULL, NULL, NULL, NULL, 'Хоменко АН 79787163401', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3967, 1, NULL, NULL, NULL, NULL, NULL, 'Хоменко Андрей ', NULL, NULL, '7 978 847 71 83', 0, NULL);
INSERT INTO public.contractors VALUES (3968, 0, NULL, NULL, NULL, NULL, NULL, 'Хоменко Г.В. ', NULL, NULL, '7 978 78 26 169', 0, NULL);
INSERT INTO public.contractors VALUES (3969, 1, NULL, NULL, NULL, NULL, NULL, 'Хомич ИА 79788267940', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3970, 1, NULL, NULL, NULL, NULL, NULL, 'Хороший А.П. ', NULL, NULL, '79787314377', 0, NULL);
INSERT INTO public.contractors VALUES (3971, 1, NULL, NULL, NULL, NULL, NULL, 'Хорошун ВИ 79788345877', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3972, 1, NULL, NULL, NULL, NULL, NULL, 'Хоружий Николай Николаевич ', NULL, NULL, '79788084875', 0, NULL);
INSERT INTO public.contractors VALUES (3973, 1, NULL, NULL, NULL, NULL, NULL, 'Хохлов К.В. ', NULL, NULL, '7 978 755 00 34', 0, NULL);
INSERT INTO public.contractors VALUES (3974, 1, NULL, NULL, NULL, NULL, NULL, 'Хохлов П.А. ', NULL, NULL, '7978 039 43 73', 0, NULL);
INSERT INTO public.contractors VALUES (3975, 1, NULL, NULL, NULL, NULL, NULL, 'Хочина Е.А. ', NULL, NULL, '7 978 712 79 92', 0, NULL);
INSERT INTO public.contractors VALUES (3976, 0, NULL, NULL, NULL, NULL, NULL, 'Храм казанской иконы Божьей Матери г.Симферополь, ', NULL, NULL, '7 978 748 33 76, Отец Андрей', 0, NULL);
INSERT INTO public.contractors VALUES (3977, 0, NULL, NULL, NULL, NULL, NULL, 'Храмушин В.В.', NULL, NULL, '79788576891', 0, NULL);
INSERT INTO public.contractors VALUES (3978, 1, NULL, NULL, NULL, NULL, NULL, 'Храмцова Н.Б. ', NULL, NULL, '79780481750', 0, NULL);
INSERT INTO public.contractors VALUES (3979, 1, NULL, NULL, NULL, NULL, NULL, 'Храпылин Сергей (Воровского, 11) ', NULL, NULL, '7 978 712 32 04', 0, NULL);
INSERT INTO public.contractors VALUES (3980, 1, NULL, NULL, NULL, NULL, NULL, 'Храпылин СС 79787123204', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3981, 0, NULL, NULL, NULL, NULL, NULL, 'Хрящев Михаил Васильевич ', NULL, NULL, '79788434901', 0, NULL);
INSERT INTO public.contractors VALUES (3982, 0, NULL, NULL, NULL, NULL, NULL, 'Хубларян Г.М. ', NULL, NULL, '7 985 512 07 62', 0, NULL);
INSERT INTO public.contractors VALUES (3983, 0, NULL, NULL, NULL, NULL, NULL, 'Худоба Николай ', NULL, NULL, '79780517816', 0, NULL);
INSERT INTO public.contractors VALUES (3984, 1, NULL, NULL, NULL, NULL, NULL, 'Худяков Д.Ю. ', NULL, NULL, '7 978 76 86 112', 0, NULL);
INSERT INTO public.contractors VALUES (3985, 0, NULL, NULL, NULL, NULL, NULL, 'Цалов А.А. ', NULL, NULL, '7 978 818 94 44', 0, NULL);
INSERT INTO public.contractors VALUES (3986, 0, NULL, NULL, NULL, NULL, NULL, 'Царенко Владимир Александрович ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3987, 1, NULL, NULL, NULL, NULL, NULL, 'Цеков Е.С. ', NULL, NULL, '79787817846', 0, NULL);
INSERT INTO public.contractors VALUES (3988, 0, NULL, NULL, NULL, NULL, NULL, 'Цеков Максим ', NULL, NULL, '79788265424', 0, NULL);
INSERT INTO public.contractors VALUES (3989, 0, NULL, NULL, NULL, NULL, NULL, 'Целоусов С.В. ', NULL, NULL, '7 978 7647397', 0, NULL);
INSERT INTO public.contractors VALUES (3990, 1, NULL, NULL, NULL, NULL, NULL, 'Целоусов С.В. 7 978 764 7397', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3991, 0, NULL, NULL, NULL, NULL, NULL, 'Цементный двор Алушта', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3992, 1, NULL, NULL, NULL, NULL, NULL, 'Центр HTTM  ', NULL, NULL, '7 978 838 65 15 ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3993, 0, NULL, NULL, NULL, NULL, NULL, 'Центр КЭТ  ', NULL, NULL, '7 978 816 08 28 Максим ООО', 0, NULL);
INSERT INTO public.contractors VALUES (3994, 1, NULL, NULL, NULL, NULL, NULL, 'Центр фасада Евгений ', NULL, NULL, '7 978 147 49 53 (д.п.) - Л.', 0, NULL);
INSERT INTO public.contractors VALUES (3995, 1, NULL, NULL, NULL, NULL, NULL, 'ЦЕХ', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3996, 1, NULL, NULL, NULL, NULL, NULL, 'Цикало ОВ 79782108178', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (3997, 1, NULL, NULL, NULL, NULL, NULL, 'Цикунов В.А ', NULL, NULL, '7978 7144560', 0, NULL);
INSERT INTO public.contractors VALUES (3998, 0, NULL, NULL, NULL, NULL, NULL, 'Цимбалов Алексей ', NULL, NULL, '79787435468', 0, NULL);
INSERT INTO public.contractors VALUES (3999, 1, NULL, NULL, NULL, NULL, NULL, 'Циркин В.А. ', NULL, NULL, '79781048328', 0, NULL);
INSERT INTO public.contractors VALUES (4000, 0, NULL, NULL, NULL, NULL, NULL, 'ЦММ Гирда А.А. ИП', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4001, 0, NULL, NULL, NULL, NULL, NULL, 'ЦММ-К  ( ЦММ-Крымск ) ООО', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4002, 1, NULL, NULL, NULL, NULL, NULL, 'Цонина Ю.И. ', NULL, NULL, '7978 834 10 72', 0, NULL);
INSERT INTO public.contractors VALUES (4003, 1, NULL, NULL, NULL, NULL, NULL, 'Цукур А.Н. ', NULL, NULL, '7 978 862 80 90', 0, NULL);
INSERT INTO public.contractors VALUES (4004, 1, NULL, NULL, NULL, NULL, NULL, 'Цыганов С.П 7978-201-70-03', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4005, 0, NULL, NULL, NULL, NULL, NULL, 'Цыркунов Сергей ', NULL, NULL, '7 (898) 11694976', 0, NULL);
INSERT INTO public.contractors VALUES (4006, 1, NULL, NULL, NULL, NULL, NULL, 'Чабан МВ ', NULL, NULL, '79780117180', 0, NULL);
INSERT INTO public.contractors VALUES (4007, 1, NULL, NULL, NULL, NULL, NULL, 'Чабанов Тимур ', NULL, NULL, '7978 040 96 29', 0, NULL);
INSERT INTO public.contractors VALUES (4008, 1, NULL, NULL, NULL, NULL, NULL, 'Чайковский Н.В. ', NULL, NULL, '79155292962', 0, NULL);
INSERT INTO public.contractors VALUES (4009, 1, NULL, NULL, NULL, NULL, NULL, 'Чайкун Ф.У. ', NULL, NULL, '7 978 805 79 44', 0, NULL);
INSERT INTO public.contractors VALUES (4010, 1, NULL, NULL, NULL, NULL, NULL, 'Чайчук КА 79787454972', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4011, 1, NULL, NULL, NULL, NULL, NULL, 'Чакалов Х.Р. ', NULL, NULL, '79780043368', 0, NULL);
INSERT INTO public.contractors VALUES (4012, 0, NULL, NULL, NULL, NULL, NULL, 'Чалов В.В. ', NULL, NULL, '7 978 72 66 494', 0, NULL);
INSERT INTO public.contractors VALUES (4013, 1, NULL, NULL, NULL, NULL, NULL, 'Чапчай 79788566645', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4014, 1, NULL, NULL, NULL, NULL, NULL, 'Чекмарев В.З. ', NULL, NULL, '7 978 026 99 81', 0, NULL);
INSERT INTO public.contractors VALUES (4015, 1, NULL, NULL, NULL, NULL, NULL, 'Челноков Николай ', NULL, NULL, '7 978 954 32 34', 0, NULL);
INSERT INTO public.contractors VALUES (4016, 1, NULL, NULL, NULL, NULL, NULL, 'Челышев АК 79787177430', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4017, 1, NULL, NULL, NULL, NULL, NULL, 'Чемезов СА 79122159412', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4018, 1, NULL, NULL, NULL, NULL, NULL, 'Ченоков Ю.В. 8-978-864-94-35', NULL, NULL, NULL, 0, NULL);
INSERT INTO public.contractors VALUES (4019, 1, NULL, NULL, NULL, NULL, NULL, 'Чепига И.Н. ', NULL, NULL, '7 978 790 35 57', 0, NULL);
INSERT INTO public.contractors VALUES (4020, 1, NULL, NULL, NULL, NULL, NULL, 'Чепкасов А.А. ', NULL, NULL, '79787844304', 0, NULL);
INSERT INTO public.contractors VALUES (4021, 1, NULL, NULL, NULL, NULL, NULL, 'Чепрасова НП 79788182995', NULL, NULL, NULL, 0, NULL);


--
-- TOC entry 2994 (class 0 OID 16909)
-- Dependencies: 205
-- Data for Name: forbidden_size; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2995 (class 0 OID 16914)
-- Dependencies: 206
-- Data for Name: history_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.history_item VALUES (4039, 'Order placed', 0, '2021-01-28 20:32:34.363699', NULL, 0);
INSERT INTO public.history_item VALUES (4042, 'Order placed', 0, '2021-01-28 20:35:07.300165', NULL, 0);
INSERT INTO public.history_item VALUES (4046, 'Order placed', 0, '2021-01-28 21:01:46.824611', NULL, 0);
INSERT INTO public.history_item VALUES (4049, 'Order placed', 0, '2021-01-28 21:02:11.390219', NULL, 0);
INSERT INTO public.history_item VALUES (4053, 'Order placed', 0, '2021-01-29 09:48:18.704156', NULL, 0);
INSERT INTO public.history_item VALUES (4056, 'Order placed', 0, '2021-01-29 09:48:53.165726', NULL, 0);


--
-- TOC entry 2996 (class 0 OID 16919)
-- Dependencies: 207
-- Data for Name: machine; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.machine VALUES (4024, 9, 'ПС 07');


--
-- TOC entry 2997 (class 0 OID 16924)
-- Dependencies: 208
-- Data for Name: machine_width; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.machine_width VALUES (4024, 10);


--
-- TOC entry 2998 (class 0 OID 16929)
-- Dependencies: 209
-- Data for Name: material_color; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2999 (class 0 OID 16937)
-- Dependencies: 210
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.materials VALUES (4023, 1, '2021-01-28 18:32:05.199', NULL, 1111, '11', 0, 11, '2021-01-28 22:03:02.424', '11', 1111, 111, 1, 112, 1088, 111, 1132229.3, 23, 1111, 111, 10);


--
-- TOC entry 3000 (class 0 OID 16945)
-- Dependencies: 211
-- Data for Name: order_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_info VALUES (4041, '2021-01-28 20:36:17.342', 0, '2021-01-28 20:59:52.367', '2021-01-28', '13:00:00', '2021-01-28 20:59:52.383', 1, 4038, 5, NULL, 2, 3);
INSERT INTO public.order_info VALUES (4038, '2021-01-28 20:33:15.789', 0, NULL, '2021-01-28', '13:00:00', '2021-01-28 20:59:52.407', 0, 4038, 6, NULL, 2, 10);
INSERT INTO public.order_info VALUES (4048, '2021-01-28 21:02:11.417', 0, '2021-01-28 22:03:02.443', '2021-01-29', '13:00:00', '2021-01-28 22:03:02.456', 1, 4045, 5, NULL, 8, 3);
INSERT INTO public.order_info VALUES (4045, '2021-01-28 21:02:06.401', 0, NULL, '2021-01-29', '13:00:00', '2021-01-28 22:03:02.477', 0, 4045, 6, NULL, 8, 2);
INSERT INTO public.order_info VALUES (4055, '2021-01-29 09:48:53.194', 0, NULL, '2021-01-29', '13:00:00', '2021-01-29 09:48:53.194', 1, 4052, 3, NULL, 3, 3);
INSERT INTO public.order_info VALUES (4052, '2021-01-29 09:48:48.81', 0, NULL, '2021-01-29', '13:00:00', '2021-01-29 09:48:53.198', 0, 4052, 4, NULL, 3, 2);


--
-- TOC entry 3001 (class 0 OID 16950)
-- Dependencies: 212
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_item VALUES (4040, '', '2021-01-28 20:33:15.792', NULL, 11, 0, 11, 1, '2021-01-28 20:33:15.792', 4038, 0, 1788.86, 1, '', NULL, 4022, 10);
INSERT INTO public.order_item VALUES (4043, '', '2021-01-28 20:36:17.345', NULL, 11, 0, 11, 1, '2021-01-28 20:59:52.387', 4041, 1, 1788.86, 1, '', 1, 4022, 10);
INSERT INTO public.order_item VALUES (4047, '', '2021-01-28 21:02:06.409', NULL, 12, 0, 11, 1, '2021-01-28 21:02:06.409', 4045, 0, 1951.49, 1, '', NULL, 4022, 10);
INSERT INTO public.order_item VALUES (4050, '', '2021-01-28 21:02:11.419', NULL, 12, 0, 11, 1, '2021-01-28 22:03:02.461', 4048, 1, 1951.49, 1, '', 1, 4022, 10);
INSERT INTO public.order_item VALUES (4054, '', '2021-01-29 09:48:48.822', NULL, 12, 0, 11, 1, '2021-01-29 09:48:48.822', 4052, 0, 1951.49, 1, '', NULL, 4022, 10);
INSERT INTO public.order_item VALUES (4057, '', '2021-01-29 09:48:53.196', NULL, 12, 0, 11, 1, '2021-01-29 09:48:53.196', 4055, 1, 1951.49, 1, '', 1, 4022, 10);


--
-- TOC entry 3002 (class 0 OID 16960)
-- Dependencies: 213
-- Data for Name: order_item_manufacture; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3003 (class 0 OID 16969)
-- Dependencies: 214
-- Data for Name: pickup_location; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pickup_location VALUES (2, 'Инт-магазин');
INSERT INTO public.pickup_location VALUES (10, 'офис');
INSERT INTO public.pickup_location VALUES (3, 'Цех');


--
-- TOC entry 3004 (class 0 OID 16974)
-- Dependencies: 215
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product VALUES (4022, 0, NULL, 'ПС 07', 0, NULL, 1.21, NULL, 0, 1.21);


--
-- TOC entry 3005 (class 0 OID 16982)
-- Dependencies: 216
-- Data for Name: product_amount; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_amount VALUES (4025, 0, 1, 20, 112, 10);


--
-- TOC entry 3006 (class 0 OID 16988)
-- Dependencies: 217
-- Data for Name: site_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3007 (class 0 OID 16996)
-- Dependencies: 218
-- Data for Name: site_product; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3008 (class 0 OID 17004)
-- Dependencies: 219
-- Data for Name: trimming; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3009 (class 0 OID 17009)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (3, 'admin@roof.ru', 'Admin', 'admin', false, '$2a$10$WoUODCAvWmNblco7tujhEO.FJapmt6yEZ/cNRyy15283JZs2Nwdh6', 0);


--
-- TOC entry 3010 (class 0 OID 17017)
-- Dependencies: 221
-- Data for Name: warehouse_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.warehouse_item VALUES (4044, NULL, 1, 4, 4024, 4023, 4043, 4022, NULL);
INSERT INTO public.warehouse_item VALUES (4051, NULL, 1, 4, 4024, 4023, 4050, 4022, NULL);


--
-- TOC entry 3011 (class 0 OID 17023)
-- Dependencies: 222
-- Data for Name: warehouse_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3012 (class 0 OID 17031)
-- Dependencies: 223
-- Data for Name: width; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.width VALUES (10, NULL, NULL, 0.1, NULL);


--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 224
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 4057, true);


--
-- TOC entry 2788 (class 2606 OID 16895)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 2790 (class 2606 OID 16900)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 2792 (class 2606 OID 16908)
-- Name: contractors contractors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contractors
    ADD CONSTRAINT contractors_pkey PRIMARY KEY (id);


--
-- TOC entry 2794 (class 2606 OID 16913)
-- Name: forbidden_size forbidden_size_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT forbidden_size_pkey PRIMARY KEY (id);


--
-- TOC entry 2796 (class 2606 OID 16918)
-- Name: history_item history_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT history_item_pkey PRIMARY KEY (id);


--
-- TOC entry 2798 (class 2606 OID 16923)
-- Name: machine machine_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine
    ADD CONSTRAINT machine_pkey PRIMARY KEY (id);


--
-- TOC entry 2800 (class 2606 OID 16928)
-- Name: machine_width machine_width_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT machine_width_pkey PRIMARY KEY (machine_id, width_id);


--
-- TOC entry 2802 (class 2606 OID 16936)
-- Name: material_color material_color_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_color
    ADD CONSTRAINT material_color_pkey PRIMARY KEY (id);


--
-- TOC entry 2804 (class 2606 OID 16944)
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- TOC entry 2807 (class 2606 OID 16949)
-- Name: order_info order_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT order_info_pkey PRIMARY KEY (id);


--
-- TOC entry 2811 (class 2606 OID 16968)
-- Name: order_item_manufacture order_item_manufacture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_manufacture
    ADD CONSTRAINT order_item_manufacture_pkey PRIMARY KEY (id);


--
-- TOC entry 2809 (class 2606 OID 16959)
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- TOC entry 2813 (class 2606 OID 16973)
-- Name: pickup_location pickup_location_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_location
    ADD CONSTRAINT pickup_location_pkey PRIMARY KEY (id);


--
-- TOC entry 2819 (class 2606 OID 16987)
-- Name: product_amount product_amount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_amount
    ADD CONSTRAINT product_amount_pkey PRIMARY KEY (id);


--
-- TOC entry 2817 (class 2606 OID 16981)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 2821 (class 2606 OID 16995)
-- Name: site_category site_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_category
    ADD CONSTRAINT site_category_pkey PRIMARY KEY (id);


--
-- TOC entry 2823 (class 2606 OID 17003)
-- Name: site_product site_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_product
    ADD CONSTRAINT site_product_pkey PRIMARY KEY (id);


--
-- TOC entry 2825 (class 2606 OID 17008)
-- Name: trimming trimming_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT trimming_pkey PRIMARY KEY (id);


--
-- TOC entry 2827 (class 2606 OID 17040)
-- Name: users uk_6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- TOC entry 2815 (class 2606 OID 17038)
-- Name: pickup_location uk_hpm8q7wxb5r5tjtac1glmlx9f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickup_location
    ADD CONSTRAINT uk_hpm8q7wxb5r5tjtac1glmlx9f UNIQUE (name);


--
-- TOC entry 2829 (class 2606 OID 17016)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2831 (class 2606 OID 17022)
-- Name: warehouse_item warehouse_item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT warehouse_item_pkey PRIMARY KEY (id);


--
-- TOC entry 2833 (class 2606 OID 17030)
-- Name: warehouse_type warehouse_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_type
    ADD CONSTRAINT warehouse_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2835 (class 2606 OID 17035)
-- Name: width width_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.width
    ADD CONSTRAINT width_pkey PRIMARY KEY (id);


--
-- TOC entry 2805 (class 1259 OID 17036)
-- Name: idx1r5ame1ebw288sw3a5a8up9yx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx1r5ame1ebw288sw3a5a8up9yx ON public.order_info USING btree (due_date);


--
-- TOC entry 2855 (class 2606 OID 17143)
-- Name: site_product fk1ln0ybq8qqdo15ty8bp2mww8q; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_product
    ADD CONSTRAINT fk1ln0ybq8qqdo15ty8bp2mww8q FOREIGN KEY (category_id) REFERENCES public.site_category(id);


--
-- TOC entry 2843 (class 2606 OID 17083)
-- Name: material_color fk1x34qirfjdmcqf4xnu5y4ynp8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material_color
    ADD CONSTRAINT fk1x34qirfjdmcqf4xnu5y4ynp8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2864 (class 2606 OID 17188)
-- Name: width fk305ttd8l5qsinhr66whbsoi42; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.width
    ADD CONSTRAINT fk305ttd8l5qsinhr66whbsoi42 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2856 (class 2606 OID 17148)
-- Name: trimming fk4459tb72wn52c0v7g2jfy6wmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT fk4459tb72wn52c0v7g2jfy6wmd FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2847 (class 2606 OID 17103)
-- Name: order_item fk551losx9j75ss5d6bfsqvijna; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk551losx9j75ss5d6bfsqvijna FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 2840 (class 2606 OID 17063)
-- Name: history_item fk55ajiw0j59oklhbh4c8anuug4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT fk55ajiw0j59oklhbh4c8anuug4 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- TOC entry 2845 (class 2606 OID 17093)
-- Name: order_info fk817vo1nds3htdfo4srwunihio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT fk817vo1nds3htdfo4srwunihio FOREIGN KEY (customer_id) REFERENCES public.contractors(id);


--
-- TOC entry 2859 (class 2606 OID 17163)
-- Name: warehouse_item fk96ir1ofhtedfnq54bjn2vhomi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk96ir1ofhtedfnq54bjn2vhomi FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- TOC entry 2848 (class 2606 OID 17108)
-- Name: order_item fkctqwb2wwjkujo9rwv8pm7l1kv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fkctqwb2wwjkujo9rwv8pm7l1kv FOREIGN KEY (width_id) REFERENCES public.width(id);


--
-- TOC entry 2842 (class 2606 OID 17078)
-- Name: machine_width fkcxxkwemge8peocn94bovmwe3h; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT fkcxxkwemge8peocn94bovmwe3h FOREIGN KEY (machine_id) REFERENCES public.machine(id);


--
-- TOC entry 2860 (class 2606 OID 17168)
-- Name: warehouse_item fkduugfe5jk183cin4glukssvgn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fkduugfe5jk183cin4glukssvgn FOREIGN KEY (order_item_id) REFERENCES public.order_item(id);


--
-- TOC entry 2846 (class 2606 OID 17098)
-- Name: order_info fkemqrbfaf7hs1nx4ldylfq6292; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT fkemqrbfaf7hs1nx4ldylfq6292 FOREIGN KEY (pickup_location_id) REFERENCES public.pickup_location(id);


--
-- TOC entry 2838 (class 2606 OID 17053)
-- Name: forbidden_size fkexh0fniek8464aumqkownnhfr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fkexh0fniek8464aumqkownnhfr FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 2861 (class 2606 OID 17173)
-- Name: warehouse_item fkfn9dya8xsaiaqdr8dcoauo0t3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fkfn9dya8xsaiaqdr8dcoauo0t3 FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 2853 (class 2606 OID 17133)
-- Name: product_amount fkhcbnu5er4oxsk08ndnf1975u9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_amount
    ADD CONSTRAINT fkhcbnu5er4oxsk08ndnf1975u9 FOREIGN KEY (width_id) REFERENCES public.width(id);


--
-- TOC entry 2849 (class 2606 OID 17113)
-- Name: order_item fki9h5ium1uah4jw57pg722osau; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fki9h5ium1uah4jw57pg722osau FOREIGN KEY (order_id) REFERENCES public.order_info(id);


--
-- TOC entry 2837 (class 2606 OID 17048)
-- Name: forbidden_size fkid9e8wwn91vi4skahmm4v8iko; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fkid9e8wwn91vi4skahmm4v8iko FOREIGN KEY (machine_id) REFERENCES public.machine(id);


--
-- TOC entry 2851 (class 2606 OID 17123)
-- Name: order_item_manufacture fkijmea6yv66y1fy1dcinobeufp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_manufacture
    ADD CONSTRAINT fkijmea6yv66y1fy1dcinobeufp FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- TOC entry 2858 (class 2606 OID 17158)
-- Name: warehouse_item fkin1ikpxvqr2qhfkxmx5dyipv4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fkin1ikpxvqr2qhfkxmx5dyipv4 FOREIGN KEY (machine_id) REFERENCES public.machine(id);


--
-- TOC entry 2844 (class 2606 OID 17088)
-- Name: materials fkj37w3lq2w0yqoqkh70qc3etaf; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT fkj37w3lq2w0yqoqkh70qc3etaf FOREIGN KEY (width_id) REFERENCES public.width(id);


--
-- TOC entry 2854 (class 2606 OID 17138)
-- Name: site_category fkl3s525hch365wqifmfg8bisrt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_category
    ADD CONSTRAINT fkl3s525hch365wqifmfg8bisrt FOREIGN KEY (parent_id) REFERENCES public.site_category(id);


--
-- TOC entry 2850 (class 2606 OID 17118)
-- Name: order_item_manufacture fklhqxgc1m2e6dgbd1tbsxerbn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_manufacture
    ADD CONSTRAINT fklhqxgc1m2e6dgbd1tbsxerbn FOREIGN KEY (order_id) REFERENCES public.order_info(id);


--
-- TOC entry 2857 (class 2606 OID 17153)
-- Name: trimming fkohttbspsp6eo4k4l7vy9fhyw5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT fkohttbspsp6eo4k4l7vy9fhyw5 FOREIGN KEY (width_id) REFERENCES public.width(id);


--
-- TOC entry 2852 (class 2606 OID 17128)
-- Name: order_item_manufacture fkpchxd8jk7wkol2h6u6reqjth6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_manufacture
    ADD CONSTRAINT fkpchxd8jk7wkol2h6u6reqjth6 FOREIGN KEY (width_id) REFERENCES public.width(id);


--
-- TOC entry 2836 (class 2606 OID 17043)
-- Name: account fkq4qqnedcq6s37vahgkih04bgo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT fkq4qqnedcq6s37vahgkih04bgo FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);


--
-- TOC entry 2862 (class 2606 OID 17178)
-- Name: warehouse_item fkqqet71c59p8jaxna1jy6j1tg8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fkqqet71c59p8jaxna1jy6j1tg8 FOREIGN KEY (warehouse_type_id) REFERENCES public.warehouse_type(id);


--
-- TOC entry 2863 (class 2606 OID 17183)
-- Name: warehouse_type fkqst8c6n5lvicnn69twr6pas1d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warehouse_type
    ADD CONSTRAINT fkqst8c6n5lvicnn69twr6pas1d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 2841 (class 2606 OID 17073)
-- Name: machine_width fkr9a3xo7a3hft2gw44s31mdgge; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT fkr9a3xo7a3hft2gw44s31mdgge FOREIGN KEY (width_id) REFERENCES public.width(id);


--
-- TOC entry 2839 (class 2606 OID 17058)
-- Name: forbidden_size fktfhprvv2msjd50fj6iqpg02vo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fktfhprvv2msjd50fj6iqpg02vo FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2021-01-30 15:01:38

--
-- PostgreSQL database dump complete
--

