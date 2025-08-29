<?php
require_once 'Models/Model.php';

class Controller_clients extends Controller
{
    public function action_index()
    {
        // sécurité basique : réservé aux thérapeutes
        if (($_SESSION['role'] ?? '') !== 'therapeute') {
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        // Récup identité connectée (pour la sidebar)
        $me = [
            'name'   => $_SESSION['user_name']   ?? '—',
            'avatar' => $_SESSION['user_avatar'] ?? 'Content/img/avatar.png',
            'role'   => 'Naturopathe', // si tu l’as en BDD, remplace par la vraie valeur
        ];

        // Récup patients (via Model)
        $patients = $this->model->getPatients(); // -> array
        // Tri par dernier RDV desc
        usort($patients, function($a,$b){
            return strcmp($b['dernier_rdv'] ?? '', $a['dernier_rdv'] ?? '');
        });

        $this->render('clients_index', [
            'patients' => $patients,
            'me'       => $me,
        ]);
    }

    public function action_default(){ $this->action_index(); }
}
