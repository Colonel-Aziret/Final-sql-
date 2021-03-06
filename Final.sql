PGDMP                          z            Final    14.1    14.1 6    0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            1           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            2           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            3           1262    32944    Final    DATABASE     d   CREATE DATABASE "Final" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "Final";
                postgres    false            ?            1255    33065    delete_logs()    FUNCTION     ?   CREATE FUNCTION public.delete_logs() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 	BEGIN
 		delete from logs
		WHERE user_id = (select id from employees where employees.id = old.id) ;
 		return old;
 	END
 $$;
 $   DROP FUNCTION public.delete_logs();
       public          postgres    false            ?            1255    33067 
   new_logs()    FUNCTION     )  CREATE FUNCTION public.new_logs() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 	begin
 		insert into logs (user_id, entry_date , email) 
		values ((select id from employees where id = new.id) ,current_timestamp,(select email from employees where email = new.email));
 		RETURN new;
 	end 
 $$;
 !   DROP FUNCTION public.new_logs();
       public          postgres    false            ?            1255    33069    update_logs()    FUNCTION     
  CREATE FUNCTION public.update_logs() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 	begin
 		update logs set email = (select email from employees where email = new.email),
		entry_date = current_timestamp
		WHERE user_id = old.id;
		 
	
 		RETURN old;
 	end 
 $$;
 $   DROP FUNCTION public.update_logs();
       public          postgres    false            ?            1259    33022 
   categories    TABLE     ?   CREATE TABLE public.categories (
    id integer NOT NULL,
    shoes_id integer,
    shoes_category character varying(50) NOT NULL
);
    DROP TABLE public.categories;
       public         heap    postgres    false            ?            1259    33021    categories_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    216            4           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    215            ?            1259    32973 	   employees    TABLE     ?   CREATE TABLE public.employees (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    updated_at timestamp without time zone
);
    DROP TABLE public.employees;
       public         heap    postgres    false            ?            1259    32972    employees_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.employees_id_seq;
       public          postgres    false    210            5           0    0    employees_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;
          public          postgres    false    209            ?            1259    33062    logs    TABLE     ?   CREATE TABLE public.logs (
    user_id integer NOT NULL,
    entry_date character varying(100) NOT NULL,
    email character varying(100)
);
    DROP TABLE public.logs;
       public         heap    postgres    false            ?            1259    32993    money    TABLE     l   CREATE TABLE public.money (
    id integer NOT NULL,
    user_id integer,
    user_sum integer DEFAULT 0
);
    DROP TABLE public.money;
       public         heap    postgres    false            ?            1259    32992    money_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.money_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.money_id_seq;
       public          postgres    false    212            6           0    0    money_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.money_id_seq OWNED BY public.money.id;
          public          postgres    false    211            ?            1259    33014    shoes    TABLE     ?   CREATE TABLE public.shoes (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    quality character varying(50),
    price integer DEFAULT 0
);
    DROP TABLE public.shoes;
       public         heap    postgres    false            ?            1259    33013    shoes_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.shoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.shoes_id_seq;
       public          postgres    false    214            7           0    0    shoes_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.shoes_id_seq OWNED BY public.shoes.id;
          public          postgres    false    213            ?            1259    33046    user_buy_shoes    TABLE     ?   CREATE TABLE public.user_buy_shoes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    shoes_id integer NOT NULL,
    bought_at timestamp without time zone
);
 "   DROP TABLE public.user_buy_shoes;
       public         heap    postgres    false            ?            1259    33142 
   shoes_view    VIEW     I  CREATE VIEW public.shoes_view AS
 SELECT shoes.id,
    shoes.name,
    shoes.quality,
    shoes.price,
    shoes.price AS price_count
   FROM (public.shoes
     LEFT JOIN ( SELECT b.user_id,
            count(*) AS price_count
           FROM public.user_buy_shoes b
          GROUP BY b.user_id) a ON ((a.user_id = shoes.id)));
    DROP VIEW public.shoes_view;
       public          postgres    false    214    218    214    214    214            ?            1259    33045    user_buy_shoes_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.user_buy_shoes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.user_buy_shoes_id_seq;
       public          postgres    false    218            8           0    0    user_buy_shoes_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.user_buy_shoes_id_seq OWNED BY public.user_buy_shoes.id;
          public          postgres    false    217            ?           2604    33025    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            {           2604    32976    employees id    DEFAULT     l   ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);
 ;   ALTER TABLE public.employees ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209    210            |           2604    32996    money id    DEFAULT     d   ALTER TABLE ONLY public.money ALTER COLUMN id SET DEFAULT nextval('public.money_id_seq'::regclass);
 7   ALTER TABLE public.money ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212            ~           2604    33017    shoes id    DEFAULT     d   ALTER TABLE ONLY public.shoes ALTER COLUMN id SET DEFAULT nextval('public.shoes_id_seq'::regclass);
 7   ALTER TABLE public.shoes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    213    214            ?           2604    33049    user_buy_shoes id    DEFAULT     v   ALTER TABLE ONLY public.user_buy_shoes ALTER COLUMN id SET DEFAULT nextval('public.user_buy_shoes_id_seq'::regclass);
 @   ALTER TABLE public.user_buy_shoes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            *          0    33022 
   categories 
   TABLE DATA           B   COPY public.categories (id, shoes_id, shoes_category) FROM stdin;
    public          postgres    false    216   5>       $          0    32973 	   employees 
   TABLE DATA           I   COPY public.employees (id, name, surname, email, updated_at) FROM stdin;
    public          postgres    false    210   ?>       -          0    33062    logs 
   TABLE DATA           :   COPY public.logs (user_id, entry_date, email) FROM stdin;
    public          postgres    false    219   0?       &          0    32993    money 
   TABLE DATA           6   COPY public.money (id, user_id, user_sum) FROM stdin;
    public          postgres    false    212   M?       (          0    33014    shoes 
   TABLE DATA           9   COPY public.shoes (id, name, quality, price) FROM stdin;
    public          postgres    false    214   ??       ,          0    33046    user_buy_shoes 
   TABLE DATA           J   COPY public.user_buy_shoes (id, user_id, shoes_id, bought_at) FROM stdin;
    public          postgres    false    218   ??       9           0    0    categories_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.categories_id_seq', 11, true);
          public          postgres    false    215            :           0    0    employees_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.employees_id_seq', 7, true);
          public          postgres    false    209            ;           0    0    money_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.money_id_seq', 6, true);
          public          postgres    false    211            <           0    0    shoes_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.shoes_id_seq', 5, true);
          public          postgres    false    213            =           0    0    user_buy_shoes_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.user_buy_shoes_id_seq', 1, true);
          public          postgres    false    217            ?           2606    33027    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    216            ?           2606    32982    employees employees_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_email_key;
       public            postgres    false    210            ?           2606    32978    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public            postgres    false    210            ?           2606    32980    employees employees_surname_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_surname_key UNIQUE (surname);
 I   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_surname_key;
       public            postgres    false    210            ?           2606    32999    money money_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.money
    ADD CONSTRAINT money_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.money DROP CONSTRAINT money_pkey;
       public            postgres    false    212            ?           2606    33020    shoes shoes_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.shoes
    ADD CONSTRAINT shoes_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.shoes DROP CONSTRAINT shoes_pkey;
       public            postgres    false    214            ?           2606    33051 "   user_buy_shoes user_buy_shoes_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.user_buy_shoes
    ADD CONSTRAINT user_buy_shoes_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.user_buy_shoes DROP CONSTRAINT user_buy_shoes_pkey;
       public            postgres    false    218            ?           2620    33066    employees delete_logs_trigger    TRIGGER     y   CREATE TRIGGER delete_logs_trigger BEFORE DELETE ON public.employees FOR EACH ROW EXECUTE FUNCTION public.delete_logs();
 6   DROP TRIGGER delete_logs_trigger ON public.employees;
       public          postgres    false    221    210            ?           2620    33068    employees logs_tr    TRIGGER     i   CREATE TRIGGER logs_tr AFTER INSERT ON public.employees FOR EACH ROW EXECUTE FUNCTION public.new_logs();
 *   DROP TRIGGER logs_tr ON public.employees;
       public          postgres    false    222    210            ?           2620    33070    employees user_update_trigger    TRIGGER     x   CREATE TRIGGER user_update_trigger AFTER UPDATE ON public.employees FOR EACH ROW EXECUTE FUNCTION public.update_logs();
 6   DROP TRIGGER user_update_trigger ON public.employees;
       public          postgres    false    223    210            ?           2606    33028 #   categories categories_shoes_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_shoes_id_fkey FOREIGN KEY (shoes_id) REFERENCES public.shoes(id);
 M   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_shoes_id_fkey;
       public          postgres    false    216    3211    214            ?           2606    33000    money money_user_id_fkey    FK CONSTRAINT     {   ALTER TABLE ONLY public.money
    ADD CONSTRAINT money_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.employees(id);
 B   ALTER TABLE ONLY public.money DROP CONSTRAINT money_user_id_fkey;
       public          postgres    false    212    3205    210            ?           2606    33057 +   user_buy_shoes user_buy_shoes_shoes_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_buy_shoes
    ADD CONSTRAINT user_buy_shoes_shoes_id_fkey FOREIGN KEY (shoes_id) REFERENCES public.shoes(id);
 U   ALTER TABLE ONLY public.user_buy_shoes DROP CONSTRAINT user_buy_shoes_shoes_id_fkey;
       public          postgres    false    214    3211    218            ?           2606    33052 *   user_buy_shoes user_buy_shoes_user_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_buy_shoes
    ADD CONSTRAINT user_buy_shoes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.employees(id);
 T   ALTER TABLE ONLY public.user_buy_shoes DROP CONSTRAINT user_buy_shoes_user_id_fkey;
       public          postgres    false    210    218    3205            *   @   x?3?4?t?M-?LN????4?tO-?M̫???4??8M8?3??9M9?32??b???? )[C      $   ?   x?]λ?@???ǘ?n?5VT4?L`??d"~?????wNff??P-V??S?o<5?Ĭޢ??2???PP'?????"e[??h>??GP)??J??\#o???v)R?????O?t?jJ?8?S?;d???ן9.?\p?5u??????\)?>d?W2      -      x?????? ? ?      &   -   x???  ?7W??????'?V?
lw-ޜ|??rs??>???      (   [   x??1? ???c ept5?x ?? !
????mZ?????6?f(!H?3?????ԂjLO`?t> KӠO????4}t??,sED/?w?      ,   ,   x?3?4B###]C]C3#c+c+CC=CcsSS?=... |?n     