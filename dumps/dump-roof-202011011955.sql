PGDMP         7            
    x            roof    12.4    12.4 ^    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16393    roof    DATABASE     �   CREATE DATABASE roof WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE roof;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16394    account    TABLE     V  CREATE TABLE public.account (
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
    DROP TABLE public.account;
       public         heap    postgres    false    3            �            1259    16400    category    TABLE     Z   CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(255)
);
    DROP TABLE public.category;
       public         heap    postgres    false    3            �            1259    16403    contractors    TABLE     �  CREATE TABLE public.contractors (
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
    DROP TABLE public.contractors;
       public         heap    postgres    false    3            �            1259    24952    forbidden_sizes_seq    SEQUENCE     ~   CREATE SEQUENCE public.forbidden_sizes_seq
    START WITH 10
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.forbidden_sizes_seq;
       public          postgres    false    3            �            1259    24954    forbidden_size    TABLE     �  CREATE TABLE public.forbidden_size (
    id bigint DEFAULT nextval('public.forbidden_sizes_seq'::regclass) NOT NULL,
    value_from double precision NOT NULL,
    value_to double precision NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint,
    machine_id bigint,
    product_id bigint
);
 "   DROP TABLE public.forbidden_size;
       public         heap    postgres    false    223    3            �            1259    16418    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false    3            �            1259    16420    history_item    TABLE     �   CREATE TABLE public.history_item (
    id bigint NOT NULL,
    message character varying(255),
    new_state integer,
    "timestamp" timestamp without time zone,
    created_by_id bigint,
    history_id bigint,
    history_order integer
);
     DROP TABLE public.history_item;
       public         heap    postgres    false    3            �            1259    16423    machine    TABLE        CREATE TABLE public.machine (
    id bigint NOT NULL,
    length integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.machine;
       public         heap    postgres    false    3            �            1259    24887    machine_width    TABLE     d   CREATE TABLE public.machine_width (
    machine_id bigint NOT NULL,
    width_id bigint NOT NULL
);
 !   DROP TABLE public.machine_width;
       public         heap    postgres    false    3            �            1259    16429 	   materials    TABLE       CREATE TABLE public.materials (
    id bigint NOT NULL,
    cover integer NOT NULL,
    fact_coefficient double precision,
    length integer,
    manufacturer character varying(255) NOT NULL,
    material_color integer,
    party character varying(255) NOT NULL,
    price double precision NOT NULL,
    price_delivery double precision NOT NULL,
    price_one_metre double precision,
    price_one_tone double precision NOT NULL,
    remains double precision,
    serial_number integer NOT NULL,
    teor_coefficient double precision,
    used double precision,
    weight_of_bay double precision,
    width_id integer NOT NULL,
    width_fact double precision,
    material_class integer,
    created timestamp without time zone,
    modified timestamp without time zone
);
    DROP TABLE public.materials;
       public         heap    postgres    false    3            �            1259    16435 
   order_info    TABLE     �  CREATE TABLE public.order_info (
    id bigint NOT NULL,
    due_date date,
    due_time time without time zone,
    state integer,
    customer_id bigint,
    pickup_location_id bigint,
    wp_order_id bigint,
    order_type integer,
    parent_id bigint,
    discount integer,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    done timestamp without time zone
);
    DROP TABLE public.order_info;
       public         heap    postgres    false    3            �            1259    16438 
   order_item    TABLE     �  CREATE TABLE public.order_item (
    id bigint NOT NULL,
    comment character varying(255),
    quantity double precision,
    product_id bigint,
    order_id bigint,
    items_order integer,
    width_id integer,
    material_class integer,
    material_cover integer,
    material_color integer,
    height double precision,
    total_price double precision,
    order_type integer,
    size character varying,
    CONSTRAINT order_item_quantity_check CHECK ((quantity >= (1)::double precision))
);
    DROP TABLE public.order_item;
       public         heap    postgres    false    3            �            1259    16442    pickup_location    TABLE     a   CREATE TABLE public.pickup_location (
    id bigint NOT NULL,
    name character varying(255)
);
 #   DROP TABLE public.pickup_location;
       public         heap    postgres    false    3            �            1259    16445    product    TABLE     �  CREATE TABLE public.product (
    id bigint NOT NULL,
    length integer,
    material_color integer,
    name character varying(255),
    price double precision,
    type integer,
    weight integer,
    title character varying,
    second_title character varying,
    category character varying,
    width double precision,
    square_meters double precision,
    cargo_type integer
);
    DROP TABLE public.product;
       public         heap    postgres    false    3            �            1259    16590    product_amount    TABLE     �   CREATE TABLE public.product_amount (
    id bigint NOT NULL,
    product_type bigint,
    width_id bigint,
    material_class bigint,
    material_cover bigint,
    material_color bigint,
    price double precision,
    self_price double precision
);
 "   DROP TABLE public.product_amount;
       public         heap    postgres    false    3            �            1259    16448    site_category    TABLE     .  CREATE TABLE public.site_category (
    id bigint NOT NULL,
    img_path character varying(255),
    key character varying(255),
    title character varying(255),
    url character varying(255),
    created timestamp without time zone,
    modified timestamp without time zone,
    parent_id bigint
);
 !   DROP TABLE public.site_category;
       public         heap    postgres    false    3            �            1259    16454    site_product    TABLE     �  CREATE TABLE public.site_product (
    id bigint NOT NULL,
    full_price character varying(255),
    img_path character varying(255),
    price character varying(255),
    prop character varying(2000),
    site_name character varying(255),
    title character varying(255),
    category_id bigint,
    created timestamp without time zone,
    modified timestamp without time zone,
    path character varying(255)
);
     DROP TABLE public.site_product;
       public         heap    postgres    false    3            �            1259    24914    trimming_seq    SEQUENCE     w   CREATE SEQUENCE public.trimming_seq
    START WITH 10
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.trimming_seq;
       public          postgres    false    3            �            1259    24916    trimming    TABLE     B  CREATE TABLE public.trimming (
    id bigint DEFAULT nextval('public.trimming_seq'::regclass) NOT NULL,
    value double precision NOT NULL,
    width_id bigint NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint
);
    DROP TABLE public.trimming;
       public         heap    postgres    false    220    3            �            1259    16460    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    locked boolean NOT NULL,
    password_hash character varying(255),
    role integer
);
    DROP TABLE public.users;
       public         heap    postgres    false    3            �            1259    24832    warehouse_item    TABLE     O  CREATE TABLE public.warehouse_item (
    id bigint NOT NULL,
    comment character varying(255),
    state integer,
    quantity double precision,
    product_id bigint,
    order_item_id bigint,
    machine_id bigint,
    material_id bigint,
    CONSTRAINT warehouse_item_quantity_check CHECK ((quantity >= (1)::double precision))
);
 "   DROP TABLE public.warehouse_item;
       public         heap    postgres    false    3            �            1259    24927 	   width_seq    SEQUENCE     u   CREATE SEQUENCE public.width_seq
    START WITH 130
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.width_seq;
       public          postgres    false    3            �            1259    24864    width    TABLE       CREATE TABLE public.width (
    id bigint DEFAULT nextval('public.width_seq'::regclass) NOT NULL,
    value double precision NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint
);
    DROP TABLE public.width;
       public         heap    postgres    false    222    3            �          0    16394    account 
   TABLE DATA           t   COPY public.account (id, bank_name, bik, code, corr_account, depart_address, inn, value, contractor_id) FROM stdin;
    public          postgres    false    202            �          0    16400    category 
   TABLE DATA           ,   COPY public.category (id, name) FROM stdin;
    public          postgres    false    203            �          0    16403    contractors 
   TABLE DATA           �   COPY public.contractors (id, contractor_sub_type, delivery_address, email, fiz_address, inn, kpp, name, ogrn, okpo, phone, type, ur_address) FROM stdin;
    public          postgres    false    204            �          0    24954    forbidden_size 
   TABLE DATA           v   COPY public.forbidden_size (id, value_from, value_to, created, modified, user_id, machine_id, product_id) FROM stdin;
    public          postgres    false    224            �          0    16420    history_item 
   TABLE DATA           u   COPY public.history_item (id, message, new_state, "timestamp", created_by_id, history_id, history_order) FROM stdin;
    public          postgres    false    206            �          0    16423    machine 
   TABLE DATA           3   COPY public.machine (id, length, name) FROM stdin;
    public          postgres    false    207            �          0    24887    machine_width 
   TABLE DATA           =   COPY public.machine_width (machine_id, width_id) FROM stdin;
    public          postgres    false    219            �          0    16429 	   materials 
   TABLE DATA             COPY public.materials (id, cover, fact_coefficient, length, manufacturer, material_color, party, price, price_delivery, price_one_metre, price_one_tone, remains, serial_number, teor_coefficient, used, weight_of_bay, width_id, width_fact, material_class, created, modified) FROM stdin;
    public          postgres    false    208            �          0    16435 
   order_info 
   TABLE DATA           �   COPY public.order_info (id, due_date, due_time, state, customer_id, pickup_location_id, wp_order_id, order_type, parent_id, discount, created, modified, done) FROM stdin;
    public          postgres    false    209            �          0    16438 
   order_item 
   TABLE DATA           �   COPY public.order_item (id, comment, quantity, product_id, order_id, items_order, width_id, material_class, material_cover, material_color, height, total_price, order_type, size) FROM stdin;
    public          postgres    false    210            �          0    16442    pickup_location 
   TABLE DATA           3   COPY public.pickup_location (id, name) FROM stdin;
    public          postgres    false    211            �          0    16445    product 
   TABLE DATA           �   COPY public.product (id, length, material_color, name, price, type, weight, title, second_title, category, width, square_meters, cargo_type) FROM stdin;
    public          postgres    false    212            �          0    16590    product_amount 
   TABLE DATA           �   COPY public.product_amount (id, product_type, width_id, material_class, material_cover, material_color, price, self_price) FROM stdin;
    public          postgres    false    216            �          0    16448    site_category 
   TABLE DATA           d   COPY public.site_category (id, img_path, key, title, url, created, modified, parent_id) FROM stdin;
    public          postgres    false    213            �          0    16454    site_product 
   TABLE DATA           �   COPY public.site_product (id, full_price, img_path, price, prop, site_name, title, category_id, created, modified, path) FROM stdin;
    public          postgres    false    214            �          0    24916    trimming 
   TABLE DATA           S   COPY public.trimming (id, value, width_id, created, modified, user_id) FROM stdin;
    public          postgres    false    221            �          0    16460    users 
   TABLE DATA           ^   COPY public.users (id, email, first_name, last_name, locked, password_hash, role) FROM stdin;
    public          postgres    false    215            �          0    24832    warehouse_item 
   TABLE DATA           z   COPY public.warehouse_item (id, comment, state, quantity, product_id, order_item_id, machine_id, material_id) FROM stdin;
    public          postgres    false    217            �          0    24864    width 
   TABLE DATA           F   COPY public.width (id, value, created, modified, user_id) FROM stdin;
    public          postgres    false    218            �           0    0    forbidden_sizes_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.forbidden_sizes_seq', 610, true);
          public          postgres    false    223            �           0    0    hibernate_sequence    SEQUENCE SET     D   SELECT pg_catalog.setval('public.hibernate_sequence', 23301, true);
          public          postgres    false    205            �           0    0    trimming_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.trimming_seq', 120, true);
          public          postgres    false    220            �           0    0 	   width_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.width_seq', 130, false);
          public          postgres    false    222            �
           2606    16467    account account_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    202            �
           2606    16469    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    203            �
           2606    16471    contractors contractors_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.contractors
    ADD CONSTRAINT contractors_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.contractors DROP CONSTRAINT contractors_pkey;
       public            postgres    false    204                       2606    24961 #   forbidden_size forbidden_sizes_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT forbidden_sizes_pkey PRIMARY KEY (id);
 M   ALTER TABLE ONLY public.forbidden_size DROP CONSTRAINT forbidden_sizes_pkey;
       public            postgres    false    224            �
           2606    16477    history_item history_item_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT history_item_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.history_item DROP CONSTRAINT history_item_pkey;
       public            postgres    false    206            �
           2606    16479    machine machine_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.machine
    ADD CONSTRAINT machine_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.machine DROP CONSTRAINT machine_pkey;
       public            postgres    false    207            �
           2606    16481    materials materials_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.materials DROP CONSTRAINT materials_pkey;
       public            postgres    false    208            �
           2606    16483    order_info order_info_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT order_info_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.order_info DROP CONSTRAINT order_info_pkey;
       public            postgres    false    209            �
           2606    16485    order_item order_item_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.order_item DROP CONSTRAINT order_item_pkey;
       public            postgres    false    210            �
           2606    16487 $   pickup_location pickup_location_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.pickup_location
    ADD CONSTRAINT pickup_location_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.pickup_location DROP CONSTRAINT pickup_location_pkey;
       public            postgres    false    211                       2606    16594 "   product_amount product_amount_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_amount
    ADD CONSTRAINT product_amount_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_amount DROP CONSTRAINT product_amount_pkey;
       public            postgres    false    216            �
           2606    16489    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    212            �
           2606    16491     site_category site_category_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.site_category
    ADD CONSTRAINT site_category_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.site_category DROP CONSTRAINT site_category_pkey;
       public            postgres    false    213                        2606    16493    site_product site_product_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.site_product
    ADD CONSTRAINT site_product_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.site_product DROP CONSTRAINT site_product_pkey;
       public            postgres    false    214                       2606    24921    trimming trimming_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT trimming_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.trimming DROP CONSTRAINT trimming_pkey;
       public            postgres    false    221                       2606    16495 "   users uk_6dotkott2kjsp8vw4d0m25fb7 
   CONSTRAINT     ^   ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);
 L   ALTER TABLE ONLY public.users DROP CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7;
       public            postgres    false    215            �
           2606    16497 ,   pickup_location uk_hpm8q7wxb5r5tjtac1glmlx9f 
   CONSTRAINT     g   ALTER TABLE ONLY public.pickup_location
    ADD CONSTRAINT uk_hpm8q7wxb5r5tjtac1glmlx9f UNIQUE (name);
 V   ALTER TABLE ONLY public.pickup_location DROP CONSTRAINT uk_hpm8q7wxb5r5tjtac1glmlx9f;
       public            postgres    false    211                       2606    16499    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215                       2606    24837 "   warehouse_item warehouse_item_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT warehouse_item_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT warehouse_item_pkey;
       public            postgres    false    217            
           2606    24868    width width_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.width
    ADD CONSTRAINT width_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.width DROP CONSTRAINT width_pkey;
       public            postgres    false    218            �
           1259    16500    idxd8bqjebi2o4fxpq5d3fp55ub7    INDEX     W   CREATE INDEX idxd8bqjebi2o4fxpq5d3fp55ub7 ON public.order_info USING btree (due_date);
 0   DROP INDEX public.idxd8bqjebi2o4fxpq5d3fp55ub7;
       public            postgres    false    209            �
           1259    24900    machine_idx    INDEX     F   CREATE UNIQUE INDEX machine_idx ON public.machine USING btree (name);
    DROP INDEX public.machine_idx;
       public            postgres    false    207                       2606    16501 (   site_product fk1ln0ybq8qqdo15ty8bp2mww8q    FK CONSTRAINT     �   ALTER TABLE ONLY public.site_product
    ADD CONSTRAINT fk1ln0ybq8qqdo15ty8bp2mww8q FOREIGN KEY (category_id) REFERENCES public.site_category(id);
 R   ALTER TABLE ONLY public.site_product DROP CONSTRAINT fk1ln0ybq8qqdo15ty8bp2mww8q;
       public          postgres    false    213    2814    214                       2606    16506 &   order_item fk551losx9j75ss5d6bfsqvijna    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk551losx9j75ss5d6bfsqvijna FOREIGN KEY (product_id) REFERENCES public.product(id);
 P   ALTER TABLE ONLY public.order_item DROP CONSTRAINT fk551losx9j75ss5d6bfsqvijna;
       public          postgres    false    2812    212    210                       2606    16511 (   history_item fk55ajiw0j59oklhbh4c8anuug4    FK CONSTRAINT     �   ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT fk55ajiw0j59oklhbh4c8anuug4 FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 R   ALTER TABLE ONLY public.history_item DROP CONSTRAINT fk55ajiw0j59oklhbh4c8anuug4;
       public          postgres    false    206    2820    215            !           2606    24962 )   forbidden_size fk_forbidden_sizes_machine    FK CONSTRAINT     �   ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fk_forbidden_sizes_machine FOREIGN KEY (machine_id) REFERENCES public.machine(id);
 S   ALTER TABLE ONLY public.forbidden_size DROP CONSTRAINT fk_forbidden_sizes_machine;
       public          postgres    false    224    207    2799            "           2606    24967 )   forbidden_size fk_forbidden_sizes_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fk_forbidden_sizes_product FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.forbidden_size DROP CONSTRAINT fk_forbidden_sizes_product;
       public          postgres    false    2812    212    224                       2606    24890    machine_width fk_machine    FK CONSTRAINT     |   ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT fk_machine FOREIGN KEY (machine_id) REFERENCES public.machine(id);
 B   ALTER TABLE ONLY public.machine_width DROP CONSTRAINT fk_machine;
       public          postgres    false    219    2799    207                       2606    24848    warehouse_item fk_machine_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_machine_id FOREIGN KEY (machine_id) REFERENCES public.machine(id);
 F   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_machine_id;
       public          postgres    false    217    207    2799                       2606    24853    warehouse_item fk_material_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_material_id FOREIGN KEY (material_id) REFERENCES public.materials(id);
 G   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_material_id;
       public          postgres    false    208    217    2801                       2606    24843    warehouse_item fk_order_item_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_order_item_id FOREIGN KEY (order_item_id) REFERENCES public.order_item(id);
 I   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_order_item_id;
       public          postgres    false    217    210    2806                       2606    24838    warehouse_item fk_product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id);
 F   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_product_id;
       public          postgres    false    217    212    2812                        2606    24945    trimming fk_trimming_user    FK CONSTRAINT     x   ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT fk_trimming_user FOREIGN KEY (user_id) REFERENCES public.users(id);
 C   ALTER TABLE ONLY public.trimming DROP CONSTRAINT fk_trimming_user;
       public          postgres    false    221    215    2820                       2606    24922    trimming fk_trimming_width    FK CONSTRAINT     z   ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT fk_trimming_width FOREIGN KEY (width_id) REFERENCES public.width(id);
 D   ALTER TABLE ONLY public.trimming DROP CONSTRAINT fk_trimming_width;
       public          postgres    false    2826    221    218                       2606    24895    machine_width fk_width    FK CONSTRAINT     v   ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT fk_width FOREIGN KEY (width_id) REFERENCES public.width(id);
 @   ALTER TABLE ONLY public.machine_width DROP CONSTRAINT fk_width;
       public          postgres    false    219    2826    218                       2606    24940    width fk_width_user    FK CONSTRAINT     r   ALTER TABLE ONLY public.width
    ADD CONSTRAINT fk_width_user FOREIGN KEY (user_id) REFERENCES public.users(id);
 =   ALTER TABLE ONLY public.width DROP CONSTRAINT fk_width_user;
       public          postgres    false    218    215    2820                       2606    16516 &   order_info fkemqrbfaf7hs1nx4ldylfq6292    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT fkemqrbfaf7hs1nx4ldylfq6292 FOREIGN KEY (pickup_location_id) REFERENCES public.pickup_location(id);
 P   ALTER TABLE ONLY public.order_info DROP CONSTRAINT fkemqrbfaf7hs1nx4ldylfq6292;
       public          postgres    false    209    2808    211                       2606    16545 )   site_category fkl3s525hch365wqifmfg8bisrt    FK CONSTRAINT     �   ALTER TABLE ONLY public.site_category
    ADD CONSTRAINT fkl3s525hch365wqifmfg8bisrt FOREIGN KEY (parent_id) REFERENCES public.site_category(id);
 S   ALTER TABLE ONLY public.site_category DROP CONSTRAINT fkl3s525hch365wqifmfg8bisrt;
       public          postgres    false    2814    213    213                       2606    16526 (   history_item fklxc24xica6pqpahs8g4yejnh7    FK CONSTRAINT     �   ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT fklxc24xica6pqpahs8g4yejnh7 FOREIGN KEY (history_id) REFERENCES public.order_info(id);
 R   ALTER TABLE ONLY public.history_item DROP CONSTRAINT fklxc24xica6pqpahs8g4yejnh7;
       public          postgres    false    206    209    2804                       2606    16531 &   order_item fkohhydblc3by0xdl950lhtprrv    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fkohhydblc3by0xdl950lhtprrv FOREIGN KEY (order_id) REFERENCES public.order_info(id);
 P   ALTER TABLE ONLY public.order_item DROP CONSTRAINT fkohhydblc3by0xdl950lhtprrv;
       public          postgres    false    210    2804    209                       2606    24786    order_info fkorder_contractor    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT fkorder_contractor FOREIGN KEY (customer_id) REFERENCES public.contractors(id);
 G   ALTER TABLE ONLY public.order_info DROP CONSTRAINT fkorder_contractor;
       public          postgres    false    209    204    2794                       2606    16536 #   account fkq4qqnedcq6s37vahgkih04bgo    FK CONSTRAINT     �   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fkq4qqnedcq6s37vahgkih04bgo FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);
 M   ALTER TABLE ONLY public.account DROP CONSTRAINT fkq4qqnedcq6s37vahgkih04bgo;
       public          postgres    false    2794    204    202            �   L   x�34�4�LMI�44"CNN	a� NCSKC. aę�5�F� �� �ڄ� ��1~@�X$ \�u1z\\\ L>�      �      x������ � �      �      x���ێI�&v=�H��g�����B��+�-PAs��.a/��"Y�F�T1$s��dW���KV��d&3	���
�$23w7�p�<�ni���"3���077��ݴ����߿�7����������?���6/��\��nZ:���>�!��~�?r�4�7�6G������ټ"�����b�~=���ؼo�6o/�lN/�ݜlNn�����0��7����a�9hʟ7��/]۷]�v���esw��y�y�y��٣_�����	������g���&K�vӗ��7�q���-oc�6{����?�5_6�G�ޗ��pc��NMǩ��|Q�Cz�g���������<����V��h���1��[�w��(�6��5��xM�}��$�k�f^�|��m˵��+�v�G�2�˯�5�5���	}΋�V��,/-����
ݕ�]��sn�����A�7�����.��G����G��B��v(�������������7��?�����ą�/dFC"��������_�O���К?���_�w��.��~���o��j6�7韵p�qh��QQ�
�+~{�W�)nn�8S3Mg�1ބg�Lǌ����nD �c����`tʯ�B/�F_�}������Xn4[|ѧ�-W>�>�]�2"q��v_;t����w�2إ�Mӛp�H6����˯.o�
Ӎ��FքĿ�m3����~�c?�<;��tm��]�98�W7O�عo��DB�.u�щ�]V���߰�^}|kǦ�vV��\�>��y���vlH�S\��a8>C��V9qw�a�q�����P�}�$=U��]���Y�W��M�l�yR|��ηL�ڦ��eѽ���}��ŋ�L{:�]�Y24z�S��oE�6xo�yj�n����9�x���O�oL�=�_�ھ���&���&${�܌�M�+�G����ğ
@m���|�ɚ��;�p�]h�$��%�i�楏�|Ŗ��U��@8�yKd]������1}>Ӛ%�1��,Ż��!.���p��?X?�HU��qk�1�)�S�+h�i'=��ډsB�erx�������q�t��MGG�*���w2̇�h�7�I����ar,^;�HNs#٧S!}C�,�Оm�俦�����m��;�&�N=��m�������j���]��Q+��T�/ ����V�[��؛�xjB����3��h�2՚iVe<���ċ�b���ʹ�&տC�8IQ�[��ƚ(�U!_�cy��l&z=݂cM�O鋽���
,6���@�jgBbݽ�*�T���i�t���Fz�:��L�
/���gQD��c#��cMӧ�$��Kk�6�PM�G1�s�ن�֎�X5�H�^����Ȭm�%>QM�#
=Ϲ"d��04}tdƚX'V��$ �5�
�X�3�u��O�>>�8�A��u�6�	��Ň�j�ͧ�8�x����r�#йSU�S~Q=
�?�����쇡Q����<ԣ����tӨ_p�)�C�J>�y��~i�h�MUh������2̥�C_����41�U\���71�8���F����nM��Ğ7�n��MV�Ά��'v�T�
k����t`o';D��V(�r�caw|����CF)��U^���2�o�j/���k-0�=���xW�	�;�R����4/9�U��C��5o�	Z�����5O�P%|��ȟĽ8�@�L�=,�+�=�	��a�涥&�-M|�ʉ ��o��ٹ��]��qn�������L�n[qp�u�[zD�8�${.�����9�r�M#�ɣ�r������3�汗�k��];��u�+{��]~ǡd�����L{j���3�M���ù/E;��Q�[S�89��2�t7�J��ly'�ED�LGW:=,Me��9��d���Y|?��G9����d�o9���Wm3��MC��x-Ar����8�hꆾ5�a��uؖ��K���4��UpЛ��D�{��C�-2�����2.���e�!Q`�N����}-oB[S�_���.6i��&udT|@�z��x.A��X�E�%�P�����x���%}���d�x���C,��}��I�G�~u��C��X�+�׭a�7|i��S	u~^o���7�%b!k��.��X,c-o�՝m�5�&�Ɩ���&���7�x7��-�������ry������?�N���ުUo�#��DJ��x+��X3��[�oވ�\8��-˻�GL^�q��ci�[�u���s,�w��}�C{���_o�wH����[z�c;c�	�˟��d����Ǭo�ٶ��LN��k�.����5�`�U�;z�cnBfxm(k��䃾�bJ�h������C�6O1��`yZ��G�Ō��y$;Ma���0W�2C��wT�b�J�Ll�ԕ\c��ж��\��0��L�@�Y�{��h��w��� �J��Z�m�[O��ܡs�L� D�`ʑ5B܄w|\�B�p��4�c� �YМ�M��-����H�P������It� g9���Q��쳭q.��Qe��</�[w��Z�.}Wl<���@��r{��?�/��V?�H��Fx��� �I��:W��H�
E�n�|�;,]��/g���N��S�0��w_�Vy]�u��=�z�0, 2.L�ǖ0M����$4'fd�4��W3��^�F'����#�>z����z/��G��h[���tX��(�7,b$�{c� \[2mk[y��*V�R~���=�(�@n�\("��L���FHl.п�׮5I�˵K0?�G�$$�{Eb럨}*��������۾�z;��G2�V/�C������7;�b{.�!�@nа^�~X����il������t��j��'����]P��Xo�QrvI"a��2���i<-�%3�S�
��"Hh�<�&Zީ����䚔�Clȑ��9�S[$@�
�{*�No]0��棕��쒎[:���.$ΓU�'�X���Ӝ��=�i!���Ϟ�SЦ�3���%��'��Cz�{�g��c�v�\7,�g|����W̘��r�$9N<`���G��w攞`|�;�WD��L뼨hUX��)ۥ7e�X�O���w"�_~-|S!u<>ĝK������߾�?��?�������W� )�H������qk�ŀ�|���|�3��܏S�X���W��T`O��@���e��V:4����w;M�-ߵ� �Kr����dt3T�_�8
�����^ِyM���{}�Z?�� ¾ω���x��o� ������f�j{�������|����8��|��������L�N0���1�_�Cz�E���p���-��%R�㖆ǲ3kn����`I�#���:	،��8�h���mo��*r#ؑ]��V�	}�������~���3��Oŏ�����Q�����$Sj�VX�3��"�Q�tKZ"��۵%H�#�eg��T8�@���bs��ʲ���Ft��p�����8�ݴ�03��ŉfFd>pK
�Õ�.S��8	�q&>���1�5C|���+NΫ9+�!ǧ5�fN�s@a��G-l?�����.���89Q#)��N�0�I<l�����<[>[�&��Ԧ���vQ�M>�$�S���I�ǝ/�c�v[��E{�a�[�B��%1���T�������D�B}�,c�l������)9@]b�~�'I�?��q=�3��C����"[��c���#�-�����T8`�\OY�m���i�c��|�G�F�y0��8��N�׬�m{ǯq.q�[���pFҬ��oU�B�p����r��[��n��z>�n��)�GhI$���<0�l�G����G5���3�b8U��V�\9�FG�OԪ|1�_���û{:.�!S�S�s0��x���?l��ƛ�Vg�T6��
��b�r�u����#IM.|o2#ZKU��:�a��.��/�}1�lK;�Q�
�����5�N[b��TH�E3_�j�0�0:J;b���|�h�{wN��Z���nϙ�,�����τm��	��0�-
&6�(2S�����U�/�/֒��R$]�
ժ(    ��J�5m3ѷׄS�R?�~�;Rzv��b�4�H��UT��>�����	"�-�s��]���q@KSwM�W]��7d)�ρe��OLn)�(8^R���Y,�.��g25��(3����`}�<�@7_�pc8i���,�+����TtP)��Ξ��$s�`[.X�3�4L�Ǐ�p.�����%�8�&:Ξ����A����1�XM����c Zd�.�ca��ޯ쥱�&\���x)�����fCv��Eun�ڕ2�;9�簹m��L�hk߹�^�q��歾�*e�VX���;I���&�oH(����|���3���,}3�wæt�I4o%����|���μ�;I� ؚN�◛����_@\%�'����I�&K��`�B]%�I�N��'!JӶUE�އ����l�9�hP��V�NA�E"U; ����t��
���0�ⷢ��Jjm�`5Q?��<������h\����:[��щ
˪���J�v5��B:,U���&jf�ٮ&�	��U1B���RPbC�\ق]c����Nҗ�W�l|��������E�V��s�1� ӻ	��=ϹdO���B�K֬aǉ^-����÷��ޓ=��o��m�� ���b$ooN��Х+�s� y���I�!+��j;�υ}��✂�c{�x���K���+�h[�K�������'li�"Ud�/�*�6�� �+�')��Z����'��V̖p���y!I��n���ë��^	�����'y�E�<�2��!㗴��_~��w_���ᢎ�W��W�.����JBጀ%
�`�+EU�*�؏�8���+��U�����X}�����ܔp&���n��+-���qJ�C�۲���cV:��c�8d[i@�}��|���Q�$���J-��;�?�/���f ��|��������.݊Y0#�|MA�C~(S?���'͵k�b�w���/�I$��I�q(���b��	cIP��E`�
=�y$�]ɣ�:ͽ�����x�0��7o$��c����զ���a����B	G~�Ѷ2�[�g{@_�AV^,���;tz3|�|���Z���˧��4F�a�!F�d1�}��6&��w� W�MSL���d��y�����VC�ө������I�i=����Ѿg	PP�Ƈ�d��������7�`8��J}��_/6�n%L��8��,c,F�d=q��H�ך?�b��OF��.ꛂ$�Id���T��\9�1!*�1)�u�--5y�Z`1*�/�{�y鳖�eK�s��p��|�0O]v�E�ll�uM����6w�6��^g�n�+/�MY�*��b�T�ۥ%�-��������p���]��1����ƴ۪dd$,6��W���	�1T��T�XE�����C�w��}]�z7�AI�q��j�
^|	_󔥼���)[)5�f�2f\�I�@|�C�cj{����{xIL�(N#[����rK�K	WQ��̐i���٭��L�U6���4ULq�.��h��$���\Q��h�f1�+2�Ф�a�Y�v�&~y�{���צKc�Eb�ms�oo(&�ZӋa�THG��CϜe����pYl���*��S�����bs���e�~�e�1��`k(��R��˟HA�pٮ�7�@P�#M1��\���C4�1E*�MX!�.bu:�E���t�7��]�,n-�}o�E��xm�$��y�8{)dlYmvhM��M˕5���#Ǡ$�<n��Vu�G�����4�łLt��Vz��h�����<�֖%L�&uC%�n�i^����j����
锒��bMQ�@������h�b�5E�6;������3�@^{F��D�R��W�\72hz��IMQ��t1�A�1�����J�Ӯ��$��Y����Jڋt���,-��ظ2 ֛��f9��ʖq���z#��[��
MR+菂��\�W�.˄
:,fjc2-�-f�}iL��W%��+U,7���X���_���[�'O��Ⱦ4,PO(�
 7g����t,����OW^��O�#��4 �`���3���U�}ې�+�ʕ���[b-3�%��x�s�����橈O����p���n%����,�o����2��3�V'/Ƿw=m5M�b7"�tq�ޏ.��2�@�-ٽ]����Z[!y�omm�iE�Bs�����	�l/=���8j��"�#,-�w|���F�υ /��e�,R/�!�O�2����\��K�D�1t7����>�I�~�ɴj����k��)^0������\p�j��r�ˁ��1Ĳ�Xb�K���E~���I#���AY�-�c��`�Q`m輳y�>F׎�A+����o�����c`bV��NU>�{�o,.���x1gd�l�b�3��`�^·ɥ�H�����A����#}f^Ȃ����']kz�B�趴Pw%`��i;�h�#\3I�4g*	��8#�〒ʖ�yh4=v���:Ei��^�X�J#Y�b�@!���
7ܳ��-Ȧn�Z�SP�װj�M��_ }�-m���ev��Vx3���Ȝ:���{�s�n�:��<�k@D�B�g��b4�/2ާ9yK�i�A�Fy4Z.VxFaj��Ʒ̒G:,ޑ[L�C2w
TmG�|[\�+KYX}�B �$mS��/���
�A)B3�\�)�\�wCᐑ�p�9a*s{����@�Z۴�@��	λ�ѵk�G���,����k��Ȱ�Tر:Yc�䣯�(��^?݉��Т(�6R���jg��_�j؁���.Xs�ɫe���P^ �Z�z!1ti���dH�諃�e%]�g�*=X�*�?xu�C�HV�I�e֞n�ˁ�o��������x-S���:��v��;NP��Y�*�v.�y��m��/�>-��t�1���i/��i��F>�����	`!�^lJc�fIZ�-�������[[䰎m4+!��.��m�IV+��SX���Ggv�؎�Y�.���vt-��;�}�����K�k��4Ӿ�`�`��le����_��T!�%J]�\Nb���k�]�S��ｐ�����P���O�)�dϳY�Қ����}�ENwʜ�
(�;�@)��n���8�.�C��'ܻ�{�uC����ۛ0X��nZ��6	i�x}ES�y�νǹE`�4̚���~�+���=}i���0����T씀�y�� ���Y<D�C��}>-��{��G�o��Tg������4W0�y�C�}��V��a�$�(NC8�kf�Mr��3��=&'p���Vd�S| �;���yR�x	�un�U���o�>�S���m}�@�s[S��_fdLg?h3�ҝ��G�z��
R�[��FKz�K�_�V��Sq~�2���GR���w���y�M.����%�<C��ahA�j���-�Xz���R�U���t#���m?���c8��m�`�
�&�QYK�k��� �^qB��g���qߞ��8�d2�d:��q��΁��>�r��7����?��ߧ�,��/?�7��޼F4��\�x�����Re��R�Kڼg,y�@���6�Km�ZrQ�q��t�R_E�]'��NCh/���&�W�]�:�OMǞji�������vIk������}H,��f��M���`ʶd'���)2�Z��X�����E���!O�e1�b��d��9L��;�ǕV�)W�窤�l�l�eKC��] ��
�x6�'U���ʌ�f�w�H�^f�߀.9����ߑ���ܩa�V��g�8��2�C�%!�ns��,�&O�@z�RS]+�[@��w�(�I·>�6�bʾ%�0�%���jF��$�Ԝ�J���6�i���=?��an�"/h�Ҝ�ü]&�	亨HE@�3�)�p�!&&S��}�Fg�a�BstHv�P���Wd�����aaTr�bc�kL3��(>�rk*�KL3���:O��x���Y�Yfh�J��U^�205�@ؑw��A��Mx�>'�)��[�*��!գd�����[HY*��ŕ�l�X�!߷��t8��U������!j����    M�s��E�j�ֆS���(�"�$�,�fS�5ݒ{�t}M���<ϧ��F2���'ܚ�;�Ӡ����f���g�k�B�ӡ1��	Mb���\F�tiǙ>J��k�,�r�u��vh󃝮�?c]�:�2V�<���~�{��Ҏ�܂�k�L����Q��	G)�u+��7���'-�Դ���R����S�5�Q�.Zg�o5��
k(��.$vZߣ,V�Nq$����t��;����X�L�5~���?�禜�����Jc�_Q����G�tq��Nr�..���S�2\aN�C��2=��n�T�S7㵸�(�o�nՀ�B��Q�(k�gRXR¬�#NU�	�SW�Ęf��s�KS�i�RieA�;c/��*4���T�rMT\`�i����[�(
q!©����,�Y:N�\pU5����֣���t�a���s>�\����t\�2LcB��-��*0��]����p��<^W��H�G:If_l5�� *
�k��B&9�B<��0 0: ��	�V�Ԍ�#`y�:��&���h�Zk�I%�Bzf(�%ei]�O��B~:�w�<�#�F��%��,�p�Dt;��'������I��-[��?��/�i�%��J4ܦtܯ0D����Ո�0�ǒ$y�9�L�>B֓3[.콻��g7i����p�t��0,-�Hv��N��&������_[|"׃˚)�Ɣ��sϛܒ��'��8�F0x�d�BW}靊��/��D@x���q�#�Bv�<<�x�N��+jpG3iC��o70�ϕuv��90z�U�PTO��L���I02t��u>��^�U���vЙބ��z��p��}}6f�<]�0�._a<.�O��P-�
Cz��,���9;�/J(X�g(Y�5�C�v����Ls��z�W��)o���^&P/Z��*�ipjC�m&-o����'�߻_�f�꠶}a�h�wR��_K��3QV�`a?l��6��v���0�B��Jf�K�#W��(���}!	�!��G��ak�����}[!F�CO�Hp�B��LE��`��q�'W���{ �ɢ�d���!�N!^#.��-W!A]�n�!��a�e�K�:������]D���$L	�%��jngf@uz�?Ƨ�W�}2���������*y?~;�B���V�O/\�&��V(y0����U�Sד�V��̉H�@W���5LC��ZUn�	��%��J���!���"^��%@�6�<kuJ���F�V�no\o�#�"ut> � V�z�pTþ\�f�s'���y�f�s<k1�ϕ�4�F���ޫ�ʧ�qkz��&�� ��*P.B ��QY=QG�)��pzj��;�\fzS`+T��>,{�)gYt�U�X���q)Q��v�럣������3�d�4��}%�M�����6k��3v��IE�%�����wܗYu���c�귯��:L�8d�{�շ/*D��A����GS|��lgh/A��i|��h�KBA�K��r/1�P�CK�M�Ekg2����]ph e���8�t1p_�G!fU%���Avㅘ�@�I�Lz�ThR �(�66�8�}D�`>@zB����e��m��������2V<����vV�0uX�ޫ�ΕL���㠇B�)������_l3���cK������kl,d��������u0S?�ܶ�@�H�3�YSe�U�K+*������<����"ƒ����U��Z�4#���C��P*�#�s�gBh-^�=n��b,�Ttw��.Y�Qc���w�}/��%_�݄	�"�C����-���\�$�����n+�)r��b�;,'ˏW����̄�����!��'�~�7=HU�,PżC3���f���P�	�G�ؐ��v��A�SQ�碬�+�|y���\C�V�2��O��� *�8@�ڍk,�`U����%ڭ���mI�w��Ѐ�j��$��!:��?��Ӛ6��fI.��U��X>�э���8d����T��iT��k��̣����{ThQ����-�	��sUL�T�g�X�mpKY����"yJt�k|��УR���W�}M��||��b�6$u�M�`s_*�
1z!�7!>��7�=M
��}a�����mo�y&U�(0��B��Y�$�yhǶ�{��q)3�
�1���e�M\،w[�÷��]��BqH��څfF�����]�	��'���+���40=�\G*8b�!֛�ǹ)��K����:L��%�Iњ/�{���d:N*zAy��B�v��)�������_I��S:�RCqCo	7D��r��^��B��k���1&~Cx48��t��pN�����z%?1 �BX}�)'��l�bs[�k����h&�ie�\� ���}f&j�8+�t�TuE��2���_[�vԾ_����sG�ٷ�٦�|z�Z�J=��&,�w����R^�~FZ�X��ܿϹS�z��t���\C�w�V�l�Q�"&L��A�'�I��6�$��	�mn �b�~���3�nO7�:����A�|��OGb��k�S�j-�? ���خ�9�뚯��+��;L�:�'O�%u�U�p�.��E�ea�4���i��^t��g��bڈS�3WqXz����%;̝�`*�����T,nM�=��9_nԾu}�	�#�N��P/��&�g��c2��a�j�cF)=��,�PPl|��=��@;��0F.wk�0p�n��n��3�����=Z� ��)%lR<*ӽY���	���%�S����}blP��|i���#���L�)-̔z4��D���KTsV��OtR����,� ��������h
ڪå��q.U�8^`�:��j�`����E�9�,��m�S�΄���g������M�o+J8 �ᭁ��u:jB���/�-�]**ړ�`�\�t���>�{LuJO�$^_ak<�;s!���u�ǔ޸_9��皨_5��.�T����}�iN���:դ8�4��հ0�>���0�/n����$�{���������,��r�M�,R�����1��MI� �V�:��<*�xy�[�y>�n�����č���/Knm?���b
��)�F�Tm4����Z,�?Ģ�$�aM�2Z5�`QNpv�:i��LK�1���쫶'��$�:X��W�iss� ��8�:��d�a�6y��@�t��fk�v�����e�lQ��!��f������/�?\Wx�[lp��y�h˽��Z�aQ��Xu6v1�^��8��3�A���?ټr�Pʇ@�k����<-�2j)IGWn���ʍe�k�8��3��˽D�+,Ұ	�!oG=SW�'s������ <dg�zb161Q1O�X�� ��K�*��G�о�n%�!å����eh���� x��.@{��B�o
4 c!�y= �i�Yn�C����B��F)�2�����Hv�֮��\S����A�����bԄ�%�+Q[$�ѱ9�sᠰ���U=��H���d�r��Vs��MW���Z;i�M_L]:m�̓�q�<��G��k�i[��nJ�פY�G�隊�����|\��7F"����/S>
�Q���A��2�����B��-�dG��N�.����uh,��AHLٛ�fe�ɳ��o��J9H ��Zd�ZѯM�=8`�H��.O�� �0�ϱ/�'��LP��@� M�M|���p┐v)]��Y���]��"�oU�R��em3�c�&�� ��p���k27J'���T'C�1�s9��oTB����Ѫ���	ުrB�=�������_K��m��-Y������(����=͜7�lC[�Tq����-H?iB��-�($�W,Jy\{3Ð����tX�Oo+'>��=d&w���W�Ô��f��=����l��NM|$��d�H߳x�Cbr���8�:m�^�~�Yy��#�ڦ�����_d%_�#�Y�tC?C�\[�Nj��v��sg��ʱ���[ry޶�!���v�x�ǃ,�pF����;�"u��TJ�����a��&�6o���Eg[z�E_�_��b��`!w-5�d�aR��ca��c@�ھ��a������
�E�    4PeRv&��s?$=���%�8z����0����#Np؋d���2-��a]��Q��7��FsUD����2"�(�9��-L��!�`�q�'eՙ���@��f7V
ҍ;�8o\P�ő���ָ�P�椔w�쓾��2u�- ��lFu�\�oR�t�2w�h q�
	���II�"�WYYmb/C"�]}|����+�4:�� H;:�sW���~�w��K�"!��������L�Ҭ�����m�^:�Z���7r�]=S���YB�S¬����/A�����E��ݲB�G��D{cZ-�S��ki���y��\֚���\al�A�m;�x�Ֆ�l�Z��j����9��k=�+wbgk6^�|3H'��p��X�j�&X��rXB"rGApJaC��&�ZmkŨ=� w$���\��	}��U �?�*����G�K��d$���Kr�h�܈����yF�~�����a���v��C߱>P��\|�:67ɻ���J��4YU��M�1�.J~�\,��9���C��!!�e:��~o\�p�o�8-;%���Vm֣e�yf�{dZr�;�׭1w��9��??��tX?�?\����xV�l�8���@\��O�V�����!�S�e��Y�<��9�[Ťo'�T,	��\��s�}�n��Ց��1*	���Ha@Ȼ)�/�y׫)y����뛏�_�������+H��5���c�qi�lV�k�y,��q����"�j���K�շ�V��/%zE��J(V^~ޕiM��Wz��e�k�Iw�kIн�@L;�ePF�`��7���R)?�G�$���ծ��w%J� �0�0�k�>�4���h�Rf��5��wp iڷ�K��[��F���y�yޅ�m`]�ܦ^���d�	^����I9�Z��]�0��ǂ����p����܇$���ʀ���P�2�zXS�B�j);;�mg��R_��,`z�t�iL����Y*�˴��4��+c��:��W�J1�Y��~�����LR���*Y���j�
�څ��ne��e�2�Vg���p*��t���4o�I�\�Z6@',��[:)�-B�v�TmQ ,�PY��%���nҡ��`ܾX�cK�bd?���WE���.�{f�R�[��1*��Eh���'�[՚�4T�ɋ�C�sιLP��^�i>�]\��$G��Uv�<vE�r�p�	jJ:	5�XE��oŁ�v$��6ק��"�$X���n2^�
%��{�<�7��១BG�7��?�*��4f�&+p]�/d�d?��̾*����i&��v�`�׀�6p�Ez���ǩ��	�JfHܩ/A��׺.����.ܑ'
`�����Q���yd^�D��,_\�NݥB�����'^�9گ�*�����0�L�"׏�kM
�оK_%�4�ҭm�_�"�k�0E�D��v��z�TH��OC$g+�C�b�и�o��<GK��.�U+B�"��3]]'��T�+�b�����~m��n����7*��!ݱk-i���(HC�TǽL�F鵬��v�@C�c�� ��ZF=a-c��^���E���V�����Hod�ҎdW�CI�)w���pv��~�#��+*�*ۗ_o�Ȁ���t�LV�&�ν?m�������<k�}��M�&�|���>�c�d0*T��!;�W���-Z�jS�^�%A��M
65�矗�T.F��M�{��n~uC�П=����q�34� ه1��#����ڵ�o%���>>����)�lL��")���1�(��^K�����,����-sl�=`����7��zx��d�d�3�ái��c6�!�8|����
�9:�eH�����e�������� ��kˀ� iE����@8��qʦ/l �+� ���4G�Y��1���)�g��VZ�9!�����H�s-	��o}�F�I	�QY}�S�� 	�-��[$)_AY,��K�&$�$ϋ��	��G��)�_�� �:�ݐ�ﺲ��d̤�̳�fó��d(����(`$�7I��G�㮳b�����>NeS�0##&E
MHvn�kΕ�DdP»$�H?�C�?��!��j����$Hy�,�!R����s�o����o��i��,z�y�z�ӝH�q�D\ۚ<��85i�@�g��k'G�U� g�N����{�0���0��׳�1'��3�k��VA:�VBRXv?���Q7�D�9x���~B1 �2��Ol��슡�q�L7�;��\"���g��>y��=ߒ.n�&�7�!^���AZ�j�� �B�rݻb�c:-�!	Kw�xa����U����* BE�/u��jzxvazVi�2+�K۽|��$'W'���4F88�lE3#TM��@UT�PE߫N\Zv`�q+�r�:������꟯x3��S{��.FE�	��!���m�(m*�5AN���D��u_�B%�ɦ��������\.ۧp(�+$�6�~�E���ҁ'L�)���	�9�4q�`�\5�:Ց�:�tܣ'ۤ�@�	X�aq�ɻUE�����*�2�B�FU�fk����-�X�����%;I�VF��Y������,���B�"�Vۛ߳{t�\��H��}w�h��ڵ��Z���x��j�c�E�ѵ�#G>Y�2�cwM��{�̓p���8�?ܖd����ӯ��gs��@��@~�s:�I���Mf��������n�d:&�캥_���8���_Ů���<��5���|t�C��#����eK�R����](��̖g�͑�[��8����}}��Q������u����n��eweM.D/����`����I<B�t�7�;���w����f)#,��u�.���V�J�A��k��ewݢ�������!7����ȏv\#=o������%4|�K��˛���#�!�_�y|=>?��Ӿ	y;E�e��%�ؕ��:�ĥ��!)�1������$+�8�r�,i
�A+C�O��:��!M��
�}��ڹl9�^��[�"��3�Z�5B�4"��t��D�B�rg��hz}��O��Y���(�?��Vk�k��#x\ev���n�9�i\w���3R�|$��/X/�a-i����3�p2�K�����(�7���{+-��?�X�_b�z���lL��\�Nmj��e�W}^�GȈ����P�I��G�x�,�U���z�$�=� -a��3�v���/����;�O?���1M�fpɶKoo��eHQ����Ί�:��D��u|w�'��_�!�?�_���}�+���)g�?�e{"fQ]:�8��M�\�������]�G�<���#��+��z�S���='��V���<B^4�I����'���c��W�@�2F$�mE���9������������ָ�t�w�١�H�!��E^�EJ�ˮ�aIw5�G��9�K�������Z����ٟ3�\��"�ý�%J��p6�i�c����f���!�
6����+�¯�dȁåv�>�����ubA���#�L�جMMuF7��u�	Z���h=�@YY>�l�������)3�Y��l6����)���0�ֆ:�$�3o����-�����a����{'����װ�4�&҈�H��mB�D&{fLIV��x�p���L6S��&u&}alP��n��2�����u��C@yO���A��#q�
��d]�1ϭ�v�
{��@%L��������Ii�������X�r?�����C��e�+?R�}!Ū�X憩zH����!A1>m$���iG>v6o�Ӗ�H+ĭ��'��\\"�1�1���\�j.�q����p�g��a���Ӄ��R1VH����t��#+ul���)?�,��H3"]y8�S�$-ǧ/<Z�F7��f���H4C�T�l���.��y�I>��2�bϳY�ԅ�59c�"���l�)��y��#,#�Hq�<q7q �W�F�H��X���M�MF�ݖq��̏w*�"���}���c�~!�؏��)�v��    �1>NM��Ac��훖{*JM��d�[.��K]�yJaۦ�m���L0���+�����
Q 82H��\!|Z�X�OQVh߈* r���	�C|��v_�g#�Z'ë�_t�bc��j"��l�8�i��r�����:�	7+ԯm^�T�u{�d�&����w����q�lR�C�a�hD�_�y�����Vۭ��ס�D�g�^
Z�#�tnG�(^ŜILL#`��d�T�*p��ܑ]��T6�+��$I����A�P�°�tWG@��¬u2U�}7 ^M�
!O�H"�_�&�<T˖m���ᖁ��F�c������;"�_�����K�x܈��Jq�'H����&�����]UG��-�g��UwC@s��J:��nEc�@N/����>�kc��v���,�v�.Mv�l�Xi��U7Lh"Rm�i�����X�AL�SI���xȡY�Ė�婻>��S�Q-��f0&�UN��o]�tY�'����+ �X0�����ŀfQ�r��Q��puW�mδ�hw��h�r-+1K�QD�=	sIis*�\,`���2�aʱP,]�H|�zi��d�.Fk[&�Yw��X�m�	m�u�����ZL���`tN7��0ܹ���� �TP��-~���o�oq�͕d�T4�]?��(K�o������X�����[�n���b���[X�s(k�嶔}&���Y�J܊��������5�6�Po'x?�#e�P���h��K��h�-ӓ��O�0�+w|��/"-���A����]j�We���-`�`	���"��yb1OI��Lm�BWI6+?4v�>x�E*��5�C��o&X����$����l���`�k�&����yr���q1��q	��쑳[�8��7#ge���eA{�	����0(�n�@�r	e1j�>�e��Q�t��<;�^��E�%፫7Ȼ�X.[h�Q�Ȯ��D Qoô��&�N�H�:�{�m���<��@ڒZ�d�0���y��N�OH�˄r��+a�@��%�Q�ۚy���&vݭ$�3zDD��V1?����	S�6�:!���.�ZV�:�����w�m�Z����:�s�ѹ��4��$�?�'�,
T3t����X1믍���p��Vݐ	3�QZ-�<`�io拏��#J�<�iP��o5�� G�)׎(5K�$�â&�� d���T�wdG+������	��'X�������`�݀�#xu��	T�.�>�Sh��,�nQ�P.|�����R�7Y�`��F���Mj�|���iY�O鸌9.vM�����/�A7�-��`XΘ&��iV[�]�V|^��_O����,�vs+��ZH��W���gL��<a�t��WԵ�ܵ�M%�I%d��&��-^����'O�S�nҶ�"�,ŉ��M6O�U�0}�o!�4�AR\s_:�Ә_ϝy4�����j��:m�0ʚ�c>�@�k䌤㻹�Z���0����mo%�(�,j��?�O6�O������ɞI#ޏ�����X���'»�����9�ɸ�	Ӷk�`��`�Ʃ͉�Z�/�c�s/��v=ݦ	s����d`�j@���h�&x�Ӵ-�F�p��4T,|x�.U]��O�#�I3��s�����-kϸq�L��d���[b6L<�TO{\|��踗Ie]�e�����i"Ą�r8��GvH���O��E��˓���r'�XǮ�D���4cW��BY8d��v">m\=�-g�� [x�E݋�Z	���L-6Q:��j�Լ����a���q�N^�Ze�@��I� {���aM����h9�R���?�C��cl.��.
�4�E��; ���b�g������;N�~N�+���|Vb�`����~#o�*w�G��9����1�]nƃR��TN��0�+~�+���p7���̃4b?�F�@��g��;Wr�%bTT�eҎ��EI�V��M����72�5ލc7���'L�ʆ[������
)�yn�c�0�F�V�Lh1��3�I�h�cR���]�!rE����P�1���u�	]��M��7��pF�p:W	,����Ҟ0+3�N�[
Gy�$�x�Y[Y�C�$xO���.V�Kw"/v����
�O��?8�/��G�3����eHHc�hV,˂���w)�UHR�|ۅ8�j�v6���G��9�wБ�`�yY�2�vBU�*�UC�=��)E0Iʖ�`Qk
���w��W���)�<�=�l3�SyfX��jCR8L�6��̐8�8�Px�[��§�vb�[��W8n�Q�m�6j�0Þ�z#�U���|����Uks�Ű{��os�)I�7�K��.��9"���n���v�B`��bѐ%^��4���ȁ%�UuW\�j�\��>�}���oǾ�@3����������;ЙO�u֡lzp�Uev3�N��?p 6iw�����I*nX�yX�'T�Q�OYXPf�g����a�8+�z��
�#7�c2-�S�z����F�9�4�'��x"޲(��󬸢�N���V�aŭ��6����%�k3�� HH%��j��iW�u�Z��h��6���~�HΓL'u����!�Ku���!a�RD5o��6L��:CJ��~/eGaM�r#NR�c2��=��&t��[��Z�o}*��A��M�z����M?�E
�X���?e��Ȗ�����X��,,ƻyCA������mX�/�N�<��N�4_�Q�d0��T���l��Rk���2���  b���2�d;�B[AZ�̘d��9>UM�WXڸȴ�RN��aQ�C�1nu�"�Á�;���6����-���z�ԇ鏕8N׬�,B�hgX\�h�ي�t��Z�� ՚ahsۙa�a��/v�v��Į�z-��1�R�r;���$X�*TH!��<E�b�'�����9�3�a
w��P�1����y�@9w�j�=)�;i+O]Ӫƃ���ŀ�(�l�Y�!gX��ޅ��.)��2T���Acl�2��V��|�����3��.?AE�K���u��Ec�H�8S��d�hU�e���a�+��⸇J�$�H⺄�W��:����Z��-�i4T1î��,���|��i��NE��]ʇ��p���$�rg\H��R������('��>hM��a��Uтd��FW{�:�X�)6���i�:MCZ7�뭍��3,s-�H��("��0^�lfئX�RA4u꒔���ś����F��ϯ���>�C	(\9CNա3��0��%�lb��[H��M��I��)U'ݖ�
s������3�����s��8E�q79��
�i�j�-�.�a�kD��V~�8�i��j
|�OmRȟ@���iG��W� ���)�R	MK��lv���e��U�~�F�O&h"�y�ɑv��y?N�33�1HX�JHrR��7}�R��&�?%�7x���3dNy��VAn8�UF�Ҷ<<z���3O��~T����19�`ak���X�dwr�,=����c|T,��W������a�kS@��$�����t��</����I���P����Ch�(z��8�9ܤh��d_�E��t�����$@Ů��Z�0����I�3싼���0`g����,����uu����d�0e���z�8�{Gg��\���3.�a.m����jVǦ�{�����d��d-p ���8ZE�>@���f�I�gH�(E�����h4c�Xӧ̆S;<S`���E#�ַ�d�zLR�/oݔm�zs�ț�~°{��L�E����-������܂�7��+� �P]��q3�#�n����;���[g/]��G3��b�����Y>�-+��P(�+?!M;C���:%4��V��Dk��Z���:�8�X�C� �ލ�%qGV8a��]����͢%�
!p~ve=��w�I���@C�'�}�+���~����l� Z�����_�q��Gxw�-�	�E�*��\ӎ�M��shkn����߳�z��Y2�%�B�t[��2F?��Ȍ���}^\�    �܍J�������	侙�����`g��9�t1��J����n��sS�=�ܕ��r�����8����1c�""l*�/@B}�f֊+l�u3�=�L��`��A~�\�]��x�f0�M�����t&G7pRd����霄�-��I��Kϫ�V���5n�"�k�f5���UyV���s����p
cy���X0�m��l*$k2�1K:����R��]�|ͨ�>(�r�O�:p�k.�kbOC�L�[���~r_�Tל S�Us����eZ�h8��m6mkm��W�?�D�pٔ�Ѧ�&��W�]zX���F�d��$5�h� �~!G��ZL�X�
'�A�&�Y�K�$!���-�~������@|W��zg/� %?�%�ҒN]|51�K*��u�F8tw=�w�.�JcF6HL�Br� �d7�\��ҡ��^���wz��Ò���� O��ZAy'-b�w��;�x]__�ɜ��{#�|N�g�.c��I�����!*���\�X�<<Cn�3�]���S1ަ���{���yis=���Ua��\)�rC1�и���2X�|L��� �6*�	C�:�S��Sb��H]|�-�5�nXL�*��9�?��H�>�U���a�G�{ 4oLT�Æq�%�T �3A��¾=GA�Ӯ�s��r��)B�3�alt�cW:@9L-w�S�� *�b/:J�B'kj�ajB�Rs!���4�j`q��i!ecD�j���2��vO8>�X�����(����SM�?~�4��<��~kXI�'�#��/�����&`C����6/m�#8"v��7I+�7�֜�O�D,�4�m��ة���e`4T�C3E�s��u�u�:���-2^�1��Р盬���8!��[b����l����jR2mg�7+]�.����__���}��8�����IZ�*�Ф)v˹-�bSE�re�q�сCT���se�/�s|��+]�	�}!"������aY&��n�l�{��e�5w�7ZCJ�����2�uOj{�����R�g�����������qX4>�^Y�}_�|)�M&��GA�^�)1�0�3gg6�}����+$t[�i���d��R��Ƨ���j�{�e�nՉ7o�@�?�5�rCc���K��^X!��x���L��a �{Ϸ�?���
wQ���y��-Aq׍˯C#��2��eݓH"$o�I��o�9����&qX�zOzr��|�d��<��P҄�]cU+k��YU&OdPX�K�Z�����V��dfH)�[�؁$K���Ϯ�B/�r���5�����{�s��?�H�L���j��|V
TH=HyH������:(����tl���m@b��j��IX�/�#��[�jY�{�:}��>�h��Q5| _�Uy7dl7���{�˺�y6G��2�V6��)3�x�P�Ű	$WW0��5�kD��X.�P4�j?��>�D�Lu�$��s�kJ��?�2q|��c���
����8#9C�).��tL�h�B����O.m�CW.)9�n����87J�zl<|O
�]c�"������D�n���h����=C�Ŵ�|{,��fA�=����bC{<�)N9��{2���*c�9I�-�A	�k/��s����అ�����W�$3k��1u���X��mz���bw��≐\����لڥ�]�e�q�����4p�jI�bE�g��,$C���c��^�1Z�Ә�d�K�嫪~�P���N}=y�J�H��'�f[�{�'����zz CR��!���Ƶ�z�q���7��G�9n����Z�[��96�G���i��~R��8Eߍ�ј��\kz�-D�Ϝ�S�DYؘ�����F�L��-��3'\o����*��#4���mIm��u.�2���R)+|1;�˨��R���_�<v,a���8����o��6���9J*�<'n�ȣ"�9��U��v(/�~�;�s��z��o���La=��q߂#�B�ס���{D[s��8�ڽ�j�?E���a��<������`��g� �kx�������M���Ii1ٙ��c�Y+q�8��0���hl�j.���,�.L�����(,g��<��ݍt�����,l�|?x��p_�zY���߸�[i�v���~�h�7��o��v���y��H�I��+7�7XCߓ~�2qz�9\��S�c�B���Ab��(U��Q[X�{_��D�~�*OSE��tZ�wq���C�'訙۴
sĀ'E�(Z�3�8N�¾�����C7�$'+���B4��ْ�6�9{;X����o�v�vڽ�yՙq�&5dq�C�Rp������W5�!�[���t5�Hda�����E)��]�xBC���"������9�K�4[H�2�wkk&���N�d�� ��>p�Ú�9\�Ezs;h%�����b��o����U�|i\Fv�z�vEvpaP��5��>|��-�����7:�Y�LQX!��@$�ȿ�I�끾)-�X��@�7 ���E�-��0ԙ�� �Ȫ�ɸ,����n�o�a�&r_���CwC���ho8�c	W��w[�f�`X"D��oȼu}�/dW����_���k[�y�UI3��՚����sr�i%�i�3�Gxc��!�n|�,�V+���7���_���*���&w|�]<7s�}��gp�y�	���y�L-��s��ݴ�%�gWgx����4<Y�%6Jݿ�s{?�	y*+lO
<�)�ӿO�h��v�L�0ŘNu���������M�fFt�p,��Y��3�b���4��rj5��;%�J��DZf!����q����f��\&�hX�h����k敦��~���-��S��pz<F�Cn��X�?}s�ճŤR����Bv �D^uF�ΰ-�2V���S��a�Vv�@wQC�,�[�"xekk9�;k-$��-֬D�uˠ<����)G��Ӹ�	�yH��v��=Ԙ�g�B)���2s�Z{���-W��;������ ��.[���*��σa���lyp���ۢ88 ���^��p���|XH+�@v�ąn�&�Y�J9ѽ�O`scZ���j��IE����4�[�
�c,�p}C^�;�姰5�}֤����tj�B���D=9��v��/}C�m;��F��!�\~U�x�*�oBCPھ߹�P�P�rj_h<��k����6�!�L��U����QJZ�t��p�!�\��"ۛ��j�������E$�ʾ>�ȴ9�V�Ic�����h�'ibM�����H6\���3������� ��0�`�@�-���<0@�u�C|dX���M� �`�>��5�ӷ�ݚ� ��oQڵ����45*(������9T`�v�j���in/����b%ct�NC|ߊO��iB�jZ���5��sw�r����u�/ߑm��,��
��B�z��2�<�v.IZ8+7�x��^P�f �*l��a����ղRr��L��3ԗ�N#�}�Zs��(b8[A���0p���0 Lj-��V���l��S��8Ubk�X1��X�>���2�0��kG��%ӈ�nnǮ��@B{}y2�L'%\��8u��^�}�J�cV�mG�J�I쎠��,���;zėU@3k���j"�3[���!��jc���|�o���o��ؕ_�`���\B���n?��!P"�����6-Y����>` ΂	.=G��?��A�����!1�*��׌Su�F	���)�S���k߶�&�όr�9�C`��m��6��r/W�xTd/����|�z���)i��_��t�|_��X��1`>�p��8��kaa��׆-�	Z���
�}	���n�l����\���x���r���w��y��A�]�˛�"R��o�5�ק�F#FǇ�v���Z`��.{5������gK�-�Aڶ$vˎ�~���b˯
igA��d���ڎ[�X�'v���C�[��!2ժ�%%�T2�v��D�����l����O�S��})fA�p�	�EN�LW������z�U�V;Odz�������dJq�ٌ��mc����r    ���X?��GC�\����?D��{���i����k�pp!]�ò+:��f֌���|�����q��J�7~)l�$(ڷ�������N�����xiJ�?@Ƀ���[u1�X�/H�q=)AZ��rC2��8�>�hG�P���Ny~=�����.�j�CHΦ�x�__*��1�s�-���wo�
��r}L���=�)���}`��{���Ly�ZN��(�J2�cy� �8t�L�Vh�8��p�M�3���:Z�6>�f�;�]r���3ܴ
t���H��w����ԗ� ؆y_z��][���Kj�'@.����GI�r���-.�e�t�Km\�u �[��K.L��$�藁�����0C�X���EX��Q��[���f���O\<H�B���`�H��;'O���IA��$Mh��{"M]�>�j�����^`%/B����" 2ɬ<M�Z`)/�{>#Rװ���(|1���S]lȱ��[� M���h�@R5�x�v���ȴS�;*&K�c!X�q ���.�!��0c��ty�[ё��b��Ӌ�[5���c\ [�^̪�~�^�mk�����$o���d3��u��&(���K�~)}D�ҕ3�ln%�P�b����i
<`L,/���S�焨$���5J����SW�Ȁf��U�(ί�^�婢%§�ts�-�j� ���]!�1�������Q�LJ��o�AY�5J�n麲g�kdS*�[}K������H\z_���ɗ�ʭoQDz}yP,��BS#�R4�<;w\H����LA�6B����c��D��Ka����=�9��4%QHX��]�h�E��ǧ�)ڳ�l?,���
+�7�%���o�~`���()`�ޥ-{����5$(�㠥�U��($&G� ��ֶ�yi
�s����yc���ޤ����c��������|�6ڊgY�.v��R&"���XN����re�
�#3�7�Gx2vs�碐Y��'�]l�o�������/�漰?��Z�y.#ڻs�LIQ��E�y�����Z��+h����T�<�2��:\_·��̾�xҮ��ZX�����0��^O*��һ�y&Y�W�.�o�.��*%P,ο���yt�g��˸��=W3�6星}ܷ ^�N�.���5b8����/z�޹D��%�m76èM�	��ė�8�k�)~'a����GXzN����N�UPG:�V�z-oܠ_�����⠞�����6˽�A�v^�<�D$��U�a��
���4�u]��%��"ۆ$�x�J��NR�ә[.��7�ގ���(8��w.�<�Ox$�_����b�ٞ�U�$�+�����#��u��XapL��\�ɭ���RS7͐�=�nCח"��g?�a�̑�<k.v�'l�p�)��)�F�0�gUP�sL������ǵ,�\37[�b��q����"�G�V�"|.xW�S&[Y��C�'���!U%$��&�e���`]r��xߵ�i�̮�dQ���#d��\��}}��^,�"�/���.��v�b�An�_�ջ!���T̻#������n��c�Ґ��o��#iڲ٥C��d���Хf�h��-��y�o�V�� F�A
�T� A��q�n������L��(ع|,�ß����5�\�����Se�]��.يl@�f�L�~L��3�Q*��7��$��i�i�i6hu�"J(�J���2�D�����urH��A�%�aY�\wG����?��`U��h.G_�Ԇ ��k�_�ޔ�?����kGABJ�Ũ�X����\��.B�8C'T�v�����g�����s���YQKG��ѧ2���ך6�D,�r`gЎ�CKL�l���G�tu�y����[V��PRD���T�֖�@2%��I�ѣC��Sn���q�(�OXh*���܊�U���)(�Am�{dD��N��Y��+���d��T��]������#kk���� �:n��W,*Yڷ� �[w*'p��\�бϘ�9��kB�.�?��y�6�y���e�n�31�f��C���C�G�C#E����{!	�+��v#3ݓZx�M���U���N� hQ3���+��U�u�4 דӇ�rLw�jL�wz�����0���l�����D��V�y����}F;��.3�yQ�����"V���&0E7/�׍���BL�� Ԩ$ʪ���}hul�0vS�f�*��N�yA�n*���0���(|~�[��%�����x��2:�J��?4T��f�m��r���zj�40shM���M����Kj���;a/�#��X���Yv+��w����#�Wّ6�y��J
����+�����Y�;sǝP���O����.�gbf뮏��Z
f3� t4OH�˫���*&�g��a�4�c��u�6qRj*P}�o����߀0�f9�Hv����&��,�{w����B���������듡��a��2��F(�y�s7���@,�S1�>�x��{-_��/>���v��)��n=M�]�,F����<Wˬ��a��X�Hh�Y��A6sĆ���m~�9������	k#T��>�r OPއ���l���"� ����$���9��ڼ�e��)����߀ ޹g=�˒�h�#G )S����)��eJf䖿�G�m���?xk�'�h�m-�VQ�F(Ȫ�(��5Oв��ԳE�/͐���+��!�^�&�J3� �a��z��\i�SԺ2����G�U�ί���-^kۏ[c��c����w�k��0����U�Ԥ�QN2X��y%�<Q����-��pkB�pѰ��YZz��l5�~����Y��\
S�fU������-8`��U�tT�B�#��]�Jʐ������K h��E�� I�S�{M_HWj���G����l��nL��մ����E��3Nt��
�B�V����F��B���πs�GN��y#�vʾFǭ�{}��N�����y��&�g��H�C�LRâGO	�U��jt~���O�|�c'D�>k抙f�P��� �A�:$oKn��e�:X�� e�"�q掋�"� ��Nu���^���y,�t_�N`��BZ̲��Ep��������X�	��;[���5�.I����jc�H:%d�;�8%��z;���4���p]�)Ϗ8�xOڑ>"�Gt�Z2��Z�T(Hy q��[~,��߭��XfWsmߠ���ˇ#$��bMW�>�Då��a�d��<l���D��J�*��N�u���`�A�!�����@ґ'7�0cQ��~�uU(�c�g�!H�:���L5�MH�����14=&1wEBiŊ���[�[��"�'H�:x���.�)�>��>�#�����p��<�I���"���;��/�!���;�\��hawh$	�%���3{г�]�S�&t��G���N���^w
�\,��n�uN��^j
v�s0ʹr�Qf�1��ͧ#RE�_����Z�b�:؃���b�{1#�i�-���֍f��,�q���ުr�[y�󈙺p�}?����8w.������2ةt�B>6\��xǡ���I��౒�cTB�����͏kZ���<B��< m���)�ܛ]8��"|��Itqt���A���JKz{Xb�b	��[#��$C��V@a�z�rk�-6���M�|��v[��vdӰD�o��N+M4��d�c����l�V����2!X�̱c�\���sX�nNzf�:L��i�vR��F9)����}�Y4�g�y^�aH�a�*�.�W�y���L6��B0��A����\t�7�c��؏K߿~�8��HE/K�0�EM��A��a}\�kw����|�f�,����8MFB;���;e��훎}zf��H�^IC$�cw�r�� �`N��9��Ј!!��}:H�}��v6=�[ 5\������c���%�%P:j�O��\O9��y}��w���_�7��TnX��>JeM��#�W�%��2F}0U�r��Àoo�oq}�vҳ���QO�����"�9q����`a��'C�.1��Z    <a���v�ዩ��3WϦ��U(�(�����w�� 7�r�9~�X�Iz!Ij?ԭ�J�&������4�%�U���т���p�#�D\��F���L���=n�<��A:�@�/�t��*��[��r��5�rEa��1N�i�_�@A�2�Tm�qȕ�4�MR����d��U���^f�u��W%!ڢ:v�OCB�&��}��Ĵ�_�n᝭Y+�z=�\g��e�kc�@�I��$�^��g�|Aj�{���00�ʁGL��C3��qǥ5X<�!�C']A��w@�K8?W�(��+8.r�H>���P�z��K���Ẫj���t���=�7n�I���9q���!��v�-�(�8m�7~�c2n<d{��-�^Tb*��k9�o���M��WL�7<����V^?��T'����R����)B�xüte�\W!���b:s��^y��fBm��¢�ߤ�m�y&BUwc��{����#�1ƶv����S�
S|[�=��O\�m8n�����d��\T���S`�>�85�@3��ƮB��a���e,F���#<�d��x�]a^�cq��}�E�u�:8�� �Sb�0������I{�]=n$[�U>�x�d2�I��`^c�z��s�oK�\e˺t��}�]���J�mm��'��+̓#H���-�������FĊX�:�!������Q��#��H���y��9���`��ŋ��+<��϶��2q�X~6�&������s�������ҜK<�M��2��t���ecu-���a�ky����@)?�\6�Q��>�G��S��Bn�Q��,|����"꥿�0SioɊ���b��d(e��R��Z�:k������$S�}i�Z:�7aJ�-eJg%JT�M،ᑤ5�t�ی��d|$bf�Hڐ2f,�6�)+w�F �K:ָ\� �bL7L��:d��y�hn�]n��աu	���;-�U�c�+R;�ijә��k�DN ��8��c=!1�.��C�
�]��1D�^�E��%
�&Ո�o����]_p�歔U� ����d��@�'�1���6�6tN�{k��$��H�\��1PW`bl�P��v��u9/�ōx���(|�Sq�M����a/�*�ׅg��s�,�={�n��͉SA�"�C:�c�#��"�I��iE����ez\�������ޙ���a�ʭ������S�I�`�׾-�k���4)BjN� ;��>J��R6�?�T��B/0��S��t�_��?�N�`u���u��J#�Y��<-^�ef���i�uT1cu/��,��֙L�j}�U��R��^�Z���rG�#"��d~Xgi�1P(7���Ŋ��ʓݠ�!ӡUߦ9B�0�1�������X�e�m41�СT��mJ0� �I�z�m�ǒ��N�P]��gU���9�5� ��$xhMɴ�/����UL=ײ`��Bi�y���Nzkx�q"Z�!�U����e{�G��$w�ͷ��&af�.޸a�0�d�6� ������HRL���J�"%�`����t���A�	���1�3ӹ��e����Տ�w�w���io�l֛:ih�Dn���8j3����d�]y?c|��]�*�k��0>F��V�^$�����`��H�u�S���э���&M�Z|N��▪-�	b�3�u[�(�]y��%xh�,���V?@aom���fSٰaH��S-J�l��ՎNB���rz\i��lx��1b�x���)���
6͗i65�i�ӲX�D�^���6��f0���q�Vsx)C�{+��V��M�9lq����Pw��`�y�s���t�ߡ����R$qP����Y�5JSCU��7ɝ��Z��L=vݑ��ٕ�D�FDPʹ�r���n�C.*��+#^f��H�FS��Iڰ܋;��M5ʡ���:WZ	���+��egzOU��@�]xo[���u[�p/��٦�a���.�}�di�c���ڭp��<��y!�z'7��?%��V�oii��7��� i��X���
�J�����V OP����RP�+���g��-�hS�����2s�w�1�a�h����@�s�W�����CU�I�p�����8�4�394�u�0��1��Gu���0���:x]j�m"4bPЎtn��՗s��2D^��H!����t�G/�+��a���q	k5xt��D�x���Z��@��{{J�̖�XfCM�������AA��L�,5P�7�J^?Gn������0���"d:��E5[J����֞�N(�}�Ǚ�8<^X֟d��?���.��GxSs��y��vB��xD�Ym�h��Cw���sz�K���?�uq���~���mJ7A)�����%��u�T�g�P���d�"wY>�e��\@5�.���r�OJ����C�X;����t��i(�(to/�r�;�ݠ~G�6�3��JA���إ��6V��T��Q	��wok���;m���39�蘠�o�.?���b;#ے�F6�S���?p)1D맓��\�pS��r������2e�B� ���:M��Up\~͉�2d0�C�:�fD����r/�Ǩ��F>������F��^KC�ui:W1+d�^ �ty�h��j�Ȅ��s��F)=P0◝�
��{�[�ѕ�����d�{#������j�S;�Є�<]��R�W_���!8�J��\+�Υ�O�kM�3!�72�Z�sf+9��Ӊ�+���ĉ����4�YͺH��3�l�x����썢��ڕ������q8N�L#ؔp�f��T9D���"�?wg�)��:lhu������3(g9u��&�dQ}���)���;0�A8a6Ռ��m ��d#�̭t�-N�]7�?�ӱ>m:Li|ѧ�χ�՞E-�O���Iz�h_^lN����iV���1�7°���E��l�n_��+�+�<��iC�`���iy� `�v��(�,t�^/�TiLΒM�r�����N�����6Z�A�;6��zaƵXlK����vU�� 5�,�?�]ꐯ	��mۍ��>�jA�yS���K���A�^���)B����!\#�)li�����鐮�r�em�ϴ�=)*M�M�^>��N��?0ˁn��:,�>�m92t`s~�Q�;)��މ��j( �t�@u�8������|о<�1��n�t�^�T����p�s"B6u��K>=��  ����|�7�W毋���iE��Q`?�U'ן�T���ez�<�c�<��Q���C���b���^&���9�Sb�͆ѝ�PM�.U��uG3l{O�I�)-�̼��,Ԉ�ېр8���Vb�Z�	.&cA��BSñ���3/ɳV�\4צ��N����^�J��aT,�m
u�#����WW��F34w�`ul~�5Lq�\�^�a�8؂��s��%k������g#���6�Q�?���#����:���V7�P��9"��|�;r7�����}�#����r��,ChX�]�NH�RLդ��n��
���D�����Nt���|�N3iđ�ջy����}wH��A��l�=�.��%OP�B�o~;{�Z������N��e*�~&u�m�<�M�:Ɵ�/n¥:fP�HK�y�z�q�W���a,�S�/���=�7<�-/���8�p�71P��P=��2�Ky��#����D��c� K��ᆥ�J�=Z��p���gQoI����C�E5�����{�3�۷1��4uU%-�LO�h��dɳ�^I��L�9�Gm��ҩZ���K�[��;g[��/��N=�x�q��T���P��7@�:�ю�r���TW��̗�vR���iF�([:
��=��y�\���ǯDdk�NƔQ�o:��՝x^�3H=9C�d�c��\9kv��9�X��û����5�����#AL���l5Mc!7���pZ�����dԩ.5=�&��o���[9�U��}�"82�xeB�Q������fq��b�S����|>~�0�%�\���z�*���U�B�B�}9O{�1A��dQ0���=�8㫯��o�f��HB�    �L��:
ėI�_ǻY�&x��Z]�t-�\��)I��t�M/�?����呌[f�L%W��9�/���Mg�(��s��t�z�: K��c�#}��f�!(��K�<<��aq��yp�<\�u�@�_RBZH�F���M7(�8C�r(�J�-ZG5t��Jwq�q�h
�]��kz�gL	׿����C8��u-�3#�(�%������S3��A�s�(���Z��2�A��f�ƪ~"�<!&Wsާӽ
"�W7��SkRԌ�^���T�0L�eB��(�,��Ɏ���ؚ�W�w!VC�4�1c�7cŃ��6��c)ќ�0�GK�$�S0���b�R8/ȱ,���9�1�5Ҁ4��g��2�o�-Lt�&����]D(l�Ԯ�i�"5�Y��ډc4wԊOy��'!B�aбgd�G���T�d�]��씕��3f�owQ�
����Հ���We���Қ�����|�J�G��{}ǳ���*3V)�'p�Dĉ3�7�p°n�$�`��Y��`#Z5��^)���e�o��OR1�Ru��	��653c�Xh�7@����+i������C��m0~���,��̝��G|��r_!r���_KvpVͷ��!*�;	������3D�<�����8�?��>�C���YKs��n��ܠ����|��1���ȟ��K'e�����i)|��mU=cr�~���8>M��-n�P��ʼ\^�~
�F��u����E���@� Ys�j�q'oB��n��+�iҘ߄��K�Pʧ�u���{��GT��?R�K��x��Fc.�{��a͍q�dĶ�Q���]�Z��?��*�(�H5�<���S-3c��"��v{(�S�4$�4�_���T�g�h�ņc�-��m�Ts:m���(>�Jy)�}M{J?\�/�"��K��'\�*�͢�t���	�z��LT�@U�of�-���	; /���������`^���3߽���\�����^h��r��;��稩+yXC|����!���r%�q��3~H����~���5�c���{w�����	O�~���u�|�8\��<��3���`�ޯ\�s�W���� �q��-��Ѽ�2�.5=�~R�^����Yi��(V�� g���-����>����t�n^��D��ʛ���N1�+V*�Jt)�}�ű���NP"�Ri��O�-��m˩~��GF�m���NKI �����6!ܖ�����V��UD��$�O���	pԿ�fY;?|��b�4
�VB�d���P��8\�
�����*?��A)]���9���{�2�7֛�c>;b$�?2<�$��StΒ���ISVL\SL`3�7��IbĪt?Q���ϸǙMS�*q��N2���wǎ{���mK��t�(�~����>����\�+�5D�@I�c�!u��s|�=���=�F��{qo1��'�E��~dq�* Pn*K��$!Q���9��SxU��3�q�w�'��1Y[&�|��i<~��u��ܪF�ե��S-��'���:��5p�����NX\�5+t�fs0M�`O`�#�>��W���-�Ѻ�����ʡ�ӜZ��vOX<��4��X�y���-4,�/ߧI�m���З
٪Z�wI'j/~]���m�����Y�ݦ"�K���o�_ñk��B�q�3^rT�K�c�dP���kz�Ѐ��o�~a,��0;����x_��Η�fÑVv��6��j!x*�F�~�S��k�[�۲���./�T���"�(�6ڭ;���5�.��dV��fw�99��䨚�^Ɔ��Z��yj�^��jn���U���/���k6X=(�\^^C?�K�Cӹ����bV��	�b&����F8/F��AXx�̲�ܨ����5�ӡG���V1.;[|��ᴦ�)T!��J\I&m�R���б����Y�ͭYJ���/�5qGxz�R���pW_�;o7SX�k{�1��q����3��^cqx����l�U�P��۪k��	�F�}k�����%���#�w��;��2���|%��(T7x�v�T�١w������i�9�W� �n#GU�X�b���������Z�pq���~�J����y��
�j�b�"��_��Dpj}�`��n	��ς��!��/��sMݻ����8 |��,³�6܏�:��,\iI�qi6���Jy^��`%������[��S�m�>�6>KD�V[X \�݈�B�kf�H@�d�"{�^��yt�c�v�ngʵS�>˹�]X�h��aw% ܰ�)�	�an'����.�L��ª=��fbl�R��R��b�&���pt��%��Ұ�|�5��+Ϣ��v�ֶ��/n����շ{�v�S#�z58��@T�@s�"Oo;����Qn�V7�>V�;���qld50�*V����v0�%���&��O߶X[!]g��>d�q��kD�I���f
�D��bI�ߋ�!{k|	�����Kټ�+�Ez� ���8�7Q�7>`Y�T�'W�"oſ��ڋ����
#
�q�@��W�NM��\/-n��p�R�������ׄA�
4=%��%H�@���]�
Ki,/����?*�=� �ג|��`˱�a��q2Xa��Q�Fb�pƉ��S���-^}��z6�¹�/da��Zw�G��Sfk�3��ֺ6=���t|z��"��wmSi\�� (=ւ-8���&����9ޞ��C��Nsb�!rg7Qӂ�P�٥xy�����ב���m�[�3	�$���{��迊���X��m����ʯ"��t*^�X�%����:�G�g�5�T=f̢�m�*��=�{�.,"�0z�[0x�D
��������*-�;����=�*����Y�i-�8">/W�ӳ�$}�-�砺�e7�q��o���+=T��8X�A�RM-��-I��$����ŕ��S&(+�6J�K~��8�1vE����֌��Y[\��/�up�Sv�8�u��x�{#1��n��:�;��ɉF���^eN����g� KIy�2��v�i�{eF�C�Cu؇�Օvۡ�E"�{��=o��,�N@�0���2��Y�\��(7:6B ��� uV:�A���Y!�\}urw��ΙȪ�pt֑.��β:y������ڳ�tI��%r��&�᧰ ��h����5��|o���A1�a�k��dIZ�0,n�f���N�7�=.)�F�G&���j�z[0��T��,n�f����>̣#�Ө�Ŭ���H>���W^�o����/-V͎�����C�NSyW/�&H�jR�i�M/������Wɨj��:�&B+���/#�����8��3�-:-njN�T��&��.*���P�ۚʻ�����_�|i;�/cq��B���mn�"�z��)��\�п�6���R�tܮ�����+��93�\����HJ�!��݌s�#�F��w�bk�r�u��۵�ZG9�R)����WQV[�|�i�R4W�z����b����+db�C}�i�ǱXR�k�ί�q�U�A��|W/���S����8�{�,��Z��Lu����n)����Z����.�y������}�3�����T�9:!t��~�+�	~��O'��҇�S�7���]�n�I}-�|ҵU%��-�ǤŞ;%!�?�" 7N�����\��y/a�B~�[�R�n��
��/ܒ"Ca�:��F?!Z�Kĭ��D��TS����i��.�,MCUq�@�l�|��ES��-���Ս2�h���#����7�`E�%��@����2D�}`���k,�g���i��j�!բ���@!'&B�S�A�����C}}o鿎9���r+N��0�uC��/�~�² �2W3RY�\x�Î�����72C04�m���ˀ�<f��@?$����:�˨O�6#�s~~+�0�JM���ۊ�Q���Yq�H`>f,����F�h�l�^ u����t'T���.���`�L���^\�����ܸ�ٽ���[9���Ϲ�{�փ���	͈�>m�;���U'?.�GmT�V�,v�κM    �Ԓ4U����<��hi�t
�̝嚯�Cd=��L�] Q����9ST
gn�IOnY��3Me���:�>���k����x�����'�`	���^�k�lt�^�fR�Я
Ŕ�S�Q��L��e{�:Y~�.߫F+d�]L����D��[zV<Y!St�HR��i�ޫ_�g�e���� ^���sgu�����IZ���p	�,yl�T��HG��� ]���?K�@B2�T�)4\�����]�8?$���X*�ޒޠ���1����U\0H?*���O:_,�o���t�t0f�`����m�y �H/yŃ��[�s��[w#�EZ0\�Uz�@j�dcDy�]4$�jI�,�K�q�:�B�~j@?�Ź�&�_Q���D��R��c�#v_�Hs.w�Ξ#1���w~���|v'�-W_߳��|��͉=,�Hg�y����?«������|y�Y�؝>��+.5��兰��r�R�	�dn�~1�IS-PY�<��l���C�g�a���J�>��[ %��ÏZ�J��!J]wsy&H	>�j��9��&�R[�+B�Y&�o9:���"��b� 1�8M��e!���jP�5N��c/xs7��ʯ��<Wǈ�8�t�s(x���F��ǈH)@FJS��"NvE�j��Uǜt�Ad{��+kH5c�,ج^�Tk��i�-�8���Q� �u��ǍO<D9X\؁
��o)&h֔7/�	$��6�|W�ڽ�0C��@0�$�»-�9v��H�`��@��~�#�^�P.�۔Z�I��_;��g�>f�[I�K̔3�9\�{{I#���>�1�'w`��u�.�f'.����#�8n�/��?�a8�+�M��$��ū��*#C�c0<����� {
V��YQ����tk�����24ez��rڠ��J�/e�߸l`zC��:�>f4�Sَ�ǿ�`�v��GG��H|�)
�!F��%��y��������)����cU�c�y�������i�a�OH�@=�T.�Z�;�4�h1=�eCQ�G�wƍ�O?���`4s��	��6 �`	Nժ�b�	'WP�m����np�v��`�5�F��o�q �.�o{�?�U~��C� �����	/��+U-�_S�n�"���q~8*8TF ސ��^���}6Ɗ+z���iP��`4�.��R!�{`��KB}]R�ėZ��(�֍@��C�W�����6�P�0�D9��K9P�/h@��Q��\m�aGUm�t��ȯK�T%{��:Q�X`����G��Yx�Ik4ֱ*Z�����`��9�l��P����	����HF"I�C}��__�H���"6w,�ӈ%՞�S�_E?���GE�~M+�ݙ��ʨ��t���q~_�U�jn�֭�& ��v�7��L2�a��;�~�m�WsR����c�F��p��_�|�Ԝyƍ��<>���8��wc�4Ҵy�s���1������t�
7�3w�6;�AdF�O�q\�84�V�j%c��,��6t�LDN�-���2���3i�����J=��RȄ��h!�B����.�s�U�=&y'�[���Te��15�b��_T2�?��� +j"G�(}�f@��C�Oy��ڏ:a5��Vgꮐ�1N�%��c��]��5.vY������gpːI�k�:.Wߕ!렷���F�t��Z���ؿ���׊^���D�����R���ĺ{���Sb�J8�n}������k.�F��8���j��a�ps9�u��g-Q����G�G��l�7q�Q1b$�p�O�-Pޕ�| �'��-Pg�E�A�!.B�(C]�o.
�f�ŕ9�z|c�Ϊ4���~���F�{�$us7�����q�-$������'����V�lp�K"Dl��f�z�?V��f7K���<#�
Kn���4L*�k@������fF���vQ2ݸ ��_�lo�Ɠ�"�iM��fB�Ôb��hZu�����s�D��޸�,��Ϊ;���8x�r�q��M�Hw2��aN���t�T��g_��\d�nw|�:t����+ M<����x����2���H+�y��F�d��]����\�4�F��8�Q�*��t[��.��Q3N�=�V	�psm<�7,�����erkq����T�;k@"�0}U�r��H�������:��d�3%��l��`2��(5���!���sOq,��/�9W����Zʤ�*�(jmГ,;���,ʺ4ןĻ+zh�5+6���`�X#!�\!!�����z�U�$=�F,Xc [�`�B�>��C��Gn��1^� #���Cm��F!�6�Kn�=ݍ�+�<�3<�/w�4���/�
��|�|l��H��=8�y��xWł&f�o 1l~�8�|x��uT�`�4�A��0UG���$�a���<&��Fi���6䭃g����϶0kߔs��[��;j���s�Z������p7��%8(�H8��b�?\$o�:/� �C��U�V�bp԰Z"�e�!����y���m���d��{;ι�l��d��`뻡���dު��k'�(�u�"-0�e1���n��dF���`�w�iX� /�`�d�g��X�L���f�f�"��uo��d�aJ�WE�Gy9�ֿ���7��F�]��d� �����MU�l�8�����Ü�
k՗	��T>�;���4����U����_&d:�nB���U<�D<dI�z~JF�]��뢢��c8Hy*�{7�diJ������
�A^�`(S�^}we
��%�l�Ϋ�
r��¡�N1�S�!
�3^h	>��	fw Zg�V*n0Xb�a�"�����8��!�u�,M�\ȭ��i��W��k���f��9I��.�v1��l��b'!a�N~�b�wm�c��Ud�$B3�W��3�&ki�z$�/9vS��?;'�R�-ζE(�u(	�i�rO��s��%�w� 1�vKftu���l�v�a��a�f���j\l!L`��an6�;uN��0����2�j�P6_�>7�e�y��4=�;B�Dh�k����!ՙ�85򢤋��G3$�T���P�5&�!�Ԫ���aWt=$<+Ă|sR�L���-�|r��n��z��Z�+Z�����,�R<pֳ�-�W��~�ߗ�.��S����nљ�.��|]�!=��s����z��P�_�i��؊�x���Z.7u͆�lgy�:�bV���yx8��0wuR�����D\F����$���Γ�s[,�����;�+K��N.�Z&ͦ{��(8���u�őrr�x�w�'�XQ<��g�7(�(�9xa���D����T�2@�5� ~,S����V8g(�bܟq`��'��Fs�w	G/�D���HUI��V愥Q5��:?Yj���O&���P�G�r��h]{ȗ2ҦZ�m�\'�e�R��ti���:�;Ge�fg�K����f�K�4s�Nw�W�*�eT��f�	-8�u_9�`�.D��8�e��9�=��O=�]7�!����ѣlƧi��~�%��Q�$w`��|؞� r=�E��|�����Ymy�Q!z8(�P\Ջ$��t�6��E������|?e�GO��>z������W����k�	��CN�<�-���)G*�
���#��	�V�X����~���3_{P��q��8x�a��Š@J4��˨�~�Y��$�x�ɂ��,�ȆQ�V=h�PZ�G��a�e�"����A��4���QV)�xșF`N��mV!�b��U�ױ�"5� F;��4+^|m��Z�R}R]TTs\�|m���i��5�Uf��f��=�4���=y�S8��U���ٳB(���k¦<���;�������ł=�5X��?'�Bd����JPe�J����nJ0��3�paO�~��4)�p�<S.�5"?�/��������"ۗO1/��(P�!x��\��֒�,TC �K<l��h5�YJ�^�h��w~����<iwM_ݺ���}�ދ_�`���Ab@�,m�.�do���pW�8�}i�+��Ov�������]7#�    ��KJm����MĪ�;���>*��1�[��4��n�O4�ܮ����D|��/J���f�?Ǔ���⮝���ǟ�M]ZR؞G3�G�cQ�(�S !�*9�{dj@�6v�<�j��px-(�=��}c�|=ō�1=�����|����������(e�ϐ�"�u��tnF�_T��j�RRɈ���ڲ�!ù6�d��²���8��7�;䡵�P�b��>۹�'�D��]ꘇ/�i�������oe�"4j&Ʉ�,2��-�H/rZy�J�y*%��W�0�ek���p�556�۴��oy�m��.�,Z�>��!gk�e�^�չ����(j���c�e8o�S��Ã����%�i���8P�*�fZ'@rn-�+�:��V<hw��"����LEU
�?J��ύ�>��츇2��]H'�Ý�]���!��g��W|[/C�T� K	6�F�8P[���+ۑ;, =sOn���6���,E��C)�C�	S���\a��6�G��os��Q:��28�u�s�B�["i�1���4�ӰthR��C��b�[G�p5,��.���������wHT���>	�qc(o�ؚ�L�M��3f���g���O.�I��m��]�ƨ�hl:��wA!g�m��H.jq��ӝeL>����ei��q�>lG%�_�ۿ����n:X�f*��unq�C*��+�����>�a������:7|�����b-h��6��_IU?�ޅ5G����Z���|+t�ܭ,��[Y���埽�_��oe�'?��_�\z�)�^�L�l�o�ZV]�4T�����F��V�]=Nw'&�5�o]�������#m��c\�8Z+ު����|�<26���4���q�p���̵�Z���7���%��m�-�T����ԵCk�'��"�i�yI3�!6W	�
�6w5��|O3GF�靝5/�)���̽���������
v7�r��H��p��������"��wRU�v(���;����k���X������37h�����W���J���i�4���)6~��e��^��X�������y��,��]>�=rDGYX��U��vp�s��Gx=�1 �@2s*�B [)��\�����Cɭ�p@t�<v�>m~��ʡ}�#h�� ���!�����M�Dܒdf���
KIQ�A&w�"�<Qa����X�{%s��ǽ�f�d�'�$<UU�c�н�����Rh�W��:i[;L����N�o!ش��z����{*�	�S��k�Oi
�yb��t�a��e��B���o����'5megBd2��!����V��*ҎV�T��p�)CQ�3S�R^��
,D��� ��i0�)���]��3bQ��E������sއ��t�e��b��1�T�,�/iW�I��R*^��I��WU,��/�,�rI3J#t�s�P��/��.ΐ��b������6���^��ڱ�B:�� ���~o�;�q>�l4o�h6Ğ.˧�8|�Z��R�,!P�7�����g����}�G�_�zAD�[v>����������
ֶR�$��`V�z��[0	�p�rF�����+��u!�^��q��j�.-$&e)�Qk�4��y�j�g#Mv>uO��4���'�����5����_;\zD��N���9���N����a��e�y<�jA��ڡ�/R�c<�}�/D�}%�5k�C�6�],5M~�����S�C�s,�W�|����
:����|����y5��>�^�KX��Z;��Q��>8�@r�tX�
��d/:`#��-���4Q���l�N�p+���ԉ8ٲ�����Ty$�`0�����F䮶�7nH'~l̿����,��=7kΉ^;���X1��������u/a]�3��{���9p�9�E�!�3=Xk���z��c��by���
֕H��w(�l�hqf�gB���q������wvYSK��7)u��3UM�k1��-�������HE�����vX�Xn�m��ig�XC�MS���1��%M��I��Nq�������2���p�P��<Y�?���_Dy��S�]M7:-KyƎ���0�LKy���ʒ���R��J�_�Sto� �� B�n��r��|K�׾�3���K��xZJ7�(t�,K�$�vz�	���:�7Ej���R�S_��H���)E���P�U���S�o�A��1ZN����G��ry��"L_������Sa�B�[�z�{��Me8��E�B��X��P!?��@Sp����-We�ǁ�Pi�F�^�cqs���B���69ըt�+���p�P�����S���[}��V8��u/�ݛ���M�K=�j����W�i!���:�A�/�:�Q*u�N��E�9J�o�`�'� E���,lƤ�u��_4K]�q
KDL�Rn0��A1�>�i��<U�1�+�(0���&{:��ۉJ��i����"u�׬����C�ob)������	�M��C�K��򠱟�}G)�y� 4��� ����聜3�f�9�t� ^�Q��mT�2�0jy�Ӯ<S�Z75+p���T�d^WӺ��K���n�f&�@cn� �u{���l�R���Lu�X0��C�2\�M*N,�Z>ڵ�
���RQq������ P�m��Μ�.����њ܊�3��H(G�ub$���ѝ�d���݂J�\GT� a��2%�EA�"v�ɴp@�V9�q�\?I�$o��qx�<�������x=��	'�n|��ؙr��Køe��H)>��U����L]Z�Wm+ � :��ww�PrӺͪ��mx_�'p����?�eZ(�ܠG�d;BlKQP�ՒS��u�ϛ�З�[y�G*zj�_("қ�`:k���i�\����n� �Y�B<"݅6�i[n�c�k�cTp��:���0NǺ�%��)�h�i��)�C�e}Ū%z�o�w�^�el;��S=/bV$�����%�����3��;\h�����.�+ڡD���@�z��4"��G��'�;?��~ԿuK���Z$26� �$/��حr&2c����N�p,�O���`H(i[��n	8�F�R�ٙ�j*�<th����0=LE�!���izF����=���	 z���S��X����n��<�����:�9M�LxP7�0��0���:�Z�|2ͧ�������ZFz��s$��#R�lw[��B�ɋ!�m�5�
��b��&LX���.z/z)ǕZ��͸�z��̦{
������_�szS�R���R*��hNi�8;��\ƀ��ƭd�Z���}5{%j�����[��u���L��W��Ɉ���u�=#�bg-tƹ<�Y���:]*�`��Wu�Ė��/�
��!��jw���o�Z5<��-%6��� \�!����E�����V9A1�)x��z6U�Y�Tr���\fĒ�4Ԯlw�,ŔZ�-Pq>vb���tf�~��j��	w𦫿m4Q�,n�h���OGIj�%�S��#����d��P��&@'D�<Sk�HwYAw,���c�;Ͻ�\��f�e-�b9M@�����(��`��OV����6��RNc5��_�"��6�<S[��H�1���ކ�M�ۆCY虊�VY?��wS����SE)�?�i�	��ooRY��O[0�R���r㝓����#q�2{#f�++��Vv@/��_𶑌�RB���O���vA�_��]PQI���bq0!���v3�����W ��ⅸ�I�@��-�	^� �A5�ц�O�<�ƪ|,�B5�1�c�\| �8����N��]�y*�&̌(.�}]�����ǅ;�5�Q�KV�p����7A�m��aW�f̑j�_ ���1zX�Yc���R�o߽�"����j��;�>?�7�YQ��v�f)�����y\�%�M�Q�6k��ߩ����ۄR���<�I�n������%Vo���]�$N�3e�W[�6`�U���IC�g�g�����re�bտ�;��W�*K��    ��kr�9tol�]�Z��_������T�?ד��Ӥ�m�q��Z�� %1	�4�������k��O��iSʮ��p
M}2ȑq�v!�-x��Coz#	�{#��և ]��8Rm��#H�f�z^���}��U�7H�*%h��ee�����2�2�J�B�.��Д{��%��ݫD�w�j�x]I.տ�H{w�3�r\FH��0����:խ �5Yq�D��
�e������ңבtW����vk�s�G�kz=��8��(�~��r3�uZPD֧�P#�F��gҏ�(_� �[p����W_ǵO�&�"�zk�B�d�w���g�N2 !k{�u1���2T��8�_w9[ *��o�?���� z�	��)QK��r%��eM���É�o74Lr�葬<�%��\}�%�)W��ە����t�1gHͻ�~���x)�@��0���'B���9��g*�<¾У��yU�۩�$����!����'c,�;���R��=X�)�(^<J�����tV0;3�c���ChCb' ��H�{I�*���m�)�S�F�f6#�j*���٫�y����}z�a	E��� � ��M��]8�vp'uWz�GHv*�8>�mOڧ��[��˓JH���%9�EO���4��K0zK�v�tr��"�ma�����庿(�y�����ɏ��Yv}^߉]|���(�;,v�w<�N���ψES�^�����i]�=��Rz�x� �(�VK%��U�6��V��!K*��RB�3Q�R���?��b
�\S��SA������ò�!#z��B��o�R%�p1+� ^p)�3��ma��MO圇d�Qb�����I}�4��C-�w=粵�⯗))�Ĝ��F���y�R�G�<}[��B8�GF��{�MJ����m]XN�	14B��#������\���Q��w���Y�f]8��u �i�9$�)C<�Y�8�ҩ��N�S�t`z��]�ͳ_���i\�B�-��$���}��D�b���.�g�M����P�f�T�F���a�"o���4b�ji
H�����N5��+�}��Y����3�c�sYސ?=�3]E��cUa�%��J9˺��j_{)���nVSv� R���U�����&��)0�K)�qWu���'�4����Cd\),���=u��Ǒ<ef�M��==�ɿ ���-3veIt��4��e	}XH�F��W�{���,$�hQ~��ɣ:pP5h�h�����p������'�r[Ⱥ+^!�J	�d�c�,���N�A����%V��0�����p�#�Ci���%(Ys�cO��d���Z���^_�P��Q3���D���5ڔe��<B4�V��H�E��R� l�s�~�VUy�y��a����`���$y0Iw^��V���Ar�L�+��,h?R?�N���FJ�o<Z>�K��9Mjr�۔��[i�h�(���tO�8�*a!��1����g��v���{G�Hff�$�qԦ�|�>�+8�9�A����:i5B�R��O�:��Z^2N�o��]x�ĉ��4�`d��9@��;��P�6y��s��x���� g���*2fa�F�]��
l�ٯr�[{���7�v��q#����v�׌YC�����������������_����[`����-v�p��r�a��z�I?�q���3�J�n_�&�3n'���956:`\����B˛P�y}A�2���V���e	����F(Q,yZH}$�f�ɳ�%�q)f_�_�ݣ����g7n����ڬ�u�'m���#l�[�6͇�SR��9A��8:���k���.X\�[����
 ��6;�gY�[_�0_��	ڔWX��XX�S��Ya I���+�Ŋ�i�H�h�I�Ǡ�����`GH�y��5�!_��\��?�r�������x۾3�4{��G<4�����¿?ٟK�S��qچл4�(��c6�Y��&Գ��nb��n�� �O��L7A�3_�`�w����q�$��s��,6���U����L��N�p�C�6׶�cG��N0��;1c�[���I�7���'��q��c���Ο�L��a�X��yZq�M���lgp{GS�r��t�B�*W)<�ac�R.pJ���XQyW��~� XL�<������ �0�5��Ub�t���U��s�/����g���6˷'�xkY;��e�J���
���ɑ�������dc[�9��˃�a"�(�X����?�8������3|L���C6^u��h��e1\�ܵR��2�:�?����s���J�O�T���C)ǆ��4^�$5(���F�d��dgKb��A�`�>��+<:&���Jv�t�2ZwR��eY��^�8��[��v��o�����8]���τV)�n�^Ф��61�O�(6X��̕=/8Q�L��9y�n�L�>��{GkK���p�W�~���Is�d�;�������.����0�{���X��u�	
Z���n����&h��FM����䂤�1W!��rR�;��|�f�d�A���X�c�C��0R���CnM@�����B(k��{��~���|�+}N�������i{a������G��]3c�xh�3�g���I_��;F�8b �{�\xD���K����m`@#:�2P'�,g��F��m!�]����%�7��hq*��T
��4#+�,�`���r_�������Q�(;�@7�:k5mS�k�v��yd�	�}.�)���ۃ抻�jB��8�����peKXo�oJ}����1���G+e/Ǩ����Vj?�~�?YO3�a�좳S�'sg�s��5�"��+*G���)pծ
F}}�W��xC��)U`<�d�a/I��D�P_��D3�KQA����ML�[)�Z���a/O�d� ^���0�,vg�Ym��Ω�����o�tm�>z�G�{�����}���&�B�#W_�kq�������?���za욍X��c�.�J|�X<�1�����p��~)�1����d����a�Z��@��<!fe��V+o򾌒��nM}e��:	Jo�^����Qߌ�SS=5r��0��2Z��*���D��%�g	�c��ߦ1�5�������"������P�j�۽�g����	m�C�8�-�4���8�7�M����N���	!�C��-�t��K�����EN��n�S8�jkP�
�:qh���+���:�~��B��_�T���w0xW^�]$Ww�/*�LRoS��J�ѻ�!�y��_LXS��竏�w¿R��G�� q�d�o$��w¶��4w�����Ԥ@�h��fi�;dE}O�=��f�la$�q,��ܨ �1{ѳ�4�����<��Y�:3��n�~�l���q�����55HNSp5;�Uۧwn�*���`7V�OR���N�'WiTG�����^��]�	4e�kn����J
�r�J{O�
���cJ��R�2�W�H���|���p�=b�����%������g���ݼ0��z���1q�r�i>��^�4T7����U�~0�(�W���o�F<���C\�-&����z�%��B�^)%��!B��k�e���i��l
�ʒ�U�.��Vh�/ƀ�cx�8��5���Cls8�i��H����9!��E��}��}�Ӝ!��SA��Ї�gu�U�?	��@zRȴ`�G��|�ݴ���Q���׼n��Q� �s���D�`�M�fV�� t��+a|��C�[֝)�d��(׉�j<�
<j j�rR�څ �N��&�xwݱh�'�\'؄+�!7����p&{�ݷ� R���f*#&��I��%/X���@-ly�A����` �Agb
����y�o�$qz��.�Ʉ~������}#�m:`�"�U��	���|�⁊:��u7x4(.c�,9Ҕ�~��J)���/�*/�y����oF�5�S��<A*6]&����׬zIm�剏�)v4w�&'�V���d�:�tc�׌$K�qX_�Wx�^ڌh��;D&8�u{yS��m�#^`z���a�IQ�)����� ��±t    ɹ�	&8�U��/q��12��� ?�`��ܟ��)�O����j�a���5��|��| �Q�	emp��y�e���f�9����T�Vmy5x�4�����T���w��}�p�*�9m�g���Ғ9ANUp�-_��_�8;/�$S�%�1m�q�
�s2���
���u�_qpH��&��kn)���;҉7aSd�tu�UB�K�ў����\kia�&ȭS �9�ҌU
]eh!�z���ǯ�o��?Q����6����_-+w�e���cٱ�Ě(-N�9�ךJM�#3�a���Ξ��pO�������Ր�M83ϫ-_ ��<1�b�t{��>۱htM�$�P۩Z�.�B�y(����Z�2�:�?>�.�>��ΕF�x�H���D��@"U�\�A��-�"a��(nqD!�Z�]�jZ
�q��7����k�+���P��NZ�LkB��Fj�ٌ��zћU6�/F�"�Kȕ9�,�mK��"�5A�bͤ�r��Q��:q����`��{��*�&�������,���+�u��+ S�3��RG>A^���q?������4���H����edBP<���I5�V�J���	������!��#����t��Z�⯇䊼me>����<�d[�ff������$�I�{~�Y�*�G��T.!��foo�q?t<?���l�p�8,K�wo�;��N�-�jH	�X�I�Mت{�r��d$	�N�d3����Ƒ��sk���q�>	�\^3��d�f�I'��*��
�W�h%�	����9�wE��<*nш:�q\z�r�'U#K�`�}�!D>f�ȳ��6�=W���	����}Y�H8��M��ʈ	��f�$�;��͢r�@E�����M����fz寮�
�u�#?S���c�����a��>17n����s����+zw3e��ake;A�7�T(��l��'�&��2H�6��O	�Ѯ4�/c��#J����Tl�E�J��v��4�K뢍	6�F��T�~_��P�TvN��-_���wJF��'颰;D�q���
1��ف��ԃu<������BN$�nv��:F_A���r�$�6�b��_XgH�U?Z��k$PK0�H�XF�M��7�}�iNirX?:�O�`����T��5�k�WS�W՜V�H���/�r�Ed�t�	o3	B��~�8����-u΅4,���Y�6�{�������'�F���4r"�C���K1��b�	�s������V�׹�ѥ�_G����-`�EO���&m���隨�����P�,��{�FA�03.aR�Ӧ6�f��`}m�U�s(�����ƒMX��-J�&�C�$�����J�w��3o6�n��jq^��f>�=���!3�����gmT�a�Q[�����P�2�=}4.n
��T�Op��	�g$�)���1Q���%�O�����j��S�i:���F����i��(���/CGɰ~���	v��V.�z�_��1b�jr�(��6/aVM�v��P
8���u�I�-�1��O������Q-
w�w����G3���Y5��;�~�f==�#�^=,v��&�.[Nj�Y�"�JKz��o�#	T�j,�,[�<�e����H��L�<����I�7C�7a�~V�Zȍ(-3d{Ort�N������q�^�:��/�I@V����Ѯ#����������]�F>�~K�?[�y�+�3���R�$�n�B�1E2~��tξW�{M�DSA�m�/��c)�rm/��es*��q����,ݖ�&3��%~�d"7�֦� �!7,X�p�����N�8�6�J��m��g�ʳy�loH7��T��Dc���%�˻�8I���(
��>������2��Ʒ�J������<�Κ���NdJi���g�y�:V��NL3Î�����4TkJ8o�@ׁ,=�Zn蚵�P��o4C�4Cy���EC5O�-V��JY��R�2���b�L� �N�Ǜ���n��b+�r�\qBJ#��b'/�uލ�Ί!�tq�u�]�I����d�oW�b��Lsm��J�Z��yQ2$�#��\�w'�P�B�-̰��ؘ�{�e1H��Ԕ�!EIw�ݹ��R�{M�6C���[悅��K��P��Y��,V��2�s޽�1\�틛�t������ܪ�<Zo/|���%�p^��A?��lR�3w���fQJ����(�$`1}������O:y^�:�D�E_�y�6�nU���<�J�ΰ�7�؋f��ˉ��J���h�2�a�������>JJk���Y��\�i��K�VY3�.���.2��݊ʹC9������]�G�bO`o���Z8�@�f�`c�$�B�p�F�T�tOE)�Y�b��,p��{�7�Eun���P�@�`�"����T�=إ������!���Xk��~A켄�d�ܡ�[����3�D{r��͌VbL��Ξ��B�!Kc>Eu�-��LP����f(�|"U4�R��}=v�Pi�����>r��|K�����x#�7*Ȫ��S4h�H��d���5{�T��7ؗ�	?�M���
���ŗ
	��>�Y�k6Tԣ�$��SN3x>!����(Ɓ��_�#�W<>&�E�I�����������NTY"{v�����]��b���I)��!����j���j���:{��aGpF�Ԕ�Ǟ��Q:�Y���DҘj�sU�_����a��H�(I�WSN����U���%�y�e�s����-*����V��6��п
U�8�.��O����Rd��cf�`��~������ �辏41�$��5,Y٧��2���5�����US�g�c�qr�!��F`�n�_N��Z�WQ�<�ZC$�[˾��+Eogi�(�>�a蕽L�h�E�X�Y[p=�/����%cͷ\��+�3�MHUK(չ���{�B���=wX�8;�m��`�q��C���u��O���rB�}���@�A�EN�&��5xZ��b�rτ�k�>�QDYi�MW�tBΰ�p_�?������L�^QB�;��%�w%�:+��6qL���|ۈ�n[.��$b����-~F��P����b��9�o��8_�3"�4w(ሓt��ȳa�v1:�0a��� )),u�VK.�@G�J����cf{Z��� I��G��Z��{+�m���?4�G��4��_�
��\��F"����v݌T�fԔ���d�`�.㤨��X�-��cJJΰC�w���ϵ�6o��v�)��gء[�~��]E�����ytӒ��Q�L�}��R��`a[n��~T��n ��I`zf���RX½�_y�� �=�_ჴ>�� �}�ũ3�]�ր���;l�˻��d�.��D���I8H���6����qYT��v���4�1N��'M���ç�34��iU5N�=�guI}�O�����-������Pc�7I��P�ܘ��a�z���p��I��G<�4�Y5�ORA��q�u�0��X%����"�����������ވ�퐹���Ⱉ،�ԏnn�:�֢3ha�o����.p��V�>�ab�ZNxۡp�T;u�n������Y�!ۅǟ)%��2����_��T~�y&Ǭ�"��C���q)晛����&��6�e��[��s��av�ԴJ L�[�P��r+|>���6αR�y��]77��ː|$��|W�$�s��tn���sb>V �ʪ+�JzI�YD��`��N�"V��O�������-�#��uF�+����	��	�|���,�G�O�C@GU��9�D���ҚN4},�$���Ȍ�Y����˸x���*:P�|���9���J���~3O�fSxq��3"P�sۺa\�.w��˔�|�8�L�=�)���_2T�v��˘�O��h��lC�#(��$�"�{T]O����ijf�[����1Ćv���-nm��"w��2���(��A��8cI�Z�=���K�UTP}-�L��j%I�����+�1���<x��Q�>P5��*·�y�i�i���
P�y���x��u�G;�����"3μ����    ��L�Rf��yDN{
�!U�4����fP�dq�3#�Ȼ�������/Ό�z#g�8�=������� ���Kn߀�w;��s��	t�J	;�
i�ա����]����P�����ö�3��u�'Q�'��o�M����47����7~����⇸�������9.�9�Sf��SG�BF�,4#m�XA�/���Cc�fY��sC���c�ԃ��5��+�����|Y	:�F���tD��)**_/�G.�ߟk�E7(,�W��6=�ObC2�_��`�X��u(I�z^�ηŽɑ�����DT�YM���	s��C��#�F���TCD�M��?��Ŵ3��;f(T���m[����T&yXܹ��>D������v$}^jEq��o�.cy�If��N�؃�ccT�D�J������.c��zͥv��U��y���Rc�l�,'���\b��fN��4�9��a,@���2���J�װNˠglXLN���<��k���]�Ԧ�X_�*�:qw�;mΣ�E�4�-$�/�A7{�n*K��NY�-62�toG';K�~��2�[C�P�Pw8�Ϣ��!����]-f���[�|ǜ�}�*����o��o2w��R�{���ٽ%1�O����߰J��kƃYbém1���u����Ł�sՎ����YCn��̐o~�=���9�v��^�a-�0��~������)���t�F�f�ú,�����MU%L�akV��Z̏#$�C��2�F���+�K0I�w�D�P1)L�?,�iH���Z��5_W9��I�n1�IY�ŔyDI�{�� \{B�� �	3��T�\���f1���<�ިWu����F��˛q�����ӛ���f��s�ʎ,?�� �5��s�l�ߖ��M�jOD��"A� p��\U��4�x._�2.�S�2�b���T	����`r΄�v�bL�D���ײJeڮt>�*�Ôy�x�*��թ��LI��Vj�s�,pyh(W}�2or�@� ˲�_��9�KQ}j�Xב��)l�o�->��5,Q��*�☢B���Y�de�e���]�j�E���� IRb�U�S��V2�D���j�\�{±��X�B������s	Ngs�3V�k��4�Q��-���Z�8EAL �\8OX�R���6���D�1��$γLEEh�j��C5�M`%:�B�m���#��v����ZC�+g֤���DujxJѹR��R�Bf@Ւ2�ʗ�������rC�k�� x�<7���Q� KU�� �jԧY���$EH����,��&ė{���.�x��ju�rՌ�N'}���}0��������)V] ���)j'P�0r�
3��!�
��̴d֩�F�dVH���0h�w�$3a�f�-U���D�<s}��O�2G�׹��v|����B�7m�%�>]��@���)ݸZ�9�p���z+��g���H�GsG�����o�,������ʌ�x6��(L1��E����Z�c��ܦ�Ʃ���Bǈ�g]�s��@}�����ʧ��^m�$�]�Rx<���,k����D�$����*�H�2��J���,�����!l>�dgb��&��<�_��ʮ��� �k�V��˙]�E�j�-§\�J�E�F�0�zه����Z&��<宓we���J�쬣�^���8���������Y�����=q�[@�*�e�q��ޔr������H؞��Yg(GM�-cw�HT'ga^r"�Ѩy�ARQ�N�I�,��=�6
���8ل[f�%p\&�IW9��J���}Ya:;���#,��=��YJ��������|�Wa�8����ܧ��_�h;��I�W�c��vZDZv�Q�=�sq��	}Q���%��ہp_��0P��7����lD	;�J:��{A�[�B��8��T��R��V�5O�A�b�s�����_F�SU:���%�O�!����ס���{�k�].�����#]}MܙFB����g����zE?'���Wj{+�㱘�;T�+y%��ap�������ԣ�8����>H�F��b��Cп2sQ@y��z���%�O�8P���:m��h��_~���ɹ٥ �!�S��X��KQ@��'���*)��+��b;�;^�*HS�&�im-�LEu���y��d�3������S��*�6X�jw�h�^���.CTt���xO�TG�Em5?ܲ�SI~�.�S��VE�?3i(}{�COӴ��	�&1���ɷ�������߸M-G%�\���u�X�9r_DJ��EѠ=��v���6�m�.��6��v4�۔;9�i	�6����2F���������+/Va����\�2{�-/�d@#Zr�������Byg�>��ƾ��v�.�8�����8��*,:�'n>���c�K.ay�;"��s��"O�ssFG�?�h��sDIO�
���c�}�9"}v��U�� xZ�e�>5�EHx�K�˽��kv�tGh#[)x�ڬ��wZ��4��3�[Psy�q]���h�eX�������X0z�u�e�"����Cg9� }�dEb�՗�Coﵽ��A`�*����-�/,���~^WK3�ԥ��F�=�v .��Ҥh�5�,L	�	I\������Ây���u����g�ݶ��B<��~����n�,���G����S��7�������d
ނu��m�����k�9�!���\�a�m�	Ui�lGt���D�i���,i3�����b���Â���6/y�) �Qd�b�KA��4u�P�y����cg�X<�c�4sL"�Î��3�!���ӛ���_�=�s��3.!���n{�*����z��QSڶ��)�1xKR,b�T8}\	�rN7`k�Q#T�D�'$[��rnh�F���PT�f�>8K[-_u;p����:��
w~�A^�$#\���E3{���n.zB A~���F5V�,4�N�����M޳�td�H0[��̝�9�U'BE��3#��B�:�5�8I�Z�RG�T�:�&�:�8YA"8S�t�8�.{�k��x��.,Yʼ8�������{�`3���LЪ����� O"��0��U������{�Y����4\G)�uP��+�b�s�4;����\��)�(��m6�(�X�*�5����Y�5Ya��q�ҤR&��	\�c�]\�
���OuVv��/�8�|XG7�Ϊ�Ͷ9z�v����Ϗ\��LV"&/����{�]t^�:L`2���,ŏm�a��{�,�T�x}�1�W�/S�tQ��4^�O�{����dw��wu9��\e�)%�Ä���d������[��)x��ٷ���՗��%���2�B�z�`z2,�����^�f��+��	��T#ǩ�y�=�Rc�����;;����Ͽ��	ՑB�f;#I��	GrY��9]C�0w��|� �5�8͚�w�{��h�gI�z�qN�<4<�0��G�`�B�4�9�g�o�Lt��ap������S��*�� ��	%��l�i�QϷ$��*k"��ǋ��9I�������ᮯ�kY_���2�i������0�N�Tf�|F��"j#�S��jV��=���+I�,�J`6���E"�C�%h��l5�KF���~'���`�~�o;$?$|n��թ�p"鯬�"�`i_}q��mr�H��%�=�v�x��m�DRb�X;�Z�����Y�q�!ˡ��!3�I<qH�5f(w��6#q�TZا7��c핓���I*�A-�t��jI�K����,d�ϸ���E�3�#Rc�dt�"�X��/J�]9b�-P�;�@1���ʣF$��(�������x��-��E#���$�����p�Cdi3j��%]� I�9/� ���b���HNnP�
��1qRe� 9y���rƒ�J�G�"���1$Av���y<��jzk����.�Ky%!5m�������������*Y�D�Ll�<��~���ڜ��0�t<c>2��Aa�3��-bהk�cf`� [�"�5�3U�,$,��k��,;���2��    -����A��Oؗ\����4��`n��sP�8���?��4�KI݅j���ľx�p�3�F��E�MF�4:wVe��IE�J������>��Ϊ���ȶ[�H^��<⻪�#F��5�V9	�����c����p�j	 �y&ߪ�Y�g��xT立��%���ן&�h��Vs��<Kq�o1�JU��0Nᖌ�:H{f0r&�e����lD�_�S&�X;�rG�������uj��J�@�Q��$�;LP��_i"�k�����'2S���$�����8��,y�I��,y���l���@��B��I).��� ���L�9$���H��E��(RW�8��48Q�v�>e$V#������)gͤ:�p��Qz!*Q<ϧ:�]mgz��[Ř�?�P�d��R�����7�c6cF��X�p*��iH�����kS�����xS+j0.X�b��qB�J�FC������	Յ�&G��
������2x��k-�4��	�:���@!F�r(B5�}]�4��]]�2)�f"�7��6d6H�2',��x��kF�/�p�v�{h^/��N`���B��ӈ�4����;�'i�����v��b�H��D�Y��a	����ƙg�,��!�۹�G)�>�A�:>�~���!kJx�jy;���B��,:%�!O.�
��d�I;�2����p�nwQI�*6��u�|���;�Pn.�!�΢�X�����KʈI��3nlx�S¤�/ҴҢ5�dY1N���M����>�-��*����/(�"��[�ܯ�"v��<�H��,��gD�x��)W���P�0( Z>�+t��ʮ��������2�E��[�L�l�4J�9�c(PB8�|����G��d�gq{R9�}��3�H݅g2��N��r�gTۑ\���diҹ6�/�v��6{nfSF xd}L�*�d����?�"ݎ�[��5��y4��C2��n��ͫz��6��zI�{��{��Xð��*ʣjxҬ,l�_Ts)@�	���2 �Cn��,�Yks����:��hƸ<(�[UL~��#��z-K�0={�C�T��?�#u��6����2y�C�4�F�iкn��hF�-��5y%�v,�%�v\d�%x�^����~B��B�a�.p���r?U�HbQ"s�[p[����)r�&x/C�2ϫ6P7��li�:?⢶nB`qy�$ގv�s��u�r�'�Ŝ��Q.�Bkp�Ʋ� ���ֆ�6T,5LR�-F�b5v��Y�3*w	7s���L�+U��u2^X��㱟�G��n��UB��f�W��x��H2%�{\S,dYk����D�L!�<��͈�����C�O���!�A�G�eYR�	�u��pC�d�������������Jϻ����'z,��Aj�}�f=O9�������dH�aW�z���s.�L��ɪ��������]�� e"�p��=}�c�)�"!�Tyo���~�Z����Ov:>_�E�
R��E��aZ��:��p �����(DI��X�Y��y���a�si��[!��k����|�w%,�?��r�k�3w��i(3<T�eDv��E��n���;`0Uc�;�~����c<
�{֚�ITA�����(�u��j�^�կ:��;|jB��
L)��KJ��W�7�`/j��DZJ�q��T:A+�ߡT#x{�����0v��=���iK�P_d�4Z(M���P��=���8������
����홤#ve��~P�9����>u[=��7jx*����viI��ܓ��l�(�~0��� �!ǿ��2�an�@���%���giA��W�!G���I�����^��G<�L�&t>D���!E�8��$�����2.Ւ	Jo�G��kG��!�hH��Z�*�]������;���AK�oΘ�/�F�t��e��Kou�82L���xY���
'��a���&����N7Ot�:�:�<�o�[��L�ꡬ��J����j��"��M�+�p%Ֆ�z6�G�ts9�6i��!Q3Bp�l�y\�g�aN��z�����1s����޾l������_q�O�Z��'�������X�`�U�(�3@@��� H��/\�B}IGDfFN;/��Z�AE�t�=CdfD���3��4�T����sjJ�J�뚍�/�J�P�H��y��kw�I��i��̃�t��,�x�>4�y�n�ԗ��9fl��5:�pWr� ��"Õ�i���	(�e�����Gڞ�eV�";E�kX�^�5Xl�W'�m0��HW9b�_m����ݫ��͢*���+����?��_/u�iJSڥb���\�����yX�J�B���GhB�8&�E�;f/�]F1w��ߪ$���c����^�ݐ^�i����^=��6XS��~��p�ХR˶��"�2	F>!��#Vc�.�BBԌ\WU�Y�Zp��_��!���q޺&���Է����6�:{]�������Tq� ���m��)��)ȫ�t{H3���J�b���H!�R݃�B�
����GK�:))^�Ki�%)L�	��o�:	�BI\wis�E��@����x�p��[��y[�%t�8.ZMb���|��R�&��\�¶Qp���L];a*� �]X�/�$��
�+	��(<�{�
^+tm�:��;q�P�$^{Q&��������L��1�	�����F����'b���l[Ѫ��7�tE��Ӟ3۠N���R�^�o��|&����t�>R�����n�*�G��\U}�9���3uv3�f���J.�6�S"ǎۺ"��F�E�l8�������s*TCG�o�E(�HL`%�d�m�"%�QZ��v���L��a�PK�tt\��V���Yc�6��'�D������1q%кN2�8�y�Tx����"��S�<��j��M� ��:������Ctp�.��s=h란�� @�o5�W�\RwPkP1�����c�ت׽���&��}?�j�a�6�
����h��(!a��%���B+�����d���e����W�Z(p��b����ݪ��6��U����O{�zP�s����������S#��.�k�6�P�X�ѕE=��{Y�z��0l�w���x���Y�N�jp�<�5ƗIA�ni�����^�~������[���&~e�:M&Ģ�����~���I�eu�+��8i�ތK��L����½r:1���U)�H�*�A�.�U���;p`���c|a��"��M���+��������u�c��ё�PY�Q�:P���5N��JO��۠NY����&u�_U�d��������z����f	�dݖ�T"������GNȩ|�����6R���-�ԥ�`QТ`���Sg�6��y'�]���K�x��6�C�"��>��g�`�YG�fXD����o�"�����C�m�l�j{w�RS��{Z_Ԯ���t�D�MsH�z�*�9@��r�K}eɮL��lh躅���G̹Ӱ	�XU���QY��KYӟ�;/���ߐ{:<�)I�ѿz��H��nlO�uG6�m�U=w�ǈ�
F�J)sp��;�7���3�/zf�i3������[ۃ��#�s91b٦��y���\��HH<��;��8���v��H�tO���jݬN�T��Ǖ U�+���^�#�ee�d�Q��6xT�ktZ�9�{!����A���U��l���a;%Z�A3��% �5dX�H����A�����~Ϗu�jX�藒�z����T�Y�eZ$!9��2��ѝ�^]1|�n{ZO��Z�.����*4{1體^����ݗ�z͋���Z�����$��F��Y����a}{�װ����v�V�A��*cą�ﯾ��~#����4I���N�5V�H�Ҭ�sl����T��7k7���[V�x����3���a��Y����Ӛ��4�Q�.V?�0&�>,�u��p��q�t��6�������St��m�A��qݴ6�ƾƧ�&�q��7]NƐ���3ɋ�v�a������Wޫ    x��+װ���6y���=�Dt�3�����	y�ǟm�E�F[���I5~�̢��#4l�����M��zk�}ue=c���V@�0�^ɘ��LO����`���U��/c<��k&-	;�|��xYg��+��\ũ���D��O7u�����2���Z'9N���q�h.o�!3�~p�upFx��������4RKc�{
�.���Nv�n��y謩c���R���@�+C�A�f8���7��3w;�_h���/�W{��r!����Z	� �ij �e����t�c���e\���"��2����!�\(�3H���S���k��>���C��C��<77��h�|���B.Z��&�q�8*�@����5�ka�-K��e���&��/�'e�e&Wj��E�j+B� ���a]��� �gI9Q��^!5ze?ʙ�y2�0�:�!ɿ_��2�!I�(<s?���)�[�9C5�Q2��"h@��W�7<�B��{�4\C:�:�?!�9t��w�X��Bzu��DZ���'�&&L,���J;�*�*:�k�S��Z+3�KU+C�c�w��{��?)��`&���(:��Pl��C�XS~�Dq����=�U�w�m���x3W�y��,�7�j#��/���y��l>v�e5Ұ@[��	���
���[?�Ԣg_z���i˭��\%
WJ�\�������b�������}���{��R��ټ�Xd��i�����������,�o3wθ���~)� ;��2TkQ��r�7�,��ܰ�C���2�m۪�6��g�<�"Ҫ�W�8�� �(2 �4O���u�lY��uR ��p�5.�5Zik���՘y�E�*�`Ǿ@�;E��Z�H���gJ��aU����;C���[9:�ۃ����j�Ḓ��˭A�(���zCn4�f(R; ��916%���"vX:�UQ\���lo��@��'ǦvJlo�tpM'�(]��fY�$����s?W
h�� x�7��ώ-ϣq�>��6�	4I���f� s��q�Vgd��e���_�d��7,z5�f��z�*D�}K��cm���ǵ	���tH�VF���B�ZrR=�Q�|?Ў˕2\F����2�?�Ɓ�P�$�`kq����t5,>;�}4��/D4G!<��[v,��n��K]��T"8�_$��b�������a,K������,:ch9��h��0B���'�w}�4:d��2Ǐ�_����4�;� �򤾰a��B/hvր�T/o��,��&M�O�݆�c0ߠ^/�ŠworJ�j#��O#1c��4o�_H��{�(d���Ƀ�L�˫/�"�/�]����ĪO�����i����(�MK���j��ę���ﶿ��r��E}c8���ݙK�@�W5�7�]�#ǲ��.1}��0x*v����]�����ɇ��[�NW0����4��A���W�.��������Q#��tj���Wmĥݏ���9�W��U�'�x2��Gl?�pg����%������H;�����z�j�"�aK/�N��������&�k6���P���v���6�ɪr�����zmN#�~�D�@��F��e�>����-�݆�U/3��R���1�9)�xOB�2���4nm_U��eu� �f�X����t@D{h��6�D�$����8�?�^����j�J��+�t�!�����`_/��ć��b?�r,����׼��)��w$S�+���G����+�����P��c��ԭ�[~(~����(MZ8�s��Cx*��k���{l}����o������˕�@;k}�q���P-�`�j?)3�Go����c"d�Rz��\/�"m�PZ�eE���{ܟ+a�8BE?6O�`1y�0�$ѐ�\
�\�ec�4˿��ǪĞ�}�绲��$���M�7��P
KF�R�C��w����|�z�M�Ay�������J����}�q�Ǌ�[?F�KN�#k�H3�=�m=���\�̹�y 	F��N=X����5�B��cH��q$9�M�Mj.��]�E��5����<��շ�ԑ�z��\	i�ځ	�r^���G�$*x�����N6�LP,,x�oC'+άJ��kz��:&����1���|o�k�{�٦���dps�5m�cWP�q�,�D�h�&�1�+��/s�(����x\�v}N��yo<݈\Wh�)5��3���4����͖n�ڬ�7�b����֚Jm����T#�]���Mϔ!�m����,\F�����?G�O���r����<"����������%w���3�}���>��̥Ǭ, *&��>���ؘ��@y�=���i���W����0E�TvYX�m��jZ���2�.��S@5tU����� )��Ȟ��+RӸ	I�������Um�s?bg�@מ��j86�`�h/�?�;����v�ʪ��I}�5��^,ĳS%p�Љ0E�.n��x�䷰ �,[C{�I���4�ԯ�垄ʣ���N�c���0�5�&݈H���[ء�*5n�iY��i&�hy4^u9�Y���&r��/�^>�\:Ꚁ&��A��@2Q��(�R�n�7Â����K{ZL�t�:�y`&V0��^o358�B�I.�������~ƅ�C;r\c;���%�a��4��q�]5:&�d�����#n�����J1|�������a�6*��*4^��t��"����w���3F�D�H��Jcch���vh�I��j6N��o/M���v1
n>��e�=�:��ܮ��=ט ʀbe������{!Oh#����D�s��w�}VL=�+^|�ȗ�dr�FY�Y�]�t���'P_K7O�*�a���NP���;b����m����q��i�ϟ%>� �[\HBB�/.T����x^��+�����
��E�щ�m�?���}/�:�'����4t�����46~���sͽ��b��an+����qр�K]G���GH��\�B�rLs���˻L��:�&g�Wg|i$�<�C�|;k�(=n>��a��j AVY�T�'��G2ܯ'�LA8���ߚdV�8=��p�q=�ڷW�ĝ-��θ+�9o:ͷ��0dG�ߖ�|�$b\g;ϰl7;�pWr��
/�_H��o���|G��WJ��'J5�E!]$X�-�n�E���~�L򬀑��OL�.�ݺ{m�{��3�:�n|ݹ���d��;�R~�v{�M�;�g������r���O���%%��꛻\�F׬���y�����`�]��K����'v�ijzpڂ�L�/��;�R�S6)a��Μ��������u�ν�wٱd4P���m7����;cpI	�Y?[JV���<�Zg��i��Ή��W)��J��"����dcܧc�l���X��֕�:/� �Ҳ��O�Q�}	�V9��e�F'�1�IN��,(���IUm
k��Mo'���^��*�቙�.�1�.~ThM~S*@k�
��j�΄��x�t�c.`X�J�s섢�oU*��r���o'�p�� ŗϋ�f���ђq3BK�d�f� ]� {��,�g9��~O>!h�{�̹�L ����x�l+�e���e��b<�,tD}V.N��շx��uEŦQ��,�bt��		��ҳ:�����L@-���z�_�Bh'3J��q���J�`Z��#k���=��鿸R�T�i�tH�2��˂�ޔ���2���nW��O���:�f�-�>�C�OPP�u��w�/�����%,�u�����uh0�R��n�<�@���h���`�����H@K%�6tg1�sݗs����ц����0����D�J^4+k�kXz�P.g�,<a]�� ��߅n̕u�q�:�
W��΍�(i�%�����~<���B�E
�s��*A�f\zN�T7��[���-�wʯl(Λ�izh����K��}!Y�׏���rn�߆!.���,b&bಿ���Ĕk��4ج�N�p��s�9����crSȟ>���=�?o?=4�L�4/�c�ݗ�H��m>��r��88�������C8Q(�m�    Y�1Tj�I~�@2��\�W�q���TfV�b_�b2�RWB*~62����G����|A�K�8	�ӵXN�W(�w��2/�����&D���$����O=.��>9{�@�quO�0T�3:Q,��iQ0�����4��S����w�pΙ��Q�tuF�����c|Ჶ��jH�����Uϕ���/X�Q|�4v��E.��8*��$�|��m��Y�h��oȂ��U��1֬� ��=JZ4_Ue�\R�u���8U�;���yL3����r�3����3<��BA�+�����/u-�n�zw*�����!t��үᲊy���0p��O��k_)������W_n��UQG7�<F���kv��8ȫ9"Ir�t|8�-��f�AT�u�UG�.n�w9��'������p���(K��P��J�aB���:!��0nƭj�=B�6���`G�ݑ"��&i1@!kx&&�C��S�-M�9��yj�x��=���u�X׶?ʎ��e����3�改;�O��¾����0���U}� ��K N�9k�q�U%� {�+��γ�q�b�Abw���C�6�7��׉��&���* ��#x�Q?lV>؞y�ď!����"�끭��3%!w��Xy�S<�)��=�+�׆ȱ�=@��@R<�$%p�����wvif2yp��e�<uC�p]��E�O6Ȇ�AT��R}C(  XY�����"B"K(&��m����!��&���һ�Ldc��H�(�=�V��ǵ�I7I���8�I�'iT�T��@ζ�� [��^4��6!+�3�}T9�Y#]� �P>���v�?38-9۳:������KO���i���V���_�Q����ǵʠ���.۹��d����Gc��Ǒ҆�#y�b��%���i�eL��-����,j�[7m�Ļާ��65l)���������z�d��Ia���<)�L� i��Q�ɐ�F���C2����ȉ{u�>�`t��󭛭�=H7������ܡ9�K�׻�;�O�uӝ�O��T@��ڑ~�/}��CZ��+�b�h�?���&��r�g<�a�?��ή���rO�z���u0��������}]�6@�W/�r�z��8�F�=ߙ��4+��cx�v�r�g��U�5PkG��tlvE�	�'ܞ�:H��^S� ��R��ξs�&O����ʛԹ�|������U�R���v�q�^-�Î�;�
�p��6�E��j�� ���r뗃�l�p����Z8i�4p9��T��BœVK�*ʚ�\p��9W@�ST4��P�>X�7꽸�z?rM{	��Pᢛdr�2�s`���8O���܅~m���
���f��g�S��U(��/	�U���'����#�Z�|�8H��@Y��c�q�(������
H�H)�^�f^�S�g�G��H���ʹ��QMU�d&
�V��乾����I�F���@���w�{��W�c�=�	�Oέs=���nط^]����B4�� �L�����0����O{������9Wb7�A�5�K�p�d��'���[�h��s�\��[�F�N�3/q��� ��
��Yɼ�*2B���:�i�Ҧ#T�. p.�6Q!{��͌�o9e�b�ʙB\9�8\�`��T�:.��#���د�xT��I	ͧ)`N$�FU�c��~��]䘟�ɧ8��#>����@��QW#$�=@�U< ��f�����QH�h����X�N��W.@.G�c�������u���V!A�ib�i�c��ۚ3��b��ꆬң��[��t��'�������������\����3?@�Tj�J��'��E�p7�������&҆�6$`]?� 6� �{qշ�pgW�'OG���$����~�<����޴�++G��| ����f�ݮ�jp�4h\>H\�w^|A�2��޶aW3�I���$E�]|���b2Z��A2S�]aw���F�<�}R%�jM;�㒫\1�X$�Z����^l�y��d%��/s�Բ��0}6�s��:E�
Y����RM�q����v~�5q+�܉�'�rp,�LA䣍��?o��ئ��@kQ4L,>b�:��"��o�-^���!K�I9���`��/�ʩl~C.�?=�/8��A�b#�9�W�m�z�j�|�ɏ��a~��p0�0�������h�}��op�i���'�n[P�̪LRKZ��k�a���.5Z��a3e��#��V1n����.2a����J
N2�&�Dn���ؠ�/��̏�h����?ӑk��"L�s
��+t��rX8Z��vr���I$B+��g�ƈ���祏I�g���I�uD=̕4r�#��v�&L{�:�I;zhe�5���[$��r�w#
=� �i�~�:���e9X5�˅��D�a��F�����c��Q�x�M�I��-'�����]Y��Nbn%J�	���{�ڽ��폢��;�8� :Tk��	f�^u\G؛a�]T��<r�˼�����
�6��pW�THd�Ģ����#�Nˈ����ޤ�<8���`)i���f�����g�8�
y��r�H��0;5@��M�c��0I�h�?}ԉ�Du߁��ғ�ɮ�i�]�������W�>�C�y�O�Kc^\P���(��hkMw�3a_�G%�q�
�/��䦑OmGŇ���e�eAv��4M�yB���~i��6�z�P�;�����y�Z����zq�J��5zs'1���O�!����t�rjy�_�@һ�y���������V�"�$wu�p�9q����9�8�U�҈`�R���.k����|�y�j��s>u��]�zDֈ�p�����PԤ@��)H۠F�mKqĥ߹�9l>�8rKK�������Ay!�9S]�3�P�
��b؉|��V���oK�c����U	��Y/��B#�s����U���Y�������7#(�銥��C��%�,B�D��v�ɕ�hvH�ݻTw��N;�"����8��u6[S+���	;�\
��V�~^�j~/]�����ǼR�<5cG'�-&��7|��>�[^w�^ϰ��c���&��a^�%��*�Nb���v�i�Πk#T�`�Y��ȣV��t�T�^�5��Rn��aU���}�nu�w�}��1Ǐy�x�������:�{]�7�7�Ib�"����NA��OڦT{x����5'����lT�v��0WO;��4V�(�h��=7���S�~O��Pk8��ֺ�#扯��qO�c+���}AK(�ڜb܏9��O��֞%᫛����DD�#/��(d3���9bs��"_���lyV�Nu��3aV��{�w�(�}
��L�����X�&A�{�ʟ����K���si�=���:�i2�:�&�?��?r�Nq��������A��G��I&�'��&�n<<�K�X'�-��^���fF�ɍ����g�L�~.��?iX���(�:AV��X�K�j߱'v�ypW�yP~�/a
nB����kbu���K�g�{������d�3�g7�����+>i�>��_�ݐ���u��=3{�����&�?R�Mt2q^�'�I���g�*�Ӣ"
^	����h��ְO�. ��7�U�'�'(�c�#����8�;�f-������Y�n'�G�Ӊ$,�[Gl�%�,S3����B�k�M����z;�+��t$��@|
!�����,���`��s	�ު���jh�ru2��V�˖��;1d�;a��F0؉H"�2���!J�l_zn�S�D<A���xj��y�ufi�\o��̏��P����T�\"T�7<Ŕ�u��n�栖�1]��W䃔8���(�#g�~$��Vԋ���Sp�����O�)�`��s���z���JO��U�����v6��N�Q�y( w��!���";�x&H�8��t����U�e�M�5N.bA{�O�R�a�����/Q��.œv�*N�n�Y���!'�T>w�,�_���&��\�,�{�$u���=���羘�T]��s1zv$m�J���SOR�(�����et���̀XV�u�ҁu��W_��(��f����    ���	n]�X��=��Dǥ"�����"G�;pD������nx*��{L���ЫR�E9�̦ެa�m��4���nԤ���CqLޅ$T�`��9z�]���	���0��`��B�/���}��s��������F�Baomq�#ن����4p	;8G!��Ht�xն3�<UW��Qfb�À%j݁����P���g��dE<= �x��Ӥx�y	��s6^X&� ��3��]
[}�9��v��K+�FOϲF�H�N�<t��M%��	Hr�>��?&H�.�&|V�?!��uR�j!?x�UE��0��ܞ�� S�.�X@Ӗ���e��ɥ�&���Q9��LJ�$�P��m�zm�p��������+כ���#�/�QLf��mH,F��\Uk��<��vMM��޴�M��AR���B��NlH+*FZ����֭K'�N��@�c�5S<��{ސ�Cz��}a�b~$�}��}(��X,q��;����$ ��!��r�N紀�#�D� ��,W��\l#/8ءז�	N>���wn�g=�x堁�'������-QD�J��p0�Ip\�|DOS�>'�12Η1e����u<W��`?�!�3K�=�9�Ϙ�|�2�A��]xj �DS?]�ʰvu��̤��w%��Wgy�Xi���GG�QѬ�"&�[�m���'��d�����0� ;�����y�<ч�@k�j������Zxy��$�g�������	ݼ���TO������O�D�C'��l{X���������ݐȃkڸ�y=E�m��j���Z�VuR��ng���d��/��ʓ�d���	�t���1̺������F�k�����쫯x	BֲDx�v�g<����#����n��Z3F�j҇��� �z�=#�Fi�{E���g�PP�R,�/J�a��㤸~5(��0����]��Z&l�=�}�9�ჽ~C�5�>s���Ě�d��PO��	��Da[��%��#�y�Y�K��uH�J�?�u�Y�z,���x)/���3q��`7z�B�5��[�@ϒ�SY�j,'��h^�#��b`��c�~gy#+�Ȣ���V�ࣗ��;VU�a���s��l�dE^H5�c/T�Ł��.~�2���	_@�N>t��m��������C���$%`�W�!��ǅK�Tz�4顸Y,h�t�cZ7.o�Cͨ�PH��W �'No)4�w��O�����1 �H�t_ߙq���fH�J��Ф�(n���hgH� C����8�N����1r
J���%�vo�:���j�m�5�|�n�0.�3�4�Ǵ��&��=I"���X�\t;7eXC"w��<>MU{릠ҬG�,�,y�� 3M�ϐe=�8�u�#�/W�l���V�	��u�G�	�DS��Ip�'��i�b�V�����r��2Y�5Yh�n�]�GN+���w��"t�k)�Y�#��z��iI֘����*Z!%�s|��3RС%3�^KI�qw"<�gȽVw�	�ӛ⤙yh�p�p[�x���f�D� ��p�qz�.A�.?w�8�9]��=��\&�Ui|!�K��9�r�罈�g�,�������Rr�<��0��v�͐�=*�'R�P����>����7��I����w�/ŵ�������q�Q�ǚo�� pFN>K2��q(`��:�9C9�#s�m��S�m�(̵yu
���������!� �k2:�����-�e}���]��NM����xx�����=bd?ա骭� �F��r�G�H�u�B��OB��v����CBr6��YM.�Dti�H���6���<{3,k-ϐ�=r�e��n�H7��t���5��fs�F���]ҴG��){�vk�\@�O�㎤9�iC?�}��_��X?�6n6`����#���zM_��q����|�x/#��K�g�[�A8Wt���3��j��\�>�Ĭr���ǚ�ҹGܤ�VK���''��������z�ͣG�թRGA�j��
E��$-��^��*�2��aZ��՝�U��0��[{L �f�5*�NL�QL�.֚UWdyʷἾ+�˽�y�뗽�n��!�둮�X�r[���vQ$s��^������E�оo��3J��pS�Du���cW���qV���8{wq����ΐ>�^$�8��Y��ў!�_��~�����[{����R����Ye�fH�hH*�p�z�S�f��p�%���N�ai�#�pJSi5�]�~��I[��#�|��� k���G~.�/�>RY��>�G;�d�wv�t�HN�h�x��,2vz�BB7CyZ�ɀ�1�d�,�x�>�wx�� 5#xB��H�_6�����H�;����o��7Q��m�����̥��,��k,��Fϴ�T._�5b�!�oRZ���y|��+�
bΐ	 _����2KG�v�ƀv�:�K)F�ʣq�FV{���?�n�_�?�8������|ƣF�@"���o�{�G����2�����F>�̒$.����̼�{N9$i9�3ļ�/������B�W�����7,|�E
?�6�[`���vJ�J��c�E1���ht�AJ���Yx�{�oZͤ�J'�#��RPP��8��i���i����N����� �g(�nw3�B�J �^<�&��`�d�iĤ�׿���.�GÊ_,Ò�{ϰ�5"���r{Pb����s���#0��M�u�X׆i���H�!=�w���!Uo���$ُW~���c���us�_ǧr�x�N��p��O��^'��.�+5X� ?��*� �oi="�~�/����	�u6���[A��>�p�Q�7Ɉ�Mk@��\rd��$��>�n=�fȫ�ĉ0���&�,��Y�-���X�̓@�b����[����|�sl��&1Xv�Xs����2������ yQfb]߳�^�lX��2�\�;}\��DM���/�u8W#��D9��q�"!3�H��>D�@3��z�-P�XPB�A(���{��"$`_HfQ��Q���iuI�j�����s[e��d� �}!�֟��p.岰�A��p_��!�cY�Aq��q����r���oZ����2O�Fj���Q��(]��w"ו����������~�Ʃ�Y`���$�C���Y�=;��ۆ}��t�e������'���*
6]F9�DG���f��.�]l�g���(�{}��Zk�3�=���[����<��Ү�X M�PΔ���M7�NAP&�G*�3�lX�@�uEei�ÿ���
�͆�8���h�������=�$n߻ F�G:uW����	��C��X �~�c`TSBx��b��yրt��Ov̛���X⠨a?�{0�EP�ã|*Qd�[��:����
�$�q^g ߸�8|Ӛv����},r�_��[���X1i�"Ź@�5E��b���rU��n�!ݟ!� �b���:2�nI
��R9:���uV͒,�]-0�T���|ՐY�t4,���ܷ2�¾�L���BU�=�pDgIp�+���c�R:��ݻ���'3k1����#�rAǭ8�}�ꞏv�&��_�'�O��?h�Hp@��=��u�؀�o�"�W�f�o���c���d�A[�ȶ*R5	�V���5j�/�t@��{�Uj�>�T���⬼��0W<��X�0,F��H¾�����ԃ��/�t}��̩��}P22K��늞�6˾��0�6-cVFR� R�/�t�f0� �Ue������=-4���>�ο9~2�}�R���pÍ��� ��%�P�@��ޭ����=c�Eda=W=�AEyӰ�q�
����?�#~��=�{�ty��#,��}����cT�?8��h�pr��Jx�e�ΰ��a:$W_H:Z�)�#K����W=V�Q:��yֽ!%�H�:�������Tm��u�����њq�/����̍��������E��#����H��K�!:���Ɓs�!%���r#h�O�{G�.�G}�E,�w�g˴� �Q�Z���,~�G�T�    ��&ք���Z��-�Ne��p�ܯ5Y]��O����M0}�3E������.ӡ�d�D��}TdQcU�?��]�ɐ�U�/�C���)���ǂ,j�s,��y=qԈt�Ϟy"��>J^���Q��A���Vj��A��N��^�U���q^Q�Q��s��Ŷ<кX����U�"�f���zF�?H���>��ic��KF{��d�/�����
����<7��&~�)��,�K�X�D�\���� f�~��C��#���E�����c�纝�
h�/�s"C�-�L:(�|hfA�����t���z�`9�}���ƶ�K)��+���%);)U�z\UX-[��󸻡M����� rš�����N�� �<���Z���(�	�Z����H�ܠ���੝��ik����������J�d䱔����L>�:���7q�@j��5����M7|�۰*�7��遘:{S��^?��RS��u���f�$��ºǱ� l��¯7v�.�ד1.�P����Yl�tX�RV��y�_�e���|��	�ɑϰ�^�@~2�� ��g���1 G	�v�\X�t�yWHSV�� �$���hzܮ��<�/�}�G�?��O�ӿB�R@�H��>�ԋ�ku}c�ףTQϪ��X!Gy����h{�<Ѵ6�Cܻ������<C/Ic�Җ�Th0�N�B�t��6����։v��=��V�����
y��%�nժ3�$#�;j����7�T@Pnl,�2�a�+�4�����)xK�NO��ʔK��R:��˿��������4-g�0�@љ�d��g����O�}TGA���$��4�?��I��o����-᝜%�nv&aG�du�^{l�|}�l����a�'�c/�o����k��I���.yd-���B��B����X0�J���άP�]=݆��*wb�2�-�A��k>�����o�����+$$s����L�O"��r0�6�����A�w��%��r�W�Kq�β�W�]!3�X���Md�=!K|�-C~�JB��/�]��ޚ
X���t?p�fL|��@Gp]�B���դ��$�l�v��_��0e��p�s�sW}��GM�0��B��c���2�uA�s���C~Rp��|���M~#��mf�3���C:�r����ӡ�����b�!Zah@��su$p;���2�������P4��^?�Ձ�
��cz�)]�[w�i��µ�t��4ak�u��ct�p�DLh���:�t�v(>�*>�q2:fg�#E�Cs|(V�WMoYеzx�,�iM6<Mj��5d�β��߃M]�B:�8�@���I�v��ic��
i�c��l��3�I�R�d�̽&+��<v=2;6�G.-S\a�����2 �`�D-�2�����p�]��r�ܗ4j�w�db�V��w�����w�6�:�4T����5o�*K(�.��������E��iT�uh�~ڼ�1��Xl�L���0�QX��6~H2Kl��<�eg˴�h�+ گ�y�����<�I|��m,=����ȃ�;o��R#�y����f�I?�s\��<�c�\>k`̪�BN8t*�C	£б�q�x��	�H�t7�2 �a��_]:��<�!�g^<s��λ@R.e*�,�ٍ���cC
��5hojY2N��"6�s?��R�{v� �&�2`��&ϓ��i톮b���!�� ׈�7]<\���s|L��d�=�UV㱽v��."��J�C��[�S�*���:�5_x�ˋ�M��@���<�n���R�a�~ՠ<8Þ�(����3^��[�T#��"6�K�L����<��&H�j]�jzB��	=�'W/۠�QB*F��G�u�:o�Х�	���P ����<(*��ܨ.�
r��&~d��z ,H�T����ϒ���������<�YN�ߊ��y.F��1��l��v{l � Di��
["�]�ص;ܮs�ogS�W����LC��\���N�Z8o��c
�$t5۵.�]1�(�'cҁ$`�L������C��XN���n�R���$�����K�f�=8��I�؊�F9L_;}@�6A��0�F�iF��&����UYqz��fȿq�yl�����*��+d��CĘ p�U�)���I�Z�W�3h��M�2`�ߤ��,���h�4�QY�R����z���i%����+H9Vx�eD������V�ƉWw���)o��,���h�}m��=�2����ڛx7�5�i:�(� ����u��k�!NV�&[JQ��s�FͻH8���9vK���7dx���m��j��E��}̸8w�ς��]�_o�s���*[c ��`���n�Y�$(�{ɂ��66x9J{�!o�7�=|�JR�s��>{h׽~��*f�@"񥔞}�ޟ_c���*��B��N�Y����R�?�*����M��A6E��}�q=4n�`}�ۗ���K���K1����/:��@�XF���|Gz����>�tI�� b��jM_&�:+��KZ�OX����Xl�@���}���t��߼!��x�oÉ)9�U�o�f$�b�
�|o���d]�v*~0J��^0���������� gWa�=�CQ`xB���6�a|�0���Iәh��y����T�M�f��cFB�"�1�;Ö�^�}��=s�F��!��8ۨ������!����]�q�l�2�G�+B�-th���ɰ�Op�L�4v@-]�Ɨ��8Ϭ%/Y�1$�K�o!�B�l��-�
@���	�U��\�ḿ[����^�
ؒba���[0��FƗ��s
ȡ{���1��}�癯�+ky��ªm�Hl�z�]�3�׻�Yf�&���	!R���1�N�3�� &���iT���qݻ�ة�2��,8v��u�
&p���� =�����e%>�v�f�H(8̐^V�Ϲ]F-��/�`�������sD^�~3��Kf%��;�������d�(��eˮ_���F�/�"�$q�6<����>Pi�^� H �k��8X��aT6��s̖y��9���ߧ���'N�e{�4�oV��jErӃ�����W�1$��Z+�C1>R|?0���ӱ������	E�/=��{�Q��R�LL)\}m��շ��`���3a�T"��SƑQ��$�����8��~�J��Duݖ��ϗ^���x���v��du>�����7���l��:��T�jfh�N���U)m�ð��_�/���n�\ǩ�l3I��[n~�����w;��˃H���K� �z-m)�+��d��&���D�_�5$��pl�`���
t�W!�<�L��*�L�\���l[-0�����%��ª�Qa���ۻ\�%o��c؍x�kco�)��H���;�L؇x��|�9��f��Z*e���(��/"�U�}s?���}[��j2�@�����^j��,��|����tG�R~�z������O�L���ω�05�=_}'7�g]}�^z��S1��J9����(�;�s���BZ���f�m�'�ӟ:=<ɛb7N�IZ�j.���1d�����$�e8q�9�ۤ��~־B�b�|�v� ��m}���؀C�}'2��Wz�,dK�����{�ZOf�#���3y'd���m'Er�{�s�T��@���Iw�dn��������<+��u�R����Ae�a���݁'� �X���a�z䢁4s�.f�#7,'����h�H��@]N8�oa c�x<i僛�܁Ύk��xr��(��|(�Z�F���I_��s�#���μ����;�U ��S?�Y�:G
'[~3�EE�F�h�""���BҾ_���@J.�B>-�QRiE�C�ߢI4'�L�G�w��k�7_�~.q�a ��NJ��VYa�	�$' �	�/՝������N�@
�{�r$Z(��� ������D��>���U�'�j���� O\�[���i��,d�^I����oI���yU���>�����$����� �  �쎅(�=4��~O�%�ĕfr�Nh������;6����A�\X�ԇF��+q������vX�L�����䍼N�N�.�^����#/���������W�Y�,��j�
J�D��J
��D �з��3�L>-�К(`*5s	v�%F����0�=߭}�A*����B~��m��^sYI�}&V�Z��������<������S�z�9?�f�H=R��Sfߐ�{�����Y���+�����P9E��m��c��"7�&�*��{�b�����'�lE:|�5�������q���턯��G"=�p�
���5����=k�R���CF�$�K�}fܬJ3[8h�8?I=��ZW�㺔yP�б�J܎�R4��d�e�Ztf�d�˅��������z�&c�(r�^�Nc_S�fǫB�{v���L�����N��b'Wu¸���	-�H����Y��F˘������-�!I&�,��ͨ(���aD��`�5�,&?\Jj'WOW���٭P��5U,}@F�"�A2aݚ�f�� ��J��d����ױc������,�hn��f�a���R�~�ACIe�h�ca�b��4ϲVmG��qF'�C	[�}�&?��a��B���``��R�`�̵��B�1�uj�!'�V���)Q��:�k�e���f���k���:�ȪNa!����"$Xv����ߌ�j�6N;���U�*�7�d��(XH3�������L(��?7~����?��%q      �   �  x���;r�0k��@<ć ����&h��5j<����s��2�N��2�u~�|�z�~��5��'jr����{�q&��s�\y�P�j�8~���Y�N�@M9~')���I��^�����?<&��Z�5Y�]�a.�c�n$���x=H�`a�y9�ܒ�/#�,xm�a��c�sQ��	86�0��y�an�ƀ���������:�K�[�050Xej�f����զ^V���u�R��@!թyʪS�U�:�N\�:50Xuj�fթ��U�^V���8g8uj����@eթ�ƪSu:��7a�WN� �+1��ANH��Pɰr9%VN �8������Iʙ��'�ɰz�K2��zB2���A2��zB2�����H��n�a�$��aTOЀO��X=���������Nd�      �   R  x���͊A�ϳO1/`���ӷ�A�]XT�"�̓���fƞ�q�{��Y�Ѣļ{������_߾�������jo��,��I=5kTm���?�pz�>�?~~w������N�`L��
y�}����V�E�+��LԒ�fl[�	LZj��뒓r�c��g�T&�x�HhQi�}4YK���ʸ�6����k���˼p:���)/���	O�}h��Z�VDp���5�������pu)a���"g��ߒ���Sd�D�H��
�w��w9�Py.������^��'�����h��*��ɰ�Ε� TI���a�%v� �&p��֟�%����m� vh<a������]t�$�Bk��PM.R�4��L�z�&���N�M�ٴ �}��8
�
'��l+n^p�4�7����ޯ>�U���b�0̶�
��$1~��)ֶhL�`m'æz\��w@�7z���ԝ�	-��{�ۧ�w�?v|���ı�9�v��p�IKB����6���?M՚�pP���_����� ��b@!N�����/�gT�k��b��'���02���)�Z�<�.�:YK5$8�څ� GJ��7��4���r!(��)�M]rpa�ㅫ�R��n���R�Rv3'��~$F]onaye�)_��l�!�T�Ar������e\ɤl��H"c�P��r�7�PI��c�0��tF"IP�ۻp%�8)�[�y`��HV�)��[��{�F��dq�bY-��Ԏ+��[��Jm�2��<s���	~H�\�����hW�}c�X�g���m�0��r!i����:T�*�/�Ch��uHr��Q�=!�i[�G������x�?      �   �   x�E�;�0D��)|�����p

J:B4� )1$\a|#�v��~ofV�%�q������d�f�MFE�����"�<�r'Y&P�V�#�O�|�.*�W/Lx��k�Q��PP����Z���ۘ�0�d��7�a�o�?=���5��{�1�-�w��#�9�Z
!>̑vX      �   �   x�E�Q!���i�.��9*�?dVx�&�)�V��3��������U�T/+�ۼ�3�KߢІ2�q��z\=�W���5��
R�+��g�x�����;۹ء)P��C����w]g]�-=�t�=�UG�Q*K���PY�� 8l���2�Of�Ek��*���X��:K��B\�q!?���<�pq	      �   �  x�u�Mn1���)|��H�C�9L�]ut��E� E� M�܁s�R�8�щal�?��F�]���A�K|��\bQ+�r]�8�&����8T�`���;^��J���$ <MB��u�����D�h-a)}j��M�:���y�CG�%�*�J��qS־�[�сڞm6������+����#�!���fy?���)�s�i��|�ߢ`��O͒�c�aߓ�[��W�v<+�zԙ*rK�t#��଍��5�rm���;U)������!BٻA�bi�N)M��=��V��]ɖU9K�@��1S��V�$�Z��IKc����0m��AQ�u�"S�R.3��iS���+�B�E���G4�:��A��mfǪ2�E����H0���F��9͸�Z+�=9R��W���ޤ�ɦAQS�A��ۤHW��_;��a	A,u��%9��'$H��IN��@i����f#�����n��� �      �   �   x���퍃0���a
h��N��	����к��?'!!�'/b*�n7҄�Ƒ8�q��O�D�>L���	:׎�����+tL�1a;~9r88X�ǩn����=m�b�mL�Z^!+d��B����!�t6��:C��
���N`��fZg�dz��	9W��(6TOC_���-C�\��'p>�I���EHH�A�����+�����0��(���&x�E%7�$^닸̘�ˈ��}�i����0�y۶_O/�`      �   N  x�}R�q�0{�U�?3
���H�LRQ����tJk{����� @���@�,l�P�=�C�5��S �@���]hAc�C`Dp+l�=>;\Gxއ7�N��@h�N���+>�((�"�L�	�#A�Έ�-�ՔJ���T�A�$u�� 9d�3^TkY�΃�*Y��T2�߱��6�3�;F68&<͗�r�w���;��}�}�ߠ�AD7��5���-;R*��<*7�=��"�-�O�Ҥ�x��8��Fs���i%x���_�y�ֲ�绝��%�fF���s���W��q�W�~���	��$�%����݅{1|ׇ��4M��T��      �   =   x�2 ��1	Офис
2	Инт. магазин
3	Цех
\.


Ί�      �      x��{�Ǒ/�w�S���� y��UYo]ـ�a{-��X0z�{,B)P�W�_|����EQ���ԃ˾�x8�!��x����
�$7#2������~��]�f��23"###��|�m����[���Qt=�?��7�'����ߏ��k��N�,�j��_�[��{�isx-ڋ6�˛����������/~'��xΰlf���2�`�7�y�4<��n+����B�|dpl�ë��P|9�*F���o}�r�@��q�?���ى��A=��y[��öm�o�@��������)f����S����4��a��i�c �2����?�=�Ј��;0��s��fp򷢝�����Ɉ��V/+��r6<�]�Q!i�܇�����+�+����,1	ݖo���n�3�r�vx;|P�|�x/��Ǜ�5�lK�j�������������ַO�{�\�7޾���ų}~t�Λ�����������w�-#�?l�l8ϟ�]fo��c��f�gZaho�'T/��dӿ���¹���z��;�N|'���y�n>����%���2�3�ZtP�KG��{8c�|V�����ߩW����z�����k�Y��@�0����g/� S�z�=,q���w5itk����í��Au���wl�HM��u[��, �9��I;#�6E�=1e�u�:��I;#�/ՙ�M�a��l,�,խ�V�{IO��3W�A�j=ؘ�Z�	T�`-)�F����m�N_݆>}59�*�0�w�O�a��ɤJ)$,9ՙ;��	�-+F�(n������.a�I�˭T��n�Ц����F���.C�}>�1b�sW�����q����-|��1�U;�h�������$x�p�>�Mrwe�*��0�����``�ѩ:���Iz��w?ć��hF%��~ 䔊vН�MC�����3mx�S|(>Olt���ώ ���`צ0�����5���k�Yo��-�rG����H�7�?f�DW�2}�I��^���έ�¡�c�=�s�r.�ę������,ߓ&-La<�҉$C��y��������=�(tf��pP�b>�@b�C)��֊=�\������W�6����dt�ܩ|��mq47�3�5^�Z��2������lA�Ƿ,���8�(	q��!�<]�<p؈G~7�]�^�gՏF��#0���D�[��3�� \A�:��"��P��,$�^n���M3@����[SP�'��,�`�ˆ
F�Q�AeH�
uM����'�׼��[�T�SCX����^�{W�d�v��E���>�>����W�a����x*!�q�����4K�c� �S����O��a��$¿C�}xu�d�:k��<5V)��=�Xg ફf�v���8�'�qG,�xH���n*'���sǴZ,��a�3B�f�����r4�c�^U~�P�h��ѣ��g`�Y�r&%1��帕dڌNf6M's=�}�x���M&Fײ��S���ys�N��_]C��K�V�t\���Z����wF�ĝg�!����S�9;J�����T��9O�-�s���g�����͐}Tc��S����5nF��[��t�g�	|NZn�SSo|��0tS�ɩ���q��ֲ\�l��^��1�Y�8�S���Z�}�5�� ��Yy4y�6���&��c$`Gft������(KL_�1��0,>��m�����l�S����5n�82��w����.>`�m�;��{ l@\r��q����#1��^S-���?>Ĩ%hjg��z���n�]�nA�s5�;"�vT���-��aPR�~!�a�-�V�d&��c����]�0��Óy��S�pn�4�a�������-�W�{|�����w�Q�-�����i-�)1�*	�#�H��=�����)��QT�=;��A8�v���I�ْNz����%��;)�_���0��Q�n�W�<Ӥ"���d�ԏC'#(L!(nޫn>���.�Հ<h�d��&�œB ��y�*���(n� �E^��vMq���5	��O4A�ӭz�뚚2��Z%�tQ�CI�QδJ+]��(W��y����BY�b�sg{������<{)nk���_n\���/�}��[c��9��.���!�ӳg�����|�/�߾t����k�>��N��n��;���qz��u��anltz�mw�n`g����6�1Z�>�����7�7/�;;x���"e��Z��w��eO��Z�,v���O������jlƖ�����͇�~��)��]k��[:���aU�ߌ���T󁶥�e�����3���rR�')���A���OF��X<j�A��M	�.Ӯj�֐��|�I�g�w}g�?p�����]�A�~��t���Π�m�������>���llʉ7g�`bN�9�5	56g[7�@Hx.�n�ڞ�G�uΕ�p>�2���5��#�[�[�<aE�	����3w��u��ӑK:��B�L��=s���^���~�9̴;�o�;��;���q��*�KKj͍��G�'J�m�AAl�d"6g-k����Kb��11�(��ra���SsZ��baX�#�<"͝��%�e@p�\wq��S�5����� <SKci����!�6�P��	�B\�D�3ۑ;�#W�"������}�A����/�X8·�z�����]4��f���-�?◷�x�#�M~o4���g�l��:[1ƒZ�I���
�_�� Fت�MyFgX����!f��FYb���_d��
;"�kvjuJ۬���V[�*�:���-�[G�%��}�!�<��������vDy���!=���x��h�٤Ǜ��M��C�j��(w�>��G�S��ԫx(�����E�)dw������O�@{C��ȝܓ������_�ɤ\�R	�x�~�X1���0;X�u/O�c�uG,x����Q�D�cy�]�>`jX��z=�>�����>9�=�1����Ġq#���n 9�����X�]�����n>8�aX������6F�M�s�N<�N��\��@�28��[ݍvRi���&Z���~��P�+�V7L:s�����K��T��%����j� �q��K5O{*ؗj�.�Nay���	R�����Z��5��,76n50	�]��3i�f�wþ�5,a]$������1m���w��n�v��)elV�;�����t����?�}'0�	6���T��t�ej/���Oa
�m���ˢ7O>*�j��*�7��",���%���Xy�'R{W,�p���G�j^S���@S�j�S8�	�"�׷o��u�]�V��mo�}�w<�t�~hfښJvb�F�6����eioD���Uc#b�~V���TotC���.#��
��O5h�a��y��e�����	+"���5�MX�ۅM��ى�N�����3��u�g6�|D&��_�r,���:���z'��۳�3m5��H��)=1?�oY&��J �@��1�*�0��*�q+�~d�J22<^� j��U1�(�~�*|+��n#>��\���w�O���o^�@�yxCD������6�Ǣ�*����2�z�X~��n?�]�TE����_���8.�h�̩�r;�V��Se�ffM+��-L�٬ifV��5p��r�~/d[h�~ӆV�G��������lh��	����9L�ڭnUE;��C���F�T�'��@�'eA��ծ�9�ZA�T?�%����'?՘M�J��xЅG⊛ה�2s0�*]�m�z�1�<Aʩ�R��[)H�_'H95*�j� ��HG�U�(+K��K5O�i�X�'4�-�_�18����p*y�o�����������|��)���w��p;���v���Lv���	���~�cϢ+sr�:ռMo�����w�a�|���H5OX�Gʋ�'��x����z���op����J��ӥ���)׷���V{�����	R�og����:58M�iA�p�ѵ6�^h{��y�g�}�oQ�nt�3�{t���nk*8G���'�o�    ]G���<�H��9tC	5p�Tot��tO5��e�Tր�e�k�������w�-%�oh�[4����ni��N4�/wZ8�z��=s�s�U�z��r�~g�uzs��;~�2m5[�amp�"��*w���^!�A���y���~,c�ë-'.s�)��{(W�{��W��A�yD�_�n��t�ё̰?l���~�)o�6	����M>{"��?���5�1�>z���|����8�ę
<�w唒��VU��W���'�] 4d�a���xp��8^���c	E��.��#Cmq�ߡ�E�-��8@p�gG����O|�6z�>���� s�wŴ��� i,j�>.Zm
��WN�ň���xxc*�	�$�(��
�8nQ�������28�/�8��(���RR�������!0<�q9��8�A�"s��.����܎䁔��c�/{�� �Gyw�d�k–d��ɩ!�Ȩ]�Rn/�f6s�@<�'R�&/^FJts�^�'wEm��MhdWL������m7>RܕWq"yXpF]9y���`v�pY\	�b��_n�&�	d
��l�<n��1G	�aQ~,�>�'��r��^^F�t�oIxo+>�wl���:B ��o9=�ĥ��	O�1�1"��x��4�܂
g�b�U���S���Ǩ��N���� �q��Q̤�-�6�& �%��#��^Q��W~�A�}D.�O��DH�;��;-�xm������#S�_,i�;�B�0s\�#� C�$L���%qgm��C�3�Ǝ���r���9�h;R���w�Cp`�G�O��S�+t-yX��3�$�g7aI �R��XK��#q����ŝ�N6���	�؀����<B�؄[W��8�ɥ������/�8~"��0,�Yy�3K�������h�>�{�
�ҧWV���XY++cee�������VSW��Źym�6�����W��js_m��}�7wW��/��g�6�����W��js_m��}7����~��zχ���L�y��p��}n��le�����q�2NV��3`�|�2�.������2[�!��
����u!F����m|�ݖ�����φ�gmK�Y���g�]>6~�K�x����aˊsF�T�[v�h�r+��f�_��$���)�3eYp��w�H]�Lr[����ጶP-q��h�9CG~�����UGI�8D6bҺaa�m�I�">�9yW�U�?7��M���fk�;~�Z�w�6ߞ>��M���[�>�,�ԅ%S������N.���2�Hݴǩ�K.X��Tx�+v�Ϯ�ٕ?��g�ٟ]��a�V�
�\K�XXV�Q<ʟ\�Ga���z���Q�nU0�br�A��@T��b��h%B�x��f���Hă雌�ƶ���vٔ��B[�s�.%4;�k�DU�;�5app�|ŕ%㢍bQ_����x�:�bh�������Tn�Pq���&��N�0�)伨�"���T�����տ��3'����x=��\��w�u8���.��dC�bA�����\�!Ս]ݍ�U�Sk���w5��*"���'��MFX�<�RD��u���Z�!�<a-����o��
���V]��S��Z%H��J渁�������f<���=��o��N�����;A/�gښRE;��u�(Y7���u�3Q�no-�Q�.�〮}jݬ�yϜ�>�y�!��M�y��n]j�T�U��=�2���Z��]��6�������7ÎǬ�3�Ag�e^��f��d�"�q��ҟ^�}�/qj�Z3f�s�k��oJ���ʑ?��|��H8 �1>N�ĕbt��(�c5��J<�C4��S���U����}�6~#�����I�B?������w_�6kC���jUU����
4I�/��{H���#�e\�7����� <sO3~kY̥\�ˇ�<���r�f����ϰmaW�b��S|�
k�_�1|	��=�5�S����E$tx�'t�Eg8t�S|6�	��ada�}z��-�N*�`��H��V|7A8�x�40����?��~kA��W;h�\vյ�~�{���:^77�is6��@��9�t������T7��U	ϣ:���M*�b�~<2�I-Ԙj>�n�j#�Z��M�Ϙj����`RĶ�'������Ğ3H�J��iY��úa�q��dUU�C�k��߱���x�ŉ�v��)��u���@�z�t��D�z�(A��A��>]���Z�ۘ�:�-�}�Z!8ռMW�5"�j��*�աOX�R\}������:�P\��t��u��a���ˬ��i��L[S�^��|�n;���k؟�j˯a�P[��Z�>x�7�!���P@0D�UV@7;=���5�N�N	�f��T'Ƨ_�M|Á���Bߤj�u?�u.��.�p�n�]�{���:�XEAO�+z��g4m�3����IU�0C�,5ϕZzc��n�2wW�����U��*sw�3w�N��y�����^�y%[��Y�@�|���,��u�΂��:&�Bۋ?\��T�G;�x���N���(I��Vr:����d��I�)�L<�v#�9��e;�G �L�����e���BFK�K��@��'-i�������~sp��/�G����z���ul��uщ�'����t��wY�!wjvJ�W��_���JNr}�>�:}lh�����X�}�;�
�f��lzg~�U����M!Ӆ���;#���&�"���a}�Ί/��v2�GzO_��]f�u]sZ�eh݂p;�og������q�@ce���;���[�&wFXx��TA��%�:'��a��r���gU�\��R��Hj�x���qLjK��Ђ��#�dD�N��ɼ�^b`H��:�W�R��i�~S�,0bg��h�Py��u56�LB
�CPOc���c[`#I����0�p��O�_<��ʔR��CF�1������#�
��``�D�q��h8.N�aT�i�31�؈Q��%e�%�a�8�������a�������n��E���t(=-k���Z�� 	���� �5W�;b��1FF�a����o�C�Fc��H�ă:�zLk����l���"$�&S�jk�"z�C��Ԟ��oK!����\�)�eTX%[s�����#��ɨ�c�{ F�A�94Dl��¡�І�dT�7��+%�ܒ
�*)�p/�}��A���ʇ26x�X>��2`n��L��@𖂐�	�y2�`�s��8��(�ߩ��y���]�1�XfFv&��:tG"#iC<�*ɐ���ߋ{�$�`��V9�P�lD}���P�k�0��� �)iF�&�1��5��B"F����1�oɠ:��
�����!�ŉz���F���H<h��In=Z;R� �E`*��p�3U��(�b��J�[b!��VjXh���\)�ɼ��"
�M�X	��O�Ĉz���;�0�f
Õ�aV�I�!�V9)R�6����{=�U�PH{�,������䯡�6C\M�� ����򾋆W���
M��*D�o,R���,����>���1�i+%x��#�~'�x��-��Ƭ&q��5����3д�#SK$Vϟ�c3o]�x����S��g�b�˙�Tw#���*�@��x�1�]��aH����}%%X�����X2��&V�`"�$?�p������ox�V�����@R6����~����߿p����ޥ���~��Pᮐ�M)D[1�k ��G�EkW���u�r	l������a�-���ٜ����}T��Ekk�wp���Q.�/���pY�}xrJ���dt���D�K�;d"�Ci�?1��ⵃ��ml�@�}�a!�-�q̛��",w�(𮄵�b�АP�����|)�tONul�$���`>T��FrOR�p�d�Y}E��$���}u
-c���,&ԉ��%�?���4���Z�d�ln	fX��Y�����Y3ws�)�!��]�G�D�ʕer���(���A��XKՁՍ�9 <�&0Rz����>�4���    u�p+�e`P=;�r;S��IA���~_�w�𥩟�%%g1�gz��:z	cr�2�S��6�Oi��u��e�~��#��8I�Y�]�`ƀ���D"�[%Nwۆ�8(
h�L=LS��o�HRU6���g_�����0l�3�v�jX�H%���o���_\z��Y|�D�N.�����ℋ��?#ە�������Fec���q�"����+����BJ�����MT~|;;�)e�&7�&�?#�8��K�s�[>j.�3"�}v��M2�6�,�DK�� x�\$�	�Yi��SѮ�Vh��;U\	�����Z#�w�3z~}$���w	Hic؞���29ly�����8���Ƙ�H�;�> �x���9T�v�<���3�S��4���n�Ҋ��X&pL8>@M+�-�s]��"B�x�&������0�E�	t�v����#��c�Q�'���z��*� �Զ�c��D���v���	�0˴4M�m�x��v���/��1�H�~3�R��u�Ŏ�)����~�6��3�� ���ބ�%�s�Hx�D��3�%��l	kLnIb@��&Exw���A�v��YĘTZ���P�*�^���苍;Q`��J�"��6�\&Ȋ#Aܞ��D��ֈ�˦�v>��t���t'�{b�Sa���S�R	��*�V�9qm��=Dє��dw=J���q�W���̂�8|�.���c.�	l�9��waNTa�܍��I�OERQ?អN���6�	�9PU6	$`a4�C[�Q0Մ~�R�V���0u��*���Do���(
���{�	�b�;�a���TQ�$�<������r���D\w��aМ���D��#*���4�@����_O##GJߍoz�3��g�dDV:���W*�P��7�ƾ������rK�-V���n��% ��)�!#1�5��t�_��A�_����OP[���rof�xN$+_���=W�6P��H�e��;Bf���V`^@L�Ԣ��=	p�ݦ���G�nJg��9Q�p��r����f������gёp���ud�*h��Ì��!���Ҹ�,Q�m�}"6ZD����PflbL�� ���B�g�?�	��������b���*�#�ulS	�1E�%���K���(�eN���ρ}�hP$k�lJ�zG��`���M^z$��NO�=�cS��;�xL��g�bE�j0�dH�E�r�رI����ű�\ε$�<���˥#�I2EY�]���>TN�ɜ�출k�
ks|�.��j/�v�{���&7n^�9��ݮ$&�⻨!d (���w���Ǉ01�;=��X�"j��GvE�Ř\�0bN�?T�:[	.�>G_�`�!2.8y5+y�F�{�5�B�SH��
G�K��Vh�m��Z��!í�Bq�q:��G�"�H�ԯ�!�'�O|��X�2�i!�\����ήo�R�o��Bi��������n��(�̀џ�C|^��<x[���9}�5�㠖|����YT>w�ǍžHN���̣2��o��u"+�1ơ���<L%��
�~-��8ȓ2��qy<Q/���[G��W�Y��	���ha�V;Ah�Lm}���o�24���0��ݸ�y7~DfY�Ц��GՐum���ύ�	�.�2y���ԉ����,�-���<�� *�))���q;��B��:3.���Х\fH�Tġ
��m	C:�2�*I(S0�HG
���ۉ�P�+�M^p��1O+q5rΖ'�
W/����~$N�_IA{���T��"�ڞ"�w��d�*`��:� �R�H��P���$r��� �Nb�H��̩*��uj!��+$�3�3(SMn����k���5���Ǐ��:	�/��y�|(a�d��\�g�/]��Vt�`l�0q�wt�����e�A�,����v05�vF$�oq��t ���L0-�O:2�P�4�շFsC�i�D���i1c�	9K�H"y�}T(O4UE����W�P2�x��lBhʃx�`�D�&��$�r"�Q�o�co��q0�I��Y�;"k���:�a�]��z�A;���f^ψ�H��������U�O%�`WXVCY1�����4Pܸ�����=a���4ߍ��f����e����V��!bj�0��.�� �Tƒ4�L%B/��^Z�61$(!�����d��f���Z�_H|-)�	{� �2�,TOF����щW�D�b�O��R�*�Q��ȦJ4D�^�+Ixq����>nf��x$k<�3�"s̎�4NZ��U��5�ί�d���
Ri�]Z�?�eY�<��1���[,���2U1]���Ϻ�l��T��-;��u������"~Xx%�Ŵ�vt�ftn0�4�Ȝc�C��=�����K��������6�O�R�){w���]��]��]��:W��V����v�����?j}*�o�#U�Te��0��q������-FU���T�D�?a,Yf~�N�Ww�DE�><F����O
5�-�����G�a�VㅚԄT��5�<�o��������i���sK��g�AŵD���� �nVc�CC;  �*~ M����W����q{���)l1X�9����8M/<ڂ��+K��OƧn��F-�
�\i���1��7�b � ��R�g,N��p+��\2�t{�P�0	:u�'�ǜB.
����w���c�=�ݰϳM�ӳ�d�`}�{QR�խ֬��꤫7t�6���Љ��S�4�^R�=i�2��^X^���ٍ��K�~=&�4&i
|Y��T��ό�֪��;4$\V��O/H5O�m�<��.$�3����ݢ�E%��;=��T��V�;E�J�'�j�|�Z�y������k��OwFw�|?O�y��״��B
��9}���̎�Su���1C�a�������gښ�]`ou��mMCl{���Ncw��&v8���^��ab�'0L4�CK��1�!�~���,n����
GS�i�C�L���*A����.��=6Q�w� ��A����[@.]�mS�.A�cE��.A���Y��	⮚��W����=_y�����	
���v���ƀ���kZTSh�9Aw#:��w:�f�u����i�IS�����׈��K�0'�Y��m��ӍԳ<��Ul�0���"�6���Gw��⋧'\K���^��>}ߤ�%�A�u=�.�怯�~�δ5��:IKɫa��/%]3��R"��,%��[OzWg�7��m[�k/S�k��4���4Qiޞ?Ģ��6ӏ��t�Ԯa:�t��6��4,��Q��vi\���D�>��n���������m��~���S��]���:N�w2mM�zT�Y&�`Q�UVL{��w�J4Yj0+� �Z㺬��TxO�0�e9���$T�=���,�b�vT�j�o�p�Lz����| ��1jW��`x#�Kp���'L��7d*�2�to�G�k�����#"��xxvO�Ϧ:�)����-�r�=0�̇���|E&����iw_"w$O���N�WW]G�)��A�ց��Z|��I+�6;\���d�"��2"��CD�³@G|��;m���l+��V�%�9�ٸE+���Nxf���/�s���,H�
�oƇ S��Ņ"u�3՞��]�J���.�N�������V�)L� �\y��b�J�IL�<LL�$��I)x� 
0ȶ�t�� �]�e�Iv��.<_`��Q9�!����BE�e���^xr�D�%t�O�m�w�ip��NJ0��bZ��SU+����mX�!��dm���
T�SyЙ��-f��4�"C�ָ�7#(��FS��Щ��R;��=G3�H^�sě�#��ѳ�H��&9�+��읖�+WH�(�H������i�r�\��ECZ�⤋8O�}�������T�-�1y�|v����6c�چ���i�2i��*����S����ޚ*3>4#Β��ky�Ӡ`��Z��A꘎e+1&��vu�f��M¹�ش�>7�B��6�t:�S�I�%���'�0���Ođ*9%'eLY�T�	�X��>7�6L�},�u�a�}.���o[������R,x0r:    �9�#�[7sa�8�8�Њ���9�I��ԪI�S;�=YfS���z���oL\��=�\� P"U.���l��FԚ�{���c���u�7:��d,���8O����^IՀ5�7��ғ�39���F�&�UY��S?Y̚��~�T6��͆w�W��_���x%xuDuDuD?Z�_�_�_я�Z%v�j{_m��}����������n{�������j2��mU�����,�w�BXv�t_qLU]��M��dp�"{��*�ð���N��%��T�����x��MuW��1����H:�_�s��Q��rXc�^�<��B�
9�kz6G��kC��;m�تV�X񧕝��SWv��N]٩�l�~�Wu^��L^'[d����X��*�-��G+Hz���s��ue�I	Z�*M�~��x���+^l�k�\������&��v��F�NU�ϑ<[�>Y1mS�VeЋ�be�,ܕ���pW�?��k��+���e^�=V$�yh6��J��-�k�9��i�9:9C��ɐ�2!����Vv�ʎZ�Q+;j����Ƚ��������9�:���Ƀ�Gy����k-���ܱ#c���U@�_wp�;�+�
���h�eM}<�P>��\o��u�v�S�
U��iY��K��@�+�B���+wF���s1/]x�{>ŝ���MTTh#�#2GNŧ��Z[��O�5,����=���������Q��T��RU2�d߉'T�п��ؚ�C3�Ò����jl��_���z������?>�y�;��H��@ݱ�z Ԇ���E�ՉC_��W��B�g0���H]~͹z(��Qf`x��a��W��_�I�����o���<pS����0�T[�t��1�$�l�Pl!5�z�]iգɸ���G�\��sK]S?2����^QX�r���?���w�-���r����ۄ(w�N�}|��l�G��ƭ�D����DQ�+`2KJ�,~M�?��������E�F�a�()��,~Y������
��*�e�+!ݑ�b\�K��,���[�RB��/�;8�ƋKR١]�!�
X�֫�u�
X�֫��*`�Lk%��Y���7��,��m�؍��77�WU�:�v�g����Z�S?�J�M�ZO;&ϒ �Z�H�b�q��` Ly���f����IT�!%�^���*{>�V�w0�ǭ�RW��Z�G��n�	 �qy�Z�T��f�,�fy�,�@Q�;�ن??����D��Qԙ���
8���oh��o`���ւ�^�.�-�An�y�bd�_�r���p��.��`�LU��zY*�f���-o����h�J��f��xԑ �(�*M�e�y�=I�關,Z:-��ރW��L�hQ�=��%"��mj9F�#.���|ܔ�1�Yx�2F���,�yf�H�֦����e!�&ؾ���k/�_��ML���!أ�5=ݡ��p���6Jv#��l��ET���G6��! ,��8�/�*��r�~:$	u��T]V��#��C�;^�>!��(��>r���g뵜�3+Vϝ�C�y ��~%4/:Ū@@.��1~� O�T��� L����L�Q����@ڵ���L�Q轇��C]j}��R0�
��lT��^^
���Rjahw�����jF��ZV���h��,��酪b���DX��O19��V���^�����[tZU��k���Nx�x����Kcv
�x�V|�d�p�
�K��0�v�����!�%�@H����!<�m#�p�IѨ|0s��ˍ��Z|,l��Mi�����W��e/�Km�G�x�ў�F�*?��	��w�B:�F1E�;ōS#�]v ���o���n�����m��GX��!S1P���u�<��sj�i�����k�ȳ/�f�va><H1��T0��j��=��c��$$��?�_���]�ċ���<7x�D��6��N���j񶜯N-�.8[]"[-3�W'�h�!��(�s���ŗ^��^�)pt_��$x����Y�0s�\B�'�]ܖ	�q"�5i��
�o�a~f$�)��㫳�6��ν�N>�F޿���(o����5=@d�z����pc�I�@�D$-=�V�βE�Y^$>U�P&W\�E|zwy��S=����!Ҧ��OU����Z�6!&�85])OA�BHC�0]Ԧ,pOw�s��GI��a�a?�)����v_̦,rU�Wđ�e�*ܲ�U��5ߒ`Re1�j\n�[�y��
�p����W��R�J��z��^\j�Zhc;٤07t)(U1X��xI��)VX��ܾ�E��f�+q|���87�. �!��®��X�E_<���:�<АGKr��E�L��Ut��_��R��g*B�v�`M"�3L�lu�luSle���P�>���
Y{�s��W��
��4W'�xw�>o�����(�}�i���-QE B��p�e;�b�<��?�xdY�E[V�" ��B ��ŗӵQ�Z\)�{�C"�-˵=
C���ך��A��2 l�����vf�K۪�%7 ��]��xi�N^6(�0*�Xʙ�-ӛ17%�?�O�+�nVEلrO�r�&�yS,�Z��፧w�@�.���Z�Ư��f++h{�ro(�'�5�Mfm'[f�Pǔ=m��Z�P������{�����k��)Y�F)�ޠ�f�:�ZZ��c�	l	�0�Ⱈ�/v/^��w.]�����K�N'f�N�Zs�>?��03n�u���4��J�i�c���-3�B�e/?z�¯[��R�I�|�3��e�$.U���������4P����V�Q�-�z$6�e>}����ѽ����[p�GԱ�D���'ë�����S�VS��"�"�f�����+Va��!d;q��3����c�y�~����TGd�&Q��ݮ�	���i����>��|l�P���]�}���V.M'����_K��6�'���㯯�_7���P?1���A�����}t�4s޵��9&��3�9\a,��������l`*!�Dp��<���"�N[���}8C���w�e��Xg.���w�z����f��
�c9$���`#��p%��8�5��Y���f�l�1:h��V����Y<}[��4,M0�:�	r=M���\�C�vPOn͎e͉��f�1v��2@$�3N�VJ�y;׹����p���[��[~},An%�w���)���m(p ���L��X��!:�7�Ӱ���	+��e��ӻ�|��������?�-p���K[���?�����G<��v��=�&v�ף�D��_P��':�� �)����G����U��}JpjJ�֔x?3�p�������X�r�*bi������aD6���x��Xׁ����VhN��Z�s��F����(·����i�9(���/�� �h�xO�<�+�Y��L�ڼ�Nt$��5��Ɨ~�}#��2�:�-&1 w��H����׈��:aޤ��b�^Cu�U�rf7}r�B��a
�c+��a��5�*&MB{�v�3�&#sS����tk��~�S���dm�FfΎ�>	9���q����z]�	;��s!�3��4Q��UE�i�gA��K-�c� ���w_�������p���*w�����X�E�:�n2�"O(�<ʀ�}Ȗej8E�؁pyÙ���B�܉ 4�m-?��Y,|'W� <1\YO���2^�S���܈��:�I!�S��<d�XP�.��;�-�K���:� �\��x6f��餀3��Nh�B�f��_�������7vm�m��q�a!]V�ҾJ�.l�p�����;;-�ֶ����`0�eN��y˿k�V�.U�&��&���e�܄\̘��&��$��1���h���sG3����6��q���Ӧ�H}XuՇ<�Z�uYfC`Jr}�j�̯Y�+0���Ю,��]sb� ]�Q�$���J���"$��o<�S�2�����B�XJxI�<C��K/���~f�h�Fư?Aư'�9��AC��?5��ˠ�\��3�G�!�~tO%�~�]�ϣ�F ל    �"��n�4�g�/�=�<�:�� ���H�R4�����t��:�u'�.�\X�VlM��Y�9�+ D�O����?ͽ��*w�v-�N�Ҥ�(�5/T���
���'��+Lf��~5�v�H%���t_e.��U+�#t�8�W?���l���](EWT���φɓh
���b'�>�4��q�eTJ�+Hա��T_,߁O���t<��y�;��p�����[�X��H��� ׊ȸ���w�#g�ͽ0	HX��Ԅ�xc;v��Mο���`8b+_J�v4.;=���������#y�נh�B,�ȩ���8|#���en�A��r�o�'@�������WrZ �xW7�̧��'�Ϩ⟑f��Q�ľP$�ni3�&�ɤ�EK�0��g?�����x���P����nt%�37!��>��3CxU}|{�Nچ����!�1�2�?.�V��&�j{��y����̉����rӀ��W,��谲y�k�kNJ3Wu&B�p���m�HmRi�o�(�x�\������q��9�/��e�$����½�S@��=DV��m��3������1^��2]f�c8L$Me��d��S�hU���ѣHd�<YB=��qO�,�ZK-��Po)��\�'��Q�:KIpRC6�����?q�A��&��\�V�ˑ�u��ގ�*N-�%������[R?N�rb����+/��_8���:��A�� (65)v(JQ�������I�^Y>��J��:	H�3�@�q��p�wU�Ea*������e1��0ߖ
3�TDP����#R{�5F+�$ ���\���~f�r�|���hK�/��j�a���P���>�i�с��;D��?+�g�/�E��$��߀K�oO��m����Ω^y[·L�n�f����l�A�_�����/+�(j^�*=s�ȗ�X����J� �py�j�F�OQ�/�甍&��h9I�S������:e��ʓIv��)>E�J���br�Ֆ�d�mz̆/���-i�]f6�k ��x��N�������Gp@4M���gļ-'�D����`.#���˓�5�P�d����7�dO�4��@�d<����g�&\m��!/�$���k�c�$¾>ƔB>Ė�D�\n.��,6�f�������5p=
#�!1���~�L�y���]1p}}	'�@�o��- �C��)~�I��p/�#ë	��rr�;`u`(�'���i�NG=/� P�?�}뭳=�볙aP.�̈́�'e����hP��P=���`WPD3.��s ą�-'�(� �c*�\�ø�A
�q	I&ŭ&�	����cHa+�>��q��Z0ZIQ+A�=a9.�E=)���H���/+��;���^�[n��R9t�I�n����I6zCN��ݨ�-�`du�˝���9'Z#��\���Ͽ�&�K�w5"�_û��~��4�R��7�X=\Zr)�U��������_�P>e�J��ƞ�s��։p�i�[�(w͜���q;���`���K�^VT*���xW�p���C|�іB
_�-�,�8�[��	b� �o�3L�?/E������N�E
䡳h�>�f�oN�=t�8������H͓��ǚ;|]��&w��oO�CV8_1S&}�.�L7<	�^^�����Y�v�8ᇦ.':E�`.ܑ츺�p��:��Qҽy���PF�w�쉀ݎ��ƧI���v��V�m�Y�]Ɂc�S�����Y0w���,�0Hx0	�]�S���`�z�D���op��I��5 ��Q����T��v�6(���Ҟ����'�@BSԻ��̛z;O�e�4�Fc���3��5_��<���A��]�����{=ڝ<}���96�� ���5)��th�b�@st{l�t�c1��Ǎb��-ZxFm��C�e|��h��p3�;����A��\�sf���d$���JJt�3�J	g�?%����'f��g��QަX��_�_6��4�I�?U��ƒ��%���6�Jw��lF*�����	��rv��8��Hr�f$��ߘ�R3�s���,��峕U��W]�R`�,�wpi?JI�{"��0-�7���6�R)�<�P���*0�Un��*�A12��Yei/�FYe�!�X]�w��]6���O^� �$�*���Υ�O5����(��=�/Mٷ�ї�(�(�����4�7݅�4��л@���B��5Pz�I�@/�ϱV^��y��@%	�@u�)P�`h�&�R�O!ύ/&�^��p�jK��4�x� �A���/�Mμ��܃��dq��"����0�QP���L�ɟJH��"��4�����Tk��"��!���	gj��K����܃J���bTc�Xr���ה�N|2u>�K9�M<.�".o��
��Յ/���m����~������Rn�Ҿ�t�ShmYg�;�3�x{�etu�b��9��`0Hh�`�j8?�~�BZ:&��㢴l�Ю��ݩ��i�)��������_s���ڨk�`wc!`f|s�4������I:9�˷:�>���h���p�	h��M#)��kdV��d��A'J��U�4Y����4����7�����~j/l�\uٳOP
�=!��b+��s������8�)L"w�5y��=!�&�����l0��#�\�T d��,��bŽ+�0�|�4hΚ˼z��iʏ�BkGR�`�~=�s��,�Xͷ)�}�5&�B�I�Oԏ�ri�#�Q�y�bV.��|O�������z�`���;(�8vΆ�H�ÀNR�B�[�d�*@D����B�S�������+�G��5^�}۳��a�iC����E�Sݳ{��n�7W�^��1䑣ˣ*�Y�#�䊉8��X�C�j���h��AӺ&����e���	I�aHA���˃/�.�Ê��._,=�䀩�ܡ�jrG7��q������F&~v�G�[�6� ]o��+�%2�+����������4Yu�g�\�|,�����g��O��+��B�F�1�B>��˳�YSAٺ�?�D�(�B��7vD�6�y�&*")γ[i��k!�C�SؘV�;�
E��IZ9L��e��12��CʵS&j���������T�a�x��sC�Ӡ��H������\˟�[w0k�[Z��g{|~�m����w�<�Fio0ɹ&�E��	����Q+�k7�K�%<��`�R0̶��&��
K51�� v��d�,3ޕ��*�Y�u��hw�����W�G�A�|z��9����u^A}��@��`:���f(�5X�pJލ��n�L�'s�
�V��k#�u���q�nP�J�q)/�o��j0�X�W5���[S�j�EM.���@��KM Cהi� �J�CI׮��:U�s���]L��]���|� W��i?P�}l,��83	]8���E�o�Y����������#xF�Dr`G7;�qd#ﮖQ`G�Ώ�3�6,?�#��6H&�1��$y�_%w�sZ���ir��J�-��@ha� X�m�5ϛ�Z!�YS\Ws�¼����Ờ	�㞓�)Ua��{�Lc�zul��;��A�B)���ݘ?W�l�(���VP�M�l$	����z�T����Y���]���S>�q�'�)��-4UӴ�;��L�?��Z�5<!�,����M/����klf�ҫ��ǋ�)G���ы���Q'�.;��[E��$��0�3��DW�ɘy;L��E��1~Q+n���I������Ӳs��81ǬOԋ����g^d�D����'�rί���_4r���}�5^ymp��O^����&SFM��|�����6���l�Y4R����b��'�����J��ԍsd�8���4�L�T�v�~Q�Ń@��7Iɿ_Ľyq���ܠwI�'[8"�|��o?�|��|�x��ۆ���;��#ȃi�bE������P�������	��.�������_�p���I��C�J�������    ]���W���ESD*����~��.��Jt��U��C��b.�̅���6��;/N$���tE�.����?�/#�9�R�(=N���`�B��-Y�E5�i\<V���}�89�dj�6f(]m�u�>��YA���3��I��k-˶�L����~'M�P~?{����R�r|�GRLE��ye�R�}�z:G����X�pTD71k�SZO�	#Z�
�w�P�~-��}��c��M������7�z��ޅ�Ƹok��Z��A\�u�6pӅ���&�������_I�{���D�&c���By�f	�pe*D7m�Ktܦ���8pz,}M��D����4�Rk~mi\YE�5���k���c�R���|ꛎ��[����c#��������}�RK/��5�{xpij��y�b���Ŕ[�Ai��q�I������ԫr�S��B�	�/���ePP��j����-Z8�)��Q�r0��8���c��Z4���$a4���?�� }����{��i��[�U�	h5����`���[�o�`�Hb.�`��܋�Zx�����^�y.,�$�O�A�hd�L���)��rN����E�CUQ*�׋׿���6X۰�f~�pm���ןw���o� 3��fX��10á�1IgA�}>������EA(�͋/�����S#�����Y@�Ҏ�-wnq�Ħ���}�N�t�!&���9�X�P�F{`�ȑ��y+ܧ�wj�/��x���?r��ۙ�5�H=����I=N|t�͔��:�6ڦ�]�"�%�� 	���d.�j���Z|߁ �;6~�7Í��{/��gO�w��l�Vl����P٢�ޗ�>0g��0~�?^6^<��[������xFl[]}1���"���
�Q����W~lD����.��7-��@�Ԡ[]{q/�/�rq�'�[�Y8Cޯ��'?}����S��D�B
�L�˯p�b	�5(�e��^f��U���&�-���ѷ����ӻ����{��	���@�^��a�8,�}�>y�H��፿_������;������k�]�d� �y��S�Jl;�ɳ�בe���65E� ���(|�/�H��/�p1=��SaI�Y��
�|F�"h`.1ά�¡ͅ�Sq,ʢO�:ESo">�6ս�!g�'�P�Rǚ�.�Y^�a8_�&�\y��j���H_�����_���H*�܏��B����kR���=�}�ݤ��\��5����`r&m,��b��0���w�F͟��3��v"�"bئa8>N�w��;J$��o��K��gO�3i�`&��6��?�\�5�jx��l���M�}�aK��f3�6m6��~65����baD��E�kv�}�fto���x������-A���c���,\n9o������Z�BRP��,��U��ؘ_�q�v��v�M;	3�A,K�eI4�f;h�.�7a �c�
���t'��涴��%_@�2 �k���?�������br�����x2�P��� �3a���q$����e�0�1�؋dmE���n����E��J���e1�3-�������X`/��z��B��
&����:�_?������Ꮖ��(Uݯ�,1C��֊�q�[�7�4�:$Ǚ�E��}(�9�r>��Öc� ߭�B�m�B*"��b}��SHK�������*,9��>{F�"l`.d՝Ѳ���rA-�h�D����	kF�"��fYA�)��"c��h��s���%�/}i��>�՚]8)���ۗ�,���\���@�~8�0��5�������d����V3<�]��~fp'2���$'3X��|�p'2���$�΀��t6�l>;��W��,(b�Y 	�B�f���,o�D�w�cf��)��?��A�b�Ăk3t�*��D������ ��<��<g��Q��UfǄ��r慴s9Q�2�[��Yk���v^��\<p�ČY��Z��d���Y�h��ż%���?b��Ŭy�30{�����J<)�|��e[h�(�e!14�@�G�*A2{s�Q�2�V	����M��������j���с�+��uBb<ڔ����fW��h&�l9�v�z�3c�ܖ�!u�q4�b1�B�Ĺ�~��hsM�VA����r���'���`�����s�,���k�3��o�p8D�U�ɎC�-�kd	V�)���p�h���$��P��"�;�"1͕����+�I�qQl�5k�z�QE��Y��B��Ҍ4�+^":4�D�Y�"A�=Ks�̝fw�C���lGL��Z�t��Ȗa��t�Q�(0�2�H�|M��b�B*YB�d��3̶�y�#7��
���zVpn'����0���cB�9�� 0Qo}��B��Tp�g�� �(�gx�Lf��=B
���"O�)J -i(ŦGW�L�D}}�4%��˧�§M[�cf1a���,GUH���E�Y"�V�|���9�,QkYb�4L4.w�D�c(�%��vƼ(�)�'��KM�xq��i�v�{<.�� ��%���U�xmj&����􋊋s��	<�L�-v�t�-��tLwZ�v��܈�)��8��w}!�sM�V���P+��,	mD������<Qq�:q����?撬9�$*I���s瑌W��`�ؽU+v�p�v*q{���������G3��`��*���L�U�yc�h��H�U{<ҫ�n,lϼq{U�>K^su���cuP��sU�i��sp��*Qp�$�_ J4�ס��\H9$Q+f?	Q#lﲂC\�����O��k��Œr"���J�0	��4�L��΢;{*�����6������P��6\O�U�C�ix��9.-ڝ�т@h�ar��o���oF �MZ�
�<VL���f9!姯J䍆,��͚�:�¦̢^���i����g/��@��D�9�#�2��:%
i����X�z��С)��A�C���8H�Ώ`�:�	ס�Q�6/ �Sȴ��n������[d��E�cҲ�<��1>��q���]�';<�}x.m�;�D�O-�_4<Wwxr��A;
�&�9u�]D����B�S�l�i�\Yv1Y�Z��3M�|qn1q�;֬O�*��E��O	��`���,�`��������:d��D�b�p��d���%u&��^�C��WԴًCZX(GK��dh�8T�6H)Ѷ�^A;��D;����'��n%������:�\�>�=�0ݓS��P�3b��l54;�������$g�B�M1E�e�$ׅK���d�B��.ämDN�G!Y�n
7xF�J_-��d%%�a�㻋Ow@Qc�\�>Q��F1���F����w#�uoz+��C�d9/��H�L �-<41��ב��ua����Qm�I�LL��L�'9,B(XB�܇0�¦��2���>9�W��lcP6�u�bPu���B�D���P��lg����d���?�7���АjU.�(s����.Ґ]f��r�����C�4��RV���~`|a�jb���~T|�4��J��N�H4\7���4�-�-(�8��<�p3m�;"��Q�/���b	.m���y�t��A�ڈ�C	ٻ��_����4���0�8�4�o���z� \Os�fN��7��i��?��.^%���#%��p�(u	���!�<z��'RF̐v"e
��qy۶�&�x�]R����;�C���d��V�"�>�w^p�)*B��=�*Y~�)
Gf��c6A��Z>E�)(�BZ����d�Xa4�/�&v�E�8����{h���lT{��v�|[�ڕ�1S���� �f��$$�	�%�S��F�V5)�1g!1Uhbt��m���f���?^�t�v8�S$����x����p��ẋ�ޠp�F�It�c=�k<��m�wq9a�،q.W������v��m�8U2N�,8�����9��G�8����J����I�itǰ��Z;0NZg��/?<���
������<Ud �F��    ��GR�o%4��!Ӆ
\�)�'s�;U� ���'v�*̻�=�P�ĕRL��_1�)y9���� ��>���e��8��<f� 'g^~��B΍W����%��o���)3Εc�1�T)�1��Lq�[�Rg���R���Th�d��H�c�x�F���M]�1W��j�"6:�qV1L�&�h���"3n��*�*\%o8��L���8h��[�T��\5މ���1�h�b��Y�UFj/l�ސ��1ִ�"����|��9�Cr�\6.x����1�ʸ[�ԣ#���-�ж\�m���Y>vKR)˃k%N9�ˋ�0�q)&�Z�=vmL)�-3�5M�D^Ü�n���a�l�]E�q�m��qY���ot�dy��r>�!�{ͥ�|�.;$�Yk�m��
E9Fڙ�E�-6�����)���/ڒl�m�n�eS�\:v{��j�[o�!��|ǯ��+�m�6�j=�J��OX�p�=�����fn�Ȉ�M���hO�2�C�$_�"I1v��-���ߊ <;$��f �RlP��i68��~Qf�R9��!w>�b>8| ��}>����b`dA �\ם3�S:���ui0M�4���h4a���C� �n!�M�[z���o�P�3�p�Ã�gA�|�-��Ǵb��WS�-��4Q�����
6�(�L��V����Ȗ�.�yM�	z+�)�@����z^p(Fs��@�Y䞮�1$�4��{�X�cs��(q��H�^t���~� J3^�����֪X�.���(@���0�@R��|�r�6�'~35f�Zۦ���`��U�x���cYjd�����Z@|E�Y���=��<�,��T<-�m�J��Y"��������[<n�a�?�gq/\��y<����< �&A[�l��A�� '�qׁQ,-E^7s%���x�*�'�<J~���f'���9�#b��ƝW�P�/��a���=׻pр6�}�!����4^y��b��߽�����级*F����۩��o�n��/yN� �����7�	f-:'��ps�~��I�/��B�j�Y�"zV�������[�Ǣ��	�'r�ϕ�+��:D$=�P�tgLB������t�@:�fB�S�����0c\}Z`&㏢+�fn��3���`��>�_��a�����\p�I������d8Qrv��;CM�Z;�Z�-���]m]Lr	1n.1E�>�UԚ1~1ŷQ;��z�-5a.5yf*\-2j�@S��M�K�l��s
+�d�P�T'��h�B�49�a�1�L..k���=�ɫ��Nv��3��B**l��i�SI���j����ů���8-�H�����P�o����4����v�HF�VO3Y���Â:7��D^�����5�����U��/07ë��㤸��T����J~�3��8����|��>��!$���\A�v",;%��=h�$����ږ���}��k���w��ykI����a�����kD�>�݋�+�"nn������E��(X���V��$-7�w�HP��'�}g��R;4��* ��g�e-��"�^���z�<��2���B}ʙ��{�����ޮ�{G�=�����L�R�C�|>����ߝ���j��
R�ɚX����P�8��kS���9�wU԰��G����-.�a�iYe��cȄ���=JV^i��.e2��dm>�GPX,	FXB�~���F��8A�#���WEOCq�B5��&�Q>m�-N*y�K��E �Y����K4�T%�ߙX�$GL��ɨ(�7VЂ��!'����������RQ�y��h|���I�(��$b�H��)��S9�R�W�]��w.͚���q]��]E�����H��6e慒�v��ŕL5�ȞUF����#�N⚚�Θd>���\��z|{�A,/���u��� V������.2Z��*�\HN�JW�Ѐ�\mbi�Ե�f;}�Q�RD��XlIP��h�!�������" �l���G��8�p ^�V3Y#"O#|�'BN�+�{B�ԃ��7��9#&v4��e��*�&�Pӈ��������Dx�A9��fY���G�2���ME�, ����Q8ɒ�b�%�� =��=mv���HTeB r�J�L���y�%�VJ�i\�Ի���Cb~�rrQW+5i��	*jy˵���e]6�&o�r$s�Q�b$]?�`�v�� }��w�1ߌe��%���sϰ�ӎ��2V���롩-i�}�0���R�O��$PS!�!~��Y��3���ClI�
�IG&cB@���!d���xK2b-��� ��O���p:E�e��Ibk��%��l>�/��4�-p �yS�$%N	%*O�5��h5O�x���<m$�1�{۸��m�P��P�T��_fI��CxBQ7p�}8���y�@<2�/�� �M���22�hZ�9��4�b���~ ?S���ƨ�������Øv�}���{��A[���ѕ�GvD�F�0	�g^����q��(��� J�r�_~WC���#Q�!9w�F��5��Q��dl�� �_	��=�qq��=�6��c��C4��oǧ#���$����ޓby�%�pS^�e ���)5:��2�A�|�=�$�#�B��2���j���$��#�Hl�xaP�Ř�Z�����Ί���Q��I�����x��P](�>5=�S#���~q������;�}�o���ι�o.�}��g��脝7/������o��w�߉_;ۇw�_�:����;���Vڃ��j���Ѩl�҅so�v�|��w�5�}�o�����V��Յs~}��Υw.��H�����҆��?�;��iJ'��9t�Ԫ�?�{Cq���&��q5�1޼лx�����/¨$���1ɦ1IS���8�ό�֪��;4$��J���`C\�4�d[6���n�!Wͻ�~��G��7O�iռ���'�j�s��'H�j>�Ѽ���$qw���}$�A{tq����b�sg{������<{)nk���_n\���/�}��[c��9��.���!���u�yS�C���ۗ.]8�x��`��'��	�߽���{:3=��n�X�kٽ�m�N�gݍL[\a�̼��tq�8�,k�M�7/�;;x���"�K:��s�!�7�����{�&^o��7��a�&wЩ��^�E�ˤ�4L� ��djk,����
_S�i�O�L���*A����.��=6Q�w�� ��A����[@]�m���	��(5xO�r5zV�y����-K�y���N���˽6?�)Է�7\��Y�j
y�A���w�n?�}��\�̴դ)t���K��kDK($X��,a�؁�u�F��!��*�D<N�I�M%��]-Ǵ�����������.u-m��v�n��f�κc�w�f�jp-�ѽt��gC]J5Q����5C�,�.a�n`)u	�u�R���<!�F߼m8+��?u5MT����4Qi�^w*�X��C�L?6�N�L���:�2���kX�5��uM�R�����
$O�Vк�}FG'�6������.cu۰��g���2��;k;������V�g����T�("�G�C��-�����80�=c\�9#~|ΰ�Q\kY���\|���,ϑW�u��#��2%�?�Q���(�����5�Pފ��4�h/�#y�~q���O�H��cI� �1n9���gxf�Q$J��L�S)�Ľx����<<u$]��<��]7v=i�8O`j��IZ�S��ŘJN�� #����
Ֆ��c�u�M�a��s�N�X\s�#�?qk�L�bq���F��99���W7Ȥ�`�����!�����#��61��I:��L�H��H�k��*�$�Y����<�\<H���`B$��F=������LJؓ_��*����� �oJ28���eG�1S0�#N�89$pu�x�@r�H��:�9��ug;� �  ���33��	,۲�����N����k��I:	L�N��N���	��Iu�TwC�_�Z��[U�H�Ѝ/n>�7Ϩ`x���O��T�=�	��I�CX�a���� �T-�*A���~�AkJy���jUC�j�:�<Aʩ�^�V	­�M��'H95�.�*A���x�j� ʊ�I5O�i���	�����`���3�/��L����~Y�̦Z�O�7h@��74vhjH,i~ݚ�Y�nOuk[',�8���	�@߬X'Ƚ≯���	��q5� �1˩9���Rn3};��)�4[�G�r�ַn{R�R�S�kJ9���ѥ�)N7,n^S�g�	��N��\���+�m�z�N��v�1�^��:��H�5�`R�f��g��g��	�ɤ�}�7�Ӣ���t��)��'\I�>��a��WR��l�;|%�8V�w̮��ik�=a!�	Ji�ky�ZH�m���4 lǓ����t�i}�k@ئ����Tv�aw��)��i�Դ�T�����L��� ��V�A�k���N薨S�oM�i��c����1���u��纝~ �}�Ͷ5u�>�(M�з-� �o[VBo���-��+ߡbi�-�Ж�����.�x�����I{��B^�o#��*�m�d�ܽvm�C�$�(1��h�4|��nK`De2D;�ի�์�\��V^�6Z�(�1c.Y�9��՘��3S���$̴�%+�j�+;�]���P��l����(�C,�XU�g�[�R��H�dV���qŜp��>��HDny��O#3P�5[���%)���uk�d�=Pg>D"�4I��KB\0����]K�7���c��_R�}�09�d�w���ى^pb�<`	�{���]�A�?�����閦Z3�v������RU���xybS!l���`�VC��So�7�[���9���z�����q.�V6I�����$��o
�E���61 3���SU�r�ɝ*/�:&��<�~�����ޚ<��s�(�����rś�U}v�Y��k�_�$˾�.�?��5�f��Y��A�;3u��Fv%�.��t�)��l0s*�<^�CC+[��"O�ôLs_:�-S;�U����r�?H�pu?%���Ft�����Zlw�C���	X�I��~D���p��p���0��tM&?Ⱦ�#��ħ���n����`Ґ����%��#��%梟��cp%oG�yp(.�:�6M ���NI�&u�;c
q(/�/�8ԱF�hmk��
O� u u��G�L=W�@�u��8��c�S��3�v,.�h�epo�f���n�8�z��Q�"��Z�@S�b����wܪb��t-�ޛ@�tJ�ճ	�����6H�ˠ�镀H\㱶Fc�5���嫓��Ze^ʝ���)s�n�,�<��ע���&�9E����uC}��:t�RÄ%�F6�����j�}��X�^C�E���W��L��4\m�ˑ��2�򅩉��f�L��~`M�*_��pb#OOK��F0���lp/�	���JH/p���쳅��x�a�،�	��س�U��RYzj��q����ƽ�OR�]���̳��3�ǃ��:dޞ>��ؔ9�����b�oO�LN���[�Ֆ�$�V}�����?B�C���1
���6ZDͭ��;���L��Z?�Yh���`��	/���	�}�u�l�"'�EZ�n�"��������j�a������G���Ӂ���|����j&_Ֆ�OF�s�T�ؖKF�m+�S����m����˜��Σ
c��f^��$`��a
����0ϲ�kxƶ��Y�4<��}-G.Ȳ��y�ax�ˎ�+_W?�.�X[a�5e]��	SΜ�XW�r�d#�� �$L5sZ�z����G�Ƹ0������+�4ɸ$����#��Ѧ�ܰ]M�x����]L��E���TH�2�ъr��n(�v��jL�G�*���B�{U����dìc�]������y��Α:,���;�'�vH7�BV��������^��ZU��]%K���!�[��Q������t���σN��d��~��*,'�[q�l�S,��;?,~��������XI6w)��$W�:�ap�@��ڋ��)�6l!Z�+�	�\��A�߈�>U["�����m� �#���k��	_tz}U���?��U��v%>H����0.�?-�)�7��d��{�Lq��dLR|��0�O;����+s�┿{������~9�`      �   k   x�U���@�K1���҄�
�����<QI�1�F��	���,�_�!����O�BkEfޫ��-�y�*���B�[�@�R�ޒ?��▍�:y�Y�� �M(J      �   i  x�ݗK��@�דS��~�ۏ,G��Y�U$�8=�Ƕl�!;4H�D�9D6��x-��s#ܶǀ�V<6R�(���J��.���}�H�(�@�: `���q]�#\��#�=x'R�p�!�'� �Cd���YD/Lmj��:CH[F����"��}����f߲��n�a�����dw����w�n<]x�����9V<�~��>� � 2 &cB&�N(�02[���#�7���0�� �yw�gyδ�9\���n��r�,D,"/M8�S���Z	�ܪKpL����,��ݹ���D���C��0�U�p��]��Z�q,�5ܧ��6�e_�Ϗ�����U�"��ÿ�YS �ƬU/Pu2U�^*:b>��}e5UMi��tC��_q_��;>���0��<W�c�z�I�A��&1x��Neְ�M��_�`KuYK�`g� �k/Dܵ�O��>�U!%Av�^@�6�_��y�C᝼���_�Yu�e�z��������0��zc9׺$��!]?MwQ ZM[U���7�Gu%i,�Z�p��3p%m��Z/P�棹��B};��r��+��E�CZ���<GoQ16|U����c{�
�m��A��9{���e'�b'ϴ�h����8      �      x��ksǕ&��h�'�l7Q��66�{v^�؎��a��( M���� )Q�^tYɢh�k�D˦��q�ČA A����a~��9'��*�2��.`��1c���e>���sO��ַ�ol�������_��.o.߼�9֖{+��Սe_������ʏz����vpe��~3��\�\1�\�ѿ��4z2�����/Fn�����NF���oG��;��ы���?�|�bo=���w��/����FG��F�㇭o�5���ƿd�ZVk|�;:�ώw�=��G����-�{�O��-�}w�M���^�[l�;��G�3���S�t��������/�F�b�����}��%��x���5:�^=��~�}���F�-��9��>g5z:�7��߅�^�w���㏾�İc#�)��7�� ]�-����9�h����e\�u����'��okK�?��9�i��4^^�	�;�Ng]6V�]��3����=�-�}��:�ow��\H�����5c��?�����t��o�������n\[b��|���2t�8��6��g������05�l�O��FB&/���_!	��~j��k�ɽb�2�ٓ#�|�`���>����.���џ����ط��������
~�� ?y��}����(� ؟���OQZ_���� ��0��� �P!��9J�޼4�xl������"]�DY�H�(�C���8�{������ޞ�QZ>�`*�Ĕ>gr��c�|ނ�cm���qe�\��Z���^��]ݾ�i���4�8���sp@�~G�̐'�>c�|���^���>z����=��ǈ�]�FᅗKlNVƜM�cz��f����/���;�o���b��])	kĕ>G��ԯ�dC~<���ߏ�i��_���5���-O@�<;�U��7$Ups
T�3�ot�Fʷ�6|���h����p�ˆ)Q�M����=�p��=��pp�lm�6;[ׯ��d���f-��ڠcj�;�?�K�o^BvO�� @�>�s�'�m��>a:-%��O(�THC��B�Q�&�a�iY�|Y����B
�K�P��Aϑ�	������|����	(/�r�$���-�B�8O���1�M����=����3���hӇ��>%�,SY`�rg�>�>��į>��#b_��# c��S�{[�-�1<�� 9:dD�c��������A#���{�R���"�@O8��sD� �"d�� ��|�M�� ��l(�z�}��O؃���\�brdK���M�%ׂ͍ /��T#��nRz7�����s�GkD��������(69�.�PZ&0����jl�AoB��"b�;�l�[T�D�H<6y"c��Jw�l�GDzEt��փV?;�3���!�	1�j�4$���٪E���:�i�D%`��-�8�
F��y��|��8�?D{�=�.�c��~��ę<E��}�?(�Q�H�s�_9]������>~�St�\�|9S�(I�\����X������p"��_�|�82���v�#��B�^�_�� u˴��ʊ���u/!z�kJ��z-^_Zp�t��2��'�tV��Јa�[R��&�eu��]V@�<����e^�y��j��awM��,4z��-�t%���U#�[7�׆ݮbc6��т].
v%^5��j��U���ඔ�I�@���u��SO7�(n��4Y�u6��ao��B+s�%>*���>��`�:]-'=�I��]g�������O����P%hw�|��2��^CZgl�
�%>-�|Z`Z6���e�_�����gnؙ�k�ִ��X�E2�<�>��}Z�X���U�%�+?#%-�jiR�Ŧ�`��/	v��pE�d��#&|��dm���5�.�Lc[��,T��P]�9ٜ $��H���4��b�_05ʗ?G�+:$�Au}�Y�wo�d)r�H�)��d:?'� ��PUz�&T�}&������A'�=�b�{�-zÛ�5��}���@��#�(jHILL��~�3J"W�]�k�G���dS����?�A�O���b�I6�l��#â{L�1)�G?���7Y��g��3�Zb�<
!]�fK�7������lG<G�=iM��,�<K0r}��FD�r��Z%�+��k�a�22Ej,Dd:)d>zv
��p���&�#+�>S8^H5ŅpL%/
�Ff9=G��"��-#eo�WN�WFs�3kd{�92+�]�>�>��ڰ{��:l2ј�����]b�[BU�8��X��`(�����s$S��5@&�г����\H^�����90�N���y6�r��e���eJ�`��`O������)(���,Om������Os&
��=���6���������~���7�&��L��G:�I����|P<����L�V���$!���]��ַ.(Z�yL��؏,%G߆r�g ;��a8���L@�J<�y2=�AjG��\����f���g�7א-�]!8���d�o�"ߤg7�~;o��6z��5ZcG����!��jK܈6�=��}y����o�d��Y�ؔ�@Qp+9rm~��s�"Wر+�����dqAm���M�;�k��0�:��o���X�Jܽf�Y�V@FN�#ٕ�+��\�W�@�3����Ў�T��$���̴_��W�z������G9���?Ɗ>�ɟk�R^�
�G�C�>_kf=S�f�DN��h�P�?ycbE;�5������Z���\�s$Wo����Q��x���""rr]���%g�o4Inl�T����rED�J�{.��|��3��㟧���#����38�������y��c��I<��d����v+b�l�O�(r�%�5i׾��2%� ʬ�ݭ���?�^��l�-�[���9��emm�5O籪%�(ȕ8+=rV���Nz�v�w��0�>��x���� Q0,�Tz��E�V�_������!��ɖ� 8��`_b�d��[�N��1����m��K,�CA��W铯���i[�A�ڠ�2Xn�nw�o���:�7�z<�d�Aw1��S��)�{��'Q���C��冰�o�cEٹMLj�Z���ⶤ*� /�~�FR�5�a[7��8�T���`�r�؛��m�Z�D�W�.ѵ|�l	9N�Sc���ē	��ш1S)�r#L�]";���9��(RbM-�2����Nޞ mp��68�玦ټm�V���a�q8�IK�޳����� ha}PK3t;�f�~���J��1���q������j�	�B޳}��x�|��:؂t���ڄb�-JZ+@� V���}|�{�����W��9���\L��*V��m�;��� ����Y@�H�r~�ܜI�K��j�$2_Ws�r��	�b پ�p��~5�r�)U-�5/�%?�ٛ��Y���Q��9	���U �(�`�i�4|��P�K��L#��E�`�'9��0�6�+�E�έ����(�͎��s�W����a���Q�-��XP�	�����ir��Է�)�lv�*���nl1,w�����`WFo�o��@��V�����n+��t�}}P�\�,�FAuv��#պ�L��'8`Yj���z���%=BAN�����H�[ޢ��5s�ư{�w����^��Vg���������G��&�d�1H�9c8ܥɣׇ�ܺ�9�H��*F�:�d��Ѳ���� ��4�tM�lhK����-6�;��5���bɠ)�G�ԦL٧��q�=}�Z=1S���O3�P,5�j�{�蛬�V�`�r�I����)fw ��	@�J.�1m��b�l��R�(���x�Sꤘ)|AYM@��U�V�p�Z����!4�a/��oo���/��N�v��T��'�!P^��t����Gx�5fl���BLy(�O���K���?��SV=:�O�-���� ��;�HQ�]��4%h�s2�ǔ��ٷs7 �=.< x�F/c08ٿ�tE<�B.�d�;�J\��fԷ������`�{�)ʸ�-e�F��.��!��tN�!��.�p^e\P    �J�QwG��9л�����E��d���7���_�~n�n���{�_C��]�>��j��QɆ��w���:��r^�Ia��)P�ʖl�f�����l�������Eb@�f{6L��0��)���������²������ ��ĥ�<��{��k�t�}���Y"Fh/,�	P�J�_�o��q
�f�\�+Ĩ�=E�~�l�@��+��1}��7��E��1�!�d��E���3@Q�,٥�p�����+�����J�Af�����R�@��K�.��r�#��b�=~��n���/��QH�D��C�K�_�y5�[�[]rT_I�v��(1�߿�ң�;�ϵWb���9��}4R�-II��Kz4Cth����������ߌx߄�$
z�S�����=Z��28���m{pc�ٹb\���gX�u,D/<�,
��ωr��U뵡w�)�-*l�D�~��љ�ȉֳ=��=_��"x!��"$Io]��DAnv�	�#�^�L�D�Ս��`uR�t/ʲ�N���/�^2�j�l�f�,Ϝr$��9_9��`�u�@�i�u�9��&�|�HTY��zz=+�z��l���8n1FB�����Z�r��i��ܚVN@�VNbf�$F����A���A���m�� ��'̂�LXg;z,�;z̊5�o�*n��|�@�*i��̍�w�N'y_Q3>�|�^�Jn�˭��wy��οo�5.d�Qs ��p��v���z��{�x ��@�|OS�4�̺��<�����*�\qq,��ϧ 3���I �ji���[� -�fo5`/㊷�$�c��Cb}�Վ�Z�4�k]
��V��� �n�֕`����^a����S^��l
��=<L�0���e�X�� ��0��,��t1)��!'Sf�����6L�j����ܼ��P��fH��� 
^%��=9��0���왴�aw�C�r����CA��9Q�7L�V�[����h�2»I�T�CΨ�@�
�,�aF���a�
�XD.#(<J��6�l-�i[A���6�:J'(]T6cp���i4�'v;x/<��Ԧ{��
j%�nX+gUtA���b�j?�}�GT~G��)�PB?��(�V�zL�t@�?CXc��B/z��F~g�3�x��S�vxڻ�"~�{�����OL��x ��Q�J�Z^�7�k
�L�D�������Dj�Q)�SH�(d��s����y�6�f ��"n�N���~<:����W��YD�<V�9�vCr�� ws�_�mtU����/S��]h��(h���\6��s ���\����������˙�(8��y�#� �y�Т[�
���4ݥ��گ@x+��D\0W��Z���QP�ndEJ�9��{b~c���R���Ƒ��ы(�iH���I�`^Hm�K�y��^���q�۝������f�����fɈf�{ �	m3���N���V�{���/�? \lU��}��ff�؁�	�d�0M��M:�1Oz�c�ϰw?��p�.�`\����
(�x��i���k��MR�($E���|��n�Z}�@$G������/,������N`z%�2;��Rq>UQRTK�:���l�(�ζ��|�O�?��T'���KBp>���L>���;�Ϣ�]��q>dwo7�9\��M��Xp-EF���9q�4n�
��&gm���9X�X����?��K��I�_�q~1�s��_�Ye��w�R�R��S�2U59�R�mI�����VC+�_��eӌ��Ԩ)�5:�:��dn�[��Q�����sb�n�e��a:Jb�h���8����l��榹s.vZ��M���>̈��~��v?��_������0�^����?f{�Vou�������kx_��<m	�hjx�����c���^��+����I�'�<&Y�O�H��=� qp��ح|�@v���<6�ޔ�cޅ�S� �и�(�VHL�C��̸�ɌiZ��PR��`{*��� D
.��u�Ov�
���x���UgM��_\t�m�s����$0~}�����l��~w��sG���sN���P��(:�V��x���a�5�^�%7�{�k��a���x8y��Foxv���`mCv@��F���`񣆏^��9U��� .!3���I���D�0�,�Y�b�8�fK�$�;`�Fck5s?�>��iq�͆I���k��>r|w��+C0�;�[۝��P��G�=@�i���� �������Aj�@+$Fb�����]��;)��Ҁrdf��̀�H���֪ї��wSR�c�ғ#9�gv�G�Y��g٩ѳ�ZJ��4�<�Yh93 7�����	�إlk�&3�K����l'�Ԅϙ23���}x	r�E̒~E��jx/��Qt�-0:��v�|��k����
Һwx��G�'-,~��/֎� ��"J��=�I��3z��S���v�A�Q0�����I9�9/��6U۩�B�)ndu$��Ï����lw��s��sx�vp��پ�V�
P�jq�jqk��7qB�W�Y����^c�9�v2�k�%>$������ܩT��J5{����
\Ɏ�;J�����R\�x��Yn]��ܬ?�D�]|�R:Z�tm�I�n*
z<��{���M��w���%H���?/*�KE�de���Su�RbG��4q]ҭ�F>9T����[��냵̂�|��1������N��J�"�.­h��z�������SNV��$V�~Ê��Slug�9�v2*��ϩ�xM�-�9 E�;&�&���ᒡ�6��A+:�KR4�0E�+�&����#�=S*}�(>'�f7<'Nj�:H7J2�d(J�i��nTl

&$��N�O��d`���`����L���hr5�}@�Q���$~�3~5H��U�g�N����d#l[��A�cY�Cyw��c[�,k�1��T���Ik^�R��|�C��(�s~��렳O�waE�l��v(�۬V�$�e�i��5����#I'x'��UT�W)�4T���~��z��j�c;�&�N؄ݫ�6�Ǟ5��c;�f�N�Lݯ��∜���$'�����C��I�����=!�B	���t�G҇����\ʈ���Z�L�/�ת��_|*N${��9�_��߸2+��:ۦ�_�r;ۗ	�	�m��g�4Z��Z�+�����������܈�F��3GMMQNG���9K~E3XNO�e]2�	8f�9�.ٜ�9���	���Q��V7��[�Hot8���5�FF��x�loaZ�_�=�ܸ���cTXq�bw�j|���:cc�y"=`���nM��4q�Y��hߑ�r9<��͠&0{�ӌ�y8��/�W>]+��PU`J�=��ҵz��I�>�DR���w������ZZ~ɖֆ_����a�J�����?'���C�����P��R���H/ܨ�q�T���7��9S�ꕙ9�����	�z�!�W���]��k��pE�ʸ�$]��邺V��I/���1�=E7�GÞqo�l�
����𜰮�x���d�"Z���L��>�7�z,���.�4��cT�4I��?�s�1�Cj2� ��t����i�]#ŧ!��ղ�xN��c���1dȘX����;�B��.3�4Q�\}�����zO��`��1&Z�pw=`Üq2>P���g=�O��V��x�N�i�(��)���<'L+�����մ��TpezO>���|+��w�.T���=����bI�1֭���^�x�P�Ҭ�%���Y��OE+�jp��y�C/��}\.# x������iVX2���d��U�+N�V4d�������9Q��Vƻ�Kfe��Y�����ِ�NF�;U�e�0��)S�/����fNWn���	غ^�xM�{m؍ڡ���3���]9٨+��͂�=d���tE�5	t�z��$�Y��i��p�J�l��˦�W4=񺨍 #���$��z�A�yWd$�ݮ�S-X�|B���VFK.���X>$�V�-�p    �Vn�3'a�O'�Sf�S��&�� Ւ�Rߥ�����w�������$vbUz4��8X�C�↎Qф�%?����,֌��� �?'@+Z��J�đ�o0���+6�Y��P]�ꈝ�@5�nmG����qI޶k��SEs��:�l���o��,�\^�%���'ΰ�:�,����ltv��U��c,������4T�ȟ+��	+�a/[�����g����P��H<G��ln��c��ݍ�������d��l�j�J�r�(gw�.�c'͈�!%s����}��v!'�8��O�e��-�p����#~��Ɵ��&�5G���};��]�.e��@U�pܥ�.��ť���-|�9��́��0~�a��C<��d��Hapw�������x�*�����γ���v������.���-:<������O�"��t�@�Q�/�W���&�\Õ�a�7���X�d�/Q!`j�;��S^$\�M!�ѵa���!����^�?-wZ�eCѹ��&�Dg&��a�W�9�|s2�����b�y��B8JG��J$$���u;So|��ʽ#�1-��GS!��$FӢ��ۃ\�H�+-d��l$�T�Fv�7xN�Q�Y*����^����5�D�NX1q؄9�Ğ���Ü���5����L�`L=��������Ǩw�T���*�B?Nr��P���5�2�Q�X�ć)�5R��g)V��㇗ac�#�S��[�����y���9��)�	�\D��f����/*Yʾ��c���
�:vd�Iku��F�f;����-�p�Nx{�J�'�I�Ó���L�yY�l�J�imY����ض��曐��\��DT�p���:��>AQ���F`33�!�KB�>m��yȍL�O�m���-- I}��W���[�!(x+�������Qi���۝��7�
�&���F_�^�2�y��?BF��z$��9-�&�rr�#�ѣ1�������$��(C�b~b;az�3|�˸���7����F�����a����?�����f��6�:�!���2Ce�)i@e�E�n7��Y�Z��o���F�-�� U���Q�]�\.P��*��BL/��Q�M	��ְ�Y��_�ҘZ�z�[� �ln9R4Uґ�����oZ:�Τ�p���[���Q�,�U]�k��ָhH�ܴx�U܅���i�[Or��ǯЭ�Yo�n���%�@Q8���c���L2lM��<�|�jI��R�J~�6�x''�@U ���7��a&�G:��N()��E��z�U�,��?�|>�%9���Hkƴa��+�����q�����癠�U�vb��$1۳�Iq۲jضHJ=m�����j�k��k��Z����]�]�;]��Ӷ<�Ǜ.mj\t�8��S,��Y���Y���墪'�����fs�t���w�"����yR��]�J)Y)��$�U^X\e�Ϩt�umM��i�P���.Ϩ��&��Nb-G/Kme&!H"۫wC̲,e�K��ϥ��O<����u$B�K*�)+{�n׆��A�i��uǡ�"-:���y�`KDuph'8�!�
��$�^�����1�|ިN��1�fl\��0j��FT��#[tt'2����)�g\)ξ?�k1��� <���+������Zk��1/����i�u�$�WV=S��uK�l�� X�|�뭮W�n�iG�L�dZ�c$-[_
�'M��۹���-�lkun�I�fu�N�3;���8͉L$��ٞ�	��B,*�EK�hHL��
�u�5kyk�{�j���vE���Q w������>�ʔ#شa�������eݲ��*#�t���v�R�iM�ͯI��S�UkR[��i�dQ�����
ECW4!�a�l *��	�/dj��,�$�F+�7��/etA�r���F_'�e��; �!�%H�t��`7eh�UuBE ܲ�^�mb���F�vd��A�,��ՇF���?bS�����H�~��g����L	�|fX7 #�hw�,����m��(1�e�{�n�>$�=FW����ƭփP�F���<����? m�3Q��'(V)����^�f�О�?d_�I��Ƴ���C�r����^%���(��q�pE�E��1�'m��]�'k)>���Q��׹K:s��R੐I������yˋ�َo��KͦЅ���搤����m1rҴ�8�n�N��4��]x��N��N(9�+АNhcv�6�[tm�ʄ蟤�D�gxD����P�x������@�΢W������'�����Np����х�C�� *F_�	��~�Zc��_u_B�nc�`��wvð�'�3j� _����}��B���\��;\���yӫ#?�"cۃ[��J�pL�㻎mh�Ma2��4��m!L�K�I��y�����
�m�v�͛�L	�*q�?'q]�������krq�|�w�̨�6�����RIT8�
1q%���l�]߈�hG7L��&b�8��ybr#Q���B\*�KO��H���%a��Q�EltYs�]�]����ma�}�[q�_]�W��Ӹ:����8��Tg�"D �-����p$Ub#�'�+���?_7��0c���.5$��E�Bl+sH��$�j6�呯�;���ɭ�& II��� %��Ջ� ��EH7ߣFh'��3*k=�gPp����\j�"�Cr

�͸�����E��	�|)�x��������} `��H<Ì�y��gfdzL���Ii<cd����<&�T+Fd�bg��w)dZr���if)��VK�ʻ�Ώ���\�[��Јw�q�	���%qF��q�i�X��&XX� I��Кw˗�	aq3!�xr➮��'��
�g[��	p��V��o�t�go����/~�`˱��
���k���-��h2\�q��D���7{?����[�"�a����$��!2eE���ߗx��p�)�N���zJ[���|<��Y�SI��L�o�����G_3���o�S�Y I��N���r��r�ic4sp��?D�C�Q�E�0ŉ���:��.*�g��b����!al�����OUIaw�]��Ƴ��p�`�4��xT���s�Z���ǿd���`:���9Q*�$��<��
',�[h�hR:g<ڙ\�Yu�ai�ќ�CM�5�;�R��I5�t��gR~0����W��b�]y�����@^��e{��9�������"!��K)go�ey���r�K����$�������?�S<��S��= �8l�g�ߏ����;�a�CDF���U2���\O!62�V��&�Mؚ���`�Ϩ�	�wI�!]D�t�E��0.~�g���M�xV�~�ǅ���a�o�{Jd@�N���.6��#�nz�+�A@A�9F�%n���˹FT��'	��e��+����=�*��In���[6��ΓD���uv�����74�gfW��Z����!�r����fΣb��z'����lU�K�^�'��q}�vt?JF`���h
N>CP!ʕ��'�d�d;��v�N��m܏7���+��]��Z!�����7�騐�(Na��[�֯	���/:��3�>ݩP�MD���@��[�:�	ں����=�g��$T(�`q.�˚�,�+�C�����DTxK�Ԩv�S>��z��QQ<��1���7+{V�K`�㋙��Hd��i�\��3@˃�d��|�j)\@�9�&�s����Q�g<^Q�����>4b^P�}
'��� ���(������'h���lt�SL��_\%?&��~��
f	uT�3�
�C��t@D�{�Q:��:�p�@���>�?��m �3��%O|=i!u��[�4��+�2r��wIH�{���=>D�^�~V6��\�4,�3S*�[��q�b���$u���������Ȓ��U��4!�-�9��G璅��Mߒ�Vx"�ϥ@��X�i�s
~�<Hߖ�`�$T4��=�?38����?��&Il��:��B}l��q�?���S1��(�    E�/���=���x�2�X���:V���߇~��a���0u0��`d�x�A��pҚ(�+�s�tg��mE�q:�Ң�|�5\�֘7:�av����z��!P*,�'}��7:���vT&f��AG�qx��+m`&�-��q�w}ӈ�J]�L�������咻?�LHō��w���U��q�8��C��#��o:�g�p��������΍0!7���ME��0�kAʊ�q:}n����]�+��H��%�.��������*����dT�Kv��j�+�:1��0��dN�t�DT�˟�M��D�S�����fI1��qTM{D�b���*��l�w"� <R�,\���XC�Ԉ��p�Ϋ�Gmrj��jo������g��[����1��ojr}.�{�.C���l��[�1�s�E0D�$I9}��}�[�݂�wI�|0�˭����AK���a/0�	�.���"_���P���&�X]�G!���r��We`H�f�)�V)tѬMI�.x�������tE?�ӱ��sl[TN�Q�A�4��OFEJv1�x�ĳ=Ɖ��ni��K7-��u'	���<;���JŒ$�%L��*�^�u�7oW,����S�㺃;�ݹ��Q /��=��Å#���c�}�s�8fOD��dG����W�_s�S:c|�ds����K�NE�z��s��+Ư9�)�(6�/�c��jL���T�h_ִL��9�^�0���G&#�3}�=i�f�������6_�E4"��OX�����u�>d��>B��G�;�˅+q)��T
�RF����Œ&��>��7�㘠v~�.A��ձ�#�}�� ?A}N���焺�s���gxs)�����?�Ox(������Ho�0Dz@!�D����rGM���������{T�r�S���-��G��2��\-�+�/�(�s������^����\��E�<u���gh�$�Ӭԉ�]�a[Z�!����,;>&*j�G��`�[�Rai�o�b<:>�w��(��%�v���v����3uf�z��p-Ǵ,)-q�)�%�Y�PzNdT���氷�J�K
Nʩ8`�8�������{̢.�~0����ul"*��R[�9^��'�Es3>�/H)�o��$T@K6#�@*���Q���_F���3@�I(�6%��I���U��	h����Q�r��.Љ��l!���h�Ok\~%��X� xQ2(/���G䟀�K<�v�l%ų{�4���|�#��$������1���`�{�z�1�(vI���BY��%Oz=��;���̧�F�4�x�l��Ԍ��=ZP�H67���^�EU5��خ�k�oF��黶&���1K�&��;zl��Y��)(ȼ愞��Ҍ �c[��:�5!@��T��d�2Kz�H(fGg�
�s�Q�%͈p;��h��M�6�&]3�&3��lsFD1�-�vzND�c=3"�����ۓ�Aߵt_N�*�K�
��$$d^Aω�s����8��>}}u�Bf�=� b׺��o>�l�w���g��v��,t�(�ߤ/e�Q	:���,㗱�i�n�*zLA��a~t_x�ä,���&��<���}k�Ϳ~������S�P��&��I�P���ѵ̻ڇ�A��G���#;�Ѣ6�d̶#�v;�h�Äj�tce
������<+댞��WLi��z�߽\�n�\]���(�6\�5�-�Ml�9��R�^�c�9�r2*V�R�9�R�H?d�Vp-���(1-��%%2�h��(�9�S�	O�Ү�$�onm�1*,�u�{�$T�t�����V�Hbn����s�Z�=��ߓ�$�&sGB1��#ٚ�5��&$��PI@�kp���w����kr�6���&J೜�s|��ەl;n�픯�� ���9ZQ�+4w������	�����tt%�����_,��I<Bw���\!�Th�4���V_� | �gx��qK�!�M[�,�l����v}�GoF���-�PB�ס�x�IU�n���ڕ��'�]��'�t	�2Lz��Mm=N�w'����'��/���n�⊏�:"�e���� ^%a�ǽ�z]��ޱ�����ulG�,#U�9C��#��2�{��Nr�;^^��t"
:|�/��x���}^��Mǲ��g������CQ{2���>
${����t�cԸ�w�5��S��M�&jj����#G�� )��DV��	oY󖷂7�Agcp�+D���gi�sHB���K�@u�j��	̹�F���73�����=��9�_�1�@k�w+�?;F5���S�;I%��c <w���y���B�a]�l:z��$.[��eX�8�jI�����?�z���}�c�*b�>�$���X��;�z���a�	�lDw1��˘�����Ҷ�c�;��>�Tܐ�\J�1B!��0���b8�G@1��"�8�fs�+��er,�؂/��n�f���#���ü>��ĜNJ"H���bb�� ���0��aj4�V�*��rfɚ2��2u͝ Sr�'�6{��ttBNs�	�T-[Ͽ����̎��\%��54LS ���n��:�^��4LKq*Պι�Z��H6�p���T5��Y��{��,;��	4Gq~�	�l�o �,@;\��Z?�jlN�|��cl:��^�h�˚�|+���W{��!��XE��F�+|� ;B3 �̎���=L|�Dɵ�ǵ���+��d���f	�3b�@�}�9�vS $��������5�N���ދ�@L�����%��^3�Λf�5u��Mb�p��4OSo4����؛3�����)���k{�1:������E����@�����s<]�|-�
�%*��ut�McJR�VUC�Q���<��5�,''�l9� 2$E���7l�*P�����6��e�.#��آ&`W�|آ�����0��0�=�6�<��?�O���]��Ĵ5$�}#t�ۢũ~�)Qr��犒D�Bo�-xS�a����������Nd�ޓ�[�(�f�(p�d��(5�J�
[��8ɲ4�e鉇`����jY�6�$+5c�B��������e�{����ة	�G-�.c#��!~�����bH\-h�D�Z������������tl�ȄH�I�;i8��eYŠ38t���1t��O��A_��D��8�#�c�Y9�#g�yș�������O?��8K��[\�w�m.���v���3\�X[?Ta��05��#���4�r�b z@��y\��u�9����φ���FI� #l���SP��\�fA�v�A�t%�1#��9�J�L4;%nw���Khj����0��������?����?�i�=ӎ��x#�:���'����>�xuɱ
E��p��#�ɮSl��\
]g.���O�ɫ�M�z�p�Ʋ۷��a�l]��8-�V6��>3����ʏz����vpe��~3��\�\1�pO�ѯ����5��B���
�(ѓ��.��te\M3��o��C�_p-��� .B�k
URp�p���)���^���r���a��������5����=�?�+��O����t��vcG��m��]�8�&�n=��D�ˢ:4�B_���l�,@�n�s�[�용-'z���	����nF;6$ܖ5+�6�?�����t��o߆┨����iq<Y�������'�"��l���U
3E�SУ�ň_lMy`�x&\��
��SY`�7���3�#\�;쫠�H+�'-��� ����wySe��e��B�<����9ɃѼ<�xl��%���R]HEY�H����T�*zN�a��d����~�V�Ho�)-#i0��r��IN������n��7��}!e�#�J.R~��9I�ݠ~�%�����~�M�����߯ٿ�Ho�R! h��
���
jN����Ǌ%���@�GG3�fN��J:R>��9I���7���o�������fg��U id�Zn6���5�xr�G�N����i���MV�<�����Dfs�PYE�&�a���|i����B���P%    )?N�$�Ne�|+��tLA��������XW{��F���CxP-H���Z"2];T���<�[����`�6Q���`ck{8��Ԩ���h��l�ejT_�Q���	����GY�V�˓�ֈ�?U�G��|�=��n�3m�p���ž���&��,��E�X�c����7�l�E�z�sA0�^�>tj�)�5Q��ǹ��4$�$)�[=GI�&��k��F���|F$
�bG)���`�"	z#�0��tWAS���(T�	�*Q�D,��&Da+("�C�:F1�@T	A*,='!(�)�E��&�/"% ���~�L% ����L��)�/g�C���<��������.^�q��n�����/C#��G(S��2��C��8��#���<|PH� ���B�r���Qh��JSQE�簡��&Ac�˕����>e�B-Y��TQ�n�r{��ݫc�8�ݢ :*�%����n��awM��,zx�9.�$�@��=�][7�׆ݮb%c���т_.U�ݯ��ܖ�;ɸ����N Q�*1�Ȳ3�J�`s����_$51��fQ;��d������>a����1p�R�s��g�o�<�-��R�P��P�=��*���^�&1Z^�U^��U����l��`m��,��\h��J8�}�3f���r�ߐ�D��9�:^*�%��л����~.T[M M$0ds�iq��A���Js�����u�{���;����w�$[��v�	/����ꈞ�c�N���t�6����Y��M%QU7�|狎��D!q^FB �k�9k���9h9�۩������
����a�_]tֆ�F�ݛ+Y
�..��>ۥ�9�Z�ۈ*%�F�4����o��I�1�>%�]P��)n�c �����Ύ�[jѕJ�LqYʥ�p-�<��QA�����L
�)M�b��A�O��}cЩV�$e��)���j����~�ß�MV���I�Aj���t�3�X��PA1�1)�U�B��6!���,����/�d!�ҵ��_:zN�":�,�)ST�f�BH����V�x���&�#�$S<^H5�xL%	 U�!�*�yV�_ѩ��eFj�BÜFÌ�R�[�q�:���8�׆�۴ܡf$�<j4�"�K,rK(��~K6��|���e6M'�ld�����N���i��Xt�6�1�jd3,wy_Pn��`y���:Y=Ń�[�dx�,�F��w_x�30)�65��cn}\S�:���יpG^"�ކ�Vh�sw6��"瓀�	��\�B�pj��=CU�:8���&o�!��Bp��$;����۽���|�~����t�tEHT�J��3�6�3O%3��-��}T�r(*v%	�����g�G���WN��P��� 創S�ￃ-���߼ԇ�������+~I�_���(�2� ɓ�=4M]�棽:x��y
\��vu�O%I ��������������à;a�Q�	8gt���ڋ���6��
�z3k��]ch&�puGÇ��7&V��nY�{	�9=�$��蕄���k4Ho|��}<y�^�*��M��'��~:y�^��p���vt�ٳn���?O3O�G��2�����7f�g��)�v�1T���\���wڭ����?�c�T�^t���eV�����z�t����I \��C;l�~7��4��k�4(�cmK Q,��qן.���$�
OzW���a��'+m�p
�*�N�:9�6ś�5�ܖC�W��uAq
Œ<	~u�����:)��<v?��	̶.,��*���4���m�Y��z�;�[�i��TC�I�ՠ���)t���=�
��c�ס2�y��E�d8ln�l�'f�E��vc5��6�b_�+��X>�wžz 7/p����%��7���J������]�<���	CH{2��'P(&N�3)3fjc�eV����K$K�bH9�,� EE�$W����骟�X@N ��.$�.�̈́�
����~b[�q��l�')6�����$
f%�0?�ѹU?�7�oɘ}�{�!KA)�nU��fp��=��jM��xЎ$��7H͙D����.�N�����C\�&5�J
$�2.*����UN��C���䧟3�ʽ8��<*	��\�<��=a�J@x�Q�?߼`;ǒ0���̆�	��,ǣ �}%�h���u��7�
Wh �W��v��n^���`u����fw���Z
�S^6�K����@�W��ՙ�*/�2�e��5�%R6���m��sZ=�����sm�@�|�|g��X@�����$����31��v���ݵ��d�HDǸ���`Q,��]8�&��H�`��_��V.�_a��vYBe~��ג�_X�a�����#��O���G�����#�0+�]�>s��VW2���K���)��i*�iO�nUO�O��<Vo&*^e�(�2EwcM��r�L'�)B�̓�� VJ�T!U,���T
�d����_/(�	HT�J�.��n=��Vw�lM݊l�I��K�5�Vfr�
�R����k�Ք��!��a/��oo���/�N՘��T7t���M�I=�Pp���P)�ǄNhǃ
zHw@e�%E�$�pI��{�ɟ�[���t��w>l��%j'�ء��9���d|�i(_�o9�R�{�`XmH���F�?g�;�s(T�KTu������fԷq����+���.Ssq�Yж"6t�:�6	�ܦsj!�"
�U�%�
��9�����E�̕d��&8���`��ȏG�k���zo ��k�~�vlыtai� )O����:��rZ�RN���)PT�J"�ia��ԣҮ��`�?謮w�I1�H�}������u)�0���;�/�Y�7w�*8���qyYZ��k��N�%[[߰���v�J ���2-�yVon�2R�=C�����{�J#I�x��e4O����z�Z =#��x��i��(U6��(�V��r����Z,�,PT�J�D<�$bY��c�H,�������<g�R���ļ��?0���#�g��;��R������.o�s�#�Dx��=~[�n����a�Q��$���jяX�}[o�nu)�r%���~����k�p�J�x%V}-��I|ȁ�
�c�N·֯h쇯���f�[[,x Q�+Ib�x�%zk�@s���;����`�sŸGB1�� c��1^�K�E�c����?��Qk�f����/�΄EŴ$����M����z�#�ǎ�a�Kz��$*v%�0φ�EoX��B��in?����� Uxc5�0Ʈ��k�����q;h��ϲ ڢ�	���<��L,�˙�T�b]�[����>=T�����/�f���&2Eu���~0z�_(�H-�&�_^5�����p���E�o m������Z�U�lLC��J� ���[x�daff��������(ǔ'���c��s>�DHRu<��cҶ�׷�A\���j�^�5Ͼ})4w��襪���q��ڥ�(x����4��J0��n��u�I�!cʔ��Ħ )O��0�L�]d�z�%�s.&�10T\JR|�B`{��lm�67og.�/��r�pA� Hb�����=����������,XM���T�A��Gk�ӭ�-�V3U�'�e�7r,� GJ��Q"-�]�6���Vg���������G���ߌⷅC3�@�CE�cf�\Ҝ�.
*>U���1-2��E��3wM_���X^��%���y��c4M�`k#ȶ@��6jG���Jg������� ���P�J��Sga�vpTa��s����[�i��8��@R�<iWzwF����c�)N%;�F'S�HD�"�ö�g���x�X����]x����)���Рbr��| ��y�J]]^�7��=��\������D�Q)�`H�,H��>�-��Em��n[[�թ*�Ϸ �4��*�������c��4��:f����*.JOHB;���xtVG[������yl�
P�/��<����Zo��b�|�$z����B�� FŴ$�    �X����^p-�&J&ѿ�,�gtp,h΄�
��9�|c�����#�wR��E�7��[I ���W���^���Շ���=%�3S��x�7�G��H�����@Z~�βGall0��'P{���i��'-�v��Ϟ`�ja�"�`��ަ�8�{��1��ү�U�u��/!��A/�1M5c�tKK
�
��
�^�2����H�:��=��_XJ���/Ľ��Jܮe�e����|j����8��R}^_S���`k};�w�����Ȃl]�^�����[�����i�\g�j��9��P��X>	l�/"�5f�����y��ٖ�28���0ݽ9����k�D�eA���D�\�[�B6��)[�lV7�5����Woc�M��l�_���l6��cV)m�]����|��L�W���zM��xֵZ���f/�fle��M���)W��'�B/��.�N��&i6���[+���X��ب(��o��@��$��>o^ԡ���䖍�ltlM{���u�1��J=?�#Ox�ZЗk����É��/��2/՝|�,���� _<LwJn>|��%6�l�gK�;4Nb��N�м	����'�����߾�ݏ�{׻k�`��2�������)̵���nWV�5���}	=5�v'�c���ǘ�=$FY� :m-sx�E[Y�`2E�V�a|������v+"XM|Q��X6�޴�c�b�S�k��ĺ�2]�>�1MK�G�lO%8Q��H� ͨ ٮ'l®=ل�����^��W�S�t�vk��
��V���A��E��5�t0����URR��eK.'���qxN+ϯo�]u�ĕGI��]2�q��^�R�N:��(1�V�Ĭ�&H��`���w�٪1�|$��s!;�";z}��FJv���4�͗�[��mfWb��'�_��o�����m��( ��hr����bD��⨪]xr WɐD�ѸI��ɐa�Y2$?�r�hqx͙4Y5ڪ��;R�9�/I��l^dȮO��]��������[����'����Pȃ
���wQt&����&6J�U"���Id���I�L��#4h&G��Ѹ�ǫ�!��wS��c��#<�g�DH��x��W�{>�e�;y��u�Ap��c���64�f����g��)���^>��&���K���/��͗���NG�mׄ��/��!������1� �Û�==iaDu��p��`}$q5RkOz�Q'��3:�"���چT	3����F��m�m
7�3��)�P5I��^�Z���Df/������>�E�X��ݯAl@��R��Y�a�r��ǯ�ل1�L;Gٙ��8*5F�#n����Vs�:��(n��u��6��D�,�K�6�M3�ҍM��n�K�×QG׋�#�?}�7�
�*O�Wq�냵�����c<�ys���0���w?�_Q57[U���.[QK��<"WUНr����6�NFő$'I78G5��7�[���"�ߡ��y�\�f��׬W�&]���#�~lW��{����6��AW٬djI?�M��b}j�~��ᒡ�6ʲA�P��8�&G�����J��SX��q�>��FNj2�9S�'�S�|3~��B&b��ܓ���~�~9�a,Y	������F�xl�bcͪ�H-\G��^�2�B��tK��߇�̸~�t�Z7�)\�y��55�k�8k��
�%y�7��+��Y�P3����e�9|�BAE+ �`bbi�������:k�U������6Ը{�Я�q�$�Cw8'm��߸2+��zצ�_y�+��6�e�i����Z�6��Ө�I�@O�I�Q�����(�$�Cw9={~��I��K� ǌ@ܜ�%�S�*��[ݠWl-#���2��K֬EfP�����������[��W�{l����̛��on5�m[�~פֿnƼy�#�y��z!u�\�]|�U��'#�������#�c��]���WʉKR�t�1ը���B�joV�&����dM�![�)";��^���|���f���I|��O����ytި��
��� }�ke��+��-������x��u}��W�vW��x��Ru|S�.oF]��ҽ�,��W����0R!��
�����
9A=�bHL���0�.���͸_|��1������/,�ǘ���Ӑ;�,���/3n�+G�^� k�Y�+?:׃�nǘ�����s����@��YO�5��'���<1^�u�8O�=��V�ɯ��{�i��(i��t�|;9T^���[����{�Ki��Z�c,�`�;��q	<F�@�YK;��}?��+��W����"xy����r�X@����V�}L�q��%�np+Z�Ip�ްAǜX=b����%����,��C�sEC>	s��2��YY�o��p��[�vO�{m؍z ���3����ب+��͂�=dВ�a�����$С�m���Kfe��Y��ínE���2�>y*L�b����{E&�a��˗OHt"nd��P�%�r�e��d�*�%i�O��*Z�"ܔ�dNbr�NR|���f�M�
�MW�a�:?j'Q���I�Ī�iYq�U��hؒ����~k����@� Z�r�W<%�����F_�A�̺Fw��TG�T��vk;REU�K�*�X���꠳ٻ��-Oʰ�rI��V��ʨ*�8ò�Lʰ�N�<�*Z�1��{�ڌsSxUX�hFOX�z���E*�>۬�FV*����67��[=����ޅQ�j�H�q�(gwÎ�c'͈�$c�p��>u
ɥ�;M�?a٧?����]�p����#~��Ɵ��>�u����};��]��J��0�*�K!�%��/�);.[��s�7�}�a�D�Ύ�xB?��DwZ���������cA�G�;��@��l@y7ӻ�w���O|���A��|��b��3 	Z�F^E��Ij�!�1x5�-\#o�~bT�E��D&;^e���a�K�)�w�5����#$��T�k���NK�l���Q�S�D��lI��iaћ�����v��(!�UD�h|��ʽ#�1-��GS%�Z����f���T�ۃ\�H�+-���t$Ь"��5���
���`�)�\�=Ad��M�,�M�)��>��{�^�\*!�Q	��C��>�
�:A����|����L���RJ���p����~Bz�h�L{�ʙ�0U5�"�g0�č��x%<�N��5[}���;�ې����[�Ҝ@υA�m��\N�M�RA�*t�t�5kyk�{�j����Uʷ�M�9B�Q6�}Ԩ�a�r��Nۚ~71�Z���e{��V�$��素��{\��[�b�O,�Ů_î�D����(�Nqf۳�����bT�iW荀���7���+�������0�|�����]�b�s=��]�]������1	Ж$u���{Tfإ�ha�ս,�x�ɔ�j*�Vw��Jo�������zwؽ���vg�����y��ǭ��㇌a䏐�gtX�������sg9�Qy���#����{��H�?��P$*60�'6�f<������[���nt[?���~����ӟ��<`J�F���@�V_Qfjh�0������8�Z�0��V��I�%T����ޛ���ÙW(?��Q�� $*[d?�4�Jw4�2:~�[� �ln9R4+H��5-YgRJ8���-�cz�(|ɟ�p��ĢH�ښX�I1�ΒP�m�ɢt�R8��H! T�,��;�fG�/���V�I�:r�����)�YJ�9�;��>mY3�1}m!}��"r����zG�ٲa?%��L>�w���)e.?g!�x�$S�@�B���7�[{&�w�9 ?���O�Q�*0����G&Z�_��oD��~̚�ɾ��Y�;bR��(u/��XN�A^eO7�=ݪaO')���_3��ih�����k9��bwmw��tu�3L��t�5]���q,ŧX`ϷfaϷf��E��8Y͉��~?��]���7,��IM���Y)#+E�$~/��rʧ��    ���~��i�P[��.O'��$��T�J�^�:�| �l���r#X����T�q)��'��1IG/��$
�R�|Y�{t�4oL��f�<8�@iZ�jQ|��D@�v��{�NR���C>�����������n�&�u��Y�`D��<�Kw"�_�Ȝ�j�������w�������3�_����I�*�(��W�2m�cW�ʪg�W��ci�m��+��u��������h�i��ISR��䤹fv��@=�s�YݞS8��9����4��U!4�_E�H`�I+S�Q���4QA�0|��sT�O�BT��_���9��֠<�X�Ӯ���׼5��B�G'�����r�/k���^��W¼,�Cu�}1o�]G�?�O��c��خ�Ֆ��Bǚ�jb����PN��bM���rS�,&�-�8��
��Q��}��������)�-T�N)R0���<��0nkbg�61r��pJ#��l;2d��Z7�F�jb��)�=�!��a�����ݮܪd�L>3��=��c�H�ɩ}����q�%�2暾L�����k��rkw�v�A(j�A~Lc���6Z�(��	;y�kb�M3Ah������E� i㩿�����[��A_E���S�k�o�(z|��>i۶���>	��|�W6��_�.�́�N��J^$M�L��5�[^|�v|+O^j6/��6��E�$5-/��۾�+/��b^j���Բc'k��qcN��>J`,h�t��3�(����B�KBQ���ߢ�WpE�$5/
T�#oN��*�i�?������U�v�?�$��3H��tm6��E@;ìt�л���{�k�I�K���B�,(��d��5 �Lj� �/',���~]-BM�d�X�r�*ӫ#ϊ��ۃ[��J�pL�㻎mh�MU��4��m!��K�I��R'5� ,��6j���n�zs�q%�������F�E��L^����b���0�Q�KF��BTJ�J~�I����F�D�8�a�6��<��y��B\ʈK��<�C�����eWs�<%`
���__�V\��WW�U{��4�����8�o'5���g�,<I��H�&����~I�D6)�+�R�	[�J�\���M�7Rm��AZ����A?g�pJ?�6I�O�,hu �(g�.�n����=jy_�6>�����젱u�oc�Y�!�K�oܕ��ף���r��(_J��-�����o �0�=��0B���:yO�3������ÓkAF��o{ʓ�R8�bD6+��J|W����K��f��{�Gv�m����v��p�q�	���%qF��C������M��UHoN�~~�+?{���t��H�,�r�b$s�/D������	�ќмc��f����~�Z$4Lg��P�%B#��/����v�K܆&�z�;��S�BW]k��B��'�6�#��|*�6����������k��~��q���T�����S�~��D\.3m��c�0^�Q�sT��%�Dq"e���ஏZy���Ԩ��06a�XBӤ
����.W���{8����{<��D�9�X�)��_��;ܗ��w.W,!�DU.����V���3ܣ���uf'&�3�^��i>4�$Z3�3�!�"<v��3)�ߏ���|W��b�]%�����Pz��8��/q�,��u!W%��̲�<o�RX=���5y{\�bǪi#�_��)���)��	��!6�3v��GL��ǝ?��0�!"#�D�*��G~�����k�NZ�&�!�cH0�gT���ѻ�ؐ���z�����=���rɦV�<�n?��B}�
�0�f>�^@ S�L_A���b���ٻFߣ�H��Җ{��lD�f1y_�$�����é�"i�[1%�$������ �F^u� �+at-M݆��y9�4�{3��ʿ�R:�*��v3'8�������Q4�i��)8�A�0�l6*��a28��'W㎼��짚�ƇJ�ЊCl����tT�K�~�a���W�M����ЁX������D��]���	�b���0��a��擨�sy�g� 1>���}oޱ�M�
��w�h�X�b;�#*�x&�1ߒ��`�6l0����0ff\F"��#T�I{�� -�t�h�`���#����!�g��F�~��-4u?����CS �	�O�����prOy�w)8��y���8Q��FG<��9����crQ��`�P*L9����H/Dj��D�ܰg�3
������{޻�Î��<C�_��˓R��=�H���;3!7U�t_Q�נ��J>W$�d���H�M��-$�> Y���h������蒴�4y�J��}��e����ݟ�_�K
$�^��2]����>6�=��;���N&�~�2��K��b��3U��o�-H��&��>��ӱ>�R��N)�*��Ӫ�����kx�j��Ɯd�����3
E�	?G��
56D(���+9f�+;`�ӫ��鑤 ���c�{�TT���A��_�ù�3�(̭�JT�#���=�4�
��LG���0��rtt���(��8A��5�c�%�S���Jlb�d��H�S��B���1}U55.1�����Zi�G�����}�7�H��u��<A�K|\���C΄�pS��m���gMG����8�����W�{�v�TH�Kn�	Uᦢ{��0�kA���q:Gn��K���2���%]4aR#EG�s*t�{�'�)|�&�	��EZD��v�L�<����UC̠����a�6I��qTh|Di`�<%�+P���D^+�"b���7�K�ˈz�p���Gmr���ʒ�X����g������e8��o�s=���!/C&��l��ڙ�s�E0DYI-}�$V~�[�B�2��[`\A�%ՠ����0��,�'�Z��|B���y+z,��ꐛ�Fr}��`��r�S��RP?���`�vi�n?��Z��(~&�cۢR�yb����|2�)�'��c�ؾa�9bu�r|_W0�pUͳ�ȬTI�IY��V�#�n�����%���Q��mwp��;��|2��+�Y8�)M=6���a9�
c�D� ^1��#���'��'�bͧKQ:�*�W̬ਧ���P��n�3*��g�S��zEG���z�>�5z����	�eݲ;l����hD�런��%���}Ȥ�|�^ݏ�wГ7�Sh�)��@�Vߏ�:��j���pR}��c��f�U�N�_U�%H��˭�	j�t�%G >'t�I��q�w0�'9�����r��?z�4<��-�P�B���vGJP=�'�e'�ɝ�QM�!O�ſO0o���A�JIw0�w�K;JD-]�x����<2=�0}QK�w��e�@`�ۓ�&R���2%̎m0�-�ɰ4�7M1S"y�ԇ;����R��"�bt�ԙ!�E+ĵӲ�H���#����GF�H4ݖ ���q~��#l'=π�&R��ۨh�-翌Eq��擨tEK��U��%���b��,�/�;Ì�Fд��WPb>z�5	�%v�,�CD�4��I��do"�A���D��&)��O^-�.�� �أ6г��+¨��7l�Ht�x�~�!:���8�5��9���`}ܧ�Fo��V���Кϰ;�������n����eg|��,S��13rVbj
U���`X��4��	����J&���sFBA�#��z,F���MG�\m��7麘A2��Lŝ3"
*��TK��D�cm0"���.��'iV�k龜�'T"�L��7�IT!����'����O_���v�oj��q�
�V����aV"|�n�;��nrx�П��/�������=*B�{/��|�&�^S����=&X�Kg���&žw2�F���L�&���7�����Oe@����')��Fgo������H�&H�<�F��J��Վ܁���P�ҍUNh(TR|b�RE�+����woW6�7W�{�A'�dHsn�x�Fv���Ԇ�׹��~Ά��LV*݇��
�[   �%�e����D��u�*�Ү�$�onm�1*,�u�;�$T�t�����V$i{`9����j��|2�N|OV� s��	&y$�w�d��B%Y�����k0��'�������+���W�_>�<x��hEi���_�/$)�\|�,��cZ�|Y�g�(��#�3˟��[@�Q���� �`2>�Kx�Z2�&��adE�p�75�{?z3��k��~����M�LD�����ބ�<�?�>�K�a��mj��p��;��	0>��~N�v�'��Y�����$,ymܻ�5[|�h�n�3���pA��`�Ã���zC�؆�{�����4R��	ʙ8�o���+4�{�ԝ�N�xy�}҉T�)k�^�u,�t,ێ�:�m��j:��H�y���ĐQ�B�װ&�t�7=8��)R�0���|��9�x��|����y�[���ᠳ1��!��g)�sHBU;����˥F]�֚C�:���/�SI���ٻ䀟ޛC����/�SI ���j�e��9ľ�k=}+���J|C����Q������9�T{���J�\B-ň����T�;��������nf�4���W������\%w.�l��iVG/�l���gŎPۖ$�ڒ�*��U٢��﷯(��S�?��y�{]�+�n�l���%�9�ý�׏�	^�[�f����rΩJ�֯�l!q]l���qt�z�,x�b�k��k��Hb���&0b_[|���l����Ũ�U�fp��	J��5��i^S�^����Z���}��?�jDM�R;WE���jtlf���C��0ձ9=A��'ɊJ�#�۲�O�wD��.��]fY� ��Ni�g�1�TԽLFT�<���x��A�ҋ�C4����^[!u���[�٭&Cq�z}�<���'I/E�0�+c�)"R6[����B��[gk�����?�����Ep�9\39ӂr����nq��O����91@��ѻ,�wC�������!�$�.�^���:(�Á^����1L�5�rV=���-/6�T�MՒ6t(t����F'�oA7:	ݕ�%e��
;��P�[��4�n�&W����.�K����q�%| n�L=��堃��X�̇���9A�"7�B���Q���Ve�'i�ﶙF�2GC���.��]إ������I�~��Vn\r�O�VW?���*+���L���?�|����~2����؃�s���]�9s�o����^!�8�g￹��A�+��      �   �   x�}��� E�5�b���ةe��c2����X ]td�'�\�pRV>��ة8+g�^v	���ѯ�ʶ) L P�Yv	Tn�DSo�#��$j@X-L1�݄��",37F�%P�Dm�b$�M���W�%�O��v�&��mH�_�/�x�]�y���/]d���\�>��Zn�&F}3� o��)      �   b   x�3�LL���s(��O�+*�t�89�8U�UT��C�]���s��r���KJ�2\��ܼrK�*]�����*+M�,�������S2�8�b���� U(�      �   D   x�]��� Cѳ3j��L��sTDU�Yz���n8�q6�3@f�(&� �r?{�>������\      �   h   x���� !гT1hXT�Z��:&P��g�>K.�te�*\��~����C�JF�`n��{z|���|&������+��~����������FDb��      ^    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16393    roof    DATABASE     �   CREATE DATABASE roof WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE roof;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    3            �            1259    16394    account    TABLE     V  CREATE TABLE public.account (
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
    DROP TABLE public.account;
       public         heap    postgres    false    3            �            1259    16400    category    TABLE     Z   CREATE TABLE public.category (
    id bigint NOT NULL,
    name character varying(255)
);
    DROP TABLE public.category;
       public         heap    postgres    false    3            �            1259    16403    contractors    TABLE     �  CREATE TABLE public.contractors (
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
    DROP TABLE public.contractors;
       public         heap    postgres    false    3            �            1259    24952    forbidden_sizes_seq    SEQUENCE     ~   CREATE SEQUENCE public.forbidden_sizes_seq
    START WITH 10
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.forbidden_sizes_seq;
       public          postgres    false    3            �            1259    24954    forbidden_size    TABLE     �  CREATE TABLE public.forbidden_size (
    id bigint DEFAULT nextval('public.forbidden_sizes_seq'::regclass) NOT NULL,
    value_from double precision NOT NULL,
    value_to double precision NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint,
    machine_id bigint,
    product_id bigint
);
 "   DROP TABLE public.forbidden_size;
       public         heap    postgres    false    223    3            �            1259    16418    hibernate_sequence    SEQUENCE     {   CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hibernate_sequence;
       public          postgres    false    3            �            1259    16420    history_item    TABLE     �   CREATE TABLE public.history_item (
    id bigint NOT NULL,
    message character varying(255),
    new_state integer,
    "timestamp" timestamp without time zone,
    created_by_id bigint,
    history_id bigint,
    history_order integer
);
     DROP TABLE public.history_item;
       public         heap    postgres    false    3            �            1259    16423    machine    TABLE        CREATE TABLE public.machine (
    id bigint NOT NULL,
    length integer NOT NULL,
    name character varying(255) NOT NULL
);
    DROP TABLE public.machine;
       public         heap    postgres    false    3            �            1259    24887    machine_width    TABLE     d   CREATE TABLE public.machine_width (
    machine_id bigint NOT NULL,
    width_id bigint NOT NULL
);
 !   DROP TABLE public.machine_width;
       public         heap    postgres    false    3            �            1259    16429 	   materials    TABLE       CREATE TABLE public.materials (
    id bigint NOT NULL,
    cover integer NOT NULL,
    fact_coefficient double precision,
    length integer,
    manufacturer character varying(255) NOT NULL,
    material_color integer,
    party character varying(255) NOT NULL,
    price double precision NOT NULL,
    price_delivery double precision NOT NULL,
    price_one_metre double precision,
    price_one_tone double precision NOT NULL,
    remains double precision,
    serial_number integer NOT NULL,
    teor_coefficient double precision,
    used double precision,
    weight_of_bay double precision,
    width_id integer NOT NULL,
    width_fact double precision,
    material_class integer,
    created timestamp without time zone,
    modified timestamp without time zone
);
    DROP TABLE public.materials;
       public         heap    postgres    false    3            �            1259    16435 
   order_info    TABLE     �  CREATE TABLE public.order_info (
    id bigint NOT NULL,
    due_date date,
    due_time time without time zone,
    state integer,
    customer_id bigint,
    pickup_location_id bigint,
    wp_order_id bigint,
    order_type integer,
    parent_id bigint,
    discount integer,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    done timestamp without time zone
);
    DROP TABLE public.order_info;
       public         heap    postgres    false    3            �            1259    16438 
   order_item    TABLE     �  CREATE TABLE public.order_item (
    id bigint NOT NULL,
    comment character varying(255),
    quantity double precision,
    product_id bigint,
    order_id bigint,
    items_order integer,
    width_id integer,
    material_class integer,
    material_cover integer,
    material_color integer,
    height double precision,
    total_price double precision,
    order_type integer,
    size character varying,
    CONSTRAINT order_item_quantity_check CHECK ((quantity >= (1)::double precision))
);
    DROP TABLE public.order_item;
       public         heap    postgres    false    3            �            1259    16442    pickup_location    TABLE     a   CREATE TABLE public.pickup_location (
    id bigint NOT NULL,
    name character varying(255)
);
 #   DROP TABLE public.pickup_location;
       public         heap    postgres    false    3            �            1259    16445    product    TABLE     �  CREATE TABLE public.product (
    id bigint NOT NULL,
    length integer,
    material_color integer,
    name character varying(255),
    price double precision,
    type integer,
    weight integer,
    title character varying,
    second_title character varying,
    category character varying,
    width double precision,
    square_meters double precision,
    cargo_type integer
);
    DROP TABLE public.product;
       public         heap    postgres    false    3            �            1259    16590    product_amount    TABLE     �   CREATE TABLE public.product_amount (
    id bigint NOT NULL,
    product_type bigint,
    width_id bigint,
    material_class bigint,
    material_cover bigint,
    material_color bigint,
    price double precision,
    self_price double precision
);
 "   DROP TABLE public.product_amount;
       public         heap    postgres    false    3            �            1259    16448    site_category    TABLE     .  CREATE TABLE public.site_category (
    id bigint NOT NULL,
    img_path character varying(255),
    key character varying(255),
    title character varying(255),
    url character varying(255),
    created timestamp without time zone,
    modified timestamp without time zone,
    parent_id bigint
);
 !   DROP TABLE public.site_category;
       public         heap    postgres    false    3            �            1259    16454    site_product    TABLE     �  CREATE TABLE public.site_product (
    id bigint NOT NULL,
    full_price character varying(255),
    img_path character varying(255),
    price character varying(255),
    prop character varying(2000),
    site_name character varying(255),
    title character varying(255),
    category_id bigint,
    created timestamp without time zone,
    modified timestamp without time zone,
    path character varying(255)
);
     DROP TABLE public.site_product;
       public         heap    postgres    false    3            �            1259    24914    trimming_seq    SEQUENCE     w   CREATE SEQUENCE public.trimming_seq
    START WITH 10
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.trimming_seq;
       public          postgres    false    3            �            1259    24916    trimming    TABLE     B  CREATE TABLE public.trimming (
    id bigint DEFAULT nextval('public.trimming_seq'::regclass) NOT NULL,
    value double precision NOT NULL,
    width_id bigint NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint
);
    DROP TABLE public.trimming;
       public         heap    postgres    false    220    3            �            1259    16460    users    TABLE     �   CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    locked boolean NOT NULL,
    password_hash character varying(255),
    role integer
);
    DROP TABLE public.users;
       public         heap    postgres    false    3            �            1259    24832    warehouse_item    TABLE     O  CREATE TABLE public.warehouse_item (
    id bigint NOT NULL,
    comment character varying(255),
    state integer,
    quantity double precision,
    product_id bigint,
    order_item_id bigint,
    machine_id bigint,
    material_id bigint,
    CONSTRAINT warehouse_item_quantity_check CHECK ((quantity >= (1)::double precision))
);
 "   DROP TABLE public.warehouse_item;
       public         heap    postgres    false    3            �            1259    24927 	   width_seq    SEQUENCE     u   CREATE SEQUENCE public.width_seq
    START WITH 130
    INCREMENT BY 10
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE public.width_seq;
       public          postgres    false    3            �            1259    24864    width    TABLE       CREATE TABLE public.width (
    id bigint DEFAULT nextval('public.width_seq'::regclass) NOT NULL,
    value double precision NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    modified timestamp without time zone DEFAULT now() NOT NULL,
    user_id bigint
);
    DROP TABLE public.width;
       public         heap    postgres    false    222    3            �          0    16394    account 
   TABLE DATA           t   COPY public.account (id, bank_name, bik, code, corr_account, depart_address, inn, value, contractor_id) FROM stdin;
    public          postgres    false    202   �       �          0    16400    category 
   TABLE DATA           ,   COPY public.category (id, name) FROM stdin;
    public          postgres    false    203   V        �          0    16403    contractors 
   TABLE DATA           �   COPY public.contractors (id, contractor_sub_type, delivery_address, email, fiz_address, inn, kpp, name, ogrn, okpo, phone, type, ur_address) FROM stdin;
    public          postgres    false    204           �          0    24954    forbidden_size 
   TABLE DATA           v   COPY public.forbidden_size (id, value_from, value_to, created, modified, user_id, machine_id, product_id) FROM stdin;
    public          postgres    false    224   a       �          0    16420    history_item 
   TABLE DATA           u   COPY public.history_item (id, message, new_state, "timestamp", created_by_id, history_id, history_order) FROM stdin;
    public          postgres    false    206   �       �          0    16423    machine 
   TABLE DATA           3   COPY public.machine (id, length, name) FROM stdin;
    public          postgres    false    207   \       �          0    24887    machine_width 
   TABLE DATA           =   COPY public.machine_width (machine_id, width_id) FROM stdin;
    public          postgres    false    219   �        �          0    16429 	   materials 
   TABLE DATA             COPY public.materials (id, cover, fact_coefficient, length, manufacturer, material_color, party, price, price_delivery, price_one_metre, price_one_tone, remains, serial_number, teor_coefficient, used, weight_of_bay, width_id, width_fact, material_class, created, modified) FROM stdin;
    public          postgres    false    208   �        �          0    16435 
   order_info 
   TABLE DATA           �   COPY public.order_info (id, due_date, due_time, state, customer_id, pickup_location_id, wp_order_id, order_type, parent_id, discount, created, modified, done) FROM stdin;
    public          postgres    false    209   �       �          0    16438 
   order_item 
   TABLE DATA           �   COPY public.order_item (id, comment, quantity, product_id, order_id, items_order, width_id, material_class, material_cover, material_color, height, total_price, order_type, size) FROM stdin;
    public          postgres    false    210   	       �          0    16442    pickup_location 
   TABLE DATA           3   COPY public.pickup_location (id, name) FROM stdin;
    public          postgres    false    211   X       �          0    16445    product 
   TABLE DATA           �   COPY public.product (id, length, material_color, name, price, type, weight, title, second_title, category, width, square_meters, cargo_type) FROM stdin;
    public          postgres    false    212   G        �          0    16590    product_amount 
   TABLE DATA           �   COPY public.product_amount (id, product_type, width_id, material_class, material_cover, material_color, price, self_price) FROM stdin;
    public          postgres    false    216    	       �          0    16448    site_category 
   TABLE DATA           d   COPY public.site_category (id, img_path, key, title, url, created, modified, parent_id) FROM stdin;
    public          postgres    false    213   u        �          0    16454    site_product 
   TABLE DATA           �   COPY public.site_product (id, full_price, img_path, price, prop, site_name, title, category_id, created, modified, path) FROM stdin;
    public          postgres    false    214   s       �          0    24916    trimming 
   TABLE DATA           S   COPY public.trimming (id, value, width_id, created, modified, user_id) FROM stdin;
    public          postgres    false    221   8       �          0    16460    users 
   TABLE DATA           ^   COPY public.users (id, email, first_name, last_name, locked, password_hash, role) FROM stdin;
    public          postgres    false    215   �        �          0    24832    warehouse_item 
   TABLE DATA           z   COPY public.warehouse_item (id, comment, state, quantity, product_id, order_item_id, machine_id, material_id) FROM stdin;
    public          postgres    false    217   l        �          0    24864    width 
   TABLE DATA           F   COPY public.width (id, value, created, modified, user_id) FROM stdin;
    public          postgres    false    218   N        �           0    0    forbidden_sizes_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.forbidden_sizes_seq', 610, true);
          public          postgres    false    223            �           0    0    hibernate_sequence    SEQUENCE SET     D   SELECT pg_catalog.setval('public.hibernate_sequence', 23301, true);
          public          postgres    false    205            �           0    0    trimming_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.trimming_seq', 120, true);
          public          postgres    false    220            �           0    0 	   width_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.width_seq', 130, false);
          public          postgres    false    222            �
           2606    16467    account account_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
       public            postgres    false    202            �
           2606    16469    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    203            �
           2606    16471    contractors contractors_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.contractors
    ADD CONSTRAINT contractors_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.contractors DROP CONSTRAINT contractors_pkey;
       public            postgres    false    204                       2606    24961 #   forbidden_size forbidden_sizes_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT forbidden_sizes_pkey PRIMARY KEY (id);
 M   ALTER TABLE ONLY public.forbidden_size DROP CONSTRAINT forbidden_sizes_pkey;
       public            postgres    false    224            �
           2606    16477    history_item history_item_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT history_item_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.history_item DROP CONSTRAINT history_item_pkey;
       public            postgres    false    206            �
           2606    16479    machine machine_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.machine
    ADD CONSTRAINT machine_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.machine DROP CONSTRAINT machine_pkey;
       public            postgres    false    207            �
           2606    16481    materials materials_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.materials DROP CONSTRAINT materials_pkey;
       public            postgres    false    208            �
           2606    16483    order_info order_info_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT order_info_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.order_info DROP CONSTRAINT order_info_pkey;
       public            postgres    false    209            �
           2606    16485    order_item order_item_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.order_item DROP CONSTRAINT order_item_pkey;
       public            postgres    false    210            �
           2606    16487 $   pickup_location pickup_location_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.pickup_location
    ADD CONSTRAINT pickup_location_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.pickup_location DROP CONSTRAINT pickup_location_pkey;
       public            postgres    false    211                       2606    16594 "   product_amount product_amount_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.product_amount
    ADD CONSTRAINT product_amount_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.product_amount DROP CONSTRAINT product_amount_pkey;
       public            postgres    false    216            �
           2606    16489    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    212            �
           2606    16491     site_category site_category_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.site_category
    ADD CONSTRAINT site_category_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.site_category DROP CONSTRAINT site_category_pkey;
       public            postgres    false    213                        2606    16493    site_product site_product_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.site_product
    ADD CONSTRAINT site_product_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.site_product DROP CONSTRAINT site_product_pkey;
       public            postgres    false    214                       2606    24921    trimming trimming_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT trimming_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.trimming DROP CONSTRAINT trimming_pkey;
       public            postgres    false    221                       2606    16495 "   users uk_6dotkott2kjsp8vw4d0m25fb7 
   CONSTRAINT     ^   ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);
 L   ALTER TABLE ONLY public.users DROP CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7;
       public            postgres    false    215            �
           2606    16497 ,   pickup_location uk_hpm8q7wxb5r5tjtac1glmlx9f 
   CONSTRAINT     g   ALTER TABLE ONLY public.pickup_location
    ADD CONSTRAINT uk_hpm8q7wxb5r5tjtac1glmlx9f UNIQUE (name);
 V   ALTER TABLE ONLY public.pickup_location DROP CONSTRAINT uk_hpm8q7wxb5r5tjtac1glmlx9f;
       public            postgres    false    211                       2606    16499    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215                       2606    24837 "   warehouse_item warehouse_item_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT warehouse_item_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT warehouse_item_pkey;
       public            postgres    false    217            
           2606    24868    width width_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.width
    ADD CONSTRAINT width_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.width DROP CONSTRAINT width_pkey;
       public            postgres    false    218            �
           1259    16500    idxd8bqjebi2o4fxpq5d3fp55ub7    INDEX     W   CREATE INDEX idxd8bqjebi2o4fxpq5d3fp55ub7 ON public.order_info USING btree (due_date);
 0   DROP INDEX public.idxd8bqjebi2o4fxpq5d3fp55ub7;
       public            postgres    false    209            �
           1259    24900    machine_idx    INDEX     F   CREATE UNIQUE INDEX machine_idx ON public.machine USING btree (name);
    DROP INDEX public.machine_idx;
       public            postgres    false    207                       2606    16501 (   site_product fk1ln0ybq8qqdo15ty8bp2mww8q    FK CONSTRAINT     �   ALTER TABLE ONLY public.site_product
    ADD CONSTRAINT fk1ln0ybq8qqdo15ty8bp2mww8q FOREIGN KEY (category_id) REFERENCES public.site_category(id);
 R   ALTER TABLE ONLY public.site_product DROP CONSTRAINT fk1ln0ybq8qqdo15ty8bp2mww8q;
       public          postgres    false    213    2814    214                       2606    16506 &   order_item fk551losx9j75ss5d6bfsqvijna    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk551losx9j75ss5d6bfsqvijna FOREIGN KEY (product_id) REFERENCES public.product(id);
 P   ALTER TABLE ONLY public.order_item DROP CONSTRAINT fk551losx9j75ss5d6bfsqvijna;
       public          postgres    false    2812    212    210                       2606    16511 (   history_item fk55ajiw0j59oklhbh4c8anuug4    FK CONSTRAINT     �   ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT fk55ajiw0j59oklhbh4c8anuug4 FOREIGN KEY (created_by_id) REFERENCES public.users(id);
 R   ALTER TABLE ONLY public.history_item DROP CONSTRAINT fk55ajiw0j59oklhbh4c8anuug4;
       public          postgres    false    206    2820    215            !           2606    24962 )   forbidden_size fk_forbidden_sizes_machine    FK CONSTRAINT     �   ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fk_forbidden_sizes_machine FOREIGN KEY (machine_id) REFERENCES public.machine(id);
 S   ALTER TABLE ONLY public.forbidden_size DROP CONSTRAINT fk_forbidden_sizes_machine;
       public          postgres    false    224    207    2799            "           2606    24967 )   forbidden_size fk_forbidden_sizes_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.forbidden_size
    ADD CONSTRAINT fk_forbidden_sizes_product FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.forbidden_size DROP CONSTRAINT fk_forbidden_sizes_product;
       public          postgres    false    2812    212    224                       2606    24890    machine_width fk_machine    FK CONSTRAINT     |   ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT fk_machine FOREIGN KEY (machine_id) REFERENCES public.machine(id);
 B   ALTER TABLE ONLY public.machine_width DROP CONSTRAINT fk_machine;
       public          postgres    false    219    2799    207                       2606    24848    warehouse_item fk_machine_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_machine_id FOREIGN KEY (machine_id) REFERENCES public.machine(id);
 F   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_machine_id;
       public          postgres    false    217    207    2799                       2606    24853    warehouse_item fk_material_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_material_id FOREIGN KEY (material_id) REFERENCES public.materials(id);
 G   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_material_id;
       public          postgres    false    208    217    2801                       2606    24843    warehouse_item fk_order_item_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_order_item_id FOREIGN KEY (order_item_id) REFERENCES public.order_item(id);
 I   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_order_item_id;
       public          postgres    false    217    210    2806                       2606    24838    warehouse_item fk_product_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.warehouse_item
    ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES public.product(id);
 F   ALTER TABLE ONLY public.warehouse_item DROP CONSTRAINT fk_product_id;
       public          postgres    false    217    212    2812                        2606    24945    trimming fk_trimming_user    FK CONSTRAINT     x   ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT fk_trimming_user FOREIGN KEY (user_id) REFERENCES public.users(id);
 C   ALTER TABLE ONLY public.trimming DROP CONSTRAINT fk_trimming_user;
       public          postgres    false    221    215    2820                       2606    24922    trimming fk_trimming_width    FK CONSTRAINT     z   ALTER TABLE ONLY public.trimming
    ADD CONSTRAINT fk_trimming_width FOREIGN KEY (width_id) REFERENCES public.width(id);
 D   ALTER TABLE ONLY public.trimming DROP CONSTRAINT fk_trimming_width;
       public          postgres    false    2826    221    218                       2606    24895    machine_width fk_width    FK CONSTRAINT     v   ALTER TABLE ONLY public.machine_width
    ADD CONSTRAINT fk_width FOREIGN KEY (width_id) REFERENCES public.width(id);
 @   ALTER TABLE ONLY public.machine_width DROP CONSTRAINT fk_width;
       public          postgres    false    219    2826    218                       2606    24940    width fk_width_user    FK CONSTRAINT     r   ALTER TABLE ONLY public.width
    ADD CONSTRAINT fk_width_user FOREIGN KEY (user_id) REFERENCES public.users(id);
 =   ALTER TABLE ONLY public.width DROP CONSTRAINT fk_width_user;
       public          postgres    false    218    215    2820                       2606    16516 &   order_info fkemqrbfaf7hs1nx4ldylfq6292    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT fkemqrbfaf7hs1nx4ldylfq6292 FOREIGN KEY (pickup_location_id) REFERENCES public.pickup_location(id);
 P   ALTER TABLE ONLY public.order_info DROP CONSTRAINT fkemqrbfaf7hs1nx4ldylfq6292;
       public          postgres    false    209    2808    211                       2606    16545 )   site_category fkl3s525hch365wqifmfg8bisrt    FK CONSTRAINT     �   ALTER TABLE ONLY public.site_category
    ADD CONSTRAINT fkl3s525hch365wqifmfg8bisrt FOREIGN KEY (parent_id) REFERENCES public.site_category(id);
 S   ALTER TABLE ONLY public.site_category DROP CONSTRAINT fkl3s525hch365wqifmfg8bisrt;
       public          postgres    false    2814    213    213                       2606    16526 (   history_item fklxc24xica6pqpahs8g4yejnh7    FK CONSTRAINT     �   ALTER TABLE ONLY public.history_item
    ADD CONSTRAINT fklxc24xica6pqpahs8g4yejnh7 FOREIGN KEY (history_id) REFERENCES public.order_info(id);
 R   ALTER TABLE ONLY public.history_item DROP CONSTRAINT fklxc24xica6pqpahs8g4yejnh7;
       public          postgres    false    206    209    2804                       2606    16531 &   order_item fkohhydblc3by0xdl950lhtprrv    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fkohhydblc3by0xdl950lhtprrv FOREIGN KEY (order_id) REFERENCES public.order_info(id);
 P   ALTER TABLE ONLY public.order_item DROP CONSTRAINT fkohhydblc3by0xdl950lhtprrv;
       public          postgres    false    210    2804    209                       2606    24786    order_info fkorder_contractor    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_info
    ADD CONSTRAINT fkorder_contractor FOREIGN KEY (customer_id) REFERENCES public.contractors(id);
 G   ALTER TABLE ONLY public.order_info DROP CONSTRAINT fkorder_contractor;
       public          postgres    false    209    204    2794                       2606    16536 #   account fkq4qqnedcq6s37vahgkih04bgo    FK CONSTRAINT     �   ALTER TABLE ONLY public.account
    ADD CONSTRAINT fkq4qqnedcq6s37vahgkih04bgo FOREIGN KEY (contractor_id) REFERENCES public.contractors(id);
 M   ALTER TABLE ONLY public.account DROP CONSTRAINT fkq4qqnedcq6s37vahgkih04bgo;
       public          postgres    false    2794    204    202           