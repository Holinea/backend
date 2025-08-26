
CREATE TABLE QUESTIONNAIRE(
   Id_QUESTIONNAIRE SERIAL,
   description VARCHAR(200),
   type_cible VARCHAR(50),
   nom_questionnaire_ VARCHAR(100),
   date_creation DATE,
   date_derniere_maj TIMESTAMP,
   PRIMARY KEY(Id_QUESTIONNAIRE)
);

CREATE TABLE Utilisateur(
   Id_Utilisateur SERIAL,
   mail VARCHAR(255) NOT NULL,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   date_inscription DATE,
   derniere_connexion TIMESTAMP,
   role_utilisateur VARCHAR(50) NOT NULL,
   statut_compte VARCHAR(50),
   mot_de_passe VARCHAR(255) NOT NULL,
   consentement_cgu BOOLEAN NOT NULL,
   consentement_partage_donnees_sante_ BOOLEAN NOT NULL,
   preferences_notifications VARCHAR(50),
   telephone_ BIGINT,
   PRIMARY KEY(Id_Utilisateur),
   UNIQUE(mail)
);

CREATE TABLE PRATICIEN(
   Id_PRATICIEN SERIAL,
   mode_consultation VARCHAR(50),
   adresse_cabinet VARCHAR(50),
   diplomes VARCHAR(50),
   nombre_heures_pratique BIGINT NOT NULL,
   description VARCHAR(200),
   annees_experience INTEGER,
   tarifs_consultation DOUBLE PRECISION,
   photo_profil_url VARCHAR(50),
   taux_satisfaction DECIMAL(4,2),
   statut_validation VARCHAR(50),
   Id_Utilisateur INT NOT NULL,
   PRIMARY KEY(Id_PRATICIEN),
   UNIQUE(Id_Utilisateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur)
);

CREATE TABLE QUESTIONS(
   Id_QUESTIONS SERIAL,
   texte_question VARCHAR(200),
   type_réponses VARCHAR(50),
   categorie_question_ VARCHAR(50),
   PRIMARY KEY(Id_QUESTIONS)
);

CREATE TABLE REPONSES(
   Id_QUESTIONS INT,
   Id_REPONSES SERIAL,
   contenu_reponse VARCHAR(200),
   date_reponse TIMESTAMP,
   PRIMARY KEY(Id_QUESTIONS, Id_REPONSES),
   FOREIGN KEY(Id_QUESTIONS) REFERENCES QUESTIONS(Id_QUESTIONS)
);

CREATE TABLE SPECIALITES(
   Id_SPECIALITES SERIAL,
   nom_speciallite VARCHAR(50),
   description VARCHAR(300),
   PRIMARY KEY(Id_SPECIALITES)
);

CREATE TABLE SERVICE(
   Id_PRATICIEN INT,
   Id_SERVICE SERIAL,
   description_service VARCHAR(500),
   nom_service VARCHAR(50),
   tarif VARCHAR(50),
   type_service VARCHAR(50),
   duree TIME,
   PRIMARY KEY(Id_PRATICIEN, Id_SERVICE),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE PRODUITS_BIEN_ETRE(
   Id_PRODUITS_BIEN_ETRE SERIAL,
   prix DOUBLE PRECISION,
   nom_produit VARCHAR(50),
   description VARCHAR(300),
   stock BIGINT,
   url_image VARCHAR(50),
   categorie VARCHAR(50),
   Id_PRATICIEN INT NOT NULL,
   PRIMARY KEY(Id_PRODUITS_BIEN_ETRE),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN)
);

CREATE TABLE CONTENUS_INSPIRANTS(
   Id_CONTENUS_INSPIRANTS SERIAL,
   titre VARCHAR(50),
   description_courte VARCHAR(200),
   auteur VARCHAR(50),
   categorie VARCHAR(50),
   type_contenu VARCHAR(50),
   date_publication TIMESTAMP,
   PRIMARY KEY(Id_CONTENUS_INSPIRANTS)
);

CREATE TABLE JUMEAU_NUMERIQUE(
   Id_JUMEAU_NUMERIQUE SERIAL,
   date_heure TIMESTAMP,
   donnees_energie_ VARCHAR(255),
   resume_dynamique VARCHAR(50),
   donnees_corporelles VARCHAR(50),
   donnees_emotionnelles VARCHAR(50),
   PRIMARY KEY(Id_JUMEAU_NUMERIQUE)
);

CREATE TABLE Analyse_IA_(
   Id_Analyse_IA_ SERIAL,
   version_modele DECIMAL(1,1),
   statut_validation VARCHAR(50),
   resultats VARCHAR(2000),
   date_analyse TIMESTAMP,
   type_analyse_ VARCHAR(50),
   PRIMARY KEY(Id_Analyse_IA_)
);

CREATE TABLE REFERENTIEL_SCIENTIFIFQUE(
   id_reference_scientifique SERIAL,
   titre VARCHAR(50),
   description_courte VARCHAR(200),
   type_element VARCHAR(50),
   contenu_detaille VARCHAR(50),
   auteur_source VARCHAR(50),
   date_publication_initiale DATE,
   date_derniere_mise_a_jour DATE,
   mots_cles VARCHAR(600),
   est_valide_par_expert BOOLEAN,
   url_lien VARCHAR(255),
   thematique VARCHAR(50),
   PRIMARY KEY(id_reference_scientifique)
);

CREATE TABLE RECOMMENDATION(
   Id_JUMEAU_NUMERIQUE INT,
   Id_RECOMMENDATION SERIAL,
   type_recommandation VARCHAR(300),
   impact_prevu_jumeau VARCHAR(500),
   statut_recommandation VARCHAR(50),
   date_emission DATE,
   texte_recommandation VARCHAR(2000),
   PRIMARY KEY(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION),
   FOREIGN KEY(Id_JUMEAU_NUMERIQUE) REFERENCES JUMEAU_NUMERIQUE(Id_JUMEAU_NUMERIQUE)
);

CREATE TABLE COMMUNAUTE(
   Id_COMMUNAUTE SERIAL,
   nom_groupe VARCHAR(50),
   description_groupe VARCHAR(1000),
   date_creation DATE,
   est_anonyme BOOLEAN,
   PRIMARY KEY(Id_COMMUNAUTE),
   UNIQUE(nom_groupe)
);

CREATE TABLE PUBLICATION_COMMUNAUTE(
   Id_PUBLICATION_COMMUNAUTE SERIAL,
   contenu_texte VARCHAR(1000),
   url_piece_jointe VARCHAR(50),
   type_publication VARCHAR(50),
   est_epingle VARCHAR(50),
   date_publication TIMESTAMP,
   PRIMARY KEY(Id_PUBLICATION_COMMUNAUTE)
);

CREATE TABLE ATELIERS(
   Id_ATELIERS SERIAL,
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
   statut_activite VARCHAR(50),
   PRIMARY KEY(Id_ATELIERS)
);

CREATE TABLE CONFERENCES(
   Id_CONFERENCES SERIAL,
   capacite_max INT,
   statut_conference VARCHAR(50),
   titre VARCHAR(255) NOT NULL,
   resume_conference VARCHAR(1000),
   thématique VARCHAR(100),
   duree_prevu_minutes INT,
   date_heure_debut TIMESTAMP,
   date_heure_fin TIMESTAMP,
   url_visio VARCHAR(255),
   tarif DECIMAL(15,2),
   PRIMARY KEY(Id_CONFERENCES)
);

CREATE TABLE CONVERSATIONS(
   Id_COMMUNAUTE INT,
   Id_CONVERSATIONS SERIAL,
   contenu_message VARCHAR(1000) NOT NULL,
   est_lu BOOLEAN default False,
   type_message VARCHAR(50),
   url_fichier_jointe VARCHAR(255),
   PRIMARY KEY(Id_COMMUNAUTE, Id_CONVERSATIONS),
   FOREIGN KEY(Id_COMMUNAUTE) REFERENCES COMMUNAUTE(Id_COMMUNAUTE)
);

CREATE TABLE Patient(
   numero_dossier SERIAL,
   adresse VARCHAR(50),
   date_de_naissance TIMESTAMP NOT NULL,
   genre VARCHAR(50) NOT NULL,
   date_inscription DATE NOT NULL,
   derniere_connexion TIMESTAMP NOT NULL,
   situation_pro_ VARCHAR(100),
   origine_ethnique_ VARCHAR(100),
   environnement_vie VARCHAR(255),
   habitudes_ VARCHAR(500),
   rythme_quotidien_ VARCHAR(500),
   type_activite_physique_ VARCHAR(500),
   frequence_activite_physique_ VARCHAR(50),
   type_alimentation_ VARCHAR(500),
   consommation_substances_ VARCHAR(500),
   niveau_energie_moyen INTEGER,
   gestion_emotionnelle_actuelle_ VARCHAR(500),
   _interet_spiritualite VARCHAR(50),
   suivi_progres_actuel VARCHAR(50),
   type_accompagnement_souhaite_ VARCHAR(50),
   autorisation_mise_en_lien_therapeutes BOOLEAN,
   frequence_rappels_souhaitee VARCHAR(50),
   nom_jumeau_numerique_ VARCHAR(100),
   design_jumeau_numerique VARCHAR(100),
   qualite_environnement_vie_choix_ VARCHAR(100),
   Id_Utilisateur INT NOT NULL,
   PRIMARY KEY(numero_dossier),
   UNIQUE(Id_Utilisateur),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur)
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
   mode_paiement_ VARCHAR(50),
   recommandations_post_seance_ VARCHAR(50),
   mode_rdv VARCHAR(50),
   lien_visio VARCHAR(50),
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
   note SERIAL,
   commentaire VARCHAR(300),
   date_avis TIME,
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
   date_debut_periode_ TIMESTAMP,
   date_fin_periode_ TIMESTAMP,
   est_exportable_ BOOLEAN,
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
   FOREIGN KEY(Id_PRATICIEN_1, Id_PRATICIEN_2, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS) REFERENCES RENDEZ_VOUS(Id_PRATICIEN, Id_PRATICIEN, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS),
   FOREIGN KEY(numero_dossier_1) REFERENCES Patient(numero_dossier)
);

CREATE TABLE FACTURES(
   Id_FACTURES SERIAL,
   date_facture TIMESTAMP NOT NULL,
   montant_total DECIMAL(10,2) NOT NULL,
   url_pdf VARCHAR(255),
   numero_dossier VARCHAR(50),
   Id_PRATICIEN INT NOT NULL,
   numero_dossier_1 INT NOT NULL,
   Id_PRATICIEN_1 INT,
   Id_PRATICIEN_2 INT,
   Id_PRATICIEN_3 INT,
   Id_SERVICE INT,
   numero_dossier_2 INT,
   Id_RENDEZ_VOUS INT,
   numero_dossier_3 INT,
   Id_PAIEMENT INT,
   PRIMARY KEY(Id_FACTURES),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(numero_dossier_1) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_PRATICIEN_1, Id_PRATICIEN_2, Id_PRATICIEN_3, Id_SERVICE, numero_dossier_2, Id_RENDEZ_VOUS, numero_dossier_3, Id_PAIEMENT) REFERENCES PAIEMENT(Id_PRATICIEN, Id_PRATICIEN, Id_PRATICIEN, Id_SERVICE, numero_dossier, Id_RENDEZ_VOUS, numero_dossier, Id_PAIEMENT)
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
   est_repondu VARCHAR(50),
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

CREATE TABLE patient_repond_a_(
   numero_dossier INT,
   Id_QUESTIONS INT,
   Id_REPONSES INT,
   PRIMARY KEY(numero_dossier, Id_QUESTIONS, Id_REPONSES),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_QUESTIONS, Id_REPONSES) REFERENCES REPONSES(Id_QUESTIONS, Id_REPONSES)
);

CREATE TABLE a_la_spécialite(
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
   Id_Analyse_IA_ INT,
   modele_ia VARCHAR(50),
   PRIMARY KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS, Id_Analyse_IA_),
   FOREIGN KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS) REFERENCES RESULTAT_PARCOURS(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS),
   FOREIGN KEY(Id_Analyse_IA_) REFERENCES Analyse_IA_(Id_Analyse_IA_)
);

CREATE TABLE est_sujet_de(
   Id_QUESTIONS INT,
   Id_REPONSES INT,
   Id_Analyse_IA_ INT,
   PRIMARY KEY(Id_QUESTIONS, Id_REPONSES, Id_Analyse_IA_),
   FOREIGN KEY(Id_QUESTIONS, Id_REPONSES) REFERENCES REPONSES(Id_QUESTIONS, Id_REPONSES),
   FOREIGN KEY(Id_Analyse_IA_) REFERENCES Analyse_IA_(Id_Analyse_IA_)
);

CREATE TABLE enrichit(
   Id_Analyse_IA_ INT,
   id_reference_scientifique INT,
   PRIMARY KEY(Id_Analyse_IA_, id_reference_scientifique),
   FOREIGN KEY(Id_Analyse_IA_) REFERENCES Analyse_IA_(Id_Analyse_IA_),
   FOREIGN KEY(id_reference_scientifique) REFERENCES REFERENTIEL_SCIENTIFIFQUE(id_reference_scientifique)
);

CREATE TABLE contribue_consulte(
   Id_PRATICIEN INT,
   id_reference_scientifique INT,
   PRIMARY KEY(Id_PRATICIEN, id_reference_scientifique),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(id_reference_scientifique) REFERENCES REFERENTIEL_SCIENTIFIFQUE(id_reference_scientifique)
);

CREATE TABLE recoit(
   numero_dossier INT,
   Id_JUMEAU_NUMERIQUE INT,
   Id_RECOMMENDATION INT,
   PRIMARY KEY(numero_dossier, Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION) REFERENCES RECOMMENDATION(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION)
);

CREATE TABLE est_integree(
   numero_dossier INT,
   Id_parcours_personnalises INT,
   Id_RESULTAT_PARCOURS INT,
   Id_JUMEAU_NUMERIQUE INT,
   Id_RECOMMENDATION INT,
   PRIMARY KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS, Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION),
   FOREIGN KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS) REFERENCES RESULTAT_PARCOURS(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS),
   FOREIGN KEY(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION) REFERENCES RECOMMENDATION(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION)
);

CREATE TABLE consulte_intervient(
   Id_PRATICIEN INT,
   numero_dossier INT,
   Id_parcours_personnalises INT,
   PRIMARY KEY(Id_PRATICIEN, numero_dossier, Id_parcours_personnalises),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(numero_dossier, Id_parcours_personnalises) REFERENCES parcours_personnalises(numero_dossier, Id_parcours_personnalises)
);

CREATE TABLE enrichit_BDD(
   numero_dossier INT,
   Id_parcours_personnalises INT,
   Id_RESULTAT_PARCOURS INT,
   id_reference_scientifique INT,
   PRIMARY KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS, id_reference_scientifique),
   FOREIGN KEY(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS) REFERENCES RESULTAT_PARCOURS(numero_dossier, Id_parcours_personnalises, Id_RESULTAT_PARCOURS),
   FOREIGN KEY(id_reference_scientifique) REFERENCES REFERENTIEL_SCIENTIFIFQUE(id_reference_scientifique)
);

CREATE TABLE praticien_recoit(
   Id_PRATICIEN INT,
   numero_dossier INT,
   Id_PRATICIEN_1 INT,
   Id_MESSAGE INT,
   PRIMARY KEY(Id_PRATICIEN, numero_dossier, Id_PRATICIEN_1, Id_MESSAGE),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(numero_dossier, Id_PRATICIEN_1, Id_MESSAGE) REFERENCES MESSAGE(numero_dossier, Id_PRATICIEN, Id_MESSAGE)
);

CREATE TABLE patient_recoit(
   numero_dossier INT,
   numero_dossier_1 INT,
   Id_PRATICIEN INT,
   Id_MESSAGE INT,
   PRIMARY KEY(numero_dossier, numero_dossier_1, Id_PRATICIEN, Id_MESSAGE),
   FOREIGN KEY(numero_dossier) REFERENCES Patient(numero_dossier),
   FOREIGN KEY(numero_dossier_1, Id_PRATICIEN, Id_MESSAGE) REFERENCES MESSAGE(numero_dossier, Id_PRATICIEN, Id_MESSAGE)
);

CREATE TABLE contient_publication(
   Id_COMMUNAUTE INT,
   Id_PUBLICATION_COMMUNAUTE INT,
   PRIMARY KEY(Id_COMMUNAUTE, Id_PUBLICATION_COMMUNAUTE),
   FOREIGN KEY(Id_COMMUNAUTE) REFERENCES COMMUNAUTE(Id_COMMUNAUTE),
   FOREIGN KEY(Id_PUBLICATION_COMMUNAUTE) REFERENCES PUBLICATION_COMMUNAUTE(Id_PUBLICATION_COMMUNAUTE)
);

CREATE TABLE est_membre(
   Id_Utilisateur INT,
   Id_COMMUNAUTE INT,
   PRIMARY KEY(Id_Utilisateur, Id_COMMUNAUTE),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_COMMUNAUTE) REFERENCES COMMUNAUTE(Id_COMMUNAUTE)
);

CREATE TABLE recommande(
   Id_Analyse_IA_ INT,
   Id_JUMEAU_NUMERIQUE INT,
   Id_RECOMMENDATION INT,
   PRIMARY KEY(Id_Analyse_IA_, Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION),
   FOREIGN KEY(Id_Analyse_IA_) REFERENCES Analyse_IA_(Id_Analyse_IA_),
   FOREIGN KEY(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION) REFERENCES RECOMMENDATION(Id_JUMEAU_NUMERIQUE, Id_RECOMMENDATION)
);

CREATE TABLE participe(
   Id_Utilisateur INT,
   Id_ATELIERS INT,
   PRIMARY KEY(Id_Utilisateur, Id_ATELIERS),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_ATELIERS) REFERENCES ATELIERS(Id_ATELIERS)
);

CREATE TABLE poste(
   Id_Utilisateur INT,
   Id_PUBLICATION_COMMUNAUTE INT,
   PRIMARY KEY(Id_Utilisateur, Id_PUBLICATION_COMMUNAUTE),
   FOREIGN KEY(Id_Utilisateur) REFERENCES Utilisateur(Id_Utilisateur),
   FOREIGN KEY(Id_PUBLICATION_COMMUNAUTE) REFERENCES PUBLICATION_COMMUNAUTE(Id_PUBLICATION_COMMUNAUTE)
);

CREATE TABLE animer(
   Id_PRATICIEN INT,
   Id_CONFERENCES INT,
   PRIMARY KEY(Id_PRATICIEN, Id_CONFERENCES),
   FOREIGN KEY(Id_PRATICIEN) REFERENCES PRATICIEN(Id_PRATICIEN),
   FOREIGN KEY(Id_CONFERENCES) REFERENCES CONFERENCES(Id_CONFERENCES)
);

