<?php
require_once 'Models/Model.php';

class Controller_patient extends Controller
{
    public function action_dashboard()
    {
        session_start();
        
        if (empty($_SESSION['role']) || $_SESSION['role'] !== 'patient' || empty($_SESSION['patient'])) {
            header('Location: index.php?Controller=connexion&action=index');
            exit;
        }
        $this->render('patient_dashboard', [
            'p' => $_SESSION['patient'],
        ]);
    }

    public function action_default(){ $this->action_dashboard(); }
}
