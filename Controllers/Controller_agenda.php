<?php
require_once 'Models/Model.php';

class Controller_agenda extends Controller
{
    public function action_default()
    {
        $this->action_showAgenda();
    }

    public function action_showAgenda()
    {
        session_start();
        // (Optionnel) Vérifie que le thérapeute est connecté
        if (empty($_SESSION['id_utilisateur']) || ($_SESSION['role'] ?? '') != 'therapeute') {
            header("Location: ?Controller=connexion&action=login");
            exit;
        }

        // Exemple statique : la liste des événements sera intégrée côté JS dans la vue
        // Si tu veux alimenter dynamiquement, tu pourrais ici charger les RDV du thérapeute :
        /*
        $model = Model::getModel();
        $events = $model->getRdvByTherapeute($_SESSION['id_utilisateur']);
        */

        $this->render("agenda", [
            "title" => "Mon agenda",
            // "events" => $events // à décommenter quand tu feras la partie dynamique
        ]);
    }
}
