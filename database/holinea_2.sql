--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-08-28 11:14:40 CEST

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 283 (class 1259 OID 52574)
-- Name: a_des_etats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.a_des_etats (
    numero_dossier integer NOT NULL,
    id_jumeau_numerique integer NOT NULL
);


ALTER TABLE public.a_des_etats OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 52499)
-- Name: a_la_spécialite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."a_la_spécialite" (
    id_praticien integer NOT NULL,
    id_specialites integer NOT NULL
);


ALTER TABLE public."a_la_spécialite" OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 52514)
-- Name: achete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.achete (
    numero_dossier integer NOT NULL,
    id_produits_bien_etre integer NOT NULL
);


ALTER TABLE public.achete OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 52868)
-- Name: agenda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.agenda (
    id_agenda integer NOT NULL,
    id_praticien integer
);


ALTER TABLE public.agenda OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 52867)
-- Name: agenda_id_agenda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.agenda_id_agenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.agenda_id_agenda_seq OWNER TO postgres;

--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 303
-- Name: agenda_id_agenda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.agenda_id_agenda_seq OWNED BY public.agenda.id_agenda;


--
-- TOC entry 284 (class 1259 OID 52589)
-- Name: alimente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alimente (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    id_analyse_ia_ integer NOT NULL,
    modele_ia character varying(50)
);


ALTER TABLE public.alimente OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 52202)
-- Name: analyse_ia_; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.analyse_ia_ (
    id_analyse_ia_ integer NOT NULL,
    version_modele numeric(1,1),
    statut_validation character varying(50),
    resultats character varying(2000),
    date_analyse timestamp without time zone,
    type_analyse_ character varying(50)
);


ALTER TABLE public.analyse_ia_ OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 52201)
-- Name: analyse_ia__id_analyse_ia__seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.analyse_ia__id_analyse_ia__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.analyse_ia__id_analyse_ia__seq OWNER TO postgres;

--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 237
-- Name: analyse_ia__id_analyse_ia__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.analyse_ia__id_analyse_ia__seq OWNED BY public.analyse_ia_.id_analyse_ia_;


--
-- TOC entry 299 (class 1259 OID 52814)
-- Name: animer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.animer (
    id_praticien integer NOT NULL,
    id_conferences integer NOT NULL
);


ALTER TABLE public.animer OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 52254)
-- Name: ateliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ateliers (
    id_ateliers integer NOT NULL,
    nom_activite character varying(255) NOT NULL,
    description_activite character varying(1000),
    thematique character varying(100),
    capacite_max integer,
    tarif numeric(15,2),
    date_debut timestamp without time zone NOT NULL,
    date_fin timestamp without time zone NOT NULL,
    url_visio character varying(255),
    adresse_presentiel character varying(255),
    est_gratuit boolean,
    est_enregistre boolean,
    statut_activite character varying(50)
);


ALTER TABLE public.ateliers OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 52253)
-- Name: ateliers_id_ateliers_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ateliers_id_ateliers_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ateliers_id_ateliers_seq OWNER TO postgres;

--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 247
-- Name: ateliers_id_ateliers_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ateliers_id_ateliers_seq OWNED BY public.ateliers.id_ateliers;


--
-- TOC entry 261 (class 1259 OID 52343)
-- Name: avis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avis (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_avis integer NOT NULL,
    note integer NOT NULL,
    commentaire character varying(300),
    date_avis time without time zone
);


ALTER TABLE public.avis OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 52341)
-- Name: avis_id_avis_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avis_id_avis_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avis_id_avis_seq OWNER TO postgres;

--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 259
-- Name: avis_id_avis_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avis_id_avis_seq OWNED BY public.avis.id_avis;


--
-- TOC entry 260 (class 1259 OID 52342)
-- Name: avis_note_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.avis_note_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.avis_note_seq OWNER TO postgres;

--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 260
-- Name: avis_note_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.avis_note_seq OWNED BY public.avis.note;


--
-- TOC entry 267 (class 1259 OID 52385)
-- Name: bilan_suivi_patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bilan_suivi_patient (
    numero_dossier integer NOT NULL,
    id_bilan_suivi_patient integer NOT NULL,
    date_bilan date,
    rapport_ia character varying(1000),
    retours character varying(50),
    courbes_suivi_progres real,
    kpi_quantitatifs character varying(50),
    date_debut_periode_ timestamp without time zone,
    date_fin_periode_ timestamp without time zone,
    est_exportable_ boolean
);


ALTER TABLE public.bilan_suivi_patient OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 52384)
-- Name: bilan_suivi_patient_id_bilan_suivi_patient_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bilan_suivi_patient_id_bilan_suivi_patient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bilan_suivi_patient_id_bilan_suivi_patient_seq OWNER TO postgres;

--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 266
-- Name: bilan_suivi_patient_id_bilan_suivi_patient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bilan_suivi_patient_id_bilan_suivi_patient_seq OWNED BY public.bilan_suivi_patient.id_bilan_suivi_patient;


--
-- TOC entry 244 (class 1259 OID 52234)
-- Name: communaute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.communaute (
    id_communaute integer NOT NULL,
    nom_groupe character varying(50),
    description_groupe character varying(1000),
    date_creation date,
    est_anonyme boolean
);


ALTER TABLE public.communaute OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 52233)
-- Name: communaute_id_communaute_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.communaute_id_communaute_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.communaute_id_communaute_seq OWNER TO postgres;

--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 243
-- Name: communaute_id_communaute_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.communaute_id_communaute_seq OWNED BY public.communaute.id_communaute;


--
-- TOC entry 307 (class 1259 OID 65624)
-- Name: commune; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commune (
    insee_code character varying(10) NOT NULL,
    nom_commune text NOT NULL,
    code_postal character varying(5) NOT NULL,
    acheminement text,
    departement character varying(3),
    latitude numeric(9,6),
    longitude numeric(9,6)
);


ALTER TABLE public.commune OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 52263)
-- Name: conferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conferences (
    id_conferences integer NOT NULL,
    capacite_max integer,
    statut_conference character varying(50),
    titre character varying(255) NOT NULL,
    resume_conference character varying(1000),
    "thématique" character varying(100),
    duree_prevu_minutes integer,
    date_heure_debut timestamp without time zone,
    date_heure_fin timestamp without time zone,
    url_visio character varying(255),
    tarif numeric(15,2)
);


ALTER TABLE public.conferences OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 52262)
-- Name: conferences_id_conferences_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conferences_id_conferences_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conferences_id_conferences_seq OWNER TO postgres;

--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 249
-- Name: conferences_id_conferences_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conferences_id_conferences_seq OWNED BY public.conferences.id_conferences;


--
-- TOC entry 280 (class 1259 OID 52529)
-- Name: consulte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consulte (
    numero_dossier integer NOT NULL,
    id_contenus_inspirants integer NOT NULL
);


ALTER TABLE public.consulte OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 52679)
-- Name: consulte_intervient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consulte_intervient (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL
);


ALTER TABLE public.consulte_intervient OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 52188)
-- Name: contenus_inspirants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contenus_inspirants (
    id_contenus_inspirants integer NOT NULL,
    titre character varying(50),
    description_courte character varying(200),
    auteur character varying(50),
    categorie character varying(50),
    type_contenu character varying(50),
    date_publication timestamp without time zone
);


ALTER TABLE public.contenus_inspirants OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 52187)
-- Name: contenus_inspirants_id_contenus_inspirants_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contenus_inspirants_id_contenus_inspirants_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contenus_inspirants_id_contenus_inspirants_seq OWNER TO postgres;

--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 233
-- Name: contenus_inspirants_id_contenus_inspirants_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contenus_inspirants_id_contenus_inspirants_seq OWNED BY public.contenus_inspirants.id_contenus_inspirants;


--
-- TOC entry 274 (class 1259 OID 52439)
-- Name: contient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contient (
    id_questionnaire integer NOT NULL,
    id_questions integer NOT NULL
);


ALTER TABLE public.contient OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 52739)
-- Name: contient_publication; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contient_publication (
    id_communaute integer NOT NULL,
    id_publication_communaute integer NOT NULL
);


ALTER TABLE public.contient_publication OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 52634)
-- Name: contribue_consulte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contribue_consulte (
    id_praticien integer NOT NULL,
    id_reference_scientifique integer NOT NULL
);


ALTER TABLE public.contribue_consulte OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 52272)
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id_communaute integer NOT NULL,
    id_conversations integer NOT NULL,
    contenu_message character varying(1000) NOT NULL,
    est_lu boolean DEFAULT false,
    type_message character varying(50),
    url_fichier_jointe character varying(255)
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 52271)
-- Name: conversations_id_conversations_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conversations_id_conversations_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_conversations_seq OWNER TO postgres;

--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 251
-- Name: conversations_id_conversations_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conversations_id_conversations_seq OWNED BY public.conversations.id_conversations;


--
-- TOC entry 306 (class 1259 OID 52880)
-- Name: creneaux; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.creneaux (
    id_creneau integer NOT NULL,
    id_agenda integer,
    jour date NOT NULL,
    heure_debut time without time zone NOT NULL,
    heure_fin time without time zone NOT NULL
);


ALTER TABLE public.creneaux OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 52879)
-- Name: creneaux_id_creneau_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.creneaux_id_creneau_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.creneaux_id_creneau_seq OWNER TO postgres;

--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 305
-- Name: creneaux_id_creneau_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.creneaux_id_creneau_seq OWNED BY public.creneaux.id_creneau;


--
-- TOC entry 286 (class 1259 OID 52619)
-- Name: enrichit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrichit (
    id_analyse_ia_ integer NOT NULL,
    id_reference_scientifique integer NOT NULL
);


ALTER TABLE public.enrichit OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 52694)
-- Name: enrichit_bdd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrichit_bdd (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    id_reference_scientifique integer NOT NULL
);


ALTER TABLE public.enrichit_bdd OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 52664)
-- Name: est_integree; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_integree (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL
);


ALTER TABLE public.est_integree OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 52754)
-- Name: est_membre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_membre (
    id_utilisateur integer NOT NULL,
    id_communaute integer NOT NULL
);


ALTER TABLE public.est_membre OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 52604)
-- Name: est_sujet_de; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.est_sujet_de (
    id_questions integer NOT NULL,
    id_reponses integer NOT NULL,
    id_analyse_ia_ integer NOT NULL
);


ALTER TABLE public.est_sujet_de OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 52423)
-- Name: factures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factures (
    id_factures integer NOT NULL,
    date_facture timestamp without time zone NOT NULL,
    montant_total numeric(10,2) NOT NULL,
    url_pdf character varying(255),
    numero_dossier character varying(50),
    id_praticien integer NOT NULL,
    numero_dossier_1 integer NOT NULL,
    id_paiement integer
);


ALTER TABLE public.factures OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 52422)
-- Name: factures_id_factures_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factures_id_factures_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.factures_id_factures_seq OWNER TO postgres;

--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 272
-- Name: factures_id_factures_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factures_id_factures_seq OWNED BY public.factures.id_factures;


--
-- TOC entry 269 (class 1259 OID 52399)
-- Name: historique_activite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historique_activite (
    numero_dossier integer NOT NULL,
    id_historique_activite integer NOT NULL,
    date_heure_activite timestamp without time zone,
    type_activite character varying(50),
    source_activite character varying(50)
);


ALTER TABLE public.historique_activite OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 52398)
-- Name: historique_activite_id_historique_activite_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.historique_activite_id_historique_activite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.historique_activite_id_historique_activite_seq OWNER TO postgres;

--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 268
-- Name: historique_activite_id_historique_activite_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.historique_activite_id_historique_activite_seq OWNED BY public.historique_activite.id_historique_activite;


--
-- TOC entry 236 (class 1259 OID 52195)
-- Name: jumeau_numerique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jumeau_numerique (
    id_jumeau_numerique integer NOT NULL,
    date_heure timestamp without time zone,
    donnees_energie_ character varying(255),
    resume_dynamique character varying(50),
    donnees_corporelles character varying(50),
    donnees_emotionnelles character varying(50)
);


ALTER TABLE public.jumeau_numerique OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 52194)
-- Name: jumeau_numerique_id_jumeau_numerique_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jumeau_numerique_id_jumeau_numerique_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jumeau_numerique_id_jumeau_numerique_seq OWNER TO postgres;

--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 235
-- Name: jumeau_numerique_id_jumeau_numerique_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jumeau_numerique_id_jumeau_numerique_seq OWNED BY public.jumeau_numerique.id_jumeau_numerique;


--
-- TOC entry 258 (class 1259 OID 52325)
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    numero_dossier integer NOT NULL,
    id_praticien integer NOT NULL,
    id_message integer NOT NULL,
    sujet character varying(50),
    date_heure_envoie timestamp without time zone,
    lu boolean,
    type_message character varying(50)
);


ALTER TABLE public.message OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 52324)
-- Name: message_id_message_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_id_message_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_id_message_seq OWNER TO postgres;

--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 257
-- Name: message_id_message_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_id_message_seq OWNED BY public.message.id_message;


--
-- TOC entry 271 (class 1259 OID 52411)
-- Name: paiement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paiement (
    id_praticien integer NOT NULL,
    id_praticien_1 integer NOT NULL,
    id_service integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_rendez_vous integer NOT NULL,
    id_paiement integer NOT NULL,
    montant double precision NOT NULL,
    mode_paiement character varying(50),
    date_paiement timestamp without time zone NOT NULL,
    statut_paiement character varying(50),
    reference_transaction character varying(50)
);


ALTER TABLE public.paiement OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 52410)
-- Name: paiement_id_paiement_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paiement_id_paiement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paiement_id_paiement_seq OWNER TO postgres;

--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 270
-- Name: paiement_id_paiement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paiement_id_paiement_seq OWNED BY public.paiement.id_paiement;


--
-- TOC entry 263 (class 1259 OID 52361)
-- Name: parcours_personnalises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parcours_personnalises (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    date_creation date,
    date_derniere_maj date,
    statut character varying(50),
    objectif_principal character varying(50)
);


ALTER TABLE public.parcours_personnalises OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 52360)
-- Name: parcours_personnalises_id_parcours_personnalises_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parcours_personnalises_id_parcours_personnalises_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parcours_personnalises_id_parcours_personnalises_seq OWNER TO postgres;

--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 262
-- Name: parcours_personnalises_id_parcours_personnalises_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parcours_personnalises_id_parcours_personnalises_seq OWNED BY public.parcours_personnalises.id_parcours_personnalises;


--
-- TOC entry 297 (class 1259 OID 52784)
-- Name: participe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participe (
    id_utilisateur integer NOT NULL,
    id_ateliers integer NOT NULL
);


ALTER TABLE public.participe OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 52829)
-- Name: participer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participer (
    id_utilisateur integer NOT NULL,
    id_communaute integer NOT NULL,
    id_conversations integer NOT NULL
);


ALTER TABLE public.participer OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 52287)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    numero_dossier integer NOT NULL,
    adresse character varying(50),
    date_de_naissance timestamp without time zone NOT NULL,
    genre character varying(50) NOT NULL,
    date_inscription date NOT NULL,
    derniere_connexion timestamp without time zone NOT NULL,
    situation_pro_ character varying(100),
    origine_ethnique_ character varying(100),
    environnement_vie character varying(255),
    habitudes_ character varying(500),
    rythme_quotidien_ character varying(500),
    type_activite_physique_ character varying(500),
    frequence_activite_physique_ character varying(50),
    type_alimentation_ character varying(500),
    consommation_substances_ character varying(500),
    niveau_energie_moyen integer,
    gestion_emotionnelle_actuelle_ character varying(500),
    _interet_spiritualite character varying(50),
    suivi_progres_actuel character varying(50),
    type_accompagnement_souhaite_ character varying(50),
    autorisation_mise_en_lien_therapeutes boolean,
    frequence_rappels_souhaitee character varying(50),
    nom_jumeau_numerique_ character varying(100),
    design_jumeau_numerique character varying(100),
    qualite_environnement_vie_choix_ character varying(100),
    id_utilisateur integer NOT NULL
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 52286)
-- Name: patient_numero_dossier_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patient_numero_dossier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patient_numero_dossier_seq OWNER TO postgres;

--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 253
-- Name: patient_numero_dossier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patient_numero_dossier_seq OWNED BY public.patient.numero_dossier;


--
-- TOC entry 293 (class 1259 OID 52724)
-- Name: patient_recoit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_recoit (
    numero_dossier integer NOT NULL,
    numero_dossier_1 integer NOT NULL,
    id_praticien integer NOT NULL,
    id_message integer NOT NULL
);


ALTER TABLE public.patient_recoit OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 52454)
-- Name: patient_repond_a; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_repond_a (
    numero_dossier integer NOT NULL,
    id_questionnaire integer NOT NULL,
    est_repondu character varying(50)
);


ALTER TABLE public.patient_repond_a OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 52484)
-- Name: patient_repond_a_; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_repond_a_ (
    numero_dossier integer NOT NULL,
    id_questions integer NOT NULL,
    id_reponses integer NOT NULL
);


ALTER TABLE public.patient_repond_a_ OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 52799)
-- Name: poste; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.poste (
    id_utilisateur integer NOT NULL,
    id_publication_communaute integer NOT NULL
);


ALTER TABLE public.poste OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 52846)
-- Name: praticien; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.praticien (
    id_praticien integer NOT NULL,
    mode_consultation character varying(50),
    adresse_cabinet character varying(50),
    diplomes character varying(50),
    nombre_heures_pratique bigint NOT NULL,
    description character varying(200),
    annees_experience integer,
    tarifs_consultation double precision,
    photo_profil_url character varying(50),
    taux_satisfaction numeric(4,2),
    statut_validation character varying(50),
    id_utilisateur integer NOT NULL,
    telephone_verifie boolean DEFAULT false,
    code_verification character varying(6),
    code_expiry timestamp without time zone,
    code_postal character varying(10),
    specialites character varying(255),
    type_approche text,
    ville text
);


ALTER TABLE public.praticien OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 52559)
-- Name: praticien_consulte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.praticien_consulte (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_bilan_suivi_patient integer NOT NULL
);


ALTER TABLE public.praticien_consulte OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 52845)
-- Name: praticien_id_praticien_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.praticien_id_praticien_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.praticien_id_praticien_seq OWNER TO postgres;

--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 301
-- Name: praticien_id_praticien_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.praticien_id_praticien_seq OWNED BY public.praticien.id_praticien;


--
-- TOC entry 292 (class 1259 OID 52709)
-- Name: praticien_recoit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.praticien_recoit (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_praticien_1 integer NOT NULL,
    id_message integer NOT NULL
);


ALTER TABLE public.praticien_recoit OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 52469)
-- Name: praticien_repond_a; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.praticien_repond_a (
    id_questionnaire integer NOT NULL,
    id_praticien integer NOT NULL
);


ALTER TABLE public.praticien_repond_a OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 52176)
-- Name: produits_bien_etre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produits_bien_etre (
    id_produits_bien_etre integer NOT NULL,
    prix double precision,
    nom_produit character varying(50),
    description character varying(300),
    stock bigint,
    url_image character varying(50),
    categorie character varying(50),
    id_praticien integer NOT NULL
);


ALTER TABLE public.produits_bien_etre OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 52175)
-- Name: produits_bien_etre_id_produits_bien_etre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produits_bien_etre_id_produits_bien_etre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produits_bien_etre_id_produits_bien_etre_seq OWNER TO postgres;

--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 231
-- Name: produits_bien_etre_id_produits_bien_etre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produits_bien_etre_id_produits_bien_etre_seq OWNED BY public.produits_bien_etre.id_produits_bien_etre;


--
-- TOC entry 246 (class 1259 OID 52245)
-- Name: publication_communaute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publication_communaute (
    id_publication_communaute integer NOT NULL,
    contenu_texte character varying(1000),
    url_piece_jointe character varying(50),
    type_publication character varying(50),
    est_epingle character varying(50),
    date_publication timestamp without time zone
);


ALTER TABLE public.publication_communaute OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 52244)
-- Name: publication_communaute_id_publication_communaute_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publication_communaute_id_publication_communaute_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.publication_communaute_id_publication_communaute_seq OWNER TO postgres;

--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 245
-- Name: publication_communaute_id_publication_communaute_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publication_communaute_id_publication_communaute_seq OWNED BY public.publication_communaute.id_publication_communaute;


--
-- TOC entry 281 (class 1259 OID 52544)
-- Name: publie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publie (
    id_praticien integer NOT NULL,
    id_contenus_inspirants integer NOT NULL
);


ALTER TABLE public.publie OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 52104)
-- Name: questionnaire; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questionnaire (
    id_questionnaire integer NOT NULL,
    description character varying(200),
    type_cible character varying(50),
    nom_questionnaire_ character varying(100),
    date_creation date,
    date_derniere_maj timestamp without time zone
);


ALTER TABLE public.questionnaire OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 52103)
-- Name: questionnaire_id_questionnaire_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questionnaire_id_questionnaire_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questionnaire_id_questionnaire_seq OWNER TO postgres;

--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 219
-- Name: questionnaire_id_questionnaire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questionnaire_id_questionnaire_seq OWNED BY public.questionnaire.id_questionnaire;


--
-- TOC entry 224 (class 1259 OID 52136)
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id_questions integer NOT NULL,
    texte_question character varying(200),
    "type_réponses" character varying(50),
    categorie_question_ character varying(50)
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 52135)
-- Name: questions_id_questions_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_questions_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_questions_seq OWNER TO postgres;

--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 223
-- Name: questions_id_questions_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_questions_seq OWNED BY public.questions.id_questions;


--
-- TOC entry 288 (class 1259 OID 52649)
-- Name: recoit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recoit (
    numero_dossier integer NOT NULL,
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL
);


ALTER TABLE public.recoit OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 52769)
-- Name: recommande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommande (
    id_analyse_ia_ integer NOT NULL,
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL
);


ALTER TABLE public.recommande OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 52220)
-- Name: recommendation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommendation (
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL,
    type_recommandation character varying(300),
    impact_prevu_jumeau character varying(500),
    statut_recommandation character varying(50),
    date_emission date,
    texte_recommandation character varying(2000)
);


ALTER TABLE public.recommendation OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 52219)
-- Name: recommendation_id_recommendation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recommendation_id_recommendation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.recommendation_id_recommendation_seq OWNER TO postgres;

--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 241
-- Name: recommendation_id_recommendation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recommendation_id_recommendation_seq OWNED BY public.recommendation.id_recommendation;


--
-- TOC entry 240 (class 1259 OID 52211)
-- Name: referentiel_scientififque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referentiel_scientififque (
    id_reference_scientifique integer NOT NULL,
    titre character varying(50),
    description_courte character varying(200),
    type_element character varying(50),
    contenu_detaille character varying(50),
    auteur_source character varying(50),
    date_publication_initiale date,
    date_derniere_mise_a_jour date,
    mots_cles character varying(600),
    est_valide_par_expert boolean,
    url_lien character varying(255),
    thematique character varying(50)
);


ALTER TABLE public.referentiel_scientififque OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 52210)
-- Name: referentiel_scientififque_id_reference_scientifique_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referentiel_scientififque_id_reference_scientifique_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referentiel_scientififque_id_reference_scientifique_seq OWNER TO postgres;

--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 239
-- Name: referentiel_scientififque_id_reference_scientifique_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referentiel_scientififque_id_reference_scientifique_seq OWNED BY public.referentiel_scientififque.id_reference_scientifique;


--
-- TOC entry 256 (class 1259 OID 52303)
-- Name: rendez_vous; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rendez_vous (
    id_praticien integer NOT NULL,
    id_praticien_1 integer NOT NULL,
    id_service integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_rendez_vous integer NOT NULL,
    date_heure_debut timestamp without time zone,
    date_heure_fin timestamp without time zone,
    statut_rdv character varying(50),
    mode_paiement_ character varying(50),
    recommandations_post_seance_ character varying(50),
    mode_rdv character varying(50),
    lien_visio character varying(50)
);


ALTER TABLE public.rendez_vous OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 52302)
-- Name: rendez_vous_id_rendez_vous_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rendez_vous_id_rendez_vous_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rendez_vous_id_rendez_vous_seq OWNER TO postgres;

--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 255
-- Name: rendez_vous_id_rendez_vous_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rendez_vous_id_rendez_vous_seq OWNED BY public.rendez_vous.id_rendez_vous;


--
-- TOC entry 226 (class 1259 OID 52143)
-- Name: reponses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reponses (
    id_questions integer NOT NULL,
    id_reponses integer NOT NULL,
    contenu_reponse character varying(200),
    date_reponse timestamp without time zone
);


ALTER TABLE public.reponses OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 52142)
-- Name: reponses_id_reponses_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reponses_id_reponses_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reponses_id_reponses_seq OWNER TO postgres;

--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 225
-- Name: reponses_id_reponses_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reponses_id_reponses_seq OWNED BY public.reponses.id_reponses;


--
-- TOC entry 265 (class 1259 OID 52373)
-- Name: resultat_parcours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resultat_parcours (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    date_cible date,
    description character varying(200),
    statut_etape character varying(50),
    type_etape character varying(50)
);


ALTER TABLE public.resultat_parcours OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 52372)
-- Name: resultat_parcours_id_resultat_parcours_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resultat_parcours_id_resultat_parcours_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resultat_parcours_id_resultat_parcours_seq OWNER TO postgres;

--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 264
-- Name: resultat_parcours_id_resultat_parcours_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resultat_parcours_id_resultat_parcours_seq OWNED BY public.resultat_parcours.id_resultat_parcours;


--
-- TOC entry 230 (class 1259 OID 52162)
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    id_praticien integer NOT NULL,
    id_service integer NOT NULL,
    description_service character varying(500),
    nom_service character varying(50),
    tarif character varying(50),
    type_service character varying(50),
    duree time without time zone
);


ALTER TABLE public.service OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 52161)
-- Name: service_id_service_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_id_service_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_id_service_seq OWNER TO postgres;

--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 229
-- Name: service_id_service_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_id_service_seq OWNED BY public.service.id_service;


--
-- TOC entry 228 (class 1259 OID 52155)
-- Name: specialites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialites (
    id_specialites integer NOT NULL,
    nom_speciallite character varying(50),
    description character varying(300)
);


ALTER TABLE public.specialites OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 52154)
-- Name: specialites_id_specialites_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.specialites_id_specialites_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specialites_id_specialites_seq OWNER TO postgres;

--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 227
-- Name: specialites_id_specialites_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.specialites_id_specialites_seq OWNED BY public.specialites.id_specialites;


--
-- TOC entry 222 (class 1259 OID 52111)
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id_utilisateur integer NOT NULL,
    mail character varying(255) NOT NULL,
    nom character varying(50),
    prenom character varying(50),
    date_inscription date,
    derniere_connexion timestamp without time zone,
    role_utilisateur character varying(50) NOT NULL,
    statut_compte character varying(50),
    mot_de_passe character varying(255) NOT NULL,
    consentement_cgu boolean NOT NULL,
    consentement_partage_donnees_sante_ boolean NOT NULL,
    preferences_notifications character varying(50),
    telephone_ bigint
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 52110)
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNER TO postgres;

--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 221
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- TOC entry 3736 (class 2604 OID 52871)
-- Name: agenda id_agenda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agenda ALTER COLUMN id_agenda SET DEFAULT nextval('public.agenda_id_agenda_seq'::regclass);


--
-- TOC entry 3714 (class 2604 OID 52205)
-- Name: analyse_ia_ id_analyse_ia_; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyse_ia_ ALTER COLUMN id_analyse_ia_ SET DEFAULT nextval('public.analyse_ia__id_analyse_ia__seq'::regclass);


--
-- TOC entry 3719 (class 2604 OID 52257)
-- Name: ateliers id_ateliers; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ateliers ALTER COLUMN id_ateliers SET DEFAULT nextval('public.ateliers_id_ateliers_seq'::regclass);


--
-- TOC entry 3726 (class 2604 OID 52346)
-- Name: avis id_avis; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avis ALTER COLUMN id_avis SET DEFAULT nextval('public.avis_id_avis_seq'::regclass);


--
-- TOC entry 3727 (class 2604 OID 52347)
-- Name: avis note; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avis ALTER COLUMN note SET DEFAULT nextval('public.avis_note_seq'::regclass);


--
-- TOC entry 3730 (class 2604 OID 52388)
-- Name: bilan_suivi_patient id_bilan_suivi_patient; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan_suivi_patient ALTER COLUMN id_bilan_suivi_patient SET DEFAULT nextval('public.bilan_suivi_patient_id_bilan_suivi_patient_seq'::regclass);


--
-- TOC entry 3717 (class 2604 OID 52237)
-- Name: communaute id_communaute; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communaute ALTER COLUMN id_communaute SET DEFAULT nextval('public.communaute_id_communaute_seq'::regclass);


--
-- TOC entry 3720 (class 2604 OID 52266)
-- Name: conferences id_conferences; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferences ALTER COLUMN id_conferences SET DEFAULT nextval('public.conferences_id_conferences_seq'::regclass);


--
-- TOC entry 3712 (class 2604 OID 52191)
-- Name: contenus_inspirants id_contenus_inspirants; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenus_inspirants ALTER COLUMN id_contenus_inspirants SET DEFAULT nextval('public.contenus_inspirants_id_contenus_inspirants_seq'::regclass);


--
-- TOC entry 3721 (class 2604 OID 52275)
-- Name: conversations id_conversations; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id_conversations SET DEFAULT nextval('public.conversations_id_conversations_seq'::regclass);


--
-- TOC entry 3737 (class 2604 OID 52883)
-- Name: creneaux id_creneau; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creneaux ALTER COLUMN id_creneau SET DEFAULT nextval('public.creneaux_id_creneau_seq'::regclass);


--
-- TOC entry 3733 (class 2604 OID 52426)
-- Name: factures id_factures; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factures ALTER COLUMN id_factures SET DEFAULT nextval('public.factures_id_factures_seq'::regclass);


--
-- TOC entry 3731 (class 2604 OID 52402)
-- Name: historique_activite id_historique_activite; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_activite ALTER COLUMN id_historique_activite SET DEFAULT nextval('public.historique_activite_id_historique_activite_seq'::regclass);


--
-- TOC entry 3713 (class 2604 OID 52198)
-- Name: jumeau_numerique id_jumeau_numerique; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jumeau_numerique ALTER COLUMN id_jumeau_numerique SET DEFAULT nextval('public.jumeau_numerique_id_jumeau_numerique_seq'::regclass);


--
-- TOC entry 3725 (class 2604 OID 52328)
-- Name: message id_message; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message ALTER COLUMN id_message SET DEFAULT nextval('public.message_id_message_seq'::regclass);


--
-- TOC entry 3732 (class 2604 OID 52414)
-- Name: paiement id_paiement; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiement ALTER COLUMN id_paiement SET DEFAULT nextval('public.paiement_id_paiement_seq'::regclass);


--
-- TOC entry 3728 (class 2604 OID 52364)
-- Name: parcours_personnalises id_parcours_personnalises; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcours_personnalises ALTER COLUMN id_parcours_personnalises SET DEFAULT nextval('public.parcours_personnalises_id_parcours_personnalises_seq'::regclass);


--
-- TOC entry 3723 (class 2604 OID 52290)
-- Name: patient numero_dossier; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient ALTER COLUMN numero_dossier SET DEFAULT nextval('public.patient_numero_dossier_seq'::regclass);


--
-- TOC entry 3734 (class 2604 OID 52849)
-- Name: praticien id_praticien; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien ALTER COLUMN id_praticien SET DEFAULT nextval('public.praticien_id_praticien_seq'::regclass);


--
-- TOC entry 3711 (class 2604 OID 52179)
-- Name: produits_bien_etre id_produits_bien_etre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits_bien_etre ALTER COLUMN id_produits_bien_etre SET DEFAULT nextval('public.produits_bien_etre_id_produits_bien_etre_seq'::regclass);


--
-- TOC entry 3718 (class 2604 OID 52248)
-- Name: publication_communaute id_publication_communaute; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication_communaute ALTER COLUMN id_publication_communaute SET DEFAULT nextval('public.publication_communaute_id_publication_communaute_seq'::regclass);


--
-- TOC entry 3705 (class 2604 OID 52107)
-- Name: questionnaire id_questionnaire; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questionnaire ALTER COLUMN id_questionnaire SET DEFAULT nextval('public.questionnaire_id_questionnaire_seq'::regclass);


--
-- TOC entry 3707 (class 2604 OID 52139)
-- Name: questions id_questions; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id_questions SET DEFAULT nextval('public.questions_id_questions_seq'::regclass);


--
-- TOC entry 3716 (class 2604 OID 52223)
-- Name: recommendation id_recommendation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation ALTER COLUMN id_recommendation SET DEFAULT nextval('public.recommendation_id_recommendation_seq'::regclass);


--
-- TOC entry 3715 (class 2604 OID 52214)
-- Name: referentiel_scientififque id_reference_scientifique; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referentiel_scientififque ALTER COLUMN id_reference_scientifique SET DEFAULT nextval('public.referentiel_scientififque_id_reference_scientifique_seq'::regclass);


--
-- TOC entry 3724 (class 2604 OID 52306)
-- Name: rendez_vous id_rendez_vous; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rendez_vous ALTER COLUMN id_rendez_vous SET DEFAULT nextval('public.rendez_vous_id_rendez_vous_seq'::regclass);


--
-- TOC entry 3708 (class 2604 OID 52146)
-- Name: reponses id_reponses; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponses ALTER COLUMN id_reponses SET DEFAULT nextval('public.reponses_id_reponses_seq'::regclass);


--
-- TOC entry 3729 (class 2604 OID 52376)
-- Name: resultat_parcours id_resultat_parcours; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_parcours ALTER COLUMN id_resultat_parcours SET DEFAULT nextval('public.resultat_parcours_id_resultat_parcours_seq'::regclass);


--
-- TOC entry 3710 (class 2604 OID 52165)
-- Name: service id_service; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service ALTER COLUMN id_service SET DEFAULT nextval('public.service_id_service_seq'::regclass);


--
-- TOC entry 3709 (class 2604 OID 52158)
-- Name: specialites id_specialites; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialites ALTER COLUMN id_specialites SET DEFAULT nextval('public.specialites_id_specialites_seq'::regclass);


--
-- TOC entry 3706 (class 2604 OID 52114)
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- TOC entry 4142 (class 0 OID 52574)
-- Dependencies: 283
-- Data for Name: a_des_etats; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4137 (class 0 OID 52499)
-- Dependencies: 278
-- Data for Name: a_la_spécialite; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4138 (class 0 OID 52514)
-- Dependencies: 279
-- Data for Name: achete; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4163 (class 0 OID 52868)
-- Dependencies: 304
-- Data for Name: agenda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4143 (class 0 OID 52589)
-- Dependencies: 284
-- Data for Name: alimente; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4097 (class 0 OID 52202)
-- Dependencies: 238
-- Data for Name: analyse_ia_; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4158 (class 0 OID 52814)
-- Dependencies: 299
-- Data for Name: animer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4107 (class 0 OID 52254)
-- Dependencies: 248
-- Data for Name: ateliers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4120 (class 0 OID 52343)
-- Dependencies: 261
-- Data for Name: avis; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4126 (class 0 OID 52385)
-- Dependencies: 267
-- Data for Name: bilan_suivi_patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.bilan_suivi_patient VALUES (5, 1, '2025-07-31', 'RAS', 'RAS', NULL, '', '2025-07-31 13:06:20.900593', '2025-07-31 13:06:20.900593', false);
INSERT INTO public.bilan_suivi_patient VALUES (6, 2, '2025-07-31', 'RAS', 'RAS', NULL, '', '2025-07-31 13:06:20.900593', '2025-07-31 13:06:20.900593', false);


--
-- TOC entry 4103 (class 0 OID 52234)
-- Dependencies: 244
-- Data for Name: communaute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4166 (class 0 OID 65624)
-- Dependencies: 307
-- Data for Name: commune; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.commune VALUES ('75056', 'Paris', '75001', 'PARIS 01', NULL, NULL, NULL);
INSERT INTO public.commune VALUES ('75056', 'Paris', '75002', 'PARIS 02', NULL, NULL, NULL);
INSERT INTO public.commune VALUES ('13055', 'Marseille', '13001', 'MARSEILLE 01', NULL, NULL, NULL);
INSERT INTO public.commune VALUES ('69383', 'Lyon', '69001', 'LYON 01', NULL, NULL, NULL);
INSERT INTO public.commune VALUES ('31555', 'Toulouse', '31000', 'TOULOUSE', NULL, NULL, NULL);
INSERT INTO public.commune VALUES ('44109', 'Nantes', '44000', 'NANTES', NULL, NULL, NULL);


--
-- TOC entry 4109 (class 0 OID 52263)
-- Dependencies: 250
-- Data for Name: conferences; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4139 (class 0 OID 52529)
-- Dependencies: 280
-- Data for Name: consulte; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4149 (class 0 OID 52679)
-- Dependencies: 290
-- Data for Name: consulte_intervient; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4093 (class 0 OID 52188)
-- Dependencies: 234
-- Data for Name: contenus_inspirants; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4133 (class 0 OID 52439)
-- Dependencies: 274
-- Data for Name: contient; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4153 (class 0 OID 52739)
-- Dependencies: 294
-- Data for Name: contient_publication; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4146 (class 0 OID 52634)
-- Dependencies: 287
-- Data for Name: contribue_consulte; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4111 (class 0 OID 52272)
-- Dependencies: 252
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4165 (class 0 OID 52880)
-- Dependencies: 306
-- Data for Name: creneaux; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4145 (class 0 OID 52619)
-- Dependencies: 286
-- Data for Name: enrichit; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4150 (class 0 OID 52694)
-- Dependencies: 291
-- Data for Name: enrichit_bdd; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4148 (class 0 OID 52664)
-- Dependencies: 289
-- Data for Name: est_integree; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4154 (class 0 OID 52754)
-- Dependencies: 295
-- Data for Name: est_membre; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4144 (class 0 OID 52604)
-- Dependencies: 285
-- Data for Name: est_sujet_de; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4132 (class 0 OID 52423)
-- Dependencies: 273
-- Data for Name: factures; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4128 (class 0 OID 52399)
-- Dependencies: 269
-- Data for Name: historique_activite; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4095 (class 0 OID 52195)
-- Dependencies: 236
-- Data for Name: jumeau_numerique; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4117 (class 0 OID 52325)
-- Dependencies: 258
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4130 (class 0 OID 52411)
-- Dependencies: 271
-- Data for Name: paiement; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4122 (class 0 OID 52361)
-- Dependencies: 263
-- Data for Name: parcours_personnalises; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4156 (class 0 OID 52784)
-- Dependencies: 297
-- Data for Name: participe; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4159 (class 0 OID 52829)
-- Dependencies: 300
-- Data for Name: participer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4113 (class 0 OID 52287)
-- Dependencies: 254
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patient VALUES (5, '15 rue Paris', '1995-08-12 00:00:00', 'F', '2025-07-31', '2025-07-31 12:56:11.171753', 'Etudiante', NULL, NULL, 'Sport', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 52);
INSERT INTO public.patient VALUES (6, '22 avenue Lyon', '1989-03-27 00:00:00', 'M', '2025-07-31', '2025-07-31 12:56:11.171753', 'Commercial', NULL, NULL, 'Lecture', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 53);


--
-- TOC entry 4152 (class 0 OID 52724)
-- Dependencies: 293
-- Data for Name: patient_recoit; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4134 (class 0 OID 52454)
-- Dependencies: 275
-- Data for Name: patient_repond_a; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4136 (class 0 OID 52484)
-- Dependencies: 277
-- Data for Name: patient_repond_a_; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4157 (class 0 OID 52799)
-- Dependencies: 298
-- Data for Name: poste; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4161 (class 0 OID 52846)
-- Dependencies: 302
-- Data for Name: praticien; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.praticien VALUES (48, 'cabinet', '81b rue du chevaleret, 75013', 'Master en naturopathie', 400, 'naturopathe galsen', 5, 50, 'Uploads/photos/689206a5ce7c6_sylla.png', NULL, 'valide', 65, false, NULL, NULL, '75013', 'naturopathie', NULL, NULL);
INSERT INTO public.praticien VALUES (49, 'cabinet', '81b rue du chevaleret, 75013', 'Master en massage', 700, 'Je propose des séances de yoga thérapeutique et de relaxation pour réduire le stress et améliorer la souplesse.', 7, 75, 'Uploads/photos/6892129f027a9_alou.png', 92.00, 'valide', 60, false, NULL, NULL, '75013', 'Yoga', 'Énergétique', 'Paris');
INSERT INTO public.praticien VALUES (50, 'cabinet', '81b rue du chevaleret, 75013', 'Master en massage', 145, 'Praticien spécialisé en massages relaxants et thérapeutiques pour soulager les tensions musculaires et améliorer le bien-être.', 3, 60, 'Uploads/photos/default_masseur.png', 88.00, 'valide', 61, false, NULL, NULL, '75013', 'massage', 'Manuelle', 'Paris');
INSERT INTO public.praticien VALUES (47, 'distance', '81b rue du chevaleret, 75013', 'Master en naturopathie', 300, 'je suis naturopathe senegalaise', 5, 50, 'Uploads/photos/6891ff3f1a52b_sylla.png', 95.00, 'valide', 64, false, NULL, NULL, '75013', 'naturopathie', 'Holistique', 'Paris');


--
-- TOC entry 4141 (class 0 OID 52559)
-- Dependencies: 282
-- Data for Name: praticien_consulte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.praticien_consulte VALUES (36, 5, 1);
INSERT INTO public.praticien_consulte VALUES (36, 6, 2);


--
-- TOC entry 4151 (class 0 OID 52709)
-- Dependencies: 292
-- Data for Name: praticien_recoit; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4135 (class 0 OID 52469)
-- Dependencies: 276
-- Data for Name: praticien_repond_a; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4091 (class 0 OID 52176)
-- Dependencies: 232
-- Data for Name: produits_bien_etre; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4105 (class 0 OID 52245)
-- Dependencies: 246
-- Data for Name: publication_communaute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4140 (class 0 OID 52544)
-- Dependencies: 281
-- Data for Name: publie; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4079 (class 0 OID 52104)
-- Dependencies: 220
-- Data for Name: questionnaire; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4083 (class 0 OID 52136)
-- Dependencies: 224
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4147 (class 0 OID 52649)
-- Dependencies: 288
-- Data for Name: recoit; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4155 (class 0 OID 52769)
-- Dependencies: 296
-- Data for Name: recommande; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4101 (class 0 OID 52220)
-- Dependencies: 242
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4099 (class 0 OID 52211)
-- Dependencies: 240
-- Data for Name: referentiel_scientififque; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4115 (class 0 OID 52303)
-- Dependencies: 256
-- Data for Name: rendez_vous; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4085 (class 0 OID 52143)
-- Dependencies: 226
-- Data for Name: reponses; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4124 (class 0 OID 52373)
-- Dependencies: 265
-- Data for Name: resultat_parcours; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4089 (class 0 OID 52162)
-- Dependencies: 230
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4087 (class 0 OID 52155)
-- Dependencies: 228
-- Data for Name: specialites; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4081 (class 0 OID 52111)
-- Dependencies: 222
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.utilisateur VALUES (45, 'ess@holinea.fr', 'fall', 'habdallahi', '2025-07-31', '2025-07-31 12:19:20.22067', 'therapeute', 'actif', '$2y$10$kokkA8c4iIf15Xjjyce8ZuUutXFEYvVPaQWYwO3Da8wcw.Wx3kcPu', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (52, 'client1@exemple.com', 'Dupont', 'Marie', '2025-07-31', '2025-07-31 12:47:21.086047', 'patient', 'actif', 'testhash', true, false, NULL, 33660000001);
INSERT INTO public.utilisateur VALUES (53, 'client2@exemple.com', 'Martin', 'Jean', '2025-07-31', '2025-07-31 12:47:21.086047', 'patient', 'actif', 'testhash', true, true, NULL, 33660000002);
INSERT INTO public.utilisateur VALUES (54, 'fall@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 10:37:50.662133', 'therapeute', 'actif', '$2y$10$dKDziXFEHBN.isXrL7Ozb.OHkSvZOu67N607bDQB.Z4vb1gZN..3q', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (55, 'fall1@holinea.fr', 'fall', 'abdou', '2025-08-05', '2025-08-05 11:47:15.136171', 'therapeute', 'actif', '$2y$10$3y4vc90x6tqQfyGnzyz85.GQ82VFGQgogm1SZV/YXpnmOA9VMv9Ym', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (56, 'fall2@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 11:53:55.53552', 'therapeute', 'actif', '$2y$10$5YeHFVKT5lvZptKarlIRv.TrIXxvBI.Cf9h0ldQY1B2QMpp8OdBMq', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (57, 'fall3@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 12:00:22.044469', 'therapeute', 'actif', '$2y$10$gtQGfxvIRGR0lJ2jwe9gX.0xwpaUyAV7xu/SBrMWLutA6KXMaq9Vi', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (58, 'fall4@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 12:03:09.238271', 'therapeute', 'actif', '$2y$10$c6PePT6jLwryCg92qDLNOuIcNsOCG8iUgVOYhyUl7tDVKKrdQWOOW', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (59, 'fall5@holinea.fr', 'fall', 'ishak', '2025-08-05', '2025-08-05 12:16:09.600295', 'therapeute', 'actif', '$2y$10$ORWLJMwcc9KEiGgC0ALNIuIv2Ftu4JFusnNq6z9Ka9dShuCZ6S5nm', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (60, 'fall6@holinea.fr', 'FALL', 'habdallahi', '2025-08-05', '2025-08-05 12:37:25.410447', 'therapeute', 'actif', '$2y$10$lM5qb0ZpoyBT20R0xy/eIOLV2UtdUzwcZtyBGmgQBRPW93AjcVMZi', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (61, 'diop@holinea.fr', 'DIOP', 'FAMA', '2025-08-05', '2025-08-05 12:42:41.848355', 'therapeute', 'actif', '$2y$10$QTl9ph8ApnLzA.BROlM6rO8BrflhDGDmprCUPectgDsuvJ3pXy6AK', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (62, 'ndiaye@holinea.fr', 'ndiaye', 'awa', '2025-08-05', '2025-08-05 14:32:08.998837', 'therapeute', 'actif', '$2y$10$0d8EuTaBk.mJjqEPipXvCurUKDWW3PdYIiJ5c3HZNG3kazbk3xJza', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (63, 'sylla@holinea.fr', 'AIDA', 'SYLLA', '2025-08-05', '2025-08-05 14:48:23.362678', 'therapeute', 'actif', '$2y$10$FQXBWvOusvXMAzMa.o50yenJWDHxee/WSO5gGKHWwIsp6pvWFiDBy', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (64, 'ndiaye2@holinea.fr', 'AIDA', 'NDIAYE', '2025-08-05', '2025-08-05 14:55:42.597666', 'therapeute', 'actif', '$2y$10$CqZaDBWa8j9Lo9RfQ6l9deyPs09vB1josMYMG4CgHZ4HZMAGvv3Oe', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (65, 'contact@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 15:27:17.878211', 'therapeute', 'actif', '$2y$10$kfs0U5/I41pkH5zmVFwPLuQOvZjLHkhGOKZTRvOAdkPOq5EH22HAe', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (66, 'alou@holinea.fr', 'alou', 'diop', '2025-08-05', '2025-08-05 16:18:23.40199', 'therapeute', 'actif', '$2y$10$rpUxwhMuEG4FhZiRyZ59puYysahbSBF.bbLU0KY3hVVwxgu5zWHSq', true, true, NULL, 33625628751);
INSERT INTO public.utilisateur VALUES (67, 'ndiaye22@holinea.fr', 'fall', 'habdallahi', '2025-08-07', '2025-08-07 17:44:24.638939', 'therapeute', 'actif', '$2y$10$iqNghvHGrCgf9AWTNGyFXuw29Hy.WFPVGTDdf7Qmb85RMiG29FTWS', true, true, NULL, 33625628751);


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 303
-- Name: agenda_id_agenda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.agenda_id_agenda_seq', 1, false);


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 237
-- Name: analyse_ia__id_analyse_ia__seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.analyse_ia__id_analyse_ia__seq', 1, false);


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 247
-- Name: ateliers_id_ateliers_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ateliers_id_ateliers_seq', 1, false);


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 259
-- Name: avis_id_avis_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avis_id_avis_seq', 1, false);


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 260
-- Name: avis_note_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.avis_note_seq', 1, false);


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 266
-- Name: bilan_suivi_patient_id_bilan_suivi_patient_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bilan_suivi_patient_id_bilan_suivi_patient_seq', 2, true);


--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 243
-- Name: communaute_id_communaute_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.communaute_id_communaute_seq', 1, false);


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 249
-- Name: conferences_id_conferences_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conferences_id_conferences_seq', 1, false);


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 233
-- Name: contenus_inspirants_id_contenus_inspirants_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contenus_inspirants_id_contenus_inspirants_seq', 1, false);


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 251
-- Name: conversations_id_conversations_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conversations_id_conversations_seq', 1, false);


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 305
-- Name: creneaux_id_creneau_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.creneaux_id_creneau_seq', 1, false);


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 272
-- Name: factures_id_factures_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factures_id_factures_seq', 1, false);


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 268
-- Name: historique_activite_id_historique_activite_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historique_activite_id_historique_activite_seq', 1, false);


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 235
-- Name: jumeau_numerique_id_jumeau_numerique_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jumeau_numerique_id_jumeau_numerique_seq', 1, false);


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 257
-- Name: message_id_message_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_id_message_seq', 1, false);


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 270
-- Name: paiement_id_paiement_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paiement_id_paiement_seq', 1, false);


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 262
-- Name: parcours_personnalises_id_parcours_personnalises_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parcours_personnalises_id_parcours_personnalises_seq', 1, false);


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 253
-- Name: patient_numero_dossier_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patient_numero_dossier_seq', 6, true);


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 301
-- Name: praticien_id_praticien_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.praticien_id_praticien_seq', 50, true);


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 231
-- Name: produits_bien_etre_id_produits_bien_etre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produits_bien_etre_id_produits_bien_etre_seq', 1, false);


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 245
-- Name: publication_communaute_id_publication_communaute_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publication_communaute_id_publication_communaute_seq', 1, false);


--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 219
-- Name: questionnaire_id_questionnaire_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questionnaire_id_questionnaire_seq', 1, false);


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 223
-- Name: questions_id_questions_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_questions_seq', 1, false);


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 241
-- Name: recommendation_id_recommendation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recommendation_id_recommendation_seq', 1, false);


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 239
-- Name: referentiel_scientififque_id_reference_scientifique_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referentiel_scientififque_id_reference_scientifique_seq', 1, false);


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 255
-- Name: rendez_vous_id_rendez_vous_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rendez_vous_id_rendez_vous_seq', 1, false);


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 225
-- Name: reponses_id_reponses_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reponses_id_reponses_seq', 1, false);


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 264
-- Name: resultat_parcours_id_resultat_parcours_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resultat_parcours_id_resultat_parcours_seq', 1, false);


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 229
-- Name: service_id_service_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_id_service_seq', 1, false);


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 227
-- Name: specialites_id_specialites_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.specialites_id_specialites_seq', 1, false);


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 221
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 67, true);


--
-- TOC entry 3817 (class 2606 OID 52578)
-- Name: a_des_etats a_des_etats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.a_des_etats
    ADD CONSTRAINT a_des_etats_pkey PRIMARY KEY (numero_dossier, id_jumeau_numerique);


--
-- TOC entry 3807 (class 2606 OID 52503)
-- Name: a_la_spécialite a_la_spécialite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."a_la_spécialite"
    ADD CONSTRAINT "a_la_spécialite_pkey" PRIMARY KEY (id_praticien, id_specialites);


--
-- TOC entry 3809 (class 2606 OID 52518)
-- Name: achete achete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achete
    ADD CONSTRAINT achete_pkey PRIMARY KEY (numero_dossier, id_produits_bien_etre);


--
-- TOC entry 3864 (class 2606 OID 52873)
-- Name: agenda agenda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agenda
    ADD CONSTRAINT agenda_pkey PRIMARY KEY (id_agenda);


--
-- TOC entry 3819 (class 2606 OID 52593)
-- Name: alimente alimente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alimente
    ADD CONSTRAINT alimente_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_analyse_ia_);


--
-- TOC entry 3759 (class 2606 OID 52209)
-- Name: analyse_ia_ analyse_ia__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.analyse_ia_
    ADD CONSTRAINT analyse_ia__pkey PRIMARY KEY (id_analyse_ia_);


--
-- TOC entry 3849 (class 2606 OID 52818)
-- Name: animer animer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animer
    ADD CONSTRAINT animer_pkey PRIMARY KEY (id_praticien, id_conferences);


--
-- TOC entry 3771 (class 2606 OID 52261)
-- Name: ateliers ateliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ateliers
    ADD CONSTRAINT ateliers_pkey PRIMARY KEY (id_ateliers);


--
-- TOC entry 3785 (class 2606 OID 52349)
-- Name: avis avis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_pkey PRIMARY KEY (id_praticien, numero_dossier, id_avis);


--
-- TOC entry 3791 (class 2606 OID 52392)
-- Name: bilan_suivi_patient bilan_suivi_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan_suivi_patient
    ADD CONSTRAINT bilan_suivi_patient_pkey PRIMARY KEY (numero_dossier, id_bilan_suivi_patient);


--
-- TOC entry 3765 (class 2606 OID 52243)
-- Name: communaute communaute_nom_groupe_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communaute
    ADD CONSTRAINT communaute_nom_groupe_key UNIQUE (nom_groupe);


--
-- TOC entry 3767 (class 2606 OID 52241)
-- Name: communaute communaute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.communaute
    ADD CONSTRAINT communaute_pkey PRIMARY KEY (id_communaute);


--
-- TOC entry 3773 (class 2606 OID 52270)
-- Name: conferences conferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conferences
    ADD CONSTRAINT conferences_pkey PRIMARY KEY (id_conferences);


--
-- TOC entry 3831 (class 2606 OID 52683)
-- Name: consulte_intervient consulte_intervient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consulte_intervient
    ADD CONSTRAINT consulte_intervient_pkey PRIMARY KEY (id_praticien, numero_dossier, id_parcours_personnalises);


--
-- TOC entry 3811 (class 2606 OID 52533)
-- Name: consulte consulte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consulte
    ADD CONSTRAINT consulte_pkey PRIMARY KEY (numero_dossier, id_contenus_inspirants);


--
-- TOC entry 3755 (class 2606 OID 52193)
-- Name: contenus_inspirants contenus_inspirants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contenus_inspirants
    ADD CONSTRAINT contenus_inspirants_pkey PRIMARY KEY (id_contenus_inspirants);


--
-- TOC entry 3799 (class 2606 OID 52443)
-- Name: contient contient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contient
    ADD CONSTRAINT contient_pkey PRIMARY KEY (id_questionnaire, id_questions);


--
-- TOC entry 3839 (class 2606 OID 52743)
-- Name: contient_publication contient_publication_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contient_publication
    ADD CONSTRAINT contient_publication_pkey PRIMARY KEY (id_communaute, id_publication_communaute);


--
-- TOC entry 3825 (class 2606 OID 52638)
-- Name: contribue_consulte contribue_consulte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contribue_consulte
    ADD CONSTRAINT contribue_consulte_pkey PRIMARY KEY (id_praticien, id_reference_scientifique);


--
-- TOC entry 3775 (class 2606 OID 52280)
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id_communaute, id_conversations);


--
-- TOC entry 3866 (class 2606 OID 52885)
-- Name: creneaux creneaux_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creneaux
    ADD CONSTRAINT creneaux_pkey PRIMARY KEY (id_creneau);


--
-- TOC entry 3833 (class 2606 OID 52698)
-- Name: enrichit_bdd enrichit_bdd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrichit_bdd
    ADD CONSTRAINT enrichit_bdd_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_reference_scientifique);


--
-- TOC entry 3823 (class 2606 OID 52623)
-- Name: enrichit enrichit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrichit
    ADD CONSTRAINT enrichit_pkey PRIMARY KEY (id_analyse_ia_, id_reference_scientifique);


--
-- TOC entry 3829 (class 2606 OID 52668)
-- Name: est_integree est_integree_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_integree
    ADD CONSTRAINT est_integree_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3841 (class 2606 OID 52758)
-- Name: est_membre est_membre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_membre
    ADD CONSTRAINT est_membre_pkey PRIMARY KEY (id_utilisateur, id_communaute);


--
-- TOC entry 3821 (class 2606 OID 52608)
-- Name: est_sujet_de est_sujet_de_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_sujet_de
    ADD CONSTRAINT est_sujet_de_pkey PRIMARY KEY (id_questions, id_reponses, id_analyse_ia_);


--
-- TOC entry 3797 (class 2606 OID 52428)
-- Name: factures factures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factures
    ADD CONSTRAINT factures_pkey PRIMARY KEY (id_factures);


--
-- TOC entry 3793 (class 2606 OID 52404)
-- Name: historique_activite historique_activite_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_activite
    ADD CONSTRAINT historique_activite_pkey PRIMARY KEY (numero_dossier, id_historique_activite);


--
-- TOC entry 3757 (class 2606 OID 52200)
-- Name: jumeau_numerique jumeau_numerique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jumeau_numerique
    ADD CONSTRAINT jumeau_numerique_pkey PRIMARY KEY (id_jumeau_numerique);


--
-- TOC entry 3783 (class 2606 OID 52330)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (numero_dossier, id_praticien, id_message);


--
-- TOC entry 3795 (class 2606 OID 52416)
-- Name: paiement paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiement
    ADD CONSTRAINT paiement_pkey PRIMARY KEY (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous, id_paiement);


--
-- TOC entry 3787 (class 2606 OID 52366)
-- Name: parcours_personnalises parcours_personnalises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcours_personnalises
    ADD CONSTRAINT parcours_personnalises_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises);


--
-- TOC entry 3845 (class 2606 OID 52788)
-- Name: participe participe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participe
    ADD CONSTRAINT participe_pkey PRIMARY KEY (id_utilisateur, id_ateliers);


--
-- TOC entry 3851 (class 2606 OID 52833)
-- Name: participer participer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participer
    ADD CONSTRAINT participer_pkey PRIMARY KEY (id_utilisateur, id_communaute, id_conversations);


--
-- TOC entry 3777 (class 2606 OID 52296)
-- Name: patient patient_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- TOC entry 3779 (class 2606 OID 52294)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (numero_dossier);


--
-- TOC entry 3837 (class 2606 OID 52728)
-- Name: patient_recoit patient_recoit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_recoit
    ADD CONSTRAINT patient_recoit_pkey PRIMARY KEY (numero_dossier, numero_dossier_1, id_praticien, id_message);


--
-- TOC entry 3805 (class 2606 OID 52488)
-- Name: patient_repond_a_ patient_repond_a__pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_repond_a_
    ADD CONSTRAINT patient_repond_a__pkey PRIMARY KEY (numero_dossier, id_questions, id_reponses);


--
-- TOC entry 3801 (class 2606 OID 52458)
-- Name: patient_repond_a patient_repond_a_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_repond_a
    ADD CONSTRAINT patient_repond_a_pkey PRIMARY KEY (numero_dossier, id_questionnaire);


--
-- TOC entry 3847 (class 2606 OID 52803)
-- Name: poste poste_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_pkey PRIMARY KEY (id_utilisateur, id_publication_communaute);


--
-- TOC entry 3815 (class 2606 OID 52563)
-- Name: praticien_consulte praticien_consulte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien_consulte
    ADD CONSTRAINT praticien_consulte_pkey PRIMARY KEY (id_praticien, numero_dossier, id_bilan_suivi_patient);


--
-- TOC entry 3860 (class 2606 OID 52853)
-- Name: praticien praticien_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien
    ADD CONSTRAINT praticien_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- TOC entry 3862 (class 2606 OID 52851)
-- Name: praticien praticien_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien
    ADD CONSTRAINT praticien_pkey PRIMARY KEY (id_praticien);


--
-- TOC entry 3835 (class 2606 OID 52713)
-- Name: praticien_recoit praticien_recoit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien_recoit
    ADD CONSTRAINT praticien_recoit_pkey PRIMARY KEY (id_praticien, numero_dossier, id_praticien_1, id_message);


--
-- TOC entry 3803 (class 2606 OID 52473)
-- Name: praticien_repond_a praticien_repond_a_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien_repond_a
    ADD CONSTRAINT praticien_repond_a_pkey PRIMARY KEY (id_questionnaire, id_praticien);


--
-- TOC entry 3753 (class 2606 OID 52181)
-- Name: produits_bien_etre produits_bien_etre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produits_bien_etre
    ADD CONSTRAINT produits_bien_etre_pkey PRIMARY KEY (id_produits_bien_etre);


--
-- TOC entry 3769 (class 2606 OID 52252)
-- Name: publication_communaute publication_communaute_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publication_communaute
    ADD CONSTRAINT publication_communaute_pkey PRIMARY KEY (id_publication_communaute);


--
-- TOC entry 3813 (class 2606 OID 52548)
-- Name: publie publie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publie
    ADD CONSTRAINT publie_pkey PRIMARY KEY (id_praticien, id_contenus_inspirants);


--
-- TOC entry 3739 (class 2606 OID 52109)
-- Name: questionnaire questionnaire_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questionnaire
    ADD CONSTRAINT questionnaire_pkey PRIMARY KEY (id_questionnaire);


--
-- TOC entry 3745 (class 2606 OID 52141)
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id_questions);


--
-- TOC entry 3827 (class 2606 OID 52653)
-- Name: recoit recoit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recoit
    ADD CONSTRAINT recoit_pkey PRIMARY KEY (numero_dossier, id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3843 (class 2606 OID 52773)
-- Name: recommande recommande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommande
    ADD CONSTRAINT recommande_pkey PRIMARY KEY (id_analyse_ia_, id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3763 (class 2606 OID 52227)
-- Name: recommendation recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3761 (class 2606 OID 52218)
-- Name: referentiel_scientififque referentiel_scientififque_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referentiel_scientififque
    ADD CONSTRAINT referentiel_scientififque_pkey PRIMARY KEY (id_reference_scientifique);


--
-- TOC entry 3781 (class 2606 OID 52308)
-- Name: rendez_vous rendez_vous_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rendez_vous
    ADD CONSTRAINT rendez_vous_pkey PRIMARY KEY (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous);


--
-- TOC entry 3747 (class 2606 OID 52148)
-- Name: reponses reponses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponses
    ADD CONSTRAINT reponses_pkey PRIMARY KEY (id_questions, id_reponses);


--
-- TOC entry 3789 (class 2606 OID 52378)
-- Name: resultat_parcours resultat_parcours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_parcours
    ADD CONSTRAINT resultat_parcours_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- TOC entry 3751 (class 2606 OID 52169)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id_praticien, id_service);


--
-- TOC entry 3749 (class 2606 OID 52160)
-- Name: specialites specialites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialites
    ADD CONSTRAINT specialites_pkey PRIMARY KEY (id_specialites);


--
-- TOC entry 3741 (class 2606 OID 52120)
-- Name: utilisateur utilisateur_mail_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_mail_key UNIQUE (mail);


--
-- TOC entry 3743 (class 2606 OID 52118)
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- TOC entry 3867 (class 1259 OID 65629)
-- Name: idx_commune_cp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_commune_cp ON public.commune USING btree (code_postal);


--
-- TOC entry 3868 (class 1259 OID 65630)
-- Name: idx_commune_nom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_commune_nom ON public.commune USING gin (to_tsvector('simple'::regconfig, nom_commune));


--
-- TOC entry 3869 (class 1259 OID 65631)
-- Name: idx_commune_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_commune_trgm ON public.commune USING gin (nom_commune public.gin_trgm_ops);


--
-- TOC entry 3852 (class 1259 OID 65622)
-- Name: idx_praticien_adresse_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_adresse_trgm ON public.praticien USING gin (adresse_cabinet public.gin_trgm_ops);


--
-- TOC entry 3853 (class 1259 OID 65538)
-- Name: idx_praticien_code_postal; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_code_postal ON public.praticien USING btree (code_postal);


--
-- TOC entry 3854 (class 1259 OID 65536)
-- Name: idx_praticien_mode_consultation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_mode_consultation ON public.praticien USING btree (mode_consultation);


--
-- TOC entry 3855 (class 1259 OID 65621)
-- Name: idx_praticien_specialites_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_specialites_trgm ON public.praticien USING gin (specialites public.gin_trgm_ops);


--
-- TOC entry 3856 (class 1259 OID 65537)
-- Name: idx_praticien_statut_validation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_statut_validation ON public.praticien USING btree (statut_validation);


--
-- TOC entry 3857 (class 1259 OID 65623)
-- Name: idx_praticien_type_approche_trgm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_type_approche_trgm ON public.praticien USING gin (type_approche public.gin_trgm_ops);


--
-- TOC entry 3858 (class 1259 OID 65539)
-- Name: idx_praticien_ville; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_praticien_ville ON public.praticien USING btree (ville);


--
-- TOC entry 3898 (class 2606 OID 52584)
-- Name: a_des_etats a_des_etats_id_jumeau_numerique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.a_des_etats
    ADD CONSTRAINT a_des_etats_id_jumeau_numerique_fkey FOREIGN KEY (id_jumeau_numerique) REFERENCES public.jumeau_numerique(id_jumeau_numerique);


--
-- TOC entry 3899 (class 2606 OID 52579)
-- Name: a_des_etats a_des_etats_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.a_des_etats
    ADD CONSTRAINT a_des_etats_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3891 (class 2606 OID 52509)
-- Name: a_la_spécialite a_la_spécialite_id_specialites_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."a_la_spécialite"
    ADD CONSTRAINT "a_la_spécialite_id_specialites_fkey" FOREIGN KEY (id_specialites) REFERENCES public.specialites(id_specialites);


--
-- TOC entry 3892 (class 2606 OID 52524)
-- Name: achete achete_id_produits_bien_etre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achete
    ADD CONSTRAINT achete_id_produits_bien_etre_fkey FOREIGN KEY (id_produits_bien_etre) REFERENCES public.produits_bien_etre(id_produits_bien_etre);


--
-- TOC entry 3893 (class 2606 OID 52519)
-- Name: achete achete_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.achete
    ADD CONSTRAINT achete_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3931 (class 2606 OID 52874)
-- Name: agenda agenda_id_praticien_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.agenda
    ADD CONSTRAINT agenda_id_praticien_fkey FOREIGN KEY (id_praticien) REFERENCES public.praticien(id_praticien) ON DELETE CASCADE;


--
-- TOC entry 3900 (class 2606 OID 52599)
-- Name: alimente alimente_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alimente
    ADD CONSTRAINT alimente_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- TOC entry 3901 (class 2606 OID 52594)
-- Name: alimente alimente_numero_dossier_id_parcours_personnalises_id_resul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alimente
    ADD CONSTRAINT alimente_numero_dossier_id_parcours_personnalises_id_resul_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours) REFERENCES public.resultat_parcours(numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- TOC entry 3927 (class 2606 OID 52824)
-- Name: animer animer_id_conferences_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.animer
    ADD CONSTRAINT animer_id_conferences_fkey FOREIGN KEY (id_conferences) REFERENCES public.conferences(id_conferences);


--
-- TOC entry 3877 (class 2606 OID 52355)
-- Name: avis avis_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3880 (class 2606 OID 52393)
-- Name: bilan_suivi_patient bilan_suivi_patient_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bilan_suivi_patient
    ADD CONSTRAINT bilan_suivi_patient_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3894 (class 2606 OID 52539)
-- Name: consulte consulte_id_contenus_inspirants_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consulte
    ADD CONSTRAINT consulte_id_contenus_inspirants_fkey FOREIGN KEY (id_contenus_inspirants) REFERENCES public.contenus_inspirants(id_contenus_inspirants);


--
-- TOC entry 3911 (class 2606 OID 52689)
-- Name: consulte_intervient consulte_intervient_numero_dossier_id_parcours_personnalis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consulte_intervient
    ADD CONSTRAINT consulte_intervient_numero_dossier_id_parcours_personnalis_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises) REFERENCES public.parcours_personnalises(numero_dossier, id_parcours_personnalises);


--
-- TOC entry 3895 (class 2606 OID 52534)
-- Name: consulte consulte_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consulte
    ADD CONSTRAINT consulte_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3884 (class 2606 OID 52444)
-- Name: contient contient_id_questionnaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contient
    ADD CONSTRAINT contient_id_questionnaire_fkey FOREIGN KEY (id_questionnaire) REFERENCES public.questionnaire(id_questionnaire);


--
-- TOC entry 3885 (class 2606 OID 52449)
-- Name: contient contient_id_questions_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contient
    ADD CONSTRAINT contient_id_questions_fkey FOREIGN KEY (id_questions) REFERENCES public.questions(id_questions);


--
-- TOC entry 3917 (class 2606 OID 52744)
-- Name: contient_publication contient_publication_id_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contient_publication
    ADD CONSTRAINT contient_publication_id_communaute_fkey FOREIGN KEY (id_communaute) REFERENCES public.communaute(id_communaute);


--
-- TOC entry 3918 (class 2606 OID 52749)
-- Name: contient_publication contient_publication_id_publication_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contient_publication
    ADD CONSTRAINT contient_publication_id_publication_communaute_fkey FOREIGN KEY (id_publication_communaute) REFERENCES public.publication_communaute(id_publication_communaute);


--
-- TOC entry 3906 (class 2606 OID 52644)
-- Name: contribue_consulte contribue_consulte_id_reference_scientifique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contribue_consulte
    ADD CONSTRAINT contribue_consulte_id_reference_scientifique_fkey FOREIGN KEY (id_reference_scientifique) REFERENCES public.referentiel_scientififque(id_reference_scientifique);


--
-- TOC entry 3872 (class 2606 OID 52281)
-- Name: conversations conversations_id_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_id_communaute_fkey FOREIGN KEY (id_communaute) REFERENCES public.communaute(id_communaute);


--
-- TOC entry 3932 (class 2606 OID 52886)
-- Name: creneaux creneaux_id_agenda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creneaux
    ADD CONSTRAINT creneaux_id_agenda_fkey FOREIGN KEY (id_agenda) REFERENCES public.agenda(id_agenda) ON DELETE CASCADE;


--
-- TOC entry 3912 (class 2606 OID 52704)
-- Name: enrichit_bdd enrichit_bdd_id_reference_scientifique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrichit_bdd
    ADD CONSTRAINT enrichit_bdd_id_reference_scientifique_fkey FOREIGN KEY (id_reference_scientifique) REFERENCES public.referentiel_scientififque(id_reference_scientifique);


--
-- TOC entry 3913 (class 2606 OID 52699)
-- Name: enrichit_bdd enrichit_bdd_numero_dossier_id_parcours_personnalises_id_r_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrichit_bdd
    ADD CONSTRAINT enrichit_bdd_numero_dossier_id_parcours_personnalises_id_r_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours) REFERENCES public.resultat_parcours(numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- TOC entry 3904 (class 2606 OID 52624)
-- Name: enrichit enrichit_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrichit
    ADD CONSTRAINT enrichit_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- TOC entry 3905 (class 2606 OID 52629)
-- Name: enrichit enrichit_id_reference_scientifique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrichit
    ADD CONSTRAINT enrichit_id_reference_scientifique_fkey FOREIGN KEY (id_reference_scientifique) REFERENCES public.referentiel_scientififque(id_reference_scientifique);


--
-- TOC entry 3909 (class 2606 OID 52674)
-- Name: est_integree est_integree_id_jumeau_numerique_id_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_integree
    ADD CONSTRAINT est_integree_id_jumeau_numerique_id_recommendation_fkey FOREIGN KEY (id_jumeau_numerique, id_recommendation) REFERENCES public.recommendation(id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3910 (class 2606 OID 52669)
-- Name: est_integree est_integree_numero_dossier_id_parcours_personnalises_id_r_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_integree
    ADD CONSTRAINT est_integree_numero_dossier_id_parcours_personnalises_id_r_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours) REFERENCES public.resultat_parcours(numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- TOC entry 3919 (class 2606 OID 52764)
-- Name: est_membre est_membre_id_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_membre
    ADD CONSTRAINT est_membre_id_communaute_fkey FOREIGN KEY (id_communaute) REFERENCES public.communaute(id_communaute);


--
-- TOC entry 3920 (class 2606 OID 52759)
-- Name: est_membre est_membre_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_membre
    ADD CONSTRAINT est_membre_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- TOC entry 3902 (class 2606 OID 52614)
-- Name: est_sujet_de est_sujet_de_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_sujet_de
    ADD CONSTRAINT est_sujet_de_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- TOC entry 3903 (class 2606 OID 52609)
-- Name: est_sujet_de est_sujet_de_id_questions_id_reponses_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.est_sujet_de
    ADD CONSTRAINT est_sujet_de_id_questions_id_reponses_fkey FOREIGN KEY (id_questions, id_reponses) REFERENCES public.reponses(id_questions, id_reponses);


--
-- TOC entry 3883 (class 2606 OID 52434)
-- Name: factures factures_numero_dossier_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factures
    ADD CONSTRAINT factures_numero_dossier_1_fkey FOREIGN KEY (numero_dossier_1) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3881 (class 2606 OID 52405)
-- Name: historique_activite historique_activite_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique_activite
    ADD CONSTRAINT historique_activite_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3876 (class 2606 OID 52331)
-- Name: message message_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3882 (class 2606 OID 52417)
-- Name: paiement paiement_id_praticien_id_praticien_1_id_service_numero_dos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paiement
    ADD CONSTRAINT paiement_id_praticien_id_praticien_1_id_service_numero_dos_fkey FOREIGN KEY (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous) REFERENCES public.rendez_vous(id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous);


--
-- TOC entry 3878 (class 2606 OID 52367)
-- Name: parcours_personnalises parcours_personnalises_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parcours_personnalises
    ADD CONSTRAINT parcours_personnalises_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3923 (class 2606 OID 52794)
-- Name: participe participe_id_ateliers_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participe
    ADD CONSTRAINT participe_id_ateliers_fkey FOREIGN KEY (id_ateliers) REFERENCES public.ateliers(id_ateliers);


--
-- TOC entry 3924 (class 2606 OID 52789)
-- Name: participe participe_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participe
    ADD CONSTRAINT participe_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- TOC entry 3928 (class 2606 OID 52839)
-- Name: participer participer_id_communaute_id_conversations_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participer
    ADD CONSTRAINT participer_id_communaute_id_conversations_fkey FOREIGN KEY (id_communaute, id_conversations) REFERENCES public.conversations(id_communaute, id_conversations);


--
-- TOC entry 3929 (class 2606 OID 52834)
-- Name: participer participer_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participer
    ADD CONSTRAINT participer_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- TOC entry 3873 (class 2606 OID 52297)
-- Name: patient patient_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- TOC entry 3915 (class 2606 OID 52734)
-- Name: patient_recoit patient_recoit_numero_dossier_1_id_praticien_id_message_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_recoit
    ADD CONSTRAINT patient_recoit_numero_dossier_1_id_praticien_id_message_fkey FOREIGN KEY (numero_dossier_1, id_praticien, id_message) REFERENCES public.message(numero_dossier, id_praticien, id_message);


--
-- TOC entry 3916 (class 2606 OID 52729)
-- Name: patient_recoit patient_recoit_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_recoit
    ADD CONSTRAINT patient_recoit_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3889 (class 2606 OID 52494)
-- Name: patient_repond_a_ patient_repond_a__id_questions_id_reponses_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_repond_a_
    ADD CONSTRAINT patient_repond_a__id_questions_id_reponses_fkey FOREIGN KEY (id_questions, id_reponses) REFERENCES public.reponses(id_questions, id_reponses);


--
-- TOC entry 3890 (class 2606 OID 52489)
-- Name: patient_repond_a_ patient_repond_a__numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_repond_a_
    ADD CONSTRAINT patient_repond_a__numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3886 (class 2606 OID 52464)
-- Name: patient_repond_a patient_repond_a_id_questionnaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_repond_a
    ADD CONSTRAINT patient_repond_a_id_questionnaire_fkey FOREIGN KEY (id_questionnaire) REFERENCES public.questionnaire(id_questionnaire);


--
-- TOC entry 3887 (class 2606 OID 52459)
-- Name: patient_repond_a patient_repond_a_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_repond_a
    ADD CONSTRAINT patient_repond_a_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3925 (class 2606 OID 52809)
-- Name: poste poste_id_publication_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_id_publication_communaute_fkey FOREIGN KEY (id_publication_communaute) REFERENCES public.publication_communaute(id_publication_communaute);


--
-- TOC entry 3926 (class 2606 OID 52804)
-- Name: poste poste_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- TOC entry 3897 (class 2606 OID 52569)
-- Name: praticien_consulte praticien_consulte_numero_dossier_id_bilan_suivi_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien_consulte
    ADD CONSTRAINT praticien_consulte_numero_dossier_id_bilan_suivi_patient_fkey FOREIGN KEY (numero_dossier, id_bilan_suivi_patient) REFERENCES public.bilan_suivi_patient(numero_dossier, id_bilan_suivi_patient);


--
-- TOC entry 3930 (class 2606 OID 52854)
-- Name: praticien praticien_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien
    ADD CONSTRAINT praticien_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- TOC entry 3914 (class 2606 OID 52719)
-- Name: praticien_recoit praticien_recoit_numero_dossier_id_praticien_1_id_message_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien_recoit
    ADD CONSTRAINT praticien_recoit_numero_dossier_id_praticien_1_id_message_fkey FOREIGN KEY (numero_dossier, id_praticien_1, id_message) REFERENCES public.message(numero_dossier, id_praticien, id_message);


--
-- TOC entry 3888 (class 2606 OID 52474)
-- Name: praticien_repond_a praticien_repond_a_id_questionnaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.praticien_repond_a
    ADD CONSTRAINT praticien_repond_a_id_questionnaire_fkey FOREIGN KEY (id_questionnaire) REFERENCES public.questionnaire(id_questionnaire);


--
-- TOC entry 3896 (class 2606 OID 52554)
-- Name: publie publie_id_contenus_inspirants_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publie
    ADD CONSTRAINT publie_id_contenus_inspirants_fkey FOREIGN KEY (id_contenus_inspirants) REFERENCES public.contenus_inspirants(id_contenus_inspirants);


--
-- TOC entry 3907 (class 2606 OID 52659)
-- Name: recoit recoit_id_jumeau_numerique_id_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recoit
    ADD CONSTRAINT recoit_id_jumeau_numerique_id_recommendation_fkey FOREIGN KEY (id_jumeau_numerique, id_recommendation) REFERENCES public.recommendation(id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3908 (class 2606 OID 52654)
-- Name: recoit recoit_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recoit
    ADD CONSTRAINT recoit_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3921 (class 2606 OID 52774)
-- Name: recommande recommande_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommande
    ADD CONSTRAINT recommande_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- TOC entry 3922 (class 2606 OID 52779)
-- Name: recommande recommande_id_jumeau_numerique_id_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommande
    ADD CONSTRAINT recommande_id_jumeau_numerique_id_recommendation_fkey FOREIGN KEY (id_jumeau_numerique, id_recommendation) REFERENCES public.recommendation(id_jumeau_numerique, id_recommendation);


--
-- TOC entry 3871 (class 2606 OID 52228)
-- Name: recommendation recommendation_id_jumeau_numerique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_id_jumeau_numerique_fkey FOREIGN KEY (id_jumeau_numerique) REFERENCES public.jumeau_numerique(id_jumeau_numerique);


--
-- TOC entry 3874 (class 2606 OID 52314)
-- Name: rendez_vous rendez_vous_id_praticien_1_id_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rendez_vous
    ADD CONSTRAINT rendez_vous_id_praticien_1_id_service_fkey FOREIGN KEY (id_praticien_1, id_service) REFERENCES public.service(id_praticien, id_service);


--
-- TOC entry 3875 (class 2606 OID 52319)
-- Name: rendez_vous rendez_vous_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rendez_vous
    ADD CONSTRAINT rendez_vous_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- TOC entry 3870 (class 2606 OID 52149)
-- Name: reponses reponses_id_questions_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reponses
    ADD CONSTRAINT reponses_id_questions_fkey FOREIGN KEY (id_questions) REFERENCES public.questions(id_questions);


--
-- TOC entry 3879 (class 2606 OID 52379)
-- Name: resultat_parcours resultat_parcours_numero_dossier_id_parcours_personnalises_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resultat_parcours
    ADD CONSTRAINT resultat_parcours_numero_dossier_id_parcours_personnalises_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises) REFERENCES public.parcours_personnalises(numero_dossier, id_parcours_personnalises);


-- Completed on 2025-08-28 11:14:40 CEST

--
-- PostgreSQL database dump complete
--

