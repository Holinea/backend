<?php
require_once 'Models/Model.php';

class Controller_clients extends Controller
{
    private string $csvPath = 'Content/data/patients.csv';

    public function action_index()
    {
        session_start();

        // Accès réservé au praticien connecté
        if (empty($_SESSION['role']) || $_SESSION['role'] !== 'praticien') {
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        $m = Model::getModel();
        $patients = $m->readCsvPatients($this->csvPath);

        // Tri desc. par date de dernier RDV
        usort($patients, function($a, $b){
            return strcmp($b['dernier_rdv'] ?? '', $a['dernier_rdv'] ?? '');
        });

        $this->render('clients_index', [
            'patients' => $patients,
        ]);
    }

    public function action_default(){ $this->action_index(); }
}
