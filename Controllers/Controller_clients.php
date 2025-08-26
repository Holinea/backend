<?php
require_once 'Models/Model.php';

class Controller_clients extends Controller
{
    // Par défaut, liste les clients associés au praticien connecté
    public function action_default() {
        $this->action_liste();
    }

    // Affiche la liste des patients associés à CE praticien
    public function action_liste() {
        session_start();
        $model = Model::getModel();

        // Vérifier la connexion
        $id_utilisateur = $_SESSION['id_utilisateur'] ?? null;
        if (!$id_utilisateur) {
            header("Location: ?Controller=connexion&action=login");
            exit;
        }

        // On récupère le praticien correspondant à l'utilisateur connecté
        $praticien = $model->getPraticienByUserId($id_utilisateur);
        if (!$praticien) {
            $this->render("liste_client", [
                "patients" => [],
                "error" => "Aucun praticien trouvé pour ce compte."
            ]);
            return;
        }

        $id_praticien = $praticien['id_praticien'];
        $patients = $model->getPatientsOfPraticien($id_praticien);
        $this->render("liste_client", ["patients" => $patients]);
    }

    // Affiche le détail d'un patient
    public function action_detail() {
        $numero_dossier = $_GET['numero_dossier'] ?? null;
        if (!$numero_dossier) {
            header("Location: ?Controller=clients&action=liste");
            exit;
        }
        $model = Model::getModel();
        $patient = $model->getPatientFullInfos($numero_dossier);
        if (!$patient) {
            $this->render("liste_client", [
                "error" => "Client introuvable."
            ]);
        } else {
            $this->render("detail_client", [
                "patient" => $patient
            ]);
        }
    }
}
