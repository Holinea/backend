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
-- Data for Name: jumeau_numerique; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (45, 'ess@holinea.fr', 'fall', 'habdallahi', '2025-07-31', '2025-07-31 12:19:20.22067', 'therapeute', 'actif', '$2y$10$kokkA8c4iIf15Xjjyce8ZuUutXFEYvVPaQWYwO3Da8wcw.Wx3kcPu', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (52, 'client1@exemple.com', 'Dupont', 'Marie', '2025-07-31', '2025-07-31 12:47:21.086047', 'patient', 'actif', 'testhash', true, false, NULL, 33660000001, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (53, 'client2@exemple.com', 'Martin', 'Jean', '2025-07-31', '2025-07-31 12:47:21.086047', 'patient', 'actif', 'testhash', true, true, NULL, 33660000002, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (54, 'fall@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 10:37:50.662133', 'therapeute', 'actif', '$2y$10$dKDziXFEHBN.isXrL7Ozb.OHkSvZOu67N607bDQB.Z4vb1gZN..3q', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (55, 'fall1@holinea.fr', 'fall', 'abdou', '2025-08-05', '2025-08-05 11:47:15.136171', 'therapeute', 'actif', '$2y$10$3y4vc90x6tqQfyGnzyz85.GQ82VFGQgogm1SZV/YXpnmOA9VMv9Ym', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (56, 'fall2@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 11:53:55.53552', 'therapeute', 'actif', '$2y$10$5YeHFVKT5lvZptKarlIRv.TrIXxvBI.Cf9h0ldQY1B2QMpp8OdBMq', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (57, 'fall3@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 12:00:22.044469', 'therapeute', 'actif', '$2y$10$gtQGfxvIRGR0lJ2jwe9gX.0xwpaUyAV7xu/SBrMWLutA6KXMaq9Vi', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (58, 'fall4@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 12:03:09.238271', 'therapeute', 'actif', '$2y$10$c6PePT6jLwryCg92qDLNOuIcNsOCG8iUgVOYhyUl7tDVKKrdQWOOW', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (59, 'fall5@holinea.fr', 'fall', 'ishak', '2025-08-05', '2025-08-05 12:16:09.600295', 'therapeute', 'actif', '$2y$10$ORWLJMwcc9KEiGgC0ALNIuIv2Ftu4JFusnNq6z9Ka9dShuCZ6S5nm', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (60, 'fall6@holinea.fr', 'FALL', 'habdallahi', '2025-08-05', '2025-08-05 12:37:25.410447', 'therapeute', 'actif', '$2y$10$lM5qb0ZpoyBT20R0xy/eIOLV2UtdUzwcZtyBGmgQBRPW93AjcVMZi', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (61, 'diop@holinea.fr', 'DIOP', 'FAMA', '2025-08-05', '2025-08-05 12:42:41.848355', 'therapeute', 'actif', '$2y$10$QTl9ph8ApnLzA.BROlM6rO8BrflhDGDmprCUPectgDsuvJ3pXy6AK', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (62, 'ndiaye@holinea.fr', 'ndiaye', 'awa', '2025-08-05', '2025-08-05 14:32:08.998837', 'therapeute', 'actif', '$2y$10$0d8EuTaBk.mJjqEPipXvCurUKDWW3PdYIiJ5c3HZNG3kazbk3xJza', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (63, 'sylla@holinea.fr', 'AIDA', 'SYLLA', '2025-08-05', '2025-08-05 14:48:23.362678', 'therapeute', 'actif', '$2y$10$FQXBWvOusvXMAzMa.o50yenJWDHxee/WSO5gGKHWwIsp6pvWFiDBy', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (64, 'ndiaye2@holinea.fr', 'AIDA', 'NDIAYE', '2025-08-05', '2025-08-05 14:55:42.597666', 'therapeute', 'actif', '$2y$10$CqZaDBWa8j9Lo9RfQ6l9deyPs09vB1josMYMG4CgHZ4HZMAGvv3Oe', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (65, 'contact@holinea.fr', 'fall', 'habdallahi', '2025-08-05', '2025-08-05 15:27:17.878211', 'therapeute', 'actif', '$2y$10$kfs0U5/I41pkH5zmVFwPLuQOvZjLHkhGOKZTRvOAdkPOq5EH22HAe', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (66, 'alou@holinea.fr', 'alou', 'diop', '2025-08-05', '2025-08-05 16:18:23.40199', 'therapeute', 'actif', '$2y$10$rpUxwhMuEG4FhZiRyZ59puYysahbSBF.bbLU0KY3hVVwxgu5zWHSq', true, true, NULL, 33625628751, NULL, true, NULL);
INSERT INTO public.utilisateur (id_utilisateur, mail, nom, prenom, date_inscription, derniere_connexion, role_utilisateur, statut_compte, mot_de_passe, consentement_cgu, consentement_partage_donnees_sante_, preferences_notifications, telephone_, email_verifie_le, verification_required, photo_profil_url) VALUES (67, 'ndiaye22@holinea.fr', 'fall', 'habdallahi', '2025-08-07', '2025-08-07 17:44:24.638939', 'therapeute', 'actif', '$2y$10$iqNghvHGrCgf9AWTNGyFXuw29Hy.WFPVGTDdf7Qmb85RMiG29FTWS', true, true, NULL, 33625628751, NULL, true, NULL);


--
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.patient (numero_dossier, adresse, date_de_naissance, genre, date_inscription, derniere_connexion, situation_pro_, origine_ethnique_, environnement_vie, habitudes_, rythme_quotidien_, type_activite_physique_, frequence_activite_physique_, type_alimentation_, consommation_substances_, niveau_energie_moyen, gestion_emotionnelle_actuelle_, _interet_spiritualite, suivi_progres_actuel, type_accompagnement_souhaite_, autorisation_mise_en_lien_therapeutes, frequence_rappels_souhaitee, nom_jumeau_numerique_, design_jumeau_numerique, qualite_environnement_vie_choix_, id_utilisateur) VALUES (5, '15 rue Paris', '1995-08-12 00:00:00', 'F', '2025-07-31', '2025-07-31 12:56:11.171753', 'Etudiante', NULL, NULL, 'Sport', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 52);
INSERT INTO public.patient (numero_dossier, adresse, date_de_naissance, genre, date_inscription, derniere_connexion, situation_pro_, origine_ethnique_, environnement_vie, habitudes_, rythme_quotidien_, type_activite_physique_, frequence_activite_physique_, type_alimentation_, consommation_substances_, niveau_energie_moyen, gestion_emotionnelle_actuelle_, _interet_spiritualite, suivi_progres_actuel, type_accompagnement_souhaite_, autorisation_mise_en_lien_therapeutes, frequence_rappels_souhaitee, nom_jumeau_numerique_, design_jumeau_numerique, qualite_environnement_vie_choix_, id_utilisateur) VALUES (6, '22 avenue Lyon', '1989-03-27 00:00:00', 'M', '2025-07-31', '2025-07-31 12:56:11.171753', 'Commercial', NULL, NULL, 'Lecture', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 53);


--
-- Data for Name: a_des_etats; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: specialites; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: a_la_spécialite; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: produits_bien_etre; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: achete; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: praticien; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.praticien (id_praticien, mode_consultation, adresse_cabinet, diplomes, nombre_heures_pratique, description, annees_experience, tarifs_consultation, photo_profil_url, taux_satisfaction, statut_validation, id_utilisateur, telephone_verifie, code_verification, code_expiry, code_postal, specialites, type_approche, ville, longue_description) VALUES (48, 'cabinet', '81b rue du chevaleret, 75013', 'Master en naturopathie', 400, 'naturopathe galsen', 5, 50, 'Uploads/photos/689206a5ce7c6_sylla.png', NULL, 'valide', 65, false, NULL, NULL, '75013', 'naturopathie', NULL, NULL, 'naturopathe galsen');
INSERT INTO public.praticien (id_praticien, mode_consultation, adresse_cabinet, diplomes, nombre_heures_pratique, description, annees_experience, tarifs_consultation, photo_profil_url, taux_satisfaction, statut_validation, id_utilisateur, telephone_verifie, code_verification, code_expiry, code_postal, specialites, type_approche, ville, longue_description) VALUES (50, 'cabinet', '81b rue du chevaleret, 75013', 'Master en massage', 145, 'Praticien spécialisé en massages relaxants et thérapeutiques pour soulager les tensions musculaires et améliorer le bien-être.', 3, 60, 'Uploads/photos/default_masseur.png', 88.00, 'valide', 61, false, NULL, NULL, '75013', 'massage', 'Manuelle', 'Paris', 'Praticien spécialisé en massages relaxants et thérapeutiques pour soulager les tensions musculaires et améliorer le bien-être.');
INSERT INTO public.praticien (id_praticien, mode_consultation, adresse_cabinet, diplomes, nombre_heures_pratique, description, annees_experience, tarifs_consultation, photo_profil_url, taux_satisfaction, statut_validation, id_utilisateur, telephone_verifie, code_verification, code_expiry, code_postal, specialites, type_approche, ville, longue_description) VALUES (47, 'distance', '81b rue du chevaleret, 75013', 'Master en naturopathie', 300, 'je suis naturopathe senegalaise', 5, 50, 'Uploads/photos/6891ff3f1a52b_sylla.png', 95.00, 'valide', 64, false, NULL, NULL, '75013', 'naturopathie', 'Holistique', 'Paris', 'je suis naturopathe senegalaise');
INSERT INTO public.praticien (id_praticien, mode_consultation, adresse_cabinet, diplomes, nombre_heures_pratique, description, annees_experience, tarifs_consultation, photo_profil_url, taux_satisfaction, statut_validation, id_utilisateur, telephone_verifie, code_verification, code_expiry, code_postal, specialites, type_approche, ville, longue_description) VALUES (49, 'cabinet', '81b rue du chevaleret, 75013', 'Master en massage', 700, 'Je propose des séances de yoga thérapeutique et de relaxation pour réduire le stress et améliorer la souplesse.', 7, 75, 'Uploads/photos/6892129f027a9_alou.png', 92.00, 'valide', 60, false, NULL, NULL, '75013', 'Yoga', 'Énergétique', 'Paris', 'Je propose des séances de yoga thérapeutique et de relaxation adaptées aux besoins spécifiques de chaque personne. Mon objectif est de permettre à chacun de retrouver une harmonie entre le corps, le mental et l’esprit, dans un cadre bienveillant et apaisant. Le yoga que je transmets ne se limite pas à une simple pratique physique : il s’agit d’un véritable chemin de transformation intérieure.

Après plusieurs années de formation en Inde et en Europe, j’ai acquis une solide connaissance des postures (asanas), de la respiration (pranayama) et de la méditation. J’ai complété cet enseignement par des spécialisations en yoga thérapeutique, ce qui me permet aujourd’hui d’accompagner des publics variés : personnes souffrant de douleurs chroniques, individus en période de convalescence, femmes enceintes, ou encore personnes en recherche d’un meilleur équilibre émotionnel.

Lors d’une séance type, je commence par un moment d’écoute afin de comprendre vos besoins du jour. Ensuite, nous progressons à travers des mouvements doux, adaptés à vos capacités, en accordant une attention particulière à la respiration. Loin d’être une performance, ma pratique du yoga est avant tout une invitation à ressentir et à se reconnecter à soi-même. Chaque posture est proposée dans le respect de votre rythme, avec des ajustements possibles pour éviter toute contrainte.

Le yoga thérapeutique agit sur plusieurs niveaux : amélioration de la souplesse et de la posture, renforcement musculaire en profondeur, diminution du stress et de l’anxiété, meilleure qualité du sommeil, mais aussi apaisement global du système nerveux. J’intègre également des exercices de méditation et de visualisation pour favoriser un ancrage mental plus serein.

Je crois profondément que chacun possède en lui la capacité d’évoluer vers plus de santé et de bien-être. Mon rôle est de vous accompagner dans cette démarche, de vous transmettre des outils concrets que vous pourrez ensuite utiliser dans votre quotidien. Au-delà des séances en présentiel, je propose également un suivi à distance, avec des programmes personnalisés que vous pouvez pratiquer chez vous.

En choisissant de travailler ensemble, vous bénéficierez d’un espace de confiance, où vos besoins et vos limites seront respectés. Le yoga devient alors un allié précieux pour retrouver une énergie vitale équilibrée, une meilleure gestion des émotions et un rapport plus doux avec votre corps. Mon souhait est que chaque séance soit pour vous une bulle de calme et un pas supplémentaire sur le chemin de votre mieux-être.');


--
-- Data for Name: agenda; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agenda (id_agenda, id_praticien, titre) VALUES (1, 49, 'Agenda 49');
INSERT INTO public.agenda (id_agenda, id_praticien, titre) VALUES (2, 50, 'Agenda 50');
INSERT INTO public.agenda (id_agenda, id_praticien, titre) VALUES (3, 47, 'Agenda 47');


--
-- Data for Name: agenda_slots; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (1, 0, '2025-09-01', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.682516+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (2, 0, '2025-09-02', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.686468+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (3, 0, '2025-09-03', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.686705+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (4, 0, '2025-09-04', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.686879+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (5, 0, '2025-09-05', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.688202+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (6, 0, '2025-09-06', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.688397+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (7, 0, '2025-09-07', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.688605+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (8, 0, '2025-09-08', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.688779+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (9, 0, '2025-09-09', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.689324+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (10, 0, '2025-09-10', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.689494+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (11, 0, '2025-09-11', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.689885+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (12, 0, '2025-09-12', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.690572+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (13, 0, '2025-09-13', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.690766+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (14, 0, '2025-09-14', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.690935+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (15, 0, '2025-09-15', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.691349+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (16, 0, '2025-09-16', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.691561+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (17, 0, '2025-09-17', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.691757+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (18, 0, '2025-09-18', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.691983+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (19, 0, '2025-09-19', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.692165+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (20, 0, '2025-09-20', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.692338+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (21, 0, '2025-09-21', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.692777+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (22, 0, '2025-09-22', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.692955+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (23, 0, '2025-09-23', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.693149+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (24, 0, '2025-09-24', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.693318+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (25, 0, '2025-09-25', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.693501+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (26, 0, '2025-09-26', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.69368+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (27, 0, '2025-09-27', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.693873+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (28, 0, '2025-09-28', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.697104+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (29, 0, '2025-09-29', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.697278+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (30, 0, '2025-09-30', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 14:09:35.697463+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (31, 0, '2025-09-01', '10:00:00', '12:45:00', 'free', 'Fall', 'cabinet', '2025-09-01 14:09:59.656026+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (32, 0, '2025-09-02', '10:00:00', '11:45:00', 'free', 'Yasmine', 'cabinet', '2025-09-01 16:34:48.233892+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (33, 0, '2025-10-01', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.326399+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (34, 0, '2025-10-02', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.328321+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (35, 0, '2025-10-03', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.329076+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (36, 0, '2025-10-04', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.329454+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (37, 0, '2025-10-05', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.330034+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (38, 0, '2025-10-06', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.3303+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (39, 0, '2025-10-07', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.331136+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (40, 0, '2025-10-08', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.331473+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (41, 0, '2025-10-09', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.331746+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (42, 0, '2025-10-10', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.332412+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (43, 0, '2025-10-11', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.332774+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (44, 0, '2025-10-12', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.33311+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (45, 0, '2025-10-13', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.333407+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (46, 0, '2025-10-14', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.333707+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (47, 0, '2025-10-15', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.334024+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (48, 0, '2025-10-16', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.334319+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (49, 0, '2025-10-17', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.335395+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (50, 0, '2025-10-18', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.335716+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (51, 0, '2025-10-19', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.336288+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (52, 0, '2025-10-20', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.336598+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (53, 0, '2025-10-21', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.33689+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (54, 0, '2025-10-22', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.33764+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (55, 0, '2025-10-23', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.338171+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (56, 0, '2025-10-24', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.338429+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (57, 0, '2025-10-25', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.338693+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (58, 0, '2025-10-26', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.338938+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (59, 0, '2025-10-27', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.339214+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (60, 0, '2025-10-28', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.33951+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (61, 0, '2025-10-29', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.339773+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (62, 0, '2025-10-30', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.340057+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (63, 0, '2025-10-31', '10:00:00', '11:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-01 16:36:30.340339+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (64, 0, '2025-08-01', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.663885+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (65, 0, '2025-08-02', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.669146+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (66, 0, '2025-08-03', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.669541+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (67, 0, '2025-08-04', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.669779+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (68, 0, '2025-08-05', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.670047+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (69, 0, '2025-08-06', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.670268+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (70, 0, '2025-08-07', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.670502+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (71, 0, '2025-08-08', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.670674+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (72, 0, '2025-08-09', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.670867+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (73, 0, '2025-08-10', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.671074+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (74, 0, '2025-08-11', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.671251+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (75, 0, '2025-08-12', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.671441+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (76, 0, '2025-08-13', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.671633+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (77, 0, '2025-08-14', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.673157+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (78, 0, '2025-08-15', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.673829+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (79, 0, '2025-08-16', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.674041+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (80, 0, '2025-08-17', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.674255+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (81, 0, '2025-08-18', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.674447+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (82, 0, '2025-08-19', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.674639+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (83, 0, '2025-08-20', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.675348+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (84, 0, '2025-08-21', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.675562+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (85, 0, '2025-08-22', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.675754+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (86, 0, '2025-08-23', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.676507+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (87, 0, '2025-08-24', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.676667+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (88, 0, '2025-08-25', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.676826+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (89, 0, '2025-08-26', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.67698+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (90, 0, '2025-08-27', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.677147+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (91, 0, '2025-08-28', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.677357+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (92, 0, '2025-08-29', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.677549+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (93, 0, '2025-08-30', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.6777+02');
INSERT INTO public.agenda_slots (id, praticien_id, date, start_time, end_time, status, title, place, created_at) VALUES (94, 0, '2025-08-31', '09:00:00', '09:45:00', 'free', 'Créneau dispo', 'cabinet', '2025-09-09 11:23:43.678417+02');


--
-- Data for Name: analyse_ia_; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: parcours_personnalises; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: resultat_parcours; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: alimente; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: conferences; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: animer; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ateliers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: avis; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: bilan_suivi_patient; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.bilan_suivi_patient (numero_dossier, id_bilan_suivi_patient, date_bilan, rapport_ia, retours, courbes_suivi_progres, kpi_quantitatifs, date_debut_periode_, date_fin_periode_, est_exportable_) VALUES (5, 1, '2025-07-31', 'RAS', 'RAS', NULL, '', '2025-07-31 13:06:20.900593', '2025-07-31 13:06:20.900593', false);
INSERT INTO public.bilan_suivi_patient (numero_dossier, id_bilan_suivi_patient, date_bilan, rapport_ia, retours, courbes_suivi_progres, kpi_quantitatifs, date_debut_periode_, date_fin_periode_, est_exportable_) VALUES (6, 2, '2025-07-31', 'RAS', 'RAS', NULL, '', '2025-07-31 13:06:20.900593', '2025-07-31 13:06:20.900593', false);


--
-- Data for Name: communaute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: commune; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) VALUES ('75056', 'Paris', '75001', 'PARIS 01', NULL, NULL, NULL);
INSERT INTO public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) VALUES ('75056', 'Paris', '75002', 'PARIS 02', NULL, NULL, NULL);
INSERT INTO public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) VALUES ('13055', 'Marseille', '13001', 'MARSEILLE 01', NULL, NULL, NULL);
INSERT INTO public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) VALUES ('69383', 'Lyon', '69001', 'LYON 01', NULL, NULL, NULL);
INSERT INTO public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) VALUES ('31555', 'Toulouse', '31000', 'TOULOUSE', NULL, NULL, NULL);
INSERT INTO public.commune (insee_code, nom_commune, code_postal, acheminement, departement, latitude, longitude) VALUES ('44109', 'Nantes', '44000', 'NANTES', NULL, NULL, NULL);


--
-- Data for Name: contenus_inspirants; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: consulte; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: consulte_intervient; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: questionnaire; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: contient; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: publication_communaute; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: contient_publication; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: referentiel_scientififque; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: contribue_consulte; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: creneaux; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (11, 1, '2025-08-29', '09:00:00', '09:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (12, 1, '2025-08-29', '11:00:00', '11:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (13, 1, '2025-08-30', '14:00:00', '14:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (14, 1, '2025-08-31', '16:00:00', '16:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (15, 2, '2025-08-29', '10:00:00', '10:45:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (16, 2, '2025-08-30', '09:30:00', '10:15:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (17, 2, '2025-08-31', '15:00:00', '15:45:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (18, 3, '2025-08-29', '08:30:00', '09:15:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (19, 3, '2025-08-30', '13:00:00', '13:45:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (20, 3, '2025-08-30', '17:30:00', '18:15:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (21, 1, '2025-08-30', '09:00:00', '09:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (22, 1, '2025-08-30', '11:00:00', '11:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (23, 1, '2025-08-31', '14:00:00', '14:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (24, 1, '2025-09-01', '16:00:00', '16:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (25, 1, '2025-09-02', '10:00:00', '10:50:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (26, 2, '2025-08-30', '10:00:00', '10:45:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (27, 2, '2025-08-31', '09:30:00', '10:15:00');
INSERT INTO public.creneaux (id_creneau, id_agenda, jour, heure_debut, heure_fin) VALUES (28, 2, '2025-09-01', '15:00:00', '15:45:00');


--
-- Data for Name: email_verification_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: enrichit; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: enrichit_bdd; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: recommendation; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: est_integree; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: est_membre; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: reponses; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: est_sujet_de; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: factures; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: historique_activite; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: rendez_vous; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: paiement; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: participe; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: participer; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: patient_recoit; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: patient_repond_a; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: patient_repond_a_; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: poste; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: praticien_consulte; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.praticien_consulte (id_praticien, numero_dossier, id_bilan_suivi_patient) VALUES (36, 5, 1);
INSERT INTO public.praticien_consulte (id_praticien, numero_dossier, id_bilan_suivi_patient) VALUES (36, 6, 2);


--
-- Data for Name: praticien_recoit; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: praticien_repond_a; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: publie; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: recoit; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: recommande; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: user_email_verifications; Type: TABLE DATA; Schema: public; Owner: -
--



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
-- PostgreSQL database dump complete
--

