<?php
class Controller_home extends Controller
{
    // Page d'accueil publique
    public function action_index()
    {
        // Pas besoin de session ni de vérif connexion ici !
        $this->render("home", [
            "title" => "Bienvenue sur Holinea"
        ]);
    }

    public function action_accueil()
    {
        // Pas besoin de session ni de vérif connexion ici !
        $this->render("accueil", [
            "title" => "Bienvenue sur Holinea"
        ]);
    }

    // Menu principal privé (pour utilisateurs connectés)
    public function action_dashboard()
    {
        session_start();
        if (!isset($_SESSION['id_utilisateur'])) {
            header("Location: ?Controller=connexion&action=login");
            exit();
        }
        $model = Model::getModel();
        $user = $model->getUserById($_SESSION['id_utilisateur']);
        $this->render("home", [
            "title" => "Menu principal",
            "user"  => $user,
        ]);
    }

    public function action_default()
    {
        $this->action_index();
    }
}
?>
