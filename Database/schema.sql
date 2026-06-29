--
-- PostgreSQL database dump
--

\restrict yONfUTrL93PUKO5Z6ggNjNAER0z0UQVhlIkQN3jPySKST7E42h1KAfFvuST4Jos

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2026-06-29 12:53:32

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
-- TOC entry 2 (class 3079 OID 343447)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 898 (class 1247 OID 343417)
-- Name: backlinkstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.backlinkstatus AS ENUM (
    'ACTIVE',
    'LOST',
    'PENDING'
);


ALTER TYPE public.backlinkstatus OWNER TO postgres;

--
-- TOC entry 889 (class 1247 OID 343395)
-- Name: competitorstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.competitorstatus AS ENUM (
    'ACTIVE',
    'INACTIVE'
);


ALTER TYPE public.competitorstatus OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 343536)
-- Name: backlink_analysis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlink_analysis (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    competitor_backlink_id uuid NOT NULL,
    source_domain character varying(255),
    domain_rating integer,
    relevance_score integer,
    authority_score integer,
    opportunity_score integer,
    link_type character varying(50),
    recommendation text,
    analyzed_at timestamp without time zone DEFAULT now(),
    spam_score integer
);


ALTER TABLE public.backlink_analysis OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 343552)
-- Name: backlink_opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlink_opportunities (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    analysis_id uuid NOT NULL,
    domain_rating_score integer NOT NULL,
    relevance_score integer NOT NULL,
    difficulty_score integer NOT NULL,
    final_score integer NOT NULL,
    priority character varying(20) NOT NULL,
    suggested_action text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.backlink_opportunities OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 343408)
-- Name: backlink_sources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlink_sources (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source_domain character varying(255) NOT NULL,
    domain_rating integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.backlink_sources OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 343423)
-- Name: competitor_backlinks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competitor_backlinks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    competitor_id uuid NOT NULL,
    backlink_source_id uuid NOT NULL,
    source_url character varying(500) NOT NULL,
    anchor_text character varying(500),
    first_seen_date timestamp without time zone NOT NULL,
    last_seen_date timestamp without time zone NOT NULL,
    is_analyzed boolean DEFAULT false NOT NULL,
    status public.backlinkstatus DEFAULT 'ACTIVE'::public.backlinkstatus NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    nofollow boolean
);


ALTER TABLE public.competitor_backlinks OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 343399)
-- Name: competitors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.competitors (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_name character varying(255) NOT NULL,
    domain character varying(255) NOT NULL,
    industry character varying(100) NOT NULL,
    status public.competitorstatus DEFAULT 'ACTIVE'::public.competitorstatus NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.competitors OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 351938)
-- Name: email_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.email_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workflow_name character varying(150),
    recipient_email character varying(255),
    subject text,
    attachment_name character varying(255),
    status character varying(20),
    sent_at timestamp without time zone,
    error_message text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.email_logs OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 351909)
-- Name: error_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.error_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    agent_name character varying(100),
    workflow_name character varying(200),
    node_name character varying(150),
    error_type character varying(150),
    error_message text,
    input_data jsonb,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.error_logs OWNER TO postgres;

--
-- TOC entry 4841 (class 2606 OID 343544)
-- Name: backlink_analysis backlink_analysis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_analysis
    ADD CONSTRAINT backlink_analysis_pkey PRIMARY KEY (id);


--
-- TOC entry 4845 (class 2606 OID 343562)
-- Name: backlink_opportunities backlink_opportunities_analysis_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_opportunities
    ADD CONSTRAINT backlink_opportunities_analysis_id_key UNIQUE (analysis_id);


--
-- TOC entry 4847 (class 2606 OID 343560)
-- Name: backlink_opportunities backlink_opportunities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_opportunities
    ADD CONSTRAINT backlink_opportunities_pkey PRIMARY KEY (id);


--
-- TOC entry 4830 (class 2606 OID 343412)
-- Name: backlink_sources backlink_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_sources
    ADD CONSTRAINT backlink_sources_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 343431)
-- Name: competitor_backlinks competitor_backlinks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitor_backlinks
    ADD CONSTRAINT competitor_backlinks_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 343406)
-- Name: competitors competitors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitors
    ADD CONSTRAINT competitors_pkey PRIMARY KEY (id);


--
-- TOC entry 4851 (class 2606 OID 351946)
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4849 (class 2606 OID 351917)
-- Name: error_logs error_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.error_logs
    ADD CONSTRAINT error_logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4843 (class 2606 OID 343551)
-- Name: backlink_analysis uq_backlink_analysis; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_analysis
    ADD CONSTRAINT uq_backlink_analysis UNIQUE (competitor_backlink_id);


--
-- TOC entry 4833 (class 2606 OID 343414)
-- Name: backlink_sources uq_backlink_source_domain; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_sources
    ADD CONSTRAINT uq_backlink_source_domain UNIQUE (source_domain);


--
-- TOC entry 4839 (class 2606 OID 343433)
-- Name: competitor_backlinks uq_competitor_backlink_source; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitor_backlinks
    ADD CONSTRAINT uq_competitor_backlink_source UNIQUE (competitor_id, backlink_source_id);


--
-- TOC entry 4831 (class 1259 OID 343415)
-- Name: ix_backlink_sources_source_domain; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_backlink_sources_source_domain ON public.backlink_sources USING btree (source_domain);


--
-- TOC entry 4836 (class 1259 OID 343445)
-- Name: ix_competitor_backlink_first_seen; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_competitor_backlink_first_seen ON public.competitor_backlinks USING btree (competitor_id, first_seen_date);


--
-- TOC entry 4837 (class 1259 OID 343444)
-- Name: ix_competitor_backlink_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_competitor_backlink_status ON public.competitor_backlinks USING btree (competitor_id, status);


--
-- TOC entry 4828 (class 1259 OID 343407)
-- Name: ix_competitors_domain; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_competitors_domain ON public.competitors USING btree (domain);


--
-- TOC entry 4854 (class 2606 OID 343545)
-- Name: backlink_analysis backlink_analysis_competitor_backlink_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_analysis
    ADD CONSTRAINT backlink_analysis_competitor_backlink_id_fkey FOREIGN KEY (competitor_backlink_id) REFERENCES public.competitor_backlinks(id) ON DELETE CASCADE;


--
-- TOC entry 4855 (class 2606 OID 343563)
-- Name: backlink_opportunities backlink_opportunities_analysis_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlink_opportunities
    ADD CONSTRAINT backlink_opportunities_analysis_id_fkey FOREIGN KEY (analysis_id) REFERENCES public.backlink_analysis(id) ON DELETE CASCADE;


--
-- TOC entry 4852 (class 2606 OID 343439)
-- Name: competitor_backlinks competitor_backlinks_backlink_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitor_backlinks
    ADD CONSTRAINT competitor_backlinks_backlink_source_id_fkey FOREIGN KEY (backlink_source_id) REFERENCES public.backlink_sources(id) ON DELETE CASCADE;


--
-- TOC entry 4853 (class 2606 OID 343434)
-- Name: competitor_backlinks competitor_backlinks_competitor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.competitor_backlinks
    ADD CONSTRAINT competitor_backlinks_competitor_id_fkey FOREIGN KEY (competitor_id) REFERENCES public.competitors(id) ON DELETE CASCADE;


-- Completed on 2026-06-29 12:53:32

--
-- PostgreSQL database dump complete
--

\unrestrict yONfUTrL93PUKO5Z6ggNjNAER0z0UQVhlIkQN3jPySKST7E42h1KAfFvuST4Jos

