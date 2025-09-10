<?php
require_once 'Models/Model.php';

class Controller_connexion_patient extends Controller
{
    /** Affiche la page de connexion */
    public function action_index() {
        if (session_status() === PHP_SESSION_NONE) session_start();

        $errors = $_SESSION['flash_errors'] ?? [];
        unset($_SESSION['flash_errors']);

        $this->render('patient_login', [
            'errors' => $errors
        ]);
    }

    /** Traite la soumission du formulaire de login */
    public function action_login() {
        if (session_status() === PHP_SESSION_NONE) session_start();

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?Controller=connexion_patient&action=index'); exit;
        }

        $email = trim($_POST['email'] ?? '');
        $pass  = $_POST['password'] ?? '';

        $errors = [];

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors['email'] = "Email invalide.";
        }

        $m = Model::getModel();
        $user = $m->getByEmail($email);

        if (!$user || !password_verify($pass, $user['mot_de_passe'])) {
            $errors['login'] = "Email ou mot de passe incorrect.";
        }

        if ($errors) {
            $_SESSION['flash_errors'] = $errors;
            header('Location: index.php?Controller=connexion_patient&action=index'); exit;
        }

        // Connexion réussie
        $_SESSION['user_id']   = $user['id_utilisateur'];
        $_SESSION['role']      = 'patient';
        $_SESSION['user_name'] = $user['prenom'].' '.$user['nom'];

        header('Location: index.php?Controller=home&action=accueil');
        exit;
    }

    /** Déconnexion */
    public function action_logout() {
        if (session_status() === PHP_SESSION_NONE) session_start();
        session_destroy();
        header('Location: index.php?Controller=connexion_patient&action=index');
        exit;
    }

    /** Par défaut → affiche la page de connexion */
    public function action_default() {
        $this->action_index();
    }
}
