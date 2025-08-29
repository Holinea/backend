<?php

class Controller_connexion extends Controller
{
    /**
     * GET /connexion
     * Affiche la page de connexion.
     */
    public function action_index()
    {
        // message flash éventuel
        $error = $_SESSION['flash_error'] ?? null;
        unset($_SESSION['flash_error']);

        $this->render('connexion', [
            'error' => $error,
        ]);
    }

    /**
     * POST /connexion/login
     * 1) Essaie de reconnaître un patient par email dans le CSV.
     * 2) Sinon, essaie de reconnaître un praticien par email en BDD.
     * 3) Sinon => message d’erreur.
     *
     * ⚠️ Toute la lecture se fait via Model.php :
     *   - $this->model->findPatientByEmail(string $email) : ?array
     *   - $this->model->getPraticienByEmail(string $email) : ?array
     */
    public function action_login()
    {
        $model = Model::getModel();
        $mail = trim($_POST['mail'] ?? '');
        $pass = trim($_POST['mot_de_passe'] ?? '');

        if ($mail === '' || $pass === '') {
            $_SESSION['flash_error'] = "Veuillez saisir l'email et le mot de passe.";
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        // 1) Patient (CSV)
        $patient = $this->model->findPatientByEmail($mail); // -> ?array
        if ($patient) {
            $_SESSION['role']           = 'patient';
            $_SESSION['user_email']     = $mail;
            $_SESSION['user_id']        = $patient['id'] ?? null;
            $_SESSION['user_name']      = trim(($patient['prenom'] ?? '').' '.($patient['nom'] ?? ''));
            $_SESSION['user_avatar']    = $patient['avatar'] ?: 'Content/img/avatar.png';
            $_SESSION['patient_profile']= $patient;

            header('Location: index.php?Controller=patient&action=dashboard');
            exit;
        }

        // 2) Praticien (BDD)
        $prat = $this->model->getPraticienByEmail($mail); // -> ?array
        if ($prat) {
            $_SESSION['role']         = 'therapeute';
            $_SESSION['user_email']   = $mail;
            $_SESSION['user_id']      = $prat['id_praticien'] ?? null;
            $_SESSION['user_name']    = trim(($prat['prenom'] ?? '').' '.($prat['nom'] ?? ''));
            $_SESSION['user_avatar']  = $prat['avatar'] ?: 'Content/img/avatar.png';
            $_SESSION['praticien']    = $prat;

            header('Location: index.php?Controller=clients&action=index');
            exit;
        }

        // 3) échec
        $_SESSION['flash_error'] = "Identifiants inconnus.";
        header('Location: index.php?Controller=connexion&action=index');
        exit;
    }

    /**
     * GET /connexion/logout
     */
    public function action_logout()
    {
        $_SESSION = [];
        if (ini_get('session.use_cookies')) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000, $params['path'], $params['domain'], $params['secure'], $params['httponly']);
        }
        session_destroy();
        header('Location: index.php?Controller=connexion&action=index');
        exit;
    }

    public function action_default() { $this->action_index(); }
}
