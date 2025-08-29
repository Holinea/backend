<?php
require_once 'Models/Model.php';

class Controller_clients extends Controller
{
    public function action_index()
    {
        if (session_status() !== PHP_SESSION_ACTIVE) session_start();

        // Accès réservé au praticien connecté
        if (empty($_SESSION['role']) || $_SESSION['role'] !== 'praticien') {
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        // Pour l’instant, on n’affiche pas encore de patients (pas de CSV / pas de BDD clients).
        $patients = []; // à peupler plus tard

        // Infos de l’utilisateur connecté (sidebar / header)
        $me = [
            'avatar' => $_SESSION['user_avatar'] ?? 'Content/img/avatar.png',
            'name'   => $_SESSION['user_name']   ?? '—',
            'role'   => $_SESSION['user_title']  ?? 'Praticien',
        ];

        $this->render('clients_index', [
            'patients' => $patients,
            'me'       => $me,
        ]);
    }

    public function action_default(){ $this->action_index(); }
}
