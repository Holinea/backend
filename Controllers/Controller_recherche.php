<?php

class Controller_recherche extends Controller {
    public function action_recherche() {
        $modalite     = $_POST['modalite']     ?? $_GET['modalite']     ?? 'cabinet';
        $specialites  = trim($_POST['specialites']  ?? $_GET['specialites']  ?? '');
        $code_postal  = trim($_POST['code_postal'] ?? $_GET['code_postal'] ?? '');
        $autour       = isset($_POST['autour']) ? true : (isset($_GET['autour']) ? true : false);

        $order        = $_GET['order'] ?? ''; // <-- NOUVEAU

        $model = Model::getModel();
        // Passe le paramètre $order à la fonction rechercherPraticiens :
        $resultats = $model->rechercherPraticiens($modalite, $specialites, $code_postal, $autour, $order);

        $show_results = !empty($specialites) || !empty($code_postal) || $autour || isset($modalite);

        $data = [
            'resultats'   => $resultats,
            'modalite'    => $modalite,
            'specialites' => $specialites,
            'code_postal' => $code_postal,
            'autour'      => $autour,
            'show_results'=> $show_results,
            'order'       => $order // <-- NOUVEAU (pour la vue si besoin)
        ];
        $this->render("resultats_praticiens", $data);
    }

    public function action_default() {
        $this->action_recherche();
    }
}

?>
