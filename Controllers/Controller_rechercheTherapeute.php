<?php


class Controller_rechercheTherapeute extends Controller {
    public function action_resultats() {
        // L'id du thérapeute connecté (issu de la session)
        session_start();
        $id_therapeute = $_SESSION['id_praticien'] ?? null;
        if (!$id_therapeute) {
            header("Location: ?Controller=connexion&action=login");
            exit;
        }

        $specialites = trim($_GET['specialites'] ?? '');
        $ville = trim($_GET['ville'] ?? '');
        $commun = isset($_GET['commun']);

        $model = Model::getModel();
        $resultats = $model->rechercherAutresTherapeutes($id_therapeute, $specialites, $ville, $commun);

        $this->render("recherche_therapeute", [
            "resultats" => $resultats,
            "specialites" => $specialites,
            "ville" => $ville,
            "commun" => $commun
        ]);
    }

    public function action_default() {
        $this->action_resultats();
    }
}
?>