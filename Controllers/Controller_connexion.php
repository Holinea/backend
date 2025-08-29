<?php
require_once 'Models/Model.php';

class Controller_connexion extends Controller
{
    /** Formulaire de connexion */
    public function action_index()
    {
        if (session_status() !== PHP_SESSION_ACTIVE) session_start();

        // Si déjà connecté, on envoie vers l’espace praticien
        if (!empty($_SESSION['role']) && $_SESSION['role'] === 'praticien') {
            header('Location: index.php?Controller=clients&action=index');
            exit;
        }

        // Affiche la vue de connexion
        $this->render('connexion', [
            'error' => $_SESSION['flash_error'] ?? null
        ]);
        unset($_SESSION['flash_error']);
    }

    /** Traitement du POST */
    public function action_login()
    {
        if (session_status() !== PHP_SESSION_ACTIVE) session_start();

        $mail = trim($_POST['mail'] ?? '');
        $pass = trim($_POST['mot_de_passe'] ?? '');

        if ($mail === '' || $pass === '') {
            $_SESSION['flash_error'] = "Veuillez saisir l'email et le mot de passe.";
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        // TODO: vérifier le mot de passe avec la BDD (hash)
        // Pour l’instant on considère que tout email est accepté.

        // On tente de récupérer le praticien par email pour afficher ses vraies infos
        $m = Model::getModel();
        $me = [
            'avatar' => 'Content/img/avatar.png',
            'name'   => $mail,
            'role'   => 'Praticien',
        ];

        if (method_exists($m, 'getPraticienByEmail')) {
            $p = $m->getPraticienByEmail($mail); // doit retourner prenom, nom, photo_profil_url, specialites…
            if ($p) {
                $me['name']   = trim(($p['prenom'] ?? '').' '.($p['nom'] ?? '')) ?: $mail;
                $me['avatar'] = $p['avatar'] ?? ($p['photo_profil_url'] ?? $me['avatar']);
                $me['role']   = $p['specialites'] ?: 'Praticien';
            }
        }

        // Mémorise la session praticien
        $_SESSION['role']        = 'praticien';
        $_SESSION['user_email']  = $mail;
        $_SESSION['user_id']     = $p['id_utilisateur'] ?? null;
        $_SESSION['praticien_id']= $p['id_praticien']   ?? null;
        $_SESSION['user_name']   = $me['name'];
        $_SESSION['user_avatar'] = $me['avatar'];
        $_SESSION['user_title']  = $me['role'];

        header('Location: index.php?Controller=clients&action=index');
        exit;
    }

    public function action_default()
    {
        $this->action_index();
    }
}
