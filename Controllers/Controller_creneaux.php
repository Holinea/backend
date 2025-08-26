<?php
require_once 'Models/Model.php';

class Controller_creneaux extends Controller
{
    public function action_default() {
        $this->action_liste();
    }

    // Affiche tous les praticiens avec leurs créneaux sur 30j
    public function action_liste() {
        $model = Model::getModel();
        $praticiens_raw = $model->getAllPraticiensWithCreneaux();

        // Organise les données pour la vue (par praticien)
        $praticiens = [];
        foreach ($praticiens_raw as $row) {
            $id = $row['id_praticien'];
            if (!isset($praticiens[$id])) {
                $praticiens[$id] = [
                    'id' => $id,
                    'nom' => $row['nom'],
                    'prenom' => $row['prenom'],
                    'photo' => $row['photo_profil_url'] ?: 'default-therapist.jpg',
                    'description' => $row['description'],
                    'tarif' => $row['tarifs_consultation'],
                    'mode_consultation' => $row['mode_consultation'],
                    'creneaux' => []
                ];
            }
            if (!empty($row['jour'])) {
                $praticiens[$id]['creneaux'][$row['jour']][] = [
                    'debut' => $row['heure_debut'],
                    'fin' => $row['heure_fin']
                ];
            }
        }

        // Génère les dates des 30j à venir
        $dates = [];
        for ($i = 0; $i < 30; $i++) {
            $dates[] = date('Y-m-d', strtotime("+$i days"));
        }

        $this->render("praticiens_creneaux", [
            "praticiens" => $praticiens,
            "dates" => $dates
        ]);
    }

    // Ajoute un créneau (formulaire, POST)
    public function action_ajouter() {
        $model = Model::getModel();
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id_praticien = $_POST['id_praticien'];
            $jour = $_POST['jour'];
            $heure_debut = $_POST['heure_debut'];
            $heure_fin = $_POST['heure_fin'];
            $model->insertCreneau($id_praticien, $jour, $heure_debut, $heure_fin);
            header("Location: ?Controller=creneaux&action=liste");
            exit;
        }
        // Affiche formulaire
        $this->render("ajouter_creneau", []);
    }
}
