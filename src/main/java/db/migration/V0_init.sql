--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

-- Started on 2024-03-19 22:20:09

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2351 (class 1262 OID 16393)
-- Name: loja; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE loja WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';


ALTER DATABASE loja OWNER TO postgres;

\connect loja

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 220 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 220
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 221 (class 1255 OID 24941)
-- Name: validarchavepesssoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validarchavepesssoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare existe integer;

BEGIN 

existe=(select count(1) from pessoa_fisica where id =new.pessoa_id);
if(existe<=0)then
existe = (select count(1) from pessoa_juridica where id =new.pessoa.id);
if(existe<=0)then
raise exception 'nao foi econtrado ID ou PK da pessoa para associar';
end if;
end if;
return new;
END; 

$$;


ALTER FUNCTION public.validarchavepesssoa() OWNER TO postgres;

--
-- TOC entry 234 (class 1255 OID 32771)
-- Name: validarchavepesssoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION validarchavepesssoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

declare existe integer;

BEGIN 

existe=(select count(1) from pessoa_fisica where id =new.pessoa_forn_id);
if(existe<=0)then
existe = (select count(1) from pessoa_juridica where id =new.pessoa_forn_id);
if(existe<=0)then
raise exception 'nao foi econtrado ID ou PK da pessoa para associar';
end if;
end if;
return new;
END; 

$$;


ALTER FUNCTION public.validarchavepesssoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 184 (class 1259 OID 24583)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE acesso (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE acesso OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24834)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE avaliacao_produto OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 24576)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE categoria_produto OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 24673)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conta_pagar (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(38,2),
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    CONSTRAINT conta_pagar_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying, 'ALUGUEL'::character varying, 'FUNCIONARIO'::character varying, 'RENEGOCIADA'::character varying])::text[])))
);


ALTER TABLE conta_pagar OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 24654)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conta_receber (
    id bigint NOT NULL,
    dt_pagamento date,
    valor_desconto numeric(38,2),
    pessoa_id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    CONSTRAINT conta_receber_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying])::text[])))
);


ALTER TABLE conta_receber OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 24684)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cup_desc (
    id bigint NOT NULL,
    data_validade_cupom date,
    valor_porcent_desc numeric(38,2),
    valor_real_desc numeric(38,2),
    cod_desc character varying(255) NOT NULL
);


ALTER TABLE cup_desc OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24848)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    tipo_endereco character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    CONSTRAINT endereco_tipo_endereco_check CHECK (((tipo_endereco)::text = ANY ((ARRAY['COBRANCA'::character varying, 'ENTREGA'::character varying])::text[])))
);


ALTER TABLE endereco OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 24666)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE forma_pagamento OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 24701)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE imagem_produto OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24817)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE item_venda_loja (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virtu_id bigint NOT NULL
);


ALTER TABLE item_venda_loja OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 16394)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE marca_produto OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24872)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    num_nota character varying(255) NOT NULL,
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_icms numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24890)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 24729)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nota_item_produto (
    id bigint NOT NULL,
    quantidade character varying(255) NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    prosuto_id bigint NOT NULL
);


ALTER TABLE nota_item_produto OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 24590)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pessoa_fisica (
    id bigint NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL
);


ALTER TABLE pessoa_fisica OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 24600)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pessoa_juridica (
    id bigint NOT NULL,
    categoria character varying(255),
    insc_municipal character varying(255),
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cnpj character varying(255) NOT NULL,
    inscr_estadual character varying(255) NOT NULL,
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE pessoa_juridica OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24911)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE produto (
    id bigint NOT NULL,
    qtd_alerta_estoque integer,
    qtd_estoque integer NOT NULL,
    alerta_qtd_estoque boolean NOT NULL,
    altura double precision NOT NULL,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtd_clique integer,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(38,2) NOT NULL
);


ALTER TABLE produto OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 24588)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_acesso OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24839)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_avaliacao_produto OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 24581)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_categoria_produto OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24682)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_conta_pagar OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 24663)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_conta_receber OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 24689)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_cup_desc OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 24624)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_endereco OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 24671)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_forma_pagamento OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 24709)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_imagem_produto OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24822)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_item_venda_loja OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16399)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_marca_produto OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24801)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 24764)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 24734)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_nota_item_produto OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 24598)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_pessoa OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 24699)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_produto OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 24754)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_status_rastreio OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 24642)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_usuario OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24774)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE seq_vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24746)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE status_rastreio (
    id bigint NOT NULL,
    centro_distribuicao character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE status_rastreio OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 24627)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuario (
    id bigint NOT NULL,
    pessoa_id bigint NOT NULL,
    data_atual_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 24635)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE usuarios_acesso OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24767)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE vd_cp_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_desconto numeric(38,2),
    valor_fret numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    cupom_desc_id bigint,
    endereco_cobranca_id bigint NOT NULL,
    endereco_entrega_id bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 2311 (class 0 OID 24583)
-- Dependencies: 184
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2341 (class 0 OID 24834)
-- Dependencies: 214
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2309 (class 0 OID 24576)
-- Dependencies: 182
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2324 (class 0 OID 24673)
-- Dependencies: 197
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2320 (class 0 OID 24654)
-- Dependencies: 193
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2326 (class 0 OID 24684)
-- Dependencies: 199
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2343 (class 0 OID 24848)
-- Dependencies: 216
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2322 (class 0 OID 24666)
-- Dependencies: 195
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2329 (class 0 OID 24701)
-- Dependencies: 202
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2339 (class 0 OID 24817)
-- Dependencies: 212
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2307 (class 0 OID 16394)
-- Dependencies: 180
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2344 (class 0 OID 24872)
-- Dependencies: 217
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2345 (class 0 OID 24890)
-- Dependencies: 218
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2331 (class 0 OID 24729)
-- Dependencies: 204
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2313 (class 0 OID 24590)
-- Dependencies: 186
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2315 (class 0 OID 24600)
-- Dependencies: 188
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2346 (class 0 OID 24911)
-- Dependencies: 219
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 185
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_acesso', 1, false);


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 215
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_avaliacao_produto', 1, false);


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 183
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_categoria_produto', 1, false);


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 198
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_conta_pagar', 1, false);


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 194
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_conta_receber', 1, false);


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 200
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_cup_desc', 1, false);


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 189
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_endereco', 1, false);


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 196
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_forma_pagamento', 1, false);


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 203
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_imagem_produto', 1, false);


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 213
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_item_venda_loja', 1, false);


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 181
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_marca_produto', 1, false);


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 211
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 208
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 205
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_nota_item_produto', 1, false);


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 187
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_pessoa', 1, false);


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 201
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_produto', 1, false);


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 207
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_status_rastreio', 1, false);


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 192
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_usuario', 1, false);


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('seq_vd_cp_loja_virt', 1, false);


--
-- TOC entry 2333 (class 0 OID 24746)
-- Dependencies: 206
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2317 (class 0 OID 24627)
-- Dependencies: 190
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2318 (class 0 OID 24635)
-- Dependencies: 191
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2336 (class 0 OID 24767)
-- Dependencies: 209
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2118 (class 2606 OID 24587)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2150 (class 2606 OID 24838)
-- Name: avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2116 (class 2606 OID 24580)
-- Name: categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2132 (class 2606 OID 24681)
-- Name: conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 2128 (class 2606 OID 24662)
-- Name: conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 2134 (class 2606 OID 24688)
-- Name: cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 2152 (class 2606 OID 24856)
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 2130 (class 2606 OID 24670)
-- Name: forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2136 (class 2606 OID 24708)
-- Name: imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2148 (class 2606 OID 24821)
-- Name: item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 2114 (class 2606 OID 16398)
-- Name: marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2154 (class 2606 OID 24879)
-- Name: nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2156 (class 2606 OID 24897)
-- Name: nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 2138 (class 2606 OID 24733)
-- Name: nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2120 (class 2606 OID 24597)
-- Name: pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 2122 (class 2606 OID 24607)
-- Name: pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 2160 (class 2606 OID 24918)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2140 (class 2606 OID 24753)
-- Name: status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 2158 (class 2606 OID 24899)
-- Name: uk_3sg7y5xs15vowbpi2mcql08kg; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT uk_3sg7y5xs15vowbpi2mcql08kg UNIQUE (venda_compra_loja_virt_id);


--
-- TOC entry 2142 (class 2606 OID 24811)
-- Name: uk_ae7s32pyh14q43o3c3bt3f9ja; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT uk_ae7s32pyh14q43o3c3bt3f9ja UNIQUE (venda_compra_loja_virt_id);


--
-- TOC entry 2144 (class 2606 OID 24773)
-- Name: uk_hkxjejv08kldx994j4serhrbu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT uk_hkxjejv08kldx994j4serhrbu UNIQUE (nota_fiscal_venda_id);


--
-- TOC entry 2126 (class 2606 OID 24639)
-- Name: unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 2124 (class 2606 OID 24634)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2146 (class 2606 OID 24771)
-- Name: vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 2187 (class 2620 OID 24942)
-- Name: validarchavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoaavaliacaoproduto BEFORE UPDATE ON avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2188 (class 2620 OID 32768)
-- Name: validarchavepessoaavaliacaoproduto2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoaavaliacaoproduto2 BEFORE INSERT ON avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2181 (class 2620 OID 32769)
-- Name: validarchavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoacontapagar BEFORE UPDATE ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2182 (class 2620 OID 32770)
-- Name: validarchavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoacontapagar2 BEFORE INSERT ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2183 (class 2620 OID 32775)
-- Name: validarchavepessoacontapagarpessoa_forn_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoacontapagarpessoa_forn_id BEFORE UPDATE ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa2();


--
-- TOC entry 2184 (class 2620 OID 32776)
-- Name: validarchavepessoacontapagarpessoa_forn_id2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoacontapagarpessoa_forn_id2 BEFORE INSERT ON conta_pagar FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa2();


--
-- TOC entry 2179 (class 2620 OID 32779)
-- Name: validarchavepessoacontareceber; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoacontareceber BEFORE UPDATE ON conta_receber FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2180 (class 2620 OID 32780)
-- Name: validarchavepessoacontareceber2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoacontareceber2 BEFORE INSERT ON conta_receber FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2189 (class 2620 OID 32781)
-- Name: validarchavepessoaendereco; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoaendereco BEFORE UPDATE ON endereco FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2190 (class 2620 OID 32782)
-- Name: validarchavepessoaendereco2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoaendereco2 BEFORE INSERT ON endereco FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2191 (class 2620 OID 32783)
-- Name: validarchavepessoanotafiscalcompra; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoanotafiscalcompra BEFORE UPDATE ON nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2192 (class 2620 OID 32784)
-- Name: validarchavepessoanotafiscalcompra2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoanotafiscalcompra2 BEFORE INSERT ON nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2177 (class 2620 OID 32785)
-- Name: validarchavepessoausuario; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoausuario BEFORE UPDATE ON usuario FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2178 (class 2620 OID 32786)
-- Name: validarchavepessoausuario2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoausuario2 BEFORE INSERT ON usuario FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2185 (class 2620 OID 32787)
-- Name: validarchavepessoavd_cp_loja_virt; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoavd_cp_loja_virt BEFORE UPDATE ON vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2186 (class 2620 OID 32789)
-- Name: validarchavepessoavd_cp_loja_virt2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validarchavepessoavd_cp_loja_virt2 BEFORE INSERT ON vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE validarchavepesssoa();


--
-- TOC entry 2161 (class 2606 OID 24644)
-- Name: aesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT aesso_fk FOREIGN KEY (acesso_id) REFERENCES acesso(id);


--
-- TOC entry 2175 (class 2606 OID 24880)
-- Name: conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES conta_pagar(id);


--
-- TOC entry 2167 (class 2606 OID 24776)
-- Name: cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES cup_desc(id);


--
-- TOC entry 2169 (class 2606 OID 24857)
-- Name: endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES endereco(id);


--
-- TOC entry 2170 (class 2606 OID 24862)
-- Name: endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES endereco(id);


--
-- TOC entry 2168 (class 2606 OID 24791)
-- Name: forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id);


--
-- TOC entry 2164 (class 2606 OID 24885)
-- Name: nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES nota_fiscal_compra(id);


--
-- TOC entry 2171 (class 2606 OID 24905)
-- Name: nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES nota_fiscal_venda(id);


--
-- TOC entry 2174 (class 2606 OID 24919)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2163 (class 2606 OID 24924)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2173 (class 2606 OID 24929)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES produto(id);


--
-- TOC entry 2165 (class 2606 OID 24934)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (prosuto_id) REFERENCES produto(id);


--
-- TOC entry 2162 (class 2606 OID 24649)
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- TOC entry 2166 (class 2606 OID 24812)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2176 (class 2606 OID 24900)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2172 (class 2606 OID 24829)
-- Name: venda_compraloja_virtu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_venda_loja
    ADD CONSTRAINT venda_compraloja_virtu_fk FOREIGN KEY (venda_compra_loja_virtu_id) REFERENCES vd_cp_loja_virt(id);


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2024-03-19 22:20:09

--
-- PostgreSQL database dump complete
--

