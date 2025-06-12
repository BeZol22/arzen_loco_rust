--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: companies; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.companies (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    company_name character varying NOT NULL,
    company_tax_number character varying NOT NULL,
    company_country character varying,
    company_province character varying,
    company_postal_code character varying,
    company_settlement character varying,
    company_street character varying,
    company_street_number character varying,
    company_email character varying,
    company_phone_number character varying
);


ALTER TABLE public.companies OWNER TO loco;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO loco;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: company_billings; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.company_billings (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    billing_company_name character varying NOT NULL,
    billing_tax_number character varying NOT NULL,
    billing_email character varying,
    billing_country character varying,
    billing_province character varying,
    billing_postal_code character varying,
    billing_settlement character varying,
    billing_street character varying,
    billing_street_number character varying,
    company_iid uuid NOT NULL
);


ALTER TABLE public.company_billings OWNER TO loco;

--
-- Name: company_billings_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.company_billings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_billings_id_seq OWNER TO loco;

--
-- Name: company_billings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.company_billings_id_seq OWNED BY public.company_billings.id;


--
-- Name: company_contacts; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.company_contacts (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    contact_name character varying,
    contact_phone_number character varying,
    contact_email character varying,
    company_iid uuid NOT NULL
);


ALTER TABLE public.company_contacts OWNER TO loco;

--
-- Name: company_contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.company_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_contacts_id_seq OWNER TO loco;

--
-- Name: company_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.company_contacts_id_seq OWNED BY public.company_contacts.id;


--
-- Name: company_premises; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.company_premises (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    premise_company_name character varying,
    premise_country character varying,
    premise_email character varying,
    premise_phone_number character varying,
    premise_postal_code character varying,
    premise_province character varying,
    premise_settlement character varying,
    premise_street character varying,
    premise_street_number character varying,
    company_iid uuid NOT NULL
);


ALTER TABLE public.company_premises OWNER TO loco;

--
-- Name: company_premises_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.company_premises_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_premises_id_seq OWNER TO loco;

--
-- Name: company_premises_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.company_premises_id_seq OWNED BY public.company_premises.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.notes (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    title character varying,
    content character varying
);


ALTER TABLE public.notes OWNER TO loco;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notes_id_seq OWNER TO loco;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: pesticides; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.pesticides (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    pesticide_name character varying NOT NULL,
    pesticide_type character varying,
    pesticide_subtype1 character varying,
    pesticide_subtype2 character varying,
    pesticide_subtype3 character varying,
    pesticide_subtype4 character varying,
    pesticide_substance1 character varying,
    pesticide_substance2 character varying,
    pesticide_substance3 character varying,
    pesticide_substance4 character varying,
    pesticide_antidote1 character varying,
    pesticide_antidote2 character varying
);


ALTER TABLE public.pesticides OWNER TO loco;

--
-- Name: pesticides_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.pesticides_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pesticides_id_seq OWNER TO loco;

--
-- Name: pesticides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.pesticides_id_seq OWNED BY public.pesticides.id;


--
-- Name: responsible_persons; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.responsible_persons (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    responsible_person_name character varying,
    responsible_person_license character varying NOT NULL
);


ALTER TABLE public.responsible_persons OWNER TO loco;

--
-- Name: responsible_persons_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.responsible_persons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.responsible_persons_id_seq OWNER TO loco;

--
-- Name: responsible_persons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.responsible_persons_id_seq OWNED BY public.responsible_persons.id;


--
-- Name: seaql_migrations; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.seaql_migrations (
    version character varying NOT NULL,
    applied_at bigint NOT NULL
);


ALTER TABLE public.seaql_migrations OWNER TO loco;

--
-- Name: users; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.users (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    pid uuid NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    api_key character varying NOT NULL,
    name character varying NOT NULL,
    reset_token character varying,
    reset_sent_at timestamp with time zone,
    email_verification_token character varying,
    email_verification_sent_at timestamp with time zone,
    email_verified_at timestamp with time zone
);


ALTER TABLE public.users OWNER TO loco;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO loco;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: workdocuments; Type: TABLE; Schema: public; Owner: loco
--

CREATE TABLE public.workdocuments (
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id integer NOT NULL,
    internal_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    serial_number character varying NOT NULL,
    client_name character varying,
    jobs_done character varying,
    pesticides jsonb,
    responsible_person jsonb,
    client_name_for_work_paper character varying,
    scope_of_work character varying,
    work_art jsonb,
    work_end_date timestamp with time zone,
    work_start_date timestamp with time zone,
    work_subject jsonb,
    work_subject_other character varying,
    company_id integer NOT NULL
);


ALTER TABLE public.workdocuments OWNER TO loco;

--
-- Name: workdocuments_id_seq; Type: SEQUENCE; Schema: public; Owner: loco
--

CREATE SEQUENCE public.workdocuments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workdocuments_id_seq OWNER TO loco;

--
-- Name: workdocuments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: loco
--

ALTER SEQUENCE public.workdocuments_id_seq OWNED BY public.workdocuments.id;


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: company_billings id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_billings ALTER COLUMN id SET DEFAULT nextval('public.company_billings_id_seq'::regclass);


--
-- Name: company_contacts id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_contacts ALTER COLUMN id SET DEFAULT nextval('public.company_contacts_id_seq'::regclass);


--
-- Name: company_premises id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_premises ALTER COLUMN id SET DEFAULT nextval('public.company_premises_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: pesticides id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.pesticides ALTER COLUMN id SET DEFAULT nextval('public.pesticides_id_seq'::regclass);


--
-- Name: responsible_persons id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.responsible_persons ALTER COLUMN id SET DEFAULT nextval('public.responsible_persons_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: workdocuments id; Type: DEFAULT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.workdocuments ALTER COLUMN id SET DEFAULT nextval('public.workdocuments_id_seq'::regclass);


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.companies (created_at, updated_at, id, internal_id, company_name, company_tax_number, company_country, company_province, company_postal_code, company_settlement, company_street, company_street_number, company_email, company_phone_number) FROM stdin;
2024-12-14 13:19:43.554261+00	2024-12-14 13:19:43.554261+00	3	025116a5-673d-4cc9-8c45-2de5bb266e48	Máté Kft.	123456789-2-111	Magyarország	Budapest	2800	Tatabánya	Zápor utca	20	abc@email.hu	+363012349876
2024-12-11 13:08:35.348318+00	2025-03-20 14:39:30.575237+00	2	474d426e-82ea-482b-b198-34adf09b1092	Csaba Módosítva Kft.	123456789-2-25	Magyarország	Fejér	8000	Székesfehérvár	Zápor utca	20	abc@email.hu	+363012349876
2025-05-31 08:57:17.226054+00	2025-05-31 08:57:17.226054+00	4	4fc3539c-7a69-4375-9232-285f450d6533	Kriszti Kft.	123456789-2-19	Magyarország	Budapest	1034	Budapest	Zápor utca	20	abc@email.hu	+363012349876
2025-06-11 21:48:59.363564+00	2025-06-11 21:48:59.363564+00	5	30e24f2b-d6d1-49a5-8e82-20e565d1e9b4	Gergő Kft.	12345-2-11	Magyarország	Pest	1200	Vecsés	Alma utca	5	gergo@gmail.com	+3630123456
2025-06-12 13:59:38.640346+00	2025-06-12 13:59:38.640346+00	6	70a5aa28-a251-4ddc-a518-5afd47618adc	Kriszti 2 Kft.	1111-2	Magyarország		1191	Budapest	Dobó Katica utca	11		
\.


--
-- Data for Name: company_billings; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.company_billings (created_at, updated_at, id, internal_id, billing_company_name, billing_tax_number, billing_email, billing_country, billing_province, billing_postal_code, billing_settlement, billing_street, billing_street_number, company_iid) FROM stdin;
\.


--
-- Data for Name: company_contacts; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.company_contacts (created_at, updated_at, id, internal_id, contact_name, contact_phone_number, contact_email, company_iid) FROM stdin;
\.


--
-- Data for Name: company_premises; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.company_premises (created_at, updated_at, id, internal_id, premise_company_name, premise_country, premise_email, premise_phone_number, premise_postal_code, premise_province, premise_settlement, premise_street, premise_street_number, company_iid) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.notes (created_at, updated_at, id, title, content) FROM stdin;
\.


--
-- Data for Name: pesticides; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.pesticides (created_at, updated_at, id, internal_id, pesticide_name, pesticide_type, pesticide_subtype1, pesticide_subtype2, pesticide_subtype3, pesticide_subtype4, pesticide_substance1, pesticide_substance2, pesticide_substance3, pesticide_substance4, pesticide_antidote1, pesticide_antidote2) FROM stdin;
2024-11-02 19:19:03.053012+00	2024-11-02 19:19:03.053012+00	9	23ce942b-0014-46a7-a571-9eb3339ca43e	Nyest ellen	Rágcsálóirtószer	Nyestirtószer	\N	\N	\N	Hatóanyag neve	Hatóanyag #2 neve	Hatóanyag #3 neve	Hatóanyag #4 neve	Ellenszer neve	Ellenszer #2 neve
2024-11-02 19:19:17.835506+00	2024-11-02 19:19:17.835506+00	10	b30fd619-b4da-4d1e-a89e-f18a9dc12046	Nyest és egér ellen	Rágcsálóirtószer	Nyestirtószer	Egérirtószer	\N	\N	Hatóanyag neve	Hatóanyag #2 neve	Hatóanyag #3 neve	Hatóanyag #4 neve	Ellenszer neve	Ellenszer #2 neve
2024-11-03 10:00:07.993859+00	2024-11-03 10:00:07.993859+00	11	39bdcbe3-d094-415a-80b1-ba627fbb169d	Rovarok ellen vagyok	Rovarirtószer	Ágyipoloskairtószer	\N	\N	\N	Hatóanyag neve	Hatóanyag #2 neve	Hatóanyag #3 neve	Hatóanyag #4 neve	Ellenszer neve	Ellenszer #2 neve
2024-11-03 10:15:44.670028+00	2024-11-03 10:15:44.670028+00	12	7bd32f68-d8a9-42b8-90c5-dfabb776999d	Darázs ellen	Rovarirtószer	Darázsirtószer	\N	\N	\N	Hatóanyag neve	Hatóanyag #2 neve	Hatóanyag #3 neve	Hatóanyag #4 neve	Ellenszer neve	Ellenszer #2 neve
2024-11-03 10:15:57.291054+00	2024-11-03 10:15:57.291054+00	13	fb90c38f-975a-4e82-925e-7bd84a49ef73	Hangya és darázs ellen	Rovarirtószer	Hangyairtószer	Darázsirtószer	\N	\N	Hatóanyag neve	Hatóanyag #2 neve	Hatóanyag #3 neve	Hatóanyag #4 neve	Ellenszer neve	Ellenszer #2 neve
2024-12-11 13:06:55.197717+00	2024-12-11 13:07:22.610631+00	14	511f72ee-7d02-4120-ba62-3ea7dbe1342c	Csaba Irtószerrr	Rágcsálóirtószer	Patkányirtószer	\N	\N	\N	Lószar	Macskaszar	Emberi hugy		Nincs	
2024-12-14 13:18:31.713597+00	2024-12-14 13:18:31.713597+00	15	7c100771-89dd-4948-ac4d-2fb6efb3294d	Máté irtószer	Rovarirtószer	Légyirtószer	\N	\N	\N	Máté puki				Nincs	
2024-11-02 19:18:49.557889+00	2025-02-08 11:24:52.891784+00	8	f032541e-25f9-4628-a0c0-791e15c0c85b	Egerek ellen	Rágcsálóirtószer	Egérirtószer	\N	\N	\N	Egér elleni szer	Egér elleni szer 2	Egér elleni szer 3	Egér elleni szer 4	Egér elleni szer ellenszere	Egér elleni szer ellenszere 2
\.


--
-- Data for Name: responsible_persons; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.responsible_persons (created_at, updated_at, id, internal_id, responsible_person_name, responsible_person_license) FROM stdin;
2024-11-01 14:01:00.400899+00	2024-11-01 14:01:00.400899+00	4	d30f67eb-f8b0-4faa-83f9-71b574cd0239	Beke Zoltán	1788-3/2010
2024-11-01 14:01:11.123877+00	2024-11-01 14:01:11.123877+00	5	d6e03e83-2b65-4b19-a690-414cefa80fe5	Beke Máté	1788-3/2024
2024-12-11 13:05:09.219329+00	2024-12-11 13:05:48.356028+00	11	89a6a4b1-7208-4191-af13-09c7837f04b7	Herczegh Csabaaa	1788-3/2026
\.


--
-- Data for Name: seaql_migrations; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.seaql_migrations (version, applied_at) FROM stdin;
m20220101_000001_users	1730468839
m20231103_114510_notes	1730468839
m20241013_081933_companies	1730468839
m20241013_084731_company_contacts	1730468839
m20241013_091212_company_billings	1730468839
m20241013_164100_company_premises	1730468839
m20241101_130411_responsible_persons	1730468839
m20241101_140410_pesticides	1730566041
m20250321_104218_workdocuments	1742557204
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.users (created_at, updated_at, id, pid, email, password, api_key, name, reset_token, reset_sent_at, email_verification_token, email_verification_sent_at, email_verified_at) FROM stdin;
\.


--
-- Data for Name: workdocuments; Type: TABLE DATA; Schema: public; Owner: loco
--

COPY public.workdocuments (created_at, updated_at, id, internal_id, serial_number, client_name, jobs_done, pesticides, responsible_person, client_name_for_work_paper, scope_of_work, work_art, work_end_date, work_start_date, work_subject, work_subject_other, company_id) FROM stdin;
2025-03-30 15:52:41.435166+00	2025-03-30 15:52:41.435166+00	35	7aef1e67-ef8a-4ad2-8808-71b6ef7b0499	202503300019	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-03-05 22:59:59.999+00	2025-03-04 23:00:00+00	["rovarirtás"]		3
2025-03-30 15:54:31.968734+00	2025-03-30 15:54:31.968734+00	36	1cd4f3e5-b763-4b83-92fa-ed52687c5503	202503300020	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-03-06 22:59:59.999+00	2025-03-05 23:00:00+00	["rágcsálóirtás"]		3
2025-06-12 14:35:00.112928+00	2025-06-12 14:35:00.112928+00	59	967ec9ab-d82a-4c7e-839c-424d41b80131	202506120006	Alma	Körte	[{"pesticide": {"createdAt": "2025-06-12T13:57:50.260Z", "updatedAt": "2025-06-12T13:57:50.260Z", "internalId": "b26f2a9e-705b-4218-8977-7d400db2a01b", "pesticideName": "Kriszti szuperirtószer", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Csótányirtószer"], "pesticideAntidote1": "Sok sok levegő", "pesticideAntidote2": "", "pesticideSubstance1": "Kriszti köpet", "pesticideSubstance2": "", "pesticideSubstance3": "", "pesticideSubstance4": ""}, "pesticideName": "Kriszti szuperirtószer", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Csótányirtószer"]}]	{"createdAt": "2025-06-12T14:32:16.698318Z", "updatedAt": "2025-06-12T14:32:16.698318Z", "internalId": "e2189f57-a61f-44de-94d5-a36cf63edf46", "responsiblePersonName": "Beke Krisztina Brigitta", "responsiblePersonLicense": "1112"}	Alma	Körte	["szerződéses"]	2025-06-15 21:59:59.999+00	2025-06-13 22:00:00+00	["rovarirtás"]		6
2025-03-30 09:57:10.31126+00	2025-03-30 09:57:10.31126+00	17	3095c61d-8418-4c31-a199-628367ffef95	202503300001	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-03T10:15:44.670028Z", "updatedAt": "2024-11-03T10:15:44.670028Z", "internalId": "7bd32f68-d8a9-42b8-90c5-dfabb776999d", "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-03-21 22:59:59.999+00	2025-03-19 23:00:00+00	["rágcsálóirtás", "rovarirtás"]		2
2025-03-30 13:55:12.670592+00	2025-03-30 13:55:12.670592+00	18	093450be-a3e8-4902-83f7-37a02f1a2b55	202503300002	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-03T10:15:44.670028Z", "updatedAt": "2024-11-03T10:15:44.670028Z", "internalId": "7bd32f68-d8a9-42b8-90c5-dfabb776999d", "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-03-14 22:59:59.999+00	2025-03-11 23:00:00+00	["rágcsálóirtás", "rovarirtás"]		2
2025-03-30 14:03:05.486285+00	2025-03-30 14:03:05.486285+00	19	575e03dd-d90b-448e-9b1a-01958f2c9dd4	202503300003	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-16 22:59:59.999+00	2025-03-12 23:00:00+00	["rágcsálóirtás"]		2
2025-03-30 14:04:06.479987+00	2025-03-30 14:04:06.479987+00	20	142d96fc-f4ff-4484-9762-1e6fc447ad12	202503300004	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-03T10:15:44.670028Z", "updatedAt": "2024-11-03T10:15:44.670028Z", "internalId": "7bd32f68-d8a9-42b8-90c5-dfabb776999d", "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-03-21 22:59:59.999+00	2025-03-17 23:00:00+00	["rovarirtás"]		2
2025-03-30 14:29:50.756327+00	2025-03-30 14:29:50.756327+00	21	95bd75ca-b7a1-4853-aa02-0b7350af6540	202503300005	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:19:17.835506Z", "updatedAt": "2024-11-02T19:19:17.835506Z", "internalId": "b30fd619-b4da-4d1e-a89e-f18a9dc12046", "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer", "Egérirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-12-11T13:05:09.219329Z", "updatedAt": "2024-12-11T13:05:48.356028Z", "internalId": "89a6a4b1-7208-4191-af13-09c7837f04b7", "responsiblePersonName": "Herczegh Csabaaa", "responsiblePersonLicense": "1788-3/2026"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-27 22:59:59.999+00	2025-03-24 23:00:00+00	["egyéb"]	Cipőfertőtlenítés	3
2025-03-30 14:30:43.401157+00	2025-03-30 14:30:43.401157+00	22	7c3d06bb-3a64-41e9-b583-d5cbfa145a3f	202503300006	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:19:17.835506Z", "updatedAt": "2024-11-02T19:19:17.835506Z", "internalId": "b30fd619-b4da-4d1e-a89e-f18a9dc12046", "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer", "Egérirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-12-11T13:05:09.219329Z", "updatedAt": "2024-12-11T13:05:48.356028Z", "internalId": "89a6a4b1-7208-4191-af13-09c7837f04b7", "responsiblePersonName": "Herczegh Csabaaa", "responsiblePersonLicense": "1788-3/2026"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-27 22:59:59.999+00	2025-03-24 23:00:00+00	["egyéb"]	Cipőfertőtlenítés	3
2025-03-30 14:39:47.994396+00	2025-03-30 14:39:47.994396+00	23	76178107-3679-4cbc-bae4-a21a4a477d68	202503300007	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-04 23:00:00+00	["egyéb"]	Cipőfertőtlenítés	3
2025-03-30 14:40:06.874707+00	2025-03-30 14:40:06.874707+00	24	8f117bab-6257-4caa-8565-b7892f32f012	202503300008	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-04 23:00:00+00	["egyéb", "rovarirtás"]	Cipőfertőtlenítés	3
2025-03-30 14:40:25.241041+00	2025-03-30 14:40:25.241041+00	25	b5a1c430-7eef-45e2-b09f-3b2ab49309eb	202503300009	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-04 23:00:00+00	["egyéb", "rovarirtás", "rágcsálóirtás"]	Cipőfertőtlenítés	3
2025-03-30 14:48:40.164192+00	2025-03-30 14:48:40.164192+00	26	d0eb2ef0-373e-426e-a372-d5e7ef9c7071	202503300010	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-05 23:00:00+00	["egyéb", "rovarirtás"]	autómosás	3
2025-03-30 14:49:41.769393+00	2025-03-30 14:49:41.769393+00	27	a5b0ea84-d914-4af1-b0e0-4a86d97a9d76	202503300011	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-05 23:00:00+00	["rovarirtás"]		3
2025-03-30 14:49:59.144563+00	2025-03-30 14:49:59.144563+00	28	7d690b39-8f0b-40df-bd6d-a0e4198bf60e	202503300012	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-05 23:00:00+00	["rovarirtás", "egyéb"]	 	3
2025-03-30 14:50:34.760658+00	2025-03-30 14:50:34.760658+00	29	c8d9695a-96b8-4545-be53-ab4fce0a8902	202503300013	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-07 22:59:59.999+00	2025-03-05 23:00:00+00	["rovarirtás", "egyéb"]	    kacsa	3
2025-03-30 15:17:08.059011+00	2025-03-30 15:17:08.059011+00	30	2b9a5a7f-726d-4fa5-8f9e-dcfe97be6bfb	202503300014	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[]	{"createdAt": "2024-12-11T13:05:09.219329Z", "updatedAt": "2024-12-11T13:05:48.356028Z", "internalId": "89a6a4b1-7208-4191-af13-09c7837f04b7", "responsiblePersonName": "Herczegh Csabaaa", "responsiblePersonLicense": "1788-3/2026"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-13 22:59:59.999+00	2025-03-11 23:00:00+00	["egyéb"]	kacsa	3
2025-03-30 15:27:01.196335+00	2025-03-30 15:27:01.196335+00	31	d0bcb089-df5a-43d3-b225-126d05b1ea5d	202503300015	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:19:03.053012Z", "updatedAt": "2024-11-02T19:19:03.053012Z", "internalId": "23ce942b-0014-46a7-a571-9eb3339ca43e", "pesticideName": "Nyest ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-03-09 22:59:59.999+00	2025-03-06 23:00:00+00	["egyéb"]	teve	3
2025-03-30 15:27:58.34744+00	2025-03-30 15:27:58.34744+00	32	2b3328db-e9c0-46d2-8207-5e0070db7f15	202503300016	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:19:03.053012Z", "updatedAt": "2024-11-02T19:19:03.053012Z", "internalId": "23ce942b-0014-46a7-a571-9eb3339ca43e", "pesticideName": "Nyest ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-09 22:59:59.999+00	2025-03-06 23:00:00+00	["egyéb"]	teve	3
2025-03-30 15:30:32.958735+00	2025-03-30 15:30:32.958735+00	33	0724607b-3e49-4bb6-a199-c73ab1a4137b	202503300017	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-13 22:59:59.999+00	2025-03-11 23:00:00+00	["egyéb"]	liba	3
2025-03-30 15:31:26.493337+00	2025-03-30 15:31:26.493337+00	34	6f518db3-baf1-4641-95f4-712f2c722b96	202503300018	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["eseti"]	2025-03-15 22:59:59.999+00	2025-03-11 23:00:00+00	["rovarirtás"]		3
2025-05-30 15:05:35.975091+00	2025-05-30 15:05:35.975091+00	37	c05ff2ed-33d2-4763-9ef3-9034f0b834cd	202505300001	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-05-31 21:59:59.999+00	2025-05-29 22:00:00+00	["rágcsálóirtás"]		3
2025-05-31 08:57:37.851994+00	2025-05-31 08:57:37.851994+00	38	a30fe43c-fd41-45f4-801e-0149586610e6	202505310001	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-06-05 21:59:59.999+00	2025-06-03 22:00:00+00	["rágcsálóirtás"]		4
2025-06-11 08:32:54.452706+00	2025-06-11 08:32:54.452706+00	43	bde966b7-654d-46aa-91f9-36bb0407cfa8	202506110001	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557Z", "updatedAt": "2025-02-08T11:24:52.891Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-03T10:15:57.291054Z", "updatedAt": "2024-11-03T10:15:57.291054Z", "internalId": "fb90c38f-975a-4e82-925e-7bd84a49ef73", "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Hangyairtószer", "Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-06-27 21:59:59.999+00	2025-06-25 22:00:00+00	["rágcsálóirtás", "rovarirtás"]		4
2025-06-11 09:19:49.82937+00	2025-06-11 09:19:49.82937+00	44	daba2717-650d-4ce1-9bdc-f4844effe4ee	202506110002	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-03T10:15:44.670028Z", "updatedAt": "2024-11-03T10:15:44.670028Z", "internalId": "7bd32f68-d8a9-42b8-90c5-dfabb776999d", "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-25 21:59:59.999+00	2025-06-24 22:00:00+00	["rovarirtás"]		4
2025-06-11 10:35:39.440124+00	2025-06-11 10:35:39.440124+00	45	238ae56f-9742-49d6-92b1-2c42cb646545	202506110003	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-13 21:59:59.999+00	2025-06-11 22:00:00+00	["rovarirtás"]		4
2025-06-11 10:36:19.720311+00	2025-06-11 10:36:19.720311+00	46	bfce0564-6caf-47b0-abf0-d0ef615bdaa6	202506110004	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-03T10:15:57.291054Z", "updatedAt": "2024-11-03T10:15:57.291054Z", "internalId": "fb90c38f-975a-4e82-925e-7bd84a49ef73", "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Hangyairtószer", "Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}, {"pesticide": {"createdAt": "2024-11-02T19:19:17.835506Z", "updatedAt": "2024-11-02T19:19:17.835506Z", "internalId": "b30fd619-b4da-4d1e-a89e-f18a9dc12046", "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer", "Egérirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-12 21:59:59.999+00	2025-06-11 22:00:00+00	["rovarirtás"]		4
2025-06-11 10:36:29.237846+00	2025-06-11 10:36:29.237846+00	47	f2ea7c03-ede8-4ab7-9de3-2003eac1f75e	202506110005	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-03T10:15:57.291054Z", "updatedAt": "2024-11-03T10:15:57.291054Z", "internalId": "fb90c38f-975a-4e82-925e-7bd84a49ef73", "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Hangyairtószer", "Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}, {"pesticide": {"createdAt": "2024-11-02T19:19:17.835506Z", "updatedAt": "2024-11-02T19:19:17.835506Z", "internalId": "b30fd619-b4da-4d1e-a89e-f18a9dc12046", "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer", "Egérirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-12 21:59:59.999+00	2025-06-11 22:00:00+00	["rovarirtás"]		4
2025-06-11 10:36:44.045058+00	2025-06-11 10:36:44.045058+00	48	c706db01-3c28-4b2b-ac00-550168634892	202506110006	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-03T10:15:57.291054Z", "updatedAt": "2024-11-03T10:15:57.291054Z", "internalId": "fb90c38f-975a-4e82-925e-7bd84a49ef73", "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Hangyairtószer", "Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}, {"pesticide": {"createdAt": "2024-11-02T19:19:17.835506Z", "updatedAt": "2024-11-02T19:19:17.835506Z", "internalId": "b30fd619-b4da-4d1e-a89e-f18a9dc12046", "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer", "Egérirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-12 21:59:59.999+00	2025-06-11 22:00:00+00	["rovarirtás"]		4
2025-06-11 10:37:09.563862+00	2025-06-11 10:37:09.563862+00	49	a74c85e9-f3be-4d65-97ed-638acb0a5681	202506110007	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-03T10:15:57.291054Z", "updatedAt": "2024-11-03T10:15:57.291054Z", "internalId": "fb90c38f-975a-4e82-925e-7bd84a49ef73", "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Hangyairtószer", "Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Hangya és darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-12 21:59:59.999+00	2025-06-11 22:00:00+00	["rovarirtás"]		4
2025-06-11 10:47:28.875046+00	2025-06-11 10:47:28.875046+00	50	36815be2-d438-435a-b508-25e92d835ddd	202506110008	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-28 21:59:59.999+00	2025-06-27 22:00:00+00	["rovarirtás"]		4
2025-06-12 06:52:41.589364+00	2025-06-12 06:52:41.589364+00	53	49902c17-79aa-475c-801f-e286cb7adba0	202506120001	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557Z", "updatedAt": "2025-02-08T11:24:52.891Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-02T19:18:49.557889Z", "updatedAt": "2025-02-08T11:24:52.891784Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-13 21:59:59.999+00	2025-06-12 22:00:00+00	["rovarirtás"]		4
2025-06-12 09:45:55.944993+00	2025-06-12 09:45:55.944993+00	55	ae774646-3fcf-4c4f-be42-7d7b846965c3	202506120002	Kliens Cég Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-03T10:15:44.670Z", "updatedAt": "2024-11-03T10:15:44.670Z", "internalId": "7bd32f68-d8a9-42b8-90c5-dfabb776999d", "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Darázs ellen", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Darázsirtószer"]}]	{"createdAt": "2024-11-01T14:01:11.123877Z", "updatedAt": "2024-11-01T14:01:11.123877Z", "internalId": "d6e03e83-2b65-4b19-a690-414cefa80fe5", "responsiblePersonName": "Beke Máté", "responsiblePersonLicense": "1788-3/2024"}	Bogaras Vagyok Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca sarkától 50 méterre lévő csatornánál	["szerződéses"]	2025-06-27 21:59:59.999+00	2025-06-25 22:00:00+00	["rovarirtás"]		2
2025-06-12 14:04:14.825403+00	2025-06-12 14:04:14.825403+00	56	3b4e12fa-5b4a-4ded-915d-064f5e5a79cd	202506120003	Beke Kft.	mostunk, főztünk, takarítottunk, cipőt pucoltunk, kutyát sétáltattunk, macskát etettünk, kávét főztünk, majd teát ittunk rummal.	[{"pesticide": {"createdAt": "2024-11-02T19:18:49.557Z", "updatedAt": "2025-02-08T11:24:52.891Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}, {"pesticide": {"createdAt": "2024-11-02T19:18:49.557Z", "updatedAt": "2025-02-08T11:24:52.891Z", "internalId": "f032541e-25f9-4628-a0c0-791e15c0c85b", "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"], "pesticideAntidote1": "Egér elleni szer ellenszere", "pesticideAntidote2": "Egér elleni szer ellenszere 2", "pesticideSubstance1": "Egér elleni szer", "pesticideSubstance2": "Egér elleni szer 2", "pesticideSubstance3": "Egér elleni szer 3", "pesticideSubstance4": "Egér elleni szer 4"}, "pesticideName": "Egerek ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-11-01T14:01:00.400899Z", "updatedAt": "2024-11-01T14:01:00.400899Z", "internalId": "d30f67eb-f8b0-4faa-83f9-71b574cd0239", "responsiblePersonName": "Beke Zoltán", "responsiblePersonLicense": "1788-3/2010"}	Bogaras Kft., 1034 Budapest, Bécsi út 20.	Selmeci utca	["eseti"]	2025-06-27 21:59:59.999+00	2025-06-25 22:00:00+00	["rovarirtás"]		4
2025-06-12 14:28:44.740859+00	2025-06-12 14:28:44.740859+00	57	9a878752-fba6-4743-afbe-6a35e259b7e3	202506120004	Alma	Körte	[{"pesticide": {"createdAt": "2025-06-12T13:57:50.260211Z", "updatedAt": "2025-06-12T13:57:50.260211Z", "internalId": "b26f2a9e-705b-4218-8977-7d400db2a01b", "pesticideName": "Kriszti szuperirtószer", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Csótányirtószer"], "pesticideAntidote1": "Sok sok levegő", "pesticideAntidote2": "", "pesticideSubstance1": "Kriszti köpet", "pesticideSubstance2": "", "pesticideSubstance3": "", "pesticideSubstance4": ""}, "pesticideName": "Kriszti szuperirtószer", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Csótányirtószer"]}]	{"createdAt": "2025-06-12T13:57:07.909713Z", "updatedAt": "2025-06-12T13:57:07.909713Z", "internalId": "884ad31e-d927-4175-b885-915ff15c9cf3", "responsiblePersonName": "Beke Krisztina Brigitta", "responsiblePersonLicense": "1991"}	Alma	Körte	["szerződéses"]	2025-06-14 21:59:59.999+00	2025-06-12 22:00:00+00	["rovarirtás"]		6
2025-06-12 14:34:29.824462+00	2025-06-12 14:34:29.824462+00	58	38a032a0-6d50-453f-aa13-deba4e7c5f78	202506120005	Alma	Körte	[{"pesticide": {"createdAt": "2025-06-12T13:57:50.260Z", "updatedAt": "2025-06-12T13:57:50.260Z", "internalId": "b26f2a9e-705b-4218-8977-7d400db2a01b", "pesticideName": "Kriszti szuperirtószer", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Csótányirtószer"], "pesticideAntidote1": "Sok sok levegő", "pesticideAntidote2": "", "pesticideSubstance1": "Kriszti köpet", "pesticideSubstance2": "", "pesticideSubstance3": "", "pesticideSubstance4": ""}, "pesticideName": "Kriszti szuperirtószer", "pesticideType": "Rovarirtószer", "pesticideSubtypes": ["Csótányirtószer"]}]	{"createdAt": "2025-06-12T14:32:16.698318Z", "updatedAt": "2025-06-12T14:32:16.698318Z", "internalId": "e2189f57-a61f-44de-94d5-a36cf63edf46", "responsiblePersonName": "Beke Krisztina Brigitta", "responsiblePersonLicense": "1112"}	Alma	Körte	["szerződéses"]	2025-06-22 21:59:59.999+00	2025-06-14 22:00:00+00	["rovarirtás"]		6
2025-06-12 16:09:44.110357+00	2025-06-12 16:09:44.110357+00	62	11b26d67-0d28-4bdd-91d4-066c216f530f	202506120007	Alma	Körte	[{"pesticide": {"createdAt": "2024-11-02T19:19:17.835506Z", "updatedAt": "2024-11-02T19:19:17.835506Z", "internalId": "b30fd619-b4da-4d1e-a89e-f18a9dc12046", "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Nyestirtószer", "Egérirtószer"], "pesticideAntidote1": "Ellenszer neve", "pesticideAntidote2": "Ellenszer #2 neve", "pesticideSubstance1": "Hatóanyag neve", "pesticideSubstance2": "Hatóanyag #2 neve", "pesticideSubstance3": "Hatóanyag #3 neve", "pesticideSubstance4": "Hatóanyag #4 neve"}, "pesticideName": "Nyest és egér ellen", "pesticideType": "Rágcsálóirtószer", "pesticideSubtypes": ["Egérirtószer"]}]	{"createdAt": "2024-12-11T13:05:09.219329Z", "updatedAt": "2024-12-11T13:05:48.356028Z", "internalId": "89a6a4b1-7208-4191-af13-09c7837f04b7", "responsiblePersonName": "Herczegh Csabaaa", "responsiblePersonLicense": "1788-3/2026"}	Alma	Körte	["szerződéses"]	2025-06-15 21:59:59.999+00	2025-06-14 22:00:00+00	["rágcsálóirtás"]		6
\.


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.companies_id_seq', 6, true);


--
-- Name: company_billings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.company_billings_id_seq', 1, false);


--
-- Name: company_contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.company_contacts_id_seq', 1, false);


--
-- Name: company_premises_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.company_premises_id_seq', 1, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- Name: pesticides_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.pesticides_id_seq', 16, true);


--
-- Name: responsible_persons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.responsible_persons_id_seq', 16, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: workdocuments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: loco
--

SELECT pg_catalog.setval('public.workdocuments_id_seq', 62, true);


--
-- Name: companies companies_company_name_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_company_name_key UNIQUE (company_name);


--
-- Name: companies companies_company_tax_number_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_company_tax_number_key UNIQUE (company_tax_number);


--
-- Name: companies companies_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_internal_id_key UNIQUE (internal_id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_billings company_billings_billing_company_name_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_billings
    ADD CONSTRAINT company_billings_billing_company_name_key UNIQUE (billing_company_name);


--
-- Name: company_billings company_billings_billing_tax_number_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_billings
    ADD CONSTRAINT company_billings_billing_tax_number_key UNIQUE (billing_tax_number);


--
-- Name: company_billings company_billings_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_billings
    ADD CONSTRAINT company_billings_internal_id_key UNIQUE (internal_id);


--
-- Name: company_billings company_billings_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_billings
    ADD CONSTRAINT company_billings_pkey PRIMARY KEY (id);


--
-- Name: company_contacts company_contacts_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_internal_id_key UNIQUE (internal_id);


--
-- Name: company_contacts company_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT company_contacts_pkey PRIMARY KEY (id);


--
-- Name: company_premises company_premises_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_premises
    ADD CONSTRAINT company_premises_internal_id_key UNIQUE (internal_id);


--
-- Name: company_premises company_premises_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_premises
    ADD CONSTRAINT company_premises_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: pesticides pesticides_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.pesticides
    ADD CONSTRAINT pesticides_internal_id_key UNIQUE (internal_id);


--
-- Name: pesticides pesticides_pesticide_name_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.pesticides
    ADD CONSTRAINT pesticides_pesticide_name_key UNIQUE (pesticide_name);


--
-- Name: pesticides pesticides_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.pesticides
    ADD CONSTRAINT pesticides_pkey PRIMARY KEY (id);


--
-- Name: responsible_persons responsible_persons_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.responsible_persons
    ADD CONSTRAINT responsible_persons_internal_id_key UNIQUE (internal_id);


--
-- Name: responsible_persons responsible_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.responsible_persons
    ADD CONSTRAINT responsible_persons_pkey PRIMARY KEY (id);


--
-- Name: responsible_persons responsible_persons_responsible_person_license_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.responsible_persons
    ADD CONSTRAINT responsible_persons_responsible_person_license_key UNIQUE (responsible_person_license);


--
-- Name: seaql_migrations seaql_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.seaql_migrations
    ADD CONSTRAINT seaql_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_api_key_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_api_key_key UNIQUE (api_key);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: workdocuments workdocuments_internal_id_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.workdocuments
    ADD CONSTRAINT workdocuments_internal_id_key UNIQUE (internal_id);


--
-- Name: workdocuments workdocuments_pkey; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.workdocuments
    ADD CONSTRAINT workdocuments_pkey PRIMARY KEY (id);


--
-- Name: workdocuments workdocuments_serial_number_key; Type: CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.workdocuments
    ADD CONSTRAINT workdocuments_serial_number_key UNIQUE (serial_number);


--
-- Name: company_billings fk-company_billings-companies; Type: FK CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_billings
    ADD CONSTRAINT "fk-company_billings-companies" FOREIGN KEY (company_iid) REFERENCES public.companies(internal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: company_premises fk-company_billings-companies; Type: FK CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_premises
    ADD CONSTRAINT "fk-company_billings-companies" FOREIGN KEY (company_iid) REFERENCES public.companies(internal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: company_contacts fk-company_contacts-companies; Type: FK CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.company_contacts
    ADD CONSTRAINT "fk-company_contacts-companies" FOREIGN KEY (company_iid) REFERENCES public.companies(internal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: workdocuments fk-workdocuments-companies; Type: FK CONSTRAINT; Schema: public; Owner: loco
--

ALTER TABLE ONLY public.workdocuments
    ADD CONSTRAINT "fk-workdocuments-companies" FOREIGN KEY (company_id) REFERENCES public.companies(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

