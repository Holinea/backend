<?php
/**
 * Controller_recherche
 * - Affiche l'écran de recherche (formulaire)
 * - Exécute la recherche et affiche les résultats
 */
class Controller_recherche extends Controller
{
    public function action_index() {
        $model = Model::getModel();

        // Facettes pour les <select>
        $specialites = $model->getSpecialites();     // ex: ["Naturopathie","Ostéopathie",...]
        $approches   = $model->getTypesApproche();   // ex: ["Énergétique","Manuelle",...]

        $data = [
            'modalite'    => $_POST['modalite']    ?? $_GET['modalite']    ?? 'cabinet',
            'specialite'  => $_POST['specialite']  ?? $_GET['specialite']  ?? '',
            'approche'    => $_POST['approche']    ?? $_GET['approche']    ?? '',
            'specialites' => $specialites,
            'approches'   => $approches
        ];
        $this->render("recherche_praticiens", $data);
    }

    public function action_recherche() {
        $model = Model::getModel();

        $modalite   = $_POST['modalite']   ?? $_GET['modalite']   ?? 'cabinet';
        $specialite = $_POST['specialite'] ?? $_GET['specialite'] ?? '';
        $approche   = $_POST['approche']   ?? $_GET['approche']   ?? '';

        $order      = $_GET['order'] ?? ''; // "nom", "experience", etc. (optionnel)

        $resultats = $model->rechercherPraticiensSimple([
            'modalite'   => $modalite,
            'specialite' => $specialite,
            'approche'   => $approche,
            'order'      => $order
        ]);
        $data = [
            'modalite'   => $modalite,
            'specialite' => $specialite,
            'approche'   => $approche,
            'order'      => $order,
            'resultats'  => $resultats
        ];

        $this->render("resultats_praticiens", $data);
    }

    public function action_default() {
        $this->action_index();
    }
}
