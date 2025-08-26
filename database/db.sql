CREATE TABLE QUESTIONNAIRE (
   Id_QUESTIONNAIRE SERIAL PRIMARY KEY,
   description VARCHAR(200),
   type_cible VARCHAR(50),
   nom_questionnaire VARCHAR(100),
   date_creation DATE,
   date_derniere_maj TIMESTAMP
);

CREATE TABLE Utilisateur (
   Id_Utilisateur SERIAL PRIMARY KEY,
   mail VARCHAR(50) NOT NULL UNIQUE,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   date_inscription DATE,
   derniere_connexion TIMESTAMP,
   role_utilisateur VARCHAR(50),
   statut_compte VARCHAR(50),
   mot_de_passe VARCHAR(255) NOT NULL,
   consentement_cgu BOOLEAN NOT NULL,
   consentement_partage_donnees_sante BOOLEAN NOT NULL,
   preferences_notifications VARCHAR(50),
   telephone VARCHAR(20)
);

CREATE TABLE PRATICIEN (
   Id_PRATICIEN SERIAL PRIMARY KEY,
   mode_consultation VARCHAR(50),
   adresse_cabinet VARCHAR(50),
   diplomes VARCHAR(50),
   description VARCHAR(200),
   annees_experience SMALLINT,
   tarifs_consultation DOUBLE PRECISION,
   photo_profil_url VARCHAR(50),
   taux_satisfaction DECIMAL(4,2),
   statut_validation VARCHAR(50),
   Id_Utilisateur INT NOT NULL UNIQUE,
   FOREIGN KEY (Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur)
);

CREATE TABLE QUESTIONS (
   Id_QUESTIONS SERIAL PRIMARY KEY,
   texte_question VARCHAR(200),
   type_reponses VARCHAR(50),
   categorie_question VARCHAR(50)
);

CREATE TABLE REPONSES (
   Id_QUESTIONS INT NOT NULL,
   Id_REPONSES SERIAL,
   contenu_reponse VARCHAR(200),
   date_reponse TIMESTAMP,
   PRIMARY KEY (Id_QUESTIONS, Id_REPONSES),
   FOREIGN KEY (Id_QUESTIONS) REFERENCES QUESTIONS(Id_QUESTIONS)
);

CREATE TABLE SPECIALITES (
   Id_SPECIALITES SERIAL PRIMARY KEY,
   nom_specialite VARCHAR(50),
   description VARCHAR(300)
);

CREATE TABLE SERVICE (
   Id_PRATICIEN INT NOT NULL,
   Id_SERVICE SERIAL,
   description_service VARCHAR(500),
   nom_service VARCHAR(50),
   tarif VARCHAR(50),
   type_service VARCHAR(50),
   duree TIME,
   PRIMARY KEY (Id_PRATICIEN, Id_SERVICE),
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE PRODUITS_BIEN_ETRE (
   Id_PRODUITS_BIEN_ETRE SERIAL PRIMARY KEY,
   prix DOUBLE PRECISION,
   nom_produit VARCHAR(50),
   description VARCHAR(300),
   stock BIGINT,
   url_image VARCHAR(50),
   categorie VARCHAR(50),
   Id_PRATICIEN INT NOT NULL,
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE CONTENUS_INSPIRANTS (
   Id_CONTENUS_INSPIRANTS SERIAL PRIMARY KEY,
   titre VARCHAR(50),
   description_courte VARCHAR(200),
   auteur VARCHAR(50),
   categorie VARCHAR(50),
   type_contenu VARCHAR(50),
   date_publication TIMESTAMP
);

CREATE TABLE JUMEAU_NUMERIQUE (
   Id_JUMEAU_NUMERIQUE SERIAL PRIMARY KEY,
   date_heure TIMESTAMP,
   donnees_energie VARCHAR(255),
   resume_dynamique VARCHAR(50),
   donnees_corporelles VARCHAR(50),
   donnees_emotionnelles VARCHAR(50)
);

CREATE TABLE Analyse_IA (
   Id_Analyse_IA SERIAL PRIMARY KEY,
   version_modele DECIMAL(2,1),
   statut_validation VARCHAR(50),
   resultats VARCHAR(2000),
   date_analyse TIMESTAMP,
   type_analyse VARCHAR(50)
);

CREATE TABLE REFERENTIEL_SCIENTIFIQUE (
   id_reference_scientifique SERIAL PRIMARY KEY,
   titre VARCHAR(50),
   description_courte VARCHAR(200),
   type_element VARCHAR(50),
   contenu_detaille VARCHAR(50),
   auteur_source VARCHAR(50),
   date_publication_initiale DATE,
   date_derniere_mise_a_jour DATE,
   mots_cles VARCHAR(600),
   est_valide_par_expert BOOLEAN,
   url_lien VARCHAR(255)
);

CREATE TABLE RECOMMENDATION (
   Id_JUMEAU_NUMERIQUE INT NOT NULL,
   Id_RECOMMENDATION SERIAL,
   type_recommandation VARCHAR(300),
   impact_prevu_jumeau VARCHAR(500),
   statut_recommandation VARCHAR(50),
   date_emission DATE,
   texte_recommandation VARCHAR(2000),
   PRIMARY KEY (Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION),
   FOREIGN KEY (Id_JUMEAU_NUMERIQUE) REFERENCES JUMEAU_NUMERIQUE(Id_JUMEAU_NUMERIQUE)
);

CREATE TABLE COMMUNAUTE (
   Id_COMMUNAUTE SERIAL PRIMARY KEY,
   nom_groupe VARCHAR(50) UNIQUE,
   description_groupe VARCHAR(1000),
   date_creation DATE,
   est_anonyme BOOLEAN
);

CREATE TABLE PUBLICATION_COMMUNAUTE (
   Id_PUBLICATION_COMMUNAUTE SERIAL PRIMARY KEY,
   contenu_texte VARCHAR(1000),
   url_piece_jointe VARCHAR(50),
   type_publication VARCHAR(50),
   est_epingle BOOLEAN,
   date_publication TIMESTAMP
);

CREATE TABLE ATELIERS (
   Id_ATELIERS SERIAL PRIMARY KEY,
   nom_activite VARCHAR(255) NOT NULL,
   description_activite VARCHAR(1000),
   thematique VARCHAR(100),
   capacite_max INT,
   tarif DECIMAL(15,2),
   date_debut TIMESTAMP NOT NULL,
   date_fin TIMESTAMP NOT NULL,
   url_visio VARCHAR(255),
   adresse_presentiel VARCHAR(255),
   est_gratuit BOOLEAN,
   est_enregistre BOOLEAN,
   statut_activite VARCHAR(50)
);

CREATE TABLE CONFERENCES (
   Id_CONFERENCES SERIAL PRIMARY KEY,
   capacite_max INT,
   statut_conference VARCHAR(50),
   titre VARCHAR(255) NOT NULL,
   resume_conference VARCHAR(1000),
   thematique VARCHAR(100),
   duree_prevu_minutes INT,
   date_heure_debut TIMESTAMP,
   date_heure_fin TIMESTAMP,
   url_visio VARCHAR(255),
   tarif DECIMAL(15,2)
);

CREATE TABLE CONVERSATIONS (
   Id_COMMUNAUTE INT NOT NULL,
   Id_CONVERSATIONS SERIAL,
   contenu_message VARCHAR(1000) NOT NULL,
   est_lu BOOLEAN DEFAULT FALSE,
   type_message VARCHAR(50),
   url_fichier_joint VARCHAR(255),
   PRIMARY KEY (Id_COMMUNAUTE, Id_CONVERSATIONS),
   FOREIGN KEY (Id_COMMUNAUTE) REFERENCES COMMUNAUTE(Id_COMMUNAUTE)
);

CREATE TABLE Patient (
   numero_dossier SERIAL PRIMARY KEY,
   adresse VARCHAR(50),
   date_de_naissance TIMESTAMP NOT NULL,
   genre VARCHAR(50) NOT NULL,
   date_inscription DATE NOT NULL,
   derniere_connexion TIMESTAMP NOT NULL,
   situation_pro VARCHAR(100),
   origine_ethnique VARCHAR(100),
   environnement_vie VARCHAR(255),
   habitudes VARCHAR(500),
   rythme_quotidien VARCHAR(500),
   type_activite_physique VARCHAR(500),
   frequence_activite_physique VARCHAR(50),
   type_alimentation VARCHAR(500),
   consommation_substances VARCHAR(500),
   niveau_energie_moyen SMALLINT,
   gestion_emotionnelle_actuelle VARCHAR(500),
   interet_spiritualite VARCHAR(50),
   suivi_progres_actuel VARCHAR(50),
   type_accompagnement_souhaite VARCHAR(50),
   autorisation_mise_en_lien_therapeutes BOOLEAN,
   frequence_rappels_souhaitee VARCHAR(50),
   nom_jumeau_numerique VARCHAR(100),
   design_jumeau_numerique VARCHAR(100),
   qualite_environnement_vie_choix VARCHAR(100),
   Id_Utilisateur INT NOT NULL UNIQUE,
   FOREIGN KEY (Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur)
);

CREATE TABLE RENDEZ_VOUS(
   Id_PRATICIEN INT,
   Id_PRATICIEN_1 INT,
   Id_SERVICE INT,
   numero_dossier INT,
   Id_RENDEZ_VOUS SERIAL,
   date_heure_debut TIMESTAMP,
   date_heure_fin TIMESTAMP,
   statut_rdv VARCHAR(50),
   mode_paiement VARCHAR(50),
   recommandations_post_seance VARCHAR(500),
   mode_rdv VARCHAR(50),
   lien_visio VARCHAR(255),
   PRIMARY KEY(Id_PRATICIEN, Id_PRATICIEN_1, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(Id_PRATICIEN_1, Id_SERVICE) REFERENCES SERVICE(Id_PRATICIEN, Id_SERVICE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier)
);

CREATE TABLE MESSAGE(
   numero_dossier INT,
   Id_PRATICIEN INT,
   Id_MESSAGE SERIAL,
   sujet VARCHAR(50),
   date_heure_envoie TIMESTAMP,
   lu BOOLEAN,
   type_message VARCHAR(50),
   PRIMARY KEY(numero_dossier, Id_PRATICIEN, Id_MESSAGE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE AVIS(
   Id_PRATICIEN INT,
   numero_dossier INT,
   Id_AVIS SERIAL,
   note SMALLINT,
   commentaire VARCHAR(300),
   date_avis TIMESTAMP,
   PRIMARY KEY(Id_PRATICIEN, numero_dossier, Id_AVIS),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier)
);

CREATE TABLE parcours_personnalises(
   numero_dossier INT,
   Id_parcours_personnalises SERIAL,
   date_creation DATE,
   date_derniere_maj DATE,
   statut VARCHAR(50),
   objectif_principal VARCHAR(50),
   PRIMARY KEY(numero_dossier, Id_parcours_personnalises),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier)
);

CREATE TABLE RESULTAT_PARCOURS(
   numero_dossier INT,
   Id_parcours_personnalises INT,
   Id_RESULTAT_PARCOURS SERIAL,
   date_cible DATE,
   description VARCHAR(200),
   statut_etape VARCHAR(50),
   type_etape VARCHAR(50),
   PRIMARY KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS),
   FOREIGN KEY(numero_dossier, Id_parcours_personnalises) REFERENCES parcours_personnalises(numero_dossier, Id_parcours_personnalises)
);

CREATE TABLE BILAN_SUIVI_PATIENT(
   numero_dossier INT,
   Id_BILAN_SUIVI_PATIENT SERIAL,
   date_bilan DATE,
   rapport_ia VARCHAR(1000),
   retours VARCHAR(50),
   courbes_suivi_progres REAL,
   kpi_quantitatifs VARCHAR(50),
   date_debut_periode TIMESTAMP,
   date_fin_periode TIMESTAMP,
   est_exportable BOOLEAN,
   PRIMARY KEY(numero_dossier, Id_BILAN_SUIVI_PATIENT),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier)
);

CREATE TABLE HISTORIQUE_ACTIVITE(
   numero_dossier INT,
   Id_HISTORIQUE_ACTIVITE SERIAL,
   date_heure_activite TIMESTAMP,
   type_activite VARCHAR(50),
   source_activite VARCHAR(50),
   PRIMARY KEY(numero_dossier, Id_HISTORIQUE_ACTIVITE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier)
);

CREATE TABLE PAIEMENT(
   Id_PRATICIEN INT,
   Id_PRATICIEN_1 INT,
   Id_PRATICIEN_2 INT,
   Id_SERVICE INT,
   numero_dossier INT,
   Id_RENDEZ_VOUS INT,
   numero_dossier_1 INT,
   Id_PAIEMENT SERIAL,
   montant DOUBLE PRECISION NOT NULL,
   mode_paiement VARCHAR(50),
   date_paiement TIMESTAMP NOT NULL,
   statut_paiement VARCHAR(50),
   reference_transaction VARCHAR(50),
   PRIMARY KEY(Id_PRATICIEN, Id_PRATICIEN_1, Id_PRATICIEN_2, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS, numero_dossier_1, Id_PAIEMENT),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(Id_PRATICIEN_1, Id_PRATICIEN_2, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS) REFERENCES RENDEZ_VOUS(Id_PRATICIEN, Id_PRATICIEN_1, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS),
   FOREIGN KEY(numero_dossier_1) REFERENCES Patient(numero_dossier)
);

CREATE TABLE FACTURES(
   Id_FACTURES SERIAL PRIMARY KEY,
   date_facture TIMESTAMP NOT NULL,
   montant_total DECIMAL(10,2) NOT NULL,
   url_pdf VARCHAR(255),
   numero_dossier INT NOT NULL,
   Id_PRATICIEN INT NOT NULL,
   Id_PRATICIEN_1 INT,
   Id_PRATICIEN_2 INT,
   Id_PRATICIEN_3 INT,
   Id_SERVICE INT,
   numero_dossier_1 INT,
   Id_RENDEZ_VOUS INT,
   numero_dossier_2 INT,
   Id_PAIEMENT INT,
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_PRATICIEN_1, Id_PRATICIEN_2, Id_PRATICIEN_3, Id_SERVICE, numero_dossier_1, Id_RENDEZ_VOUS, numero_dossier_2, Id_PAIEMENT)
       REFERENCES PAIEMENT(Id_PRATICIEN, Id_PRATICIEN_1, Id_PRATICIEN_2, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS, numero_dossier_1, Id_PAIEMENT)
);

CREATE TABLE contient(
   Id_QUESTIONNAIRE INT,
   Id_QUESTIONS INT,
   PRIMARY KEY(Id_QUESTIONNAIRE, Id_QUESTIONS),
   FOREIGN KEY(Id_QUESTIONNAIRE) REFERENCES QUESTIONNAIRE(Id_QUESTIONNAIRE),
   FOREIGN KEY(Id_QUESTIONS) REFERENCES QUESTIONS(Id_QUESTIONS)
);

CREATE TABLE patient_repond_a(
   numero_dossier INT,
   Id_QUESTIONNAIRE INT,
   est_repondu BOOLEAN,
   PRIMARY KEY(numero_dossier, Id_QUESTIONNAIRE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_QUESTIONNAIRE) REFERENCES QUESTIONNAIRE(Id_QUESTIONNAIRE)
);

CREATE TABLE praticien_repond_a(
   Id_QUESTIONNAIRE INT,
   Id_PRATICIEN INT,
   PRIMARY KEY(Id_QUESTIONNAIRE, Id_PRATICIEN),
   FOREIGN KEY(Id_QUESTIONNAIRE) REFERENCES QUESTIONNAIRE(Id_QUESTIONNAIRE),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE patient_repond(
   numero_dossier INT,
   Id_QUESTIONS INT,
   Id_REPONSES INT,
   PRIMARY KEY(numero_dossier, Id_QUESTIONS, Id_REPONSES),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_QUESTIONS, Id_REPONSES) REFERENCES REPONSES(Id_QUESTIONS, Id_REPONSES)
);

CREATE TABLE a_la_specialite(
   Id_PRATICIEN INT,
   Id_SPECIALITES INT,
   PRIMARY KEY(Id_PRATICIEN, Id_SPECIALITES),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(Id_SPECIALITES) REFERENCES SPECIALITES(Id_SPECIALITES)
);

CREATE TABLE achete(
   numero_dossier INT,
   Id_PRODUITS_BIEN_ETRE INT,
   PRIMARY KEY(numero_dossier, Id_PRODUITS_BIEN_ETRE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_PRODUITS_BIEN_ETRE) REFERENCES PRODUITS_BIEN_ETRE(Id_PRODUITS_BIEN_ETRE)
);

CREATE TABLE consulte(
   numero_dossier INT,
   Id_CONTENUS_INSPIRANTS INT,
   PRIMARY KEY(numero_dossier, Id_CONTENUS_INSPIRANTS),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_CONTENUS_INSPIRANTS) REFERENCES CONTENUS_INSPIRANTS(Id_CONTENUS_INSPIRANTS)
);

CREATE TABLE publie(
   Id_PRATICIEN INT,
   Id_CONTENUS_INSPIRANTS INT,
   PRIMARY KEY(Id_PRATICIEN, Id_CONTENUS_INSPIRANTS),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(Id_CONTENUS_INSPIRANTS) REFERENCES CONTENUS_INSPIRANTS(Id_CONTENUS_INSPIRANTS)
);

CREATE TABLE praticien_consulte(
   Id_PRATICIEN INT,
   numero_dossier INT,
   Id_BILAN_SUIVI_PATIENT INT,
   PRIMARY KEY(Id_PRATICIEN, numero_dossier, Id_BILAN_SUIVI_PATIENT),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(numero_dossier, Id_BILAN_SUIVI_PATIENT) REFERENCES BILAN_SUIVI_PATIENT(numero_dossier, Id_BILAN_SUIVI_PATIENT)
);

CREATE TABLE a_des_etats(
   numero_dossier INT,
   Id_JUMEAU_NUMERIQUE INT,
   PRIMARY KEY(numero_dossier, Id_JUMEAU_NUMERIQUE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_JUMEAU_NUMERIQUE) REFERENCES JUMEAU_NUMERIQUE(Id_JUMEAU_NUMERIQUE)
);

CREATE TABLE alimente(
   numero_dossier INT,
   Id_parcours_personnalises INT,
   Id_RESULTAT_PARCOURS INT,
   Id_Analyse_IA INT,
   modele_ia VARCHAR(50),
   PRIMARY KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS, Id_Analyse_IA),
   FOREIGN KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS) REFERENCES RESULTAT_PARCOURS(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS),
   FOREIGN KEY(Id_Analyse_IA) REFERENCES Analyse_IA(Id_Analyse_IA)
);

CREATE TABLE est_sujet_de(
   Id_QUESTIONS INT,
   Id_REPONSES INT,
   Id_Analyse_IA INT,
   PRIMARY KEY(Id_QUESTIONS, Id_REPONSES, Id_Analyse_IA),
   FOREIGN KEY(Id_QUESTIONS, Id_REPONSES) REFERENCES REPONSES(Id_QUESTIONS, Id_REPONSES),
   FOREIGN KEY(Id_Analyse_IA) REFERENCES Analyse_IA(Id_Analyse_IA)
);
CREATE TABLE RENDEZ_VOUS (
   Id_RENDEZ_VOUS SERIAL PRIMARY KEY,
   Id_PRATICIEN INT NOT NULL,
   Id_SERVICE INT NOT NULL,
   numéro_dossier INT NOT NULL,
   date_heure_debut TIMESTAMP,
   date_heure_fin TIMESTAMP,
   statut_rdv VARCHAR(50),
   mode_paiement VARCHAR(50),
   recommandations_post_seance VARCHAR(500),
   mode_rdv VARCHAR(50),
   lien_visio VARCHAR(255),
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY (Id_PRATICIEN, Id_SERVICE) REFERENCES SERVICE(Id_PRATICIEN, Id_SERVICE),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier)
);

CREATE TABLE MESSAGE (
   Id_MESSAGE SERIAL PRIMARY KEY,
   numéro_dossier INT NOT NULL,
   Id_PRATICIEN INT NOT NULL,
   sujet VARCHAR(100),
   date_heure_envoie TIMESTAMP,
   lu BOOLEAN,
   type_message VARCHAR(50),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier),
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE AVIS (
   Id_AVIS SERIAL PRIMARY KEY,
   Id_PRATICIEN INT NOT NULL,
   numéro_dossier INT NOT NULL,
   note SMALLINT CHECK (note >= 0 AND note <= 5),
   commentaire VARCHAR(300),
   date_avis TIMESTAMP,
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier)
);

CREATE TABLE parcours_personnalises (
   Id_parcours_personnalise SERIAL PRIMARY KEY,
   numéro_dossier INT NOT NULL,
   date_creation DATE,
   date_derniere_maj DATE,
   statut VARCHAR(50),
   objectif_principal VARCHAR(100),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier)
);

CREATE TABLE RESULTAT_PARCOURS (
   Id_RESULTAT_PARCOURS SERIAL PRIMARY KEY,
   Id_parcours_personnalise INT NOT NULL,
   numéro_dossier INT NOT NULL,
   date_cible DATE,
   description VARCHAR(200),
   statut_etape VARCHAR(50),
   type_etape VARCHAR(50),
   FOREIGN KEY (numéro_dossier, Id_parcours_personnalise) REFERENCES parcours_personnalises(numéro_dossier, Id_parcours_personnalise)
);

CREATE TABLE BILAN_SUIVI_PATIENT (
   Id_BILAN_SUIVI_PATIENT SERIAL PRIMARY KEY,
   numéro_dossier INT NOT NULL,
   date_bilan DATE,
   rapport_ia VARCHAR(1000),
   retours VARCHAR(500),
   courbes_suivi_progres REAL,
   kpi_quantitatifs VARCHAR(100),
   date_debut_periode TIMESTAMP,
   date_fin_periode TIMESTAMP,
   est_exportable BOOLEAN,
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier)
);

CREATE TABLE HISTORIQUE_ACTIVITE (
   Id_HISTORIQUE_ACTIVITE SERIAL PRIMARY KEY,
   numéro_dossier INT NOT NULL,
   date_heure_activite TIMESTAMP,
   type_activite VARCHAR(50),
   source_activite VARCHAR(50),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier)
);

CREATE TABLE PAIEMENT (
   Id_PAIEMENT SERIAL PRIMARY KEY,
   Id_PRATICIEN INT NOT NULL,
   Id_SERVICE INT NOT NULL,
   numéro_dossier INT NOT NULL,
   Id_RENDEZ_VOUS INT NOT NULL,
   montant DOUBLE PRECISION NOT NULL,
   mode_paiement VARCHAR(50),
   date_paiement TIMESTAMP NOT NULL,
   statut_paiement VARCHAR(50),
   reference_transaction VARCHAR(100),
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY (Id_RENDEZ_VOUS) REFERENCES RENDEZ_VOUS(Id_RENDEZ_VOUS),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier),
   FOREIGN KEY (Id_SERVICE, Id_PRATICIEN) REFERENCES SERVICE(Id_SERVICE, Id_PRATICIEN)
);

CREATE TABLE FACTURES (
   Id_FACTURE SERIAL PRIMARY KEY,
   date_facture TIMESTAMP NOT NULL,
   montant_total DECIMAL(10, 2) NOT NULL,
   url_pdf VARCHAR(255),
   Id_PRATICIEN INT NOT NULL,
   numéro_dossier INT NOT NULL,
   Id_PAIEMENT INT,
   FOREIGN KEY (Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY (numéro_dossier) REFERENCES Patient(numéro_dossier),
   FOREIGN KEY (Id_PAIEMENT) REFERENCES PAIEMENT(Id_PAIEMENT)
);

