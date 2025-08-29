<?php

class Controller_connexion extends Controller
{
    /** Affiche le formulaire de connexion */
    public function action_index()
    {
        session_start();

        // Si déjà connecté, on évite d’afficher la page de login
        if (!empty($_SESSION['role'])) {
            if ($_SESSION['role'] === 'praticien') {
                header('Location: index.php?Controller=clients&action=index');
                exit;
            }
            if ($_SESSION['role'] === 'patient') {
                header('Location: index.php?Controller=patient&action=dashboard');
                exit;
            }
        }

        // Affiche la vue de connexion (view_connexion.php)
        $this->render('connexion');
    }

    /** Traite le POST du formulaire */
    public function action_login()
    {
        session_start();

        $mail = trim($_POST['mail'] ?? '');
        $pass = trim($_POST['mot_de_passe'] ?? '');
        var_dump($mail);
        if ($mail === '' || $pass === '') {
            $_SESSION['flash_error'] = "Veuillez saisir l'email et le mot de passe.";
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        // TODO: vérifier le couple email/mot de passe (hash) en BDD.
        $_SESSION['user_email'] = $mail;

        // ==== On délègue au modèle ====
        $m = Model::getModel();

        // 1) Patient via CSV ?
        $patient = $m->findPatientInCsvByEmail('Content/data/patients.csv', $mail);
        if ($patient) {
            $_SESSION['role']        = 'patient';
            $_SESSION['patient']     = $patient;
            $_SESSION['user_id']     = $patient['id'] ?? null;
            $_SESSION['user_name']   = trim(($patient['prenom'] ?? '').' '.($patient['nom'] ?? ''));
            $_SESSION['user_avatar'] = $patient['avatar'] ?: 'Content/img/avatar.png';
            $_SESSION['user_title']  = 'Patient';

            header('Location: index.php?Controller=patient&action=dashboard');
            exit;
        }

        // 2) Sinon praticien en BDD ?
        $praticien = $m->getPraticienByEmail($mail);
        if ($praticien) {
            $_SESSION['role']          = 'praticien';
            $_SESSION['praticien_id']  = $praticien['id_praticien'];
            $_SESSION['user_id']       = $praticien['id_utilisateur'];
            $_SESSION['user_name']     = trim(($praticien['prenom'] ?? '').' '.($praticien['nom'] ?? ''));
            $_SESSION['user_avatar']   = $praticien['avatar'] ?: 'Content/img/avatar.png';
            $_SESSION['user_title']    = $praticien['specialites'] ?: 'Praticien';

            header('Location: index.php?Controller=clients&action=index');
            exit;
        }

        // 3) Échec
        $_SESSION['flash_error'] = "Identifiants inconnus.";
        header('Location: index.php?Controller=connexion&action=index');
        exit;
    }

    /** Par défaut, on affiche la page de connexion (surtout PAS de redirection) */
    public function action_default()
    {
        $this->action_index();
    }
}
