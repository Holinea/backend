<?php
require_once 'Models/Model.php';

class Controller_agenda extends Controller
{
    public function action_index()
    {
        if (session_status() !== PHP_SESSION_ACTIVE) session_start();

        // réservé au praticien connecté
        if (empty($_SESSION['role']) || $_SESSION['role'] !== 'praticien') {
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }

        // données d’en-tête (nom/avatar dans la barre latérale si besoin)
        $me = [
            'avatar' => $_SESSION['user_avatar'] ?? 'Content/img/avatar.png',
            'name'   => $_SESSION['user_name']   ?? '—',
            'role'   => $_SESSION['user_title']  ?? 'Praticien',
        ];

        $this->render('agenda', [
            'me' => $me
        ]);
    }

    public function action_default(){ $this->action_index(); }
}
