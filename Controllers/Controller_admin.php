<?php
require_once 'Models/Model.php';

class Controller_admin extends Controller
{
    private function mustBeAdmin() {
        if (session_status() === PHP_SESSION_NONE) session_start();
        if (empty($_SESSION['role']) || $_SESSION['role'] !== 'admin') {
            header('Location: index.php?Controller=connexion&action=index'); exit;
        }
    }

    public function action_index() {
        $this->mustBeAdmin();
        $m = Model::getModel();
        $users = $m->getAllPatients();
        $this->render('admin_dashboard', ['users'=>$users]);
    }

    public function action_update_status() {
        $this->mustBeAdmin();
        $id = (int)($_POST['id'] ?? 0);
        $status = $_POST['status'] ?? '';
        $m = Model::getModel();
        $m->updateUserStatus($id, $status);
        header('Location: index.php?Controller=admin&action=index');
    }

    public function action_default() { $this->action_index(); }
}
