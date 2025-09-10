--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: a_des_etats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.a_des_etats (
    numero_dossier integer NOT NULL,
    id_jumeau_numerique integer NOT NULL
);


--
-- Name: a_la_spécialite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."a_la_spécialite" (
    id_praticien integer NOT NULL,
    id_specialites integer NOT NULL
);


--
-- Name: achete; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achete (
    numero_dossier integer NOT NULL,
    id_produits_bien_etre integer NOT NULL
);


--
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    id_utilisateur integer,
    role_admin character varying(50) DEFAULT 'moderateur'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: admin_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_admin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_admin_seq OWNED BY public.admin.id_admin;


--
-- Name: agenda; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agenda (
    id_agenda integer NOT NULL,
    id_praticien integer,
    titre character varying(255)
);


--
-- Name: agenda_id_agenda_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agenda_id_agenda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agenda_id_agenda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agenda_id_agenda_seq OWNED BY public.agenda.id_agenda;


--
-- Name: agenda_slots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agenda_slots (
    id bigint NOT NULL,
    praticien_id bigint NOT NULL,
    date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    status character varying(16) NOT NULL,
    title character varying(255) DEFAULT ''::character varying,
    place character varying(32) DEFAULT 'cabinet'::character varying,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: agenda_slots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agenda_slots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agenda_slots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agenda_slots_id_seq OWNED BY public.agenda_slots.id;


--
-- Name: alimente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.alimente (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    id_analyse_ia_ integer NOT NULL,
    modele_ia character varying(50)
);


--
-- Name: analyse_ia_; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.analyse_ia_ (
    id_analyse_ia_ integer NOT NULL,
    version_modele numeric(1,1),
    statut_validation character varying(50),
    resultats character varying(2000),
    date_analyse timestamp without time zone,
    type_analyse_ character varying(50)
);


--
-- Name: analyse_ia__id_analyse_ia__seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.analyse_ia__id_analyse_ia__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analyse_ia__id_analyse_ia__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.analyse_ia__id_analyse_ia__seq OWNED BY public.analyse_ia_.id_analyse_ia_;


--
-- Name: animer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.animer (
    id_praticien integer NOT NULL,
    id_conferences integer NOT NULL
);


--
-- Name: ateliers; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: ateliers_id_ateliers_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ateliers_id_ateliers_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ateliers_id_ateliers_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ateliers_id_ateliers_seq OWNED BY public.ateliers.id_ateliers;


--
-- Name: avis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.avis (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_avis integer NOT NULL,
    note integer NOT NULL,
    commentaire character varying(300),
    date_avis time without time zone
);


--
-- Name: avis_id_avis_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.avis_id_avis_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: avis_id_avis_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.avis_id_avis_seq OWNED BY public.avis.id_avis;


--
-- Name: avis_note_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.avis_note_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: avis_note_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.avis_note_seq OWNED BY public.avis.note;


--
-- Name: bilan_suivi_patient; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: bilan_suivi_patient_id_bilan_suivi_patient_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bilan_suivi_patient_id_bilan_suivi_patient_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bilan_suivi_patient_id_bilan_suivi_patient_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bilan_suivi_patient_id_bilan_suivi_patient_seq OWNED BY public.bilan_suivi_patient.id_bilan_suivi_patient;


--
-- Name: communaute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communaute (
    id_communaute integer NOT NULL,
    nom_groupe character varying(50),
    description_groupe character varying(1000),
    date_creation date,
    est_anonyme boolean
);


--
-- Name: communaute_id_communaute_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.communaute_id_communaute_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communaute_id_communaute_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.communaute_id_communaute_seq OWNED BY public.communaute.id_communaute;


--
-- Name: commune; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: conferences; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: conferences_id_conferences_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conferences_id_conferences_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conferences_id_conferences_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conferences_id_conferences_seq OWNED BY public.conferences.id_conferences;


--
-- Name: consulte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.consulte (
    numero_dossier integer NOT NULL,
    id_contenus_inspirants integer NOT NULL
);


--
-- Name: consulte_intervient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.consulte_intervient (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL
);


--
-- Name: contenus_inspirants; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: contenus_inspirants_id_contenus_inspirants_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contenus_inspirants_id_contenus_inspirants_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contenus_inspirants_id_contenus_inspirants_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contenus_inspirants_id_contenus_inspirants_seq OWNED BY public.contenus_inspirants.id_contenus_inspirants;


--
-- Name: contient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contient (
    id_questionnaire integer NOT NULL,
    id_questions integer NOT NULL
);


--
-- Name: contient_publication; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contient_publication (
    id_communaute integer NOT NULL,
    id_publication_communaute integer NOT NULL
);


--
-- Name: contribue_consulte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contribue_consulte (
    id_praticien integer NOT NULL,
    id_reference_scientifique integer NOT NULL
);


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conversations (
    id_communaute integer NOT NULL,
    id_conversations integer NOT NULL,
    contenu_message character varying(1000) NOT NULL,
    est_lu boolean DEFAULT false,
    type_message character varying(50),
    url_fichier_jointe character varying(255)
);


--
-- Name: conversations_id_conversations_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conversations_id_conversations_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conversations_id_conversations_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conversations_id_conversations_seq OWNED BY public.conversations.id_conversations;


--
-- Name: creneaux; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.creneaux (
    id_creneau integer NOT NULL,
    id_agenda integer,
    jour date NOT NULL,
    heure_debut time without time zone NOT NULL,
    heure_fin time without time zone NOT NULL
);


--
-- Name: creneaux_id_creneau_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.creneaux_id_creneau_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: creneaux_id_creneau_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.creneaux_id_creneau_seq OWNED BY public.creneaux.id_creneau;


--
-- Name: email_verification_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_verification_tokens (
    id integer NOT NULL,
    id_utilisateur integer NOT NULL,
    token character(64) NOT NULL,
    expire_le timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: email_verification_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_verification_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_verification_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_verification_tokens_id_seq OWNED BY public.email_verification_tokens.id;


--
-- Name: enrichit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrichit (
    id_analyse_ia_ integer NOT NULL,
    id_reference_scientifique integer NOT NULL
);


--
-- Name: enrichit_bdd; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrichit_bdd (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    id_reference_scientifique integer NOT NULL
);


--
-- Name: est_integree; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.est_integree (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    id_resultat_parcours integer NOT NULL,
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL
);


--
-- Name: est_membre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.est_membre (
    id_utilisateur integer NOT NULL,
    id_communaute integer NOT NULL
);


--
-- Name: est_sujet_de; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.est_sujet_de (
    id_questions integer NOT NULL,
    id_reponses integer NOT NULL,
    id_analyse_ia_ integer NOT NULL
);


--
-- Name: factures; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: factures_id_factures_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.factures_id_factures_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: factures_id_factures_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.factures_id_factures_seq OWNED BY public.factures.id_factures;


--
-- Name: historique_activite; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.historique_activite (
    numero_dossier integer NOT NULL,
    id_historique_activite integer NOT NULL,
    date_heure_activite timestamp without time zone,
    type_activite character varying(50),
    source_activite character varying(50)
);


--
-- Name: historique_activite_id_historique_activite_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.historique_activite_id_historique_activite_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: historique_activite_id_historique_activite_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.historique_activite_id_historique_activite_seq OWNED BY public.historique_activite.id_historique_activite;


--
-- Name: jumeau_numerique; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jumeau_numerique (
    id_jumeau_numerique integer NOT NULL,
    date_heure timestamp without time zone,
    donnees_energie_ character varying(255),
    resume_dynamique character varying(50),
    donnees_corporelles character varying(50),
    donnees_emotionnelles character varying(50)
);


--
-- Name: jumeau_numerique_id_jumeau_numerique_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jumeau_numerique_id_jumeau_numerique_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jumeau_numerique_id_jumeau_numerique_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jumeau_numerique_id_jumeau_numerique_seq OWNED BY public.jumeau_numerique.id_jumeau_numerique;


--
-- Name: message; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: message_id_message_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_id_message_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_id_message_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_id_message_seq OWNED BY public.message.id_message;


--
-- Name: paiement; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: paiement_id_paiement_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.paiement_id_paiement_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: paiement_id_paiement_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.paiement_id_paiement_seq OWNED BY public.paiement.id_paiement;


--
-- Name: parcours_personnalises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parcours_personnalises (
    numero_dossier integer NOT NULL,
    id_parcours_personnalises integer NOT NULL,
    date_creation date,
    date_derniere_maj date,
    statut character varying(50),
    objectif_principal character varying(50)
);


--
-- Name: parcours_personnalises_id_parcours_personnalises_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parcours_personnalises_id_parcours_personnalises_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parcours_personnalises_id_parcours_personnalises_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parcours_personnalises_id_parcours_personnalises_seq OWNED BY public.parcours_personnalises.id_parcours_personnalises;


--
-- Name: participe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.participe (
    id_utilisateur integer NOT NULL,
    id_ateliers integer NOT NULL
);


--
-- Name: participer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.participer (
    id_utilisateur integer NOT NULL,
    id_communaute integer NOT NULL,
    id_conversations integer NOT NULL
);


--
-- Name: patient; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient (
    numero_dossier integer NOT NULL,
    adresse character varying(50),
    date_de_naissance timestamp without time zone,
    genre character varying(50) NOT NULL,
    date_inscription date DEFAULT CURRENT_DATE NOT NULL,
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


--
-- Name: patient_numero_dossier_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patient_numero_dossier_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_numero_dossier_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patient_numero_dossier_seq OWNED BY public.patient.numero_dossier;


--
-- Name: patient_recoit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_recoit (
    numero_dossier integer NOT NULL,
    numero_dossier_1 integer NOT NULL,
    id_praticien integer NOT NULL,
    id_message integer NOT NULL
);


--
-- Name: patient_repond_a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_repond_a (
    numero_dossier integer NOT NULL,
    id_questionnaire integer NOT NULL,
    est_repondu character varying(50)
);


--
-- Name: patient_repond_a_; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_repond_a_ (
    numero_dossier integer NOT NULL,
    id_questions integer NOT NULL,
    id_reponses integer NOT NULL
);


--
-- Name: poste; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.poste (
    id_utilisateur integer NOT NULL,
    id_publication_communaute integer NOT NULL
);


--
-- Name: praticien; Type: TABLE; Schema: public; Owner: -
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
    ville text,
    longue_description text
);


--
-- Name: praticien_consulte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.praticien_consulte (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_bilan_suivi_patient integer NOT NULL
);


--
-- Name: praticien_id_praticien_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.praticien_id_praticien_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: praticien_id_praticien_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.praticien_id_praticien_seq OWNED BY public.praticien.id_praticien;


--
-- Name: praticien_recoit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.praticien_recoit (
    id_praticien integer NOT NULL,
    numero_dossier integer NOT NULL,
    id_praticien_1 integer NOT NULL,
    id_message integer NOT NULL
);


--
-- Name: praticien_repond_a; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.praticien_repond_a (
    id_questionnaire integer NOT NULL,
    id_praticien integer NOT NULL
);


--
-- Name: produits_bien_etre; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: produits_bien_etre_id_produits_bien_etre_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.produits_bien_etre_id_produits_bien_etre_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: produits_bien_etre_id_produits_bien_etre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.produits_bien_etre_id_produits_bien_etre_seq OWNED BY public.produits_bien_etre.id_produits_bien_etre;


--
-- Name: publication_communaute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publication_communaute (
    id_publication_communaute integer NOT NULL,
    contenu_texte character varying(1000),
    url_piece_jointe character varying(50),
    type_publication character varying(50),
    est_epingle character varying(50),
    date_publication timestamp without time zone
);


--
-- Name: publication_communaute_id_publication_communaute_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publication_communaute_id_publication_communaute_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publication_communaute_id_publication_communaute_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publication_communaute_id_publication_communaute_seq OWNED BY public.publication_communaute.id_publication_communaute;


--
-- Name: publie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publie (
    id_praticien integer NOT NULL,
    id_contenus_inspirants integer NOT NULL
);


--
-- Name: questionnaire; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questionnaire (
    id_questionnaire integer NOT NULL,
    description character varying(200),
    type_cible character varying(50),
    nom_questionnaire_ character varying(100),
    date_creation date,
    date_derniere_maj timestamp without time zone
);


--
-- Name: questionnaire_id_questionnaire_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questionnaire_id_questionnaire_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questionnaire_id_questionnaire_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questionnaire_id_questionnaire_seq OWNED BY public.questionnaire.id_questionnaire;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    id_questions integer NOT NULL,
    texte_question character varying(200),
    "type_réponses" character varying(50),
    categorie_question_ character varying(50)
);


--
-- Name: questions_id_questions_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questions_id_questions_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_questions_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questions_id_questions_seq OWNED BY public.questions.id_questions;


--
-- Name: recoit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recoit (
    numero_dossier integer NOT NULL,
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL
);


--
-- Name: recommande; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recommande (
    id_analyse_ia_ integer NOT NULL,
    id_jumeau_numerique integer NOT NULL,
    id_recommendation integer NOT NULL
);


--
-- Name: recommendation; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: recommendation_id_recommendation_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recommendation_id_recommendation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recommendation_id_recommendation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recommendation_id_recommendation_seq OWNED BY public.recommendation.id_recommendation;


--
-- Name: referentiel_scientififque; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: referentiel_scientififque_id_reference_scientifique_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.referentiel_scientififque_id_reference_scientifique_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: referentiel_scientififque_id_reference_scientifique_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.referentiel_scientififque_id_reference_scientifique_seq OWNED BY public.referentiel_scientififque.id_reference_scientifique;


--
-- Name: rendez_vous; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: rendez_vous_id_rendez_vous_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rendez_vous_id_rendez_vous_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rendez_vous_id_rendez_vous_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rendez_vous_id_rendez_vous_seq OWNED BY public.rendez_vous.id_rendez_vous;


--
-- Name: reponses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reponses (
    id_questions integer NOT NULL,
    id_reponses integer NOT NULL,
    contenu_reponse character varying(200),
    date_reponse timestamp without time zone
);


--
-- Name: reponses_id_reponses_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reponses_id_reponses_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reponses_id_reponses_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reponses_id_reponses_seq OWNED BY public.reponses.id_reponses;


--
-- Name: resultat_parcours; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: resultat_parcours_id_resultat_parcours_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.resultat_parcours_id_resultat_parcours_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: resultat_parcours_id_resultat_parcours_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.resultat_parcours_id_resultat_parcours_seq OWNED BY public.resultat_parcours.id_resultat_parcours;


--
-- Name: service; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: service_id_service_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.service_id_service_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: service_id_service_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.service_id_service_seq OWNED BY public.service.id_service;


--
-- Name: specialites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.specialites (
    id_specialites integer NOT NULL,
    nom_speciallite character varying(50),
    description character varying(300)
);


--
-- Name: specialites_id_specialites_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.specialites_id_specialites_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: specialites_id_specialites_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.specialites_id_specialites_seq OWNED BY public.specialites.id_specialites;


--
-- Name: user_email_verifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_email_verifications (
    user_id integer NOT NULL,
    token text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    sent_at timestamp with time zone NOT NULL
);


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
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
    telephone_ bigint,
    email_verifie_le timestamp without time zone,
    verification_required boolean DEFAULT true NOT NULL,
    photo_profil_url text
);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.utilisateur_id_utilisateur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.utilisateur_id_utilisateur_seq OWNED BY public.utilisateur.id_utilisateur;


--
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_admin_seq'::regclass);


--
-- Name: agenda id_agenda; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda ALTER COLUMN id_agenda SET DEFAULT nextval('public.agenda_id_agenda_seq'::regclass);


--
-- Name: agenda_slots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_slots ALTER COLUMN id SET DEFAULT nextval('public.agenda_slots_id_seq'::regclass);


--
-- Name: analyse_ia_ id_analyse_ia_; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analyse_ia_ ALTER COLUMN id_analyse_ia_ SET DEFAULT nextval('public.analyse_ia__id_analyse_ia__seq'::regclass);


--
-- Name: ateliers id_ateliers; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ateliers ALTER COLUMN id_ateliers SET DEFAULT nextval('public.ateliers_id_ateliers_seq'::regclass);


--
-- Name: avis id_avis; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avis ALTER COLUMN id_avis SET DEFAULT nextval('public.avis_id_avis_seq'::regclass);


--
-- Name: avis note; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avis ALTER COLUMN note SET DEFAULT nextval('public.avis_note_seq'::regclass);


--
-- Name: bilan_suivi_patient id_bilan_suivi_patient; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilan_suivi_patient ALTER COLUMN id_bilan_suivi_patient SET DEFAULT nextval('public.bilan_suivi_patient_id_bilan_suivi_patient_seq'::regclass);


--
-- Name: communaute id_communaute; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communaute ALTER COLUMN id_communaute SET DEFAULT nextval('public.communaute_id_communaute_seq'::regclass);


--
-- Name: conferences id_conferences; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conferences ALTER COLUMN id_conferences SET DEFAULT nextval('public.conferences_id_conferences_seq'::regclass);


--
-- Name: contenus_inspirants id_contenus_inspirants; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenus_inspirants ALTER COLUMN id_contenus_inspirants SET DEFAULT nextval('public.contenus_inspirants_id_contenus_inspirants_seq'::regclass);


--
-- Name: conversations id_conversations; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id_conversations SET DEFAULT nextval('public.conversations_id_conversations_seq'::regclass);


--
-- Name: creneaux id_creneau; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creneaux ALTER COLUMN id_creneau SET DEFAULT nextval('public.creneaux_id_creneau_seq'::regclass);


--
-- Name: email_verification_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens ALTER COLUMN id SET DEFAULT nextval('public.email_verification_tokens_id_seq'::regclass);


--
-- Name: factures id_factures; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factures ALTER COLUMN id_factures SET DEFAULT nextval('public.factures_id_factures_seq'::regclass);


--
-- Name: historique_activite id_historique_activite; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historique_activite ALTER COLUMN id_historique_activite SET DEFAULT nextval('public.historique_activite_id_historique_activite_seq'::regclass);


--
-- Name: jumeau_numerique id_jumeau_numerique; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jumeau_numerique ALTER COLUMN id_jumeau_numerique SET DEFAULT nextval('public.jumeau_numerique_id_jumeau_numerique_seq'::regclass);


--
-- Name: message id_message; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message ALTER COLUMN id_message SET DEFAULT nextval('public.message_id_message_seq'::regclass);


--
-- Name: paiement id_paiement; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paiement ALTER COLUMN id_paiement SET DEFAULT nextval('public.paiement_id_paiement_seq'::regclass);


--
-- Name: parcours_personnalises id_parcours_personnalises; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parcours_personnalises ALTER COLUMN id_parcours_personnalises SET DEFAULT nextval('public.parcours_personnalises_id_parcours_personnalises_seq'::regclass);


--
-- Name: patient numero_dossier; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient ALTER COLUMN numero_dossier SET DEFAULT nextval('public.patient_numero_dossier_seq'::regclass);


--
-- Name: praticien id_praticien; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien ALTER COLUMN id_praticien SET DEFAULT nextval('public.praticien_id_praticien_seq'::regclass);


--
-- Name: produits_bien_etre id_produits_bien_etre; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produits_bien_etre ALTER COLUMN id_produits_bien_etre SET DEFAULT nextval('public.produits_bien_etre_id_produits_bien_etre_seq'::regclass);


--
-- Name: publication_communaute id_publication_communaute; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publication_communaute ALTER COLUMN id_publication_communaute SET DEFAULT nextval('public.publication_communaute_id_publication_communaute_seq'::regclass);


--
-- Name: questionnaire id_questionnaire; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questionnaire ALTER COLUMN id_questionnaire SET DEFAULT nextval('public.questionnaire_id_questionnaire_seq'::regclass);


--
-- Name: questions id_questions; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions ALTER COLUMN id_questions SET DEFAULT nextval('public.questions_id_questions_seq'::regclass);


--
-- Name: recommendation id_recommendation; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendation ALTER COLUMN id_recommendation SET DEFAULT nextval('public.recommendation_id_recommendation_seq'::regclass);


--
-- Name: referentiel_scientififque id_reference_scientifique; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referentiel_scientififque ALTER COLUMN id_reference_scientifique SET DEFAULT nextval('public.referentiel_scientififque_id_reference_scientifique_seq'::regclass);


--
-- Name: rendez_vous id_rendez_vous; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rendez_vous ALTER COLUMN id_rendez_vous SET DEFAULT nextval('public.rendez_vous_id_rendez_vous_seq'::regclass);


--
-- Name: reponses id_reponses; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reponses ALTER COLUMN id_reponses SET DEFAULT nextval('public.reponses_id_reponses_seq'::regclass);


--
-- Name: resultat_parcours id_resultat_parcours; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resultat_parcours ALTER COLUMN id_resultat_parcours SET DEFAULT nextval('public.resultat_parcours_id_resultat_parcours_seq'::regclass);


--
-- Name: service id_service; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service ALTER COLUMN id_service SET DEFAULT nextval('public.service_id_service_seq'::regclass);


--
-- Name: specialites id_specialites; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.specialites ALTER COLUMN id_specialites SET DEFAULT nextval('public.specialites_id_specialites_seq'::regclass);


--
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur ALTER COLUMN id_utilisateur SET DEFAULT nextval('public.utilisateur_id_utilisateur_seq'::regclass);


--
-- Data for Name: a_des_etats; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.a_des_etats (numero_dossier, id_jumeau_numerique) FROM stdin;
\.


--
-- Data for Name: a_la_spécialite; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."a_la_spécialite" (id_praticien, id_specialites) FROM stdin;
\.


--
-- Data for Name: achete; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.achete (numero_dossier, id_produits_bien_etre) FROM stdin;
\.


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin (id_admin, id_utilisateur, role_admin, created_at) FROM stdin;
\.


--
-- Data for Name: agenda; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agenda (id_agenda, id_praticien, titre) FROM stdin;
1	49	Agenda 49
2	50	Agenda 50
3	47	Agenda 47
\.


--
-- Data for Name: agenda_slots; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) FROM stdin;
1	0	2025-09-01	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.682516+02
2	0	2025-09-02	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.686468+02
3	0	2025-09-03	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.686705+02
4	0	2025-09-04	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.686879+02
5	0	2025-09-05	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.688202+02
6	0	2025-09-06	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.688397+02
7	0	2025-09-07	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.688605+02
8	0	2025-09-08	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.688779+02
9	0	2025-09-09	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.689324+02
10	0	2025-09-10	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.689494+02
11	0	2025-09-11	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.689885+02
12	0	2025-09-12	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.690572+02
13	0	2025-09-13	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.690766+02
14	0	2025-09-14	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.690935+02
15	0	2025-09-15	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.691349+02
16	0	2025-09-16	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.691561+02
17	0	2025-09-17	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.691757+02
18	0	2025-09-18	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.691983+02
19	0	2025-09-19	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.692165+02
20	0	2025-09-20	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.692338+02
21	0	2025-09-21	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.692777+02
22	0	2025-09-22	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.692955+02
23	0	2025-09-23	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.693149+02
24	0	2025-09-24	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.693318+02
25	0	2025-09-25	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.693501+02
26	0	2025-09-26	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.69368+02
27	0	2025-09-27	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.693873+02
28	0	2025-09-28	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.697104+02
29	0	2025-09-29	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.697278+02
30	0	2025-09-30	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-01 14:09:35.697463+02
31	0	2025-09-01	10:00:00	12:45:00	free	Fall	cabinet	2025-09-01 14:09:59.656026+02
32	0	2025-09-02	10:00:00	11:45:00	free	Yasmine	cabinet	2025-09-01 16:34:48.233892+02
33	0	2025-10-01	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.326399+02
34	0	2025-10-02	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.328321+02
35	0	2025-10-03	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.329076+02
36	0	2025-10-04	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.329454+02
37	0	2025-10-05	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.330034+02
38	0	2025-10-06	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.3303+02
39	0	2025-10-07	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.331136+02
40	0	2025-10-08	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.331473+02
41	0	2025-10-09	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.331746+02
42	0	2025-10-10	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.332412+02
43	0	2025-10-11	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.332774+02
44	0	2025-10-12	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.33311+02
45	0	2025-10-13	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.333407+02
46	0	2025-10-14	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.333707+02
47	0	2025-10-15	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.334024+02
48	0	2025-10-16	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.334319+02
49	0	2025-10-17	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.335395+02
50	0	2025-10-18	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.335716+02
51	0	2025-10-19	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.336288+02
52	0	2025-10-20	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.336598+02
53	0	2025-10-21	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.33689+02
54	0	2025-10-22	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.33764+02
55	0	2025-10-23	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.338171+02
56	0	2025-10-24	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.338429+02
57	0	2025-10-25	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.338693+02
58	0	2025-10-26	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.338938+02
59	0	2025-10-27	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.339214+02
60	0	2025-10-28	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.33951+02
61	0	2025-10-29	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.339773+02
62	0	2025-10-30	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.340057+02
63	0	2025-10-31	10:00:00	11:45:00	free	Créneau dispo	cabinet	2025-09-01 16:36:30.340339+02
64	0	2025-08-01	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.663885+02
65	0	2025-08-02	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.669146+02
66	0	2025-08-03	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.669541+02
67	0	2025-08-04	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.669779+02
68	0	2025-08-05	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.670047+02
69	0	2025-08-06	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.670268+02
70	0	2025-08-07	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.670502+02
71	0	2025-08-08	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.670674+02
72	0	2025-08-09	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.670867+02
73	0	2025-08-10	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.671074+02
74	0	2025-08-11	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.671251+02
75	0	2025-08-12	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.671441+02
76	0	2025-08-13	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.671633+02
77	0	2025-08-14	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.673157+02
78	0	2025-08-15	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.673829+02
79	0	2025-08-16	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.674041+02
80	0	2025-08-17	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.674255+02
81	0	2025-08-18	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.674447+02
82	0	2025-08-19	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.674639+02
83	0	2025-08-20	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.675348+02
84	0	2025-08-21	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.675562+02
85	0	2025-08-22	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.675754+02
86	0	2025-08-23	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.676507+02
87	0	2025-08-24	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.676667+02
88	0	2025-08-25	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.676826+02
89	0	2025-08-26	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.67698+02
90	0	2025-08-27	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.677147+02
91	0	2025-08-28	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.677357+02
92	0	2025-08-29	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.677549+02
93	0	2025-08-30	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.6777+02
94	0	2025-08-31	09:00:00	09:45:00	free	Créneau dispo	cabinet	2025-09-09 11:23:43.678417+02
\.


--
-- Data for Name: alimente; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.alimente (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_analyse_ia_, modele_ia) FROM stdin;
\.


--
-- Data for Name: analyse_ia_; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.analyse_ia_ (id_analyse_ia_, version_modele, statut_validation, resultats, date_analyse, type_analyse_) FROM stdin;
\.


--
-- Data for Name: animer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.animer (id_praticien, id_conferences) FROM stdin;
\.


--
-- Data for Name: ateliers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ateliers (id_ateliers, nom_activite, description_activite, thematique, capacite_max, tarif, date_debut, date_fin, url_visio, adresse_presentiel, est_gratuit, est_enregistre, statut_activite) FROM stdin;
\.


--
-- Data for Name: avis; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.avis (id_praticien, numero_dossier, id_avis, note, commentaire, date_avis) FROM stdin;
\.


--
-- Data for Name: bilan_suivi_patient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bilan_suivi_patient (numero_dossier, id_bilan_suivi_patient, date_bilan, rapport_ia, retours, courbes_suivi_progres, kpi_quantitatifs, date_debut_periode_, date_fin_periode_, est_exportable_) FROM stdin;
5	1	2025-07-31	RAS	RAS	\N		2025-07-31 13:06:20.900593	2025-07-31 13:06:20.900593	f
6	2	2025-07-31	RAS	RAS	\N		2025-07-31 13:06:20.900593	2025-07-31 13:06:20.900593	f
\.


--
-- Data for Name: communaute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.communaute (id_communaute, nom_groupe, description_groupe, date_creation, est_anonyme) FROM stdin;
\.


--
-- Data for Name: commune; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) FROM stdin;
75056	Paris	75001	PARIS 01	\N	\N	\N
75056	Paris	75002	PARIS 02	\N	\N	\N
13055	Marseille	13001	MARSEILLE 01	\N	\N	\N
69383	Lyon	69001	LYON 01	\N	\N	\N
31555	Toulouse	31000	TOULOUSE	\N	\N	\N
44109	Nantes	44000	NANTES	\N	\N	\N
\.


--
-- Data for Name: conferences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conferences (id_conferences, capacite_max, statut_conference, titre, resume_conference, "thématique", duree_prevu_minutes, date_heure_debut, date_heure_fin, url_visio, tarif) FROM stdin;
\.


--
-- Data for Name: consulte; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.consulte (numero_dossier, id_contenus_inspirants) FROM stdin;
\.


--
-- Data for Name: consulte_intervient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.consulte_intervient (id_praticien, numero_dossier, id_parcours_personnalises) FROM stdin;
\.


--
-- Data for Name: contenus_inspirants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contenus_inspirants (id_contenus_inspirants, titre, description_courte, auteur, categorie, type_contenu, date_publication) FROM stdin;
\.


--
-- Data for Name: contient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contient (id_questionnaire, id_questions) FROM stdin;
\.


--
-- Data for Name: contient_publication; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contient_publication (id_communaute, id_publication_communaute) FROM stdin;
\.


--
-- Data for Name: contribue_consulte; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contribue_consulte (id_praticien, id_reference_scientifique) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.conversations (id_communaute, id_conversations, contenu_message, est_lu, type_message, url_fichier_jointe) FROM stdin;
\.


--
-- Data for Name: creneaux; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) FROM stdin;
11	1	2025-08-29	09:00:00	09:50:00
12	1	2025-08-29	11:00:00	11:50:00
13	1	2025-08-30	14:00:00	14:50:00
14	1	2025-08-31	16:00:00	16:50:00
15	2	2025-08-29	10:00:00	10:45:00
16	2	2025-08-30	09:30:00	10:15:00
17	2	2025-08-31	15:00:00	15:45:00
18	3	2025-08-29	08:30:00	09:15:00
19	3	2025-08-30	13:00:00	13:45:00
20	3	2025-08-30	17:30:00	18:15:00
21	1	2025-08-30	09:00:00	09:50:00
22	1	2025-08-30	11:00:00	11:50:00
23	1	2025-08-31	14:00:00	14:50:00
24	1	2025-09-01	16:00:00	16:50:00
25	1	2025-09-02	10:00:00	10:50:00
26	2	2025-08-30	10:00:00	10:45:00
27	2	2025-08-31	09:30:00	10:15:00
28	2	2025-09-01	15:00:00	15:45:00
\.


--
-- Data for Name: email_verification_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.email_verification_tokens (id, id_utilisateur, token, expire_le, created_at) FROM stdin;
\.


--
-- Data for Name: enrichit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enrichit (id_analyse_ia_, id_reference_scientifique) FROM stdin;
\.


--
-- Data for Name: enrichit_bdd; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.enrichit_bdd (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_reference_scientifique) FROM stdin;
\.


--
-- Data for Name: est_integree; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.est_integree (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_jumeau_numerique, id_recommendation) FROM stdin;
\.


--
-- Data for Name: est_membre; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.est_membre (id_utilisateur, id_communaute) FROM stdin;
\.


--
-- Data for Name: est_sujet_de; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.est_sujet_de (id_questions, id_reponses, id_analyse_ia_) FROM stdin;
\.


--
-- Data for Name: factures; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.factures (id_factures, date_facture, montant_total, url_pdf, numero_dossier, id_praticien, numero_dossier_1, id_paiement) FROM stdin;
\.


--
-- Data for Name: historique_activite; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.historique_activite (numero_dossier, id_historique_activite, date_heure_activite, type_activite, source_activite) FROM stdin;
\.


--
-- Data for Name: jumeau_numerique; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jumeau_numerique (id_jumeau_numerique, date_heure, donnees_energie_, resume_dynamique, donnees_corporelles, donnees_emotionnelles) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.message (numero_dossier, id_praticien, id_message, sujet, date_heure_envoie, lu, type_message) FROM stdin;
\.


--
-- Data for Name: paiement; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.paiement (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous, id_paiement, montant, mode_paiement, date_paiement, statut_paiement, reference_transaction) FROM stdin;
\.


--
-- Data for Name: parcours_personnalises; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.parcours_personnalises (numero_dossier, id_parcours_personnalises, date_creation, date_derniere_maj, statut, objectif_principal) FROM stdin;
\.


--
-- Data for Name: participe; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.participe (id_utilisateur, id_ateliers) FROM stdin;
\.


--
-- Data for Name: participer; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.participer (id_utilisateur, id_communaute, id_conversations) FROM stdin;
\.


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patient (numero_dossier, adresse, date_de_naissance, genre, date_inscription, derniere_connexion, situation_pro_, origine_ethnique_, environnement_vie, habitudes_, rythme_quotidien_, type_activite_physique_, frequence_activite_physique_, type_alimentation_, consommation_substances_, niveau_energie_moyen, gestion_emotionnelle_actuelle_, _interet_spiritualite, suivi_progres_actuel, type_accompagnement_souhaite_, autorisation_mise_en_lien_therapeutes, frequence_rappels_souhaitee, nom_jumeau_numerique_, design_jumeau_numerique, qualite_environnement_vie_choix_, id_utilisateur) FROM stdin;
5	15 rue Paris	1995-08-12 00:00:00	F	2025-07-31	2025-07-31 12:56:11.171753	Etudiante	\N	\N	Sport	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	52
6	22 avenue Lyon	1989-03-27 00:00:00	M	2025-07-31	2025-07-31 12:56:11.171753	Commercial	\N	\N	Lecture	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	53
\.


--
-- Data for Name: patient_recoit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patient_recoit (numero_dossier, numero_dossier_1, id_praticien, id_message) FROM stdin;
\.


--
-- Data for Name: patient_repond_a; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patient_repond_a (numero_dossier, id_questionnaire, est_repondu) FROM stdin;
\.


--
-- Data for Name: patient_repond_a_; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.patient_repond_a_ (numero_dossier, id_questions, id_reponses) FROM stdin;
\.


--
-- Data for Name: poste; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.poste (id_utilisateur, id_publication_communaute) FROM stdin;
\.


--
-- Data for Name: praticien; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.praticien (id_praticien, mode_consultation, adresse_cabinet, diplomes, nombre_heures_pratique, description, annees_experience, tarifs_consultation, photo_profil_url, taux_satisfaction, statut_validation, id_utilisateur, telephone_verifie, code_verification, code_expiry, code_postal, specialites, type_approche, ville, longue_description) FROM stdin;
48	cabinet	81b rue du chevaleret, 75013	Master en naturopathie	400	naturopathe galsen	5	50	Uploads/photos/689206a5ce7c6_sylla.png	\N	valide	65	f	\N	\N	75013	naturopathie	\N	\N	naturopathe galsen
50	cabinet	81b rue du chevaleret, 75013	Master en massage	145	Praticien spécialisé en massages relaxants et thérapeutiques pour soulager les tensions musculaires et améliorer le bien-être.	3	60	Uploads/photos/default_masseur.png	88.00	valide	61	f	\N	\N	75013	massage	Manuelle	Paris	Praticien spécialisé en massages relaxants et thérapeutiques pour soulager les tensions musculaires et améliorer le bien-être.
47	distance	81b rue du chevaleret, 75013	Master en naturopathie	300	je suis naturopathe senegalaise	5	50	Uploads/photos/6891ff3f1a52b_sylla.png	95.00	valide	64	f	\N	\N	75013	naturopathie	Holistique	Paris	je suis naturopathe senegalaise
49	cabinet	81b rue du chevaleret, 75013	Master en massage	700	Je propose des séances de yoga thérapeutique et de relaxation pour réduire le stress et améliorer la souplesse.	7	75	Uploads/photos/6892129f027a9_alou.png	92.00	valide	60	f	\N	\N	75013	Yoga	Énergétique	Paris	Je propose des séances de yoga thérapeutique et de relaxation adaptées aux besoins spécifiques de chaque personne. Mon objectif est de permettre à chacun de retrouver une harmonie entre le corps, le mental et l’esprit, dans un cadre bienveillant et apaisant. Le yoga que je transmets ne se limite pas à une simple pratique physique : il s’agit d’un véritable chemin de transformation intérieure.\n\nAprès plusieurs années de formation en Inde et en Europe, j’ai acquis une solide connaissance des postures (asanas), de la respiration (pranayama) et de la méditation. J’ai complété cet enseignement par des spécialisations en yoga thérapeutique, ce qui me permet aujourd’hui d’accompagner des publics variés : personnes souffrant de douleurs chroniques, individus en période de convalescence, femmes enceintes, ou encore personnes en recherche d’un meilleur équilibre émotionnel.\n\nLors d’une séance type, je commence par un moment d’écoute afin de comprendre vos besoins du jour. Ensuite, nous progressons à travers des mouvements doux, adaptés à vos capacités, en accordant une attention particulière à la respiration. Loin d’être une performance, ma pratique du yoga est avant tout une invitation à ressentir et à se reconnecter à soi-même. Chaque posture est proposée dans le respect de votre rythme, avec des ajustements possibles pour éviter toute contrainte.\n\nLe yoga thérapeutique agit sur plusieurs niveaux : amélioration de la souplesse et de la posture, renforcement musculaire en profondeur, diminution du stress et de l’anxiété, meilleure qualité du sommeil, mais aussi apaisement global du système nerveux. J’intègre également des exercices de méditation et de visualisation pour favoriser un ancrage mental plus serein.\n\nJe crois profondément que chacun possède en lui la capacité d’évoluer vers plus de santé et de bien-être. Mon rôle est de vous accompagner dans cette démarche, de vous transmettre des outils concrets que vous pourrez ensuite utiliser dans votre quotidien. Au-delà des séances en présentiel, je propose également un suivi à distance, avec des programmes personnalisés que vous pouvez pratiquer chez vous.\n\nEn choisissant de travailler ensemble, vous bénéficierez d’un espace de confiance, où vos besoins et vos limites seront respectés. Le yoga devient alors un allié précieux pour retrouver une énergie vitale équilibrée, une meilleure gestion des émotions et un rapport plus doux avec votre corps. Mon souhait est que chaque séance soit pour vous une bulle de calme et un pas supplémentaire sur le chemin de votre mieux-être.
\.


--
-- Data for Name: praticien_consulte; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.praticien_consulte (id_praticien, numero_dossier, id_bilan_suivi_patient) FROM stdin;
36	5	1
36	6	2
\.


--
-- Data for Name: praticien_recoit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.praticien_recoit (id_praticien, numero_dossier, id_praticien_1, id_message) FROM stdin;
\.


--
-- Data for Name: praticien_repond_a; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.praticien_repond_a (id_questionnaire, id_praticien) FROM stdin;
\.


--
-- Data for Name: produits_bien_etre; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.produits_bien_etre (id_produits_bien_etre, prix, nom_produit, description, stock, url_image, categorie, id_praticien) FROM stdin;
\.


--
-- Data for Name: publication_communaute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.publication_communaute (id_publication_communaute, contenu_texte, url_piece_jointe, type_publication, est_epingle, date_publication) FROM stdin;
\.


--
-- Data for Name: publie; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.publie (id_praticien, id_contenus_inspirants) FROM stdin;
\.


--
-- Data for Name: questionnaire; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.questionnaire (id_questionnaire, description, type_cible, nom_questionnaire_, date_creation, date_derniere_maj) FROM stdin;
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.questions (id_questions, texte_question, "type_réponses", categorie_question_) FROM stdin;
\.


--
-- Data for Name: recoit; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recoit (numero_dossier, id_jumeau_numerique, id_recommendation) FROM stdin;
\.


--
-- Data for Name: recommande; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recommande (id_analyse_ia_, id_jumeau_numerique, id_recommendation) FROM stdin;
\.


--
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.recommendation (id_jumeau_numerique, id_recommendation, type_recommandation, impact_prevu_jumeau, statut_recommandation, date_emission, texte_recommandation) FROM stdin;
\.


--
-- Data for Name: referentiel_scientififque; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.referentiel_scientififque (id_reference_scientifique, titre, description_courte, type_element, contenu_detaille, auteur_source, date_publication_initiale, date_derniere_mise_a_jour, mots_cles, est_valide_par_expert, url_lien, thematique) FROM stdin;
\.


--
-- Data for Name: rendez_vous; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rendez_vous (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous, date_heure_debut, date_heure_fin, statut_rdv, mode_paiement_, recommandations_post_seance_, mode_rdv, lien_visio) FROM stdin;
\.


--
-- Data for Name: reponses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reponses (id_questions, id_reponses, contenu_reponse, date_reponse) FROM stdin;
\.


--
-- Data for Name: resultat_parcours; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resultat_parcours (numero_dossier, id_parcours_personnalises, id_resultat_parcours, date_cible, description, statut_etape, type_etape) FROM stdin;
\.


--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.service (id_praticien, id_service, description_service, nom_service, tarif, type_service, duree) FROM stdin;
\.


--
-- Data for Name: specialites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.specialites (id_specialites, nom_speciallite, description) FROM stdin;
\.


--
-- Data for Name: user_email_verifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_email_verifications (user_id, token, expires_at, sent_at) FROM stdin;
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) FROM stdin;
45	ess@holinea.fr	fall	habdallahi	2025-07-31	2025-07-31 12:19:20.22067	therapeute	actif	$2y$10$kokkA8c4iIf15Xjjyce8ZuUutXFEYvVPaQWYwO3Da8wcw.Wx3kcPu	t	t	\N	33625628751	\N	t	\N
52	client1@exemple.com	Dupont	Marie	2025-07-31	2025-07-31 12:47:21.086047	patient	actif	testhash	t	f	\N	33660000001	\N	t	\N
53	client2@exemple.com	Martin	Jean	2025-07-31	2025-07-31 12:47:21.086047	patient	actif	testhash	t	t	\N	33660000002	\N	t	\N
54	fall@holinea.fr	fall	habdallahi	2025-08-05	2025-08-05 10:37:50.662133	therapeute	actif	$2y$10$dKDziXFEHBN.isXrL7Ozb.OHkSvZOu67N607bDQB.Z4vb1gZN..3q	t	t	\N	33625628751	\N	t	\N
55	fall1@holinea.fr	fall	abdou	2025-08-05	2025-08-05 11:47:15.136171	therapeute	actif	$2y$10$3y4vc90x6tqQfyGnzyz85.GQ82VFGQgogm1SZV/YXpnmOA9VMv9Ym	t	t	\N	33625628751	\N	t	\N
56	fall2@holinea.fr	fall	habdallahi	2025-08-05	2025-08-05 11:53:55.53552	therapeute	actif	$2y$10$5YeHFVKT5lvZptKarlIRv.TrIXxvBI.Cf9h0ldQY1B2QMpp8OdBMq	t	t	\N	33625628751	\N	t	\N
57	fall3@holinea.fr	fall	habdallahi	2025-08-05	2025-08-05 12:00:22.044469	therapeute	actif	$2y$10$gtQGfxvIRGR0lJ2jwe9gX.0xwpaUyAV7xu/SBrMWLutA6KXMaq9Vi	t	t	\N	33625628751	\N	t	\N
58	fall4@holinea.fr	fall	habdallahi	2025-08-05	2025-08-05 12:03:09.238271	therapeute	actif	$2y$10$c6PePT6jLwryCg92qDLNOuIcNsOCG8iUgVOYhyUl7tDVKKrdQWOOW	t	t	\N	33625628751	\N	t	\N
59	fall5@holinea.fr	fall	ishak	2025-08-05	2025-08-05 12:16:09.600295	therapeute	actif	$2y$10$ORWLJMwcc9KEiGgC0ALNIuIv2Ftu4JFusnNq6z9Ka9dShuCZ6S5nm	t	t	\N	33625628751	\N	t	\N
60	fall6@holinea.fr	FALL	habdallahi	2025-08-05	2025-08-05 12:37:25.410447	therapeute	actif	$2y$10$lM5qb0ZpoyBT20R0xy/eIOLV2UtdUzwcZtyBGmgQBRPW93AjcVMZi	t	t	\N	33625628751	\N	t	\N
61	diop@holinea.fr	DIOP	FAMA	2025-08-05	2025-08-05 12:42:41.848355	therapeute	actif	$2y$10$QTl9ph8ApnLzA.BROlM6rO8BrflhDGDmprCUPectgDsuvJ3pXy6AK	t	t	\N	33625628751	\N	t	\N
62	ndiaye@holinea.fr	ndiaye	awa	2025-08-05	2025-08-05 14:32:08.998837	therapeute	actif	$2y$10$0d8EuTaBk.mJjqEPipXvCurUKDWW3PdYIiJ5c3HZNG3kazbk3xJza	t	t	\N	33625628751	\N	t	\N
63	sylla@holinea.fr	AIDA	SYLLA	2025-08-05	2025-08-05 14:48:23.362678	therapeute	actif	$2y$10$FQXBWvOusvXMAzMa.o50yenJWDHxee/WSO5gGKHWwIsp6pvWFiDBy	t	t	\N	33625628751	\N	t	\N
64	ndiaye2@holinea.fr	AIDA	NDIAYE	2025-08-05	2025-08-05 14:55:42.597666	therapeute	actif	$2y$10$CqZaDBWa8j9Lo9RfQ6l9deyPs09vB1josMYMG4CgHZ4HZMAGvv3Oe	t	t	\N	33625628751	\N	t	\N
65	contact@holinea.fr	fall	habdallahi	2025-08-05	2025-08-05 15:27:17.878211	therapeute	actif	$2y$10$kfs0U5/I41pkH5zmVFwPLuQOvZjLHkhGOKZTRvOAdkPOq5EH22HAe	t	t	\N	33625628751	\N	t	\N
66	alou@holinea.fr	alou	diop	2025-08-05	2025-08-05 16:18:23.40199	therapeute	actif	$2y$10$rpUxwhMuEG4FhZiRyZ59puYysahbSBF.bbLU0KY3hVVwxgu5zWHSq	t	t	\N	33625628751	\N	t	\N
67	ndiaye22@holinea.fr	fall	habdallahi	2025-08-07	2025-08-07 17:44:24.638939	therapeute	actif	$2y$10$iqNghvHGrCgf9AWTNGyFXuw29Hy.WFPVGTDdf7Qmb85RMiG29FTWS	t	t	\N	33625628751	\N	t	\N
\.


--
-- Name: admin_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_admin_seq', 1, false);


--
-- Name: agenda_id_agenda_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.agenda_id_agenda_seq', 3, true);


--
-- Name: agenda_slots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.agenda_slots_id_seq', 94, true);


--
-- Name: analyse_ia__id_analyse_ia__seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.analyse_ia__id_analyse_ia__seq', 1, false);


--
-- Name: ateliers_id_ateliers_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ateliers_id_ateliers_seq', 1, false);


--
-- Name: avis_id_avis_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.avis_id_avis_seq', 1, false);


--
-- Name: avis_note_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.avis_note_seq', 1, false);


--
-- Name: bilan_suivi_patient_id_bilan_suivi_patient_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bilan_suivi_patient_id_bilan_suivi_patient_seq', 2, true);


--
-- Name: communaute_id_communaute_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.communaute_id_communaute_seq', 1, false);


--
-- Name: conferences_id_conferences_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.conferences_id_conferences_seq', 1, false);


--
-- Name: contenus_inspirants_id_contenus_inspirants_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contenus_inspirants_id_contenus_inspirants_seq', 1, false);


--
-- Name: conversations_id_conversations_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.conversations_id_conversations_seq', 1, false);


--
-- Name: creneaux_id_creneau_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.creneaux_id_creneau_seq', 28, true);


--
-- Name: email_verification_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.email_verification_tokens_id_seq', 1, false);


--
-- Name: factures_id_factures_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.factures_id_factures_seq', 1, false);


--
-- Name: historique_activite_id_historique_activite_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.historique_activite_id_historique_activite_seq', 1, false);


--
-- Name: jumeau_numerique_id_jumeau_numerique_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jumeau_numerique_id_jumeau_numerique_seq', 1, false);


--
-- Name: message_id_message_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.message_id_message_seq', 1, false);


--
-- Name: paiement_id_paiement_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.paiement_id_paiement_seq', 1, false);


--
-- Name: parcours_personnalises_id_parcours_personnalises_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.parcours_personnalises_id_parcours_personnalises_seq', 1, false);


--
-- Name: patient_numero_dossier_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.patient_numero_dossier_seq', 30, true);


--
-- Name: praticien_id_praticien_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.praticien_id_praticien_seq', 50, true);


--
-- Name: produits_bien_etre_id_produits_bien_etre_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produits_bien_etre_id_produits_bien_etre_seq', 1, false);


--
-- Name: publication_communaute_id_publication_communaute_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.publication_communaute_id_publication_communaute_seq', 1, false);


--
-- Name: questionnaire_id_questionnaire_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.questionnaire_id_questionnaire_seq', 1, false);


--
-- Name: questions_id_questions_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.questions_id_questions_seq', 1, false);


--
-- Name: recommendation_id_recommendation_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.recommendation_id_recommendation_seq', 1, false);


--
-- Name: referentiel_scientififque_id_reference_scientifique_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.referentiel_scientififque_id_reference_scientifique_seq', 1, false);


--
-- Name: rendez_vous_id_rendez_vous_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rendez_vous_id_rendez_vous_seq', 1, false);


--
-- Name: reponses_id_reponses_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reponses_id_reponses_seq', 1, false);


--
-- Name: resultat_parcours_id_resultat_parcours_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.resultat_parcours_id_resultat_parcours_seq', 1, false);


--
-- Name: service_id_service_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.service_id_service_seq', 1, false);


--
-- Name: specialites_id_specialites_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.specialites_id_specialites_seq', 1, false);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.utilisateur_id_utilisateur_seq', 92, true);


--
-- Name: a_des_etats a_des_etats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.a_des_etats
    ADD CONSTRAINT a_des_etats_pkey PRIMARY KEY (numero_dossier, id_jumeau_numerique);


--
-- Name: a_la_spécialite a_la_spécialite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."a_la_spécialite"
    ADD CONSTRAINT "a_la_spécialite_pkey" PRIMARY KEY (id_praticien, id_specialites);


--
-- Name: achete achete_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achete
    ADD CONSTRAINT achete_pkey PRIMARY KEY (numero_dossier, id_produits_bien_etre);


--
-- Name: admin admin_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- Name: agenda agenda_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda
    ADD CONSTRAINT agenda_pkey PRIMARY KEY (id_agenda);


--
-- Name: agenda_slots agenda_slots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_slots
    ADD CONSTRAINT agenda_slots_pkey PRIMARY KEY (id);


--
-- Name: alimente alimente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alimente
    ADD CONSTRAINT alimente_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_analyse_ia_);


--
-- Name: analyse_ia_ analyse_ia__pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.analyse_ia_
    ADD CONSTRAINT analyse_ia__pkey PRIMARY KEY (id_analyse_ia_);


--
-- Name: animer animer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.animer
    ADD CONSTRAINT animer_pkey PRIMARY KEY (id_praticien, id_conferences);


--
-- Name: ateliers ateliers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ateliers
    ADD CONSTRAINT ateliers_pkey PRIMARY KEY (id_ateliers);


--
-- Name: avis avis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_pkey PRIMARY KEY (id_praticien, numero_dossier, id_avis);


--
-- Name: bilan_suivi_patient bilan_suivi_patient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilan_suivi_patient
    ADD CONSTRAINT bilan_suivi_patient_pkey PRIMARY KEY (numero_dossier, id_bilan_suivi_patient);


--
-- Name: communaute communaute_nom_groupe_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communaute
    ADD CONSTRAINT communaute_nom_groupe_key UNIQUE (nom_groupe);


--
-- Name: communaute communaute_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communaute
    ADD CONSTRAINT communaute_pkey PRIMARY KEY (id_communaute);


--
-- Name: conferences conferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conferences
    ADD CONSTRAINT conferences_pkey PRIMARY KEY (id_conferences);


--
-- Name: consulte_intervient consulte_intervient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consulte_intervient
    ADD CONSTRAINT consulte_intervient_pkey PRIMARY KEY (id_praticien, numero_dossier, id_parcours_personnalises);


--
-- Name: consulte consulte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consulte
    ADD CONSTRAINT consulte_pkey PRIMARY KEY (numero_dossier, id_contenus_inspirants);


--
-- Name: contenus_inspirants contenus_inspirants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contenus_inspirants
    ADD CONSTRAINT contenus_inspirants_pkey PRIMARY KEY (id_contenus_inspirants);


--
-- Name: contient contient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contient
    ADD CONSTRAINT contient_pkey PRIMARY KEY (id_questionnaire, id_questions);


--
-- Name: contient_publication contient_publication_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contient_publication
    ADD CONSTRAINT contient_publication_pkey PRIMARY KEY (id_communaute, id_publication_communaute);


--
-- Name: contribue_consulte contribue_consulte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contribue_consulte
    ADD CONSTRAINT contribue_consulte_pkey PRIMARY KEY (id_praticien, id_reference_scientifique);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id_communaute, id_conversations);


--
-- Name: creneaux creneaux_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creneaux
    ADD CONSTRAINT creneaux_pkey PRIMARY KEY (id_creneau);


--
-- Name: email_verification_tokens email_verification_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT email_verification_tokens_pkey PRIMARY KEY (id);


--
-- Name: email_verification_tokens email_verification_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT email_verification_tokens_token_key UNIQUE (token);


--
-- Name: enrichit_bdd enrichit_bdd_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrichit_bdd
    ADD CONSTRAINT enrichit_bdd_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_reference_scientifique);


--
-- Name: enrichit enrichit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrichit
    ADD CONSTRAINT enrichit_pkey PRIMARY KEY (id_analyse_ia_, id_reference_scientifique);


--
-- Name: est_integree est_integree_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_integree
    ADD CONSTRAINT est_integree_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours, id_jumeau_numerique, id_recommendation);


--
-- Name: est_membre est_membre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_membre
    ADD CONSTRAINT est_membre_pkey PRIMARY KEY (id_utilisateur, id_communaute);


--
-- Name: est_sujet_de est_sujet_de_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_sujet_de
    ADD CONSTRAINT est_sujet_de_pkey PRIMARY KEY (id_questions, id_reponses, id_analyse_ia_);


--
-- Name: factures factures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factures
    ADD CONSTRAINT factures_pkey PRIMARY KEY (id_factures);


--
-- Name: historique_activite historique_activite_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historique_activite
    ADD CONSTRAINT historique_activite_pkey PRIMARY KEY (numero_dossier, id_historique_activite);


--
-- Name: jumeau_numerique jumeau_numerique_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jumeau_numerique
    ADD CONSTRAINT jumeau_numerique_pkey PRIMARY KEY (id_jumeau_numerique);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (numero_dossier, id_praticien, id_message);


--
-- Name: paiement paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paiement
    ADD CONSTRAINT paiement_pkey PRIMARY KEY (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous, id_paiement);


--
-- Name: parcours_personnalises parcours_personnalises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parcours_personnalises
    ADD CONSTRAINT parcours_personnalises_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises);


--
-- Name: participe participe_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participe
    ADD CONSTRAINT participe_pkey PRIMARY KEY (id_utilisateur, id_ateliers);


--
-- Name: participer participer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participer
    ADD CONSTRAINT participer_pkey PRIMARY KEY (id_utilisateur, id_communaute, id_conversations);


--
-- Name: patient patient_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (numero_dossier);


--
-- Name: patient_recoit patient_recoit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_recoit
    ADD CONSTRAINT patient_recoit_pkey PRIMARY KEY (numero_dossier, numero_dossier_1, id_praticien, id_message);


--
-- Name: patient_repond_a_ patient_repond_a__pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_repond_a_
    ADD CONSTRAINT patient_repond_a__pkey PRIMARY KEY (numero_dossier, id_questions, id_reponses);


--
-- Name: patient_repond_a patient_repond_a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_repond_a
    ADD CONSTRAINT patient_repond_a_pkey PRIMARY KEY (numero_dossier, id_questionnaire);


--
-- Name: poste poste_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_pkey PRIMARY KEY (id_utilisateur, id_publication_communaute);


--
-- Name: praticien_consulte praticien_consulte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien_consulte
    ADD CONSTRAINT praticien_consulte_pkey PRIMARY KEY (id_praticien, numero_dossier, id_bilan_suivi_patient);


--
-- Name: praticien praticien_id_utilisateur_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien
    ADD CONSTRAINT praticien_id_utilisateur_key UNIQUE (id_utilisateur);


--
-- Name: praticien praticien_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien
    ADD CONSTRAINT praticien_pkey PRIMARY KEY (id_praticien);


--
-- Name: praticien_recoit praticien_recoit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien_recoit
    ADD CONSTRAINT praticien_recoit_pkey PRIMARY KEY (id_praticien, numero_dossier, id_praticien_1, id_message);


--
-- Name: praticien_repond_a praticien_repond_a_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien_repond_a
    ADD CONSTRAINT praticien_repond_a_pkey PRIMARY KEY (id_questionnaire, id_praticien);


--
-- Name: produits_bien_etre produits_bien_etre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produits_bien_etre
    ADD CONSTRAINT produits_bien_etre_pkey PRIMARY KEY (id_produits_bien_etre);


--
-- Name: publication_communaute publication_communaute_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publication_communaute
    ADD CONSTRAINT publication_communaute_pkey PRIMARY KEY (id_publication_communaute);


--
-- Name: publie publie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publie
    ADD CONSTRAINT publie_pkey PRIMARY KEY (id_praticien, id_contenus_inspirants);


--
-- Name: questionnaire questionnaire_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questionnaire
    ADD CONSTRAINT questionnaire_pkey PRIMARY KEY (id_questionnaire);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id_questions);


--
-- Name: recoit recoit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recoit
    ADD CONSTRAINT recoit_pkey PRIMARY KEY (numero_dossier, id_jumeau_numerique, id_recommendation);


--
-- Name: recommande recommande_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommande
    ADD CONSTRAINT recommande_pkey PRIMARY KEY (id_analyse_ia_, id_jumeau_numerique, id_recommendation);


--
-- Name: recommendation recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_pkey PRIMARY KEY (id_jumeau_numerique, id_recommendation);


--
-- Name: referentiel_scientififque referentiel_scientififque_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referentiel_scientififque
    ADD CONSTRAINT referentiel_scientififque_pkey PRIMARY KEY (id_reference_scientifique);


--
-- Name: rendez_vous rendez_vous_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rendez_vous
    ADD CONSTRAINT rendez_vous_pkey PRIMARY KEY (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous);


--
-- Name: reponses reponses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reponses
    ADD CONSTRAINT reponses_pkey PRIMARY KEY (id_questions, id_reponses);


--
-- Name: resultat_parcours resultat_parcours_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resultat_parcours
    ADD CONSTRAINT resultat_parcours_pkey PRIMARY KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id_praticien, id_service);


--
-- Name: specialites specialites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.specialites
    ADD CONSTRAINT specialites_pkey PRIMARY KEY (id_specialites);


--
-- Name: user_email_verifications user_email_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_email_verifications
    ADD CONSTRAINT user_email_verifications_pkey PRIMARY KEY (token);


--
-- Name: utilisateur utilisateur_mail_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_mail_key UNIQUE (mail);


--
-- Name: utilisateur utilisateur_mail_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_mail_unique UNIQUE (mail);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id_utilisateur);


--
-- Name: email_verif_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX email_verif_idx ON public.email_verification_tokens USING btree (id_utilisateur);


--
-- Name: idx_commune_cp; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commune_cp ON public.commune USING btree (code_postal);


--
-- Name: idx_commune_nom; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commune_nom ON public.commune USING gin (to_tsvector('simple'::regconfig, nom_commune));


--
-- Name: idx_commune_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_commune_trgm ON public.commune USING gin (nom_commune public.gin_trgm_ops);


--
-- Name: idx_praticien_adresse_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_adresse_trgm ON public.praticien USING gin (adresse_cabinet public.gin_trgm_ops);


--
-- Name: idx_praticien_code_postal; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_code_postal ON public.praticien USING btree (code_postal);


--
-- Name: idx_praticien_mode_consultation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_mode_consultation ON public.praticien USING btree (mode_consultation);


--
-- Name: idx_praticien_specialites_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_specialites_trgm ON public.praticien USING gin (specialites public.gin_trgm_ops);


--
-- Name: idx_praticien_statut_validation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_statut_validation ON public.praticien USING btree (statut_validation);


--
-- Name: idx_praticien_type_approche_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_type_approche_trgm ON public.praticien USING gin (type_approche public.gin_trgm_ops);


--
-- Name: idx_praticien_ville; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_praticien_ville ON public.praticien USING btree (ville);


--
-- Name: idx_slots_praticien_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_slots_praticien_date ON public.agenda_slots USING btree (praticien_id, date);


--
-- Name: idx_uem_expires; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_uem_expires ON public.user_email_verifications USING btree (expires_at);


--
-- Name: idx_uem_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_uem_user ON public.user_email_verifications USING btree (user_id);


--
-- Name: uq_slots_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uq_slots_unique ON public.agenda_slots USING btree (praticien_id, date, start_time, end_time, status);


--
-- Name: a_des_etats a_des_etats_id_jumeau_numerique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.a_des_etats
    ADD CONSTRAINT a_des_etats_id_jumeau_numerique_fkey FOREIGN KEY (id_jumeau_numerique) REFERENCES public.jumeau_numerique(id_jumeau_numerique);


--
-- Name: a_des_etats a_des_etats_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.a_des_etats
    ADD CONSTRAINT a_des_etats_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: a_la_spécialite a_la_spécialite_id_specialites_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."a_la_spécialite"
    ADD CONSTRAINT "a_la_spécialite_id_specialites_fkey" FOREIGN KEY (id_specialites) REFERENCES public.specialites(id_specialites);


--
-- Name: achete achete_id_produits_bien_etre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achete
    ADD CONSTRAINT achete_id_produits_bien_etre_fkey FOREIGN KEY (id_produits_bien_etre) REFERENCES public.produits_bien_etre(id_produits_bien_etre);


--
-- Name: achete achete_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achete
    ADD CONSTRAINT achete_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: admin admin_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: agenda agenda_id_praticien_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda
    ADD CONSTRAINT agenda_id_praticien_fkey FOREIGN KEY (id_praticien) REFERENCES public.praticien(id_praticien) ON DELETE CASCADE;


--
-- Name: alimente alimente_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alimente
    ADD CONSTRAINT alimente_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- Name: alimente alimente_numero_dossier_id_parcours_personnalises_id_resul_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.alimente
    ADD CONSTRAINT alimente_numero_dossier_id_parcours_personnalises_id_resul_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours) REFERENCES public.resultat_parcours(numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- Name: animer animer_id_conferences_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.animer
    ADD CONSTRAINT animer_id_conferences_fkey FOREIGN KEY (id_conferences) REFERENCES public.conferences(id_conferences);


--
-- Name: avis avis_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.avis
    ADD CONSTRAINT avis_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: bilan_suivi_patient bilan_suivi_patient_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bilan_suivi_patient
    ADD CONSTRAINT bilan_suivi_patient_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: consulte consulte_id_contenus_inspirants_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consulte
    ADD CONSTRAINT consulte_id_contenus_inspirants_fkey FOREIGN KEY (id_contenus_inspirants) REFERENCES public.contenus_inspirants(id_contenus_inspirants);


--
-- Name: consulte_intervient consulte_intervient_numero_dossier_id_parcours_personnalis_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consulte_intervient
    ADD CONSTRAINT consulte_intervient_numero_dossier_id_parcours_personnalis_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises) REFERENCES public.parcours_personnalises(numero_dossier, id_parcours_personnalises);


--
-- Name: consulte consulte_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.consulte
    ADD CONSTRAINT consulte_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: contient contient_id_questionnaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contient
    ADD CONSTRAINT contient_id_questionnaire_fkey FOREIGN KEY (id_questionnaire) REFERENCES public.questionnaire(id_questionnaire);


--
-- Name: contient contient_id_questions_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contient
    ADD CONSTRAINT contient_id_questions_fkey FOREIGN KEY (id_questions) REFERENCES public.questions(id_questions);


--
-- Name: contient_publication contient_publication_id_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contient_publication
    ADD CONSTRAINT contient_publication_id_communaute_fkey FOREIGN KEY (id_communaute) REFERENCES public.communaute(id_communaute);


--
-- Name: contient_publication contient_publication_id_publication_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contient_publication
    ADD CONSTRAINT contient_publication_id_publication_communaute_fkey FOREIGN KEY (id_publication_communaute) REFERENCES public.publication_communaute(id_publication_communaute);


--
-- Name: contribue_consulte contribue_consulte_id_reference_scientifique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contribue_consulte
    ADD CONSTRAINT contribue_consulte_id_reference_scientifique_fkey FOREIGN KEY (id_reference_scientifique) REFERENCES public.referentiel_scientififque(id_reference_scientifique);


--
-- Name: conversations conversations_id_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_id_communaute_fkey FOREIGN KEY (id_communaute) REFERENCES public.communaute(id_communaute);


--
-- Name: creneaux creneaux_id_agenda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.creneaux
    ADD CONSTRAINT creneaux_id_agenda_fkey FOREIGN KEY (id_agenda) REFERENCES public.agenda(id_agenda) ON DELETE CASCADE;


--
-- Name: email_verification_tokens email_verification_tokens_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_verification_tokens
    ADD CONSTRAINT email_verification_tokens_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur) ON DELETE CASCADE;


--
-- Name: enrichit_bdd enrichit_bdd_id_reference_scientifique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrichit_bdd
    ADD CONSTRAINT enrichit_bdd_id_reference_scientifique_fkey FOREIGN KEY (id_reference_scientifique) REFERENCES public.referentiel_scientififque(id_reference_scientifique);


--
-- Name: enrichit_bdd enrichit_bdd_numero_dossier_id_parcours_personnalises_id_r_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrichit_bdd
    ADD CONSTRAINT enrichit_bdd_numero_dossier_id_parcours_personnalises_id_r_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours) REFERENCES public.resultat_parcours(numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- Name: enrichit enrichit_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrichit
    ADD CONSTRAINT enrichit_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- Name: enrichit enrichit_id_reference_scientifique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrichit
    ADD CONSTRAINT enrichit_id_reference_scientifique_fkey FOREIGN KEY (id_reference_scientifique) REFERENCES public.referentiel_scientififque(id_reference_scientifique);


--
-- Name: est_integree est_integree_id_jumeau_numerique_id_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_integree
    ADD CONSTRAINT est_integree_id_jumeau_numerique_id_recommendation_fkey FOREIGN KEY (id_jumeau_numerique, id_recommendation) REFERENCES public.recommendation(id_jumeau_numerique, id_recommendation);


--
-- Name: est_integree est_integree_numero_dossier_id_parcours_personnalises_id_r_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_integree
    ADD CONSTRAINT est_integree_numero_dossier_id_parcours_personnalises_id_r_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises, id_resultat_parcours) REFERENCES public.resultat_parcours(numero_dossier, id_parcours_personnalises, id_resultat_parcours);


--
-- Name: est_membre est_membre_id_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_membre
    ADD CONSTRAINT est_membre_id_communaute_fkey FOREIGN KEY (id_communaute) REFERENCES public.communaute(id_communaute);


--
-- Name: est_membre est_membre_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_membre
    ADD CONSTRAINT est_membre_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: est_sujet_de est_sujet_de_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_sujet_de
    ADD CONSTRAINT est_sujet_de_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- Name: est_sujet_de est_sujet_de_id_questions_id_reponses_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.est_sujet_de
    ADD CONSTRAINT est_sujet_de_id_questions_id_reponses_fkey FOREIGN KEY (id_questions, id_reponses) REFERENCES public.reponses(id_questions, id_reponses);


--
-- Name: factures factures_numero_dossier_1_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.factures
    ADD CONSTRAINT factures_numero_dossier_1_fkey FOREIGN KEY (numero_dossier_1) REFERENCES public.patient(numero_dossier);


--
-- Name: historique_activite historique_activite_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.historique_activite
    ADD CONSTRAINT historique_activite_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: message message_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: paiement paiement_id_praticien_id_praticien_1_id_service_numero_dos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paiement
    ADD CONSTRAINT paiement_id_praticien_id_praticien_1_id_service_numero_dos_fkey FOREIGN KEY (id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous) REFERENCES public.rendez_vous(id_praticien, id_praticien_1, id_service, numero_dossier, id_rendez_vous);


--
-- Name: parcours_personnalises parcours_personnalises_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parcours_personnalises
    ADD CONSTRAINT parcours_personnalises_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: participe participe_id_ateliers_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participe
    ADD CONSTRAINT participe_id_ateliers_fkey FOREIGN KEY (id_ateliers) REFERENCES public.ateliers(id_ateliers);


--
-- Name: participe participe_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participe
    ADD CONSTRAINT participe_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: participer participer_id_communaute_id_conversations_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participer
    ADD CONSTRAINT participer_id_communaute_id_conversations_fkey FOREIGN KEY (id_communaute, id_conversations) REFERENCES public.conversations(id_communaute, id_conversations);


--
-- Name: participer participer_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participer
    ADD CONSTRAINT participer_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: patient patient_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: patient_recoit patient_recoit_numero_dossier_1_id_praticien_id_message_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_recoit
    ADD CONSTRAINT patient_recoit_numero_dossier_1_id_praticien_id_message_fkey FOREIGN KEY (numero_dossier_1, id_praticien, id_message) REFERENCES public.message(numero_dossier, id_praticien, id_message);


--
-- Name: patient_recoit patient_recoit_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_recoit
    ADD CONSTRAINT patient_recoit_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: patient_repond_a_ patient_repond_a__id_questions_id_reponses_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_repond_a_
    ADD CONSTRAINT patient_repond_a__id_questions_id_reponses_fkey FOREIGN KEY (id_questions, id_reponses) REFERENCES public.reponses(id_questions, id_reponses);


--
-- Name: patient_repond_a_ patient_repond_a__numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_repond_a_
    ADD CONSTRAINT patient_repond_a__numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: patient_repond_a patient_repond_a_id_questionnaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_repond_a
    ADD CONSTRAINT patient_repond_a_id_questionnaire_fkey FOREIGN KEY (id_questionnaire) REFERENCES public.questionnaire(id_questionnaire);


--
-- Name: patient_repond_a patient_repond_a_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_repond_a
    ADD CONSTRAINT patient_repond_a_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: poste poste_id_publication_communaute_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_id_publication_communaute_fkey FOREIGN KEY (id_publication_communaute) REFERENCES public.publication_communaute(id_publication_communaute);


--
-- Name: poste poste_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.poste
    ADD CONSTRAINT poste_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: praticien_consulte praticien_consulte_numero_dossier_id_bilan_suivi_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien_consulte
    ADD CONSTRAINT praticien_consulte_numero_dossier_id_bilan_suivi_patient_fkey FOREIGN KEY (numero_dossier, id_bilan_suivi_patient) REFERENCES public.bilan_suivi_patient(numero_dossier, id_bilan_suivi_patient);


--
-- Name: praticien praticien_id_utilisateur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien
    ADD CONSTRAINT praticien_id_utilisateur_fkey FOREIGN KEY (id_utilisateur) REFERENCES public.utilisateur(id_utilisateur);


--
-- Name: praticien_recoit praticien_recoit_numero_dossier_id_praticien_1_id_message_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien_recoit
    ADD CONSTRAINT praticien_recoit_numero_dossier_id_praticien_1_id_message_fkey FOREIGN KEY (numero_dossier, id_praticien_1, id_message) REFERENCES public.message(numero_dossier, id_praticien, id_message);


--
-- Name: praticien_repond_a praticien_repond_a_id_questionnaire_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.praticien_repond_a
    ADD CONSTRAINT praticien_repond_a_id_questionnaire_fkey FOREIGN KEY (id_questionnaire) REFERENCES public.questionnaire(id_questionnaire);


--
-- Name: publie publie_id_contenus_inspirants_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publie
    ADD CONSTRAINT publie_id_contenus_inspirants_fkey FOREIGN KEY (id_contenus_inspirants) REFERENCES public.contenus_inspirants(id_contenus_inspirants);


--
-- Name: recoit recoit_id_jumeau_numerique_id_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recoit
    ADD CONSTRAINT recoit_id_jumeau_numerique_id_recommendation_fkey FOREIGN KEY (id_jumeau_numerique, id_recommendation) REFERENCES public.recommendation(id_jumeau_numerique, id_recommendation);


--
-- Name: recoit recoit_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recoit
    ADD CONSTRAINT recoit_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: recommande recommande_id_analyse_ia__fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommande
    ADD CONSTRAINT recommande_id_analyse_ia__fkey FOREIGN KEY (id_analyse_ia_) REFERENCES public.analyse_ia_(id_analyse_ia_);


--
-- Name: recommande recommande_id_jumeau_numerique_id_recommendation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommande
    ADD CONSTRAINT recommande_id_jumeau_numerique_id_recommendation_fkey FOREIGN KEY (id_jumeau_numerique, id_recommendation) REFERENCES public.recommendation(id_jumeau_numerique, id_recommendation);


--
-- Name: recommendation recommendation_id_jumeau_numerique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recommendation
    ADD CONSTRAINT recommendation_id_jumeau_numerique_fkey FOREIGN KEY (id_jumeau_numerique) REFERENCES public.jumeau_numerique(id_jumeau_numerique);


--
-- Name: rendez_vous rendez_vous_id_praticien_1_id_service_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rendez_vous
    ADD CONSTRAINT rendez_vous_id_praticien_1_id_service_fkey FOREIGN KEY (id_praticien_1, id_service) REFERENCES public.service(id_praticien, id_service);


--
-- Name: rendez_vous rendez_vous_numero_dossier_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rendez_vous
    ADD CONSTRAINT rendez_vous_numero_dossier_fkey FOREIGN KEY (numero_dossier) REFERENCES public.patient(numero_dossier);


--
-- Name: reponses reponses_id_questions_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reponses
    ADD CONSTRAINT reponses_id_questions_fkey FOREIGN KEY (id_questions) REFERENCES public.questions(id_questions);


--
-- Name: resultat_parcours resultat_parcours_numero_dossier_id_parcours_personnalises_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resultat_parcours
    ADD CONSTRAINT resultat_parcours_numero_dossier_id_parcours_personnalises_fkey FOREIGN KEY (numero_dossier, id_parcours_personnalises) REFERENCES public.parcours_personnalises(numero_dossier, id_parcours_personnalises);


--
-- Name: user_email_verifications user_email_verifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_email_verifications
    ADD CONSTRAINT user_email_verifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.utilisateur(id_utilisateur) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

