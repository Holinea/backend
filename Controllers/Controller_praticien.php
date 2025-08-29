<?php
require_once 'Models/Model.php';

class Controller_praticien extends Controller
{
    public function action_show()
    {
        $id = isset($_GET['id']) ? (int)$_GET['id'] : 0;
        if ($id <= 0) { $this->render("404"); return; }

        $model = Model::getModel();

        // ⚠ Assure-toi du bon nom de méthode: getPraticienById OU getPraticienById2
        $p = $model->getPraticienById2($id);

        if (!$p || strtolower(trim($p['statut_validation'] ?? '')) !== 'valide') {
            $this->render("404"); return;
        }

        $this->render("praticien_show", [
            'pageTitle'   => trim(($p['prenom'] ?? '').' '.($p['nom'] ?? '')).' - Profil',
            'p'           => $p,                     // <<< clé 'p' pour la vue
            'approches'   => $model->getApprochesByPraticien($id)   ?: [],
            'specialites' => $model->getSpecialitesByPraticien($id) ?: [],
            'dispos'      => $model->getDisposExtrait($id)          ?: [],
            'avis'        => $model->getAvisRecents($id)            ?: [],
        ]);
    }

    public function action_default() { $this->render("404"); }
}
