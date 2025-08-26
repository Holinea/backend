<?php

class Controller_connexion extends Controller {

    public function action_login() {
        session_start();
        $error = '';
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $mail = trim($_POST['mail'] ?? '');
            $mdp  = $_POST['mot_de_passe'] ?? '';

            if (!$mail || !$mdp) {
                $error = "Tous les champs sont obligatoires !";
            } else {
                $userModel = Model::getModel();
                $user = $userModel->getByEmail($mail);
                if ($user && password_verify($mdp, $user['mot_de_passe'])) {
                    $_SESSION['id_utilisateur'] = $user['id_utilisateur'];
                    $_SESSION['nom'] = $user['nom'];
                    $_SESSION['role'] = $user['role_utilisateur'] ?? 'patient';

                    header("Location: index.php?Controller=home&action=accueil");
                    exit();

                    header("Location: index.php?Controller=dashboard&action=index");

                    exit();

                } else {
                    $error = "Email ou mot de passe incorrect";
                }
            }
        }
        // On prépare les données à envoyer à la vue
        $data = ['error' => $error];
        $this->render("connexion", $data);
    }

    public function action_default() {
        $this->action_login();
    }
}
?>