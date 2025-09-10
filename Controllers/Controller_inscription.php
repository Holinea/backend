<?php
require_once 'Models/Model.php';

class Controller_inscription extends Controller
{
    public function action_register() {
        if (session_status() === PHP_SESSION_NONE) session_start();
        $this->render('patient_register', [
            'errors' => $_SESSION['flash_errors'] ?? [],
            'old'    => $_SESSION['flash_old']    ?? [],
        ]);
        unset($_SESSION['flash_errors'], $_SESSION['flash_old']);
    }

    public function action_register_submit() {
        if (session_status() === PHP_SESSION_NONE) session_start();

        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            header('Location: index.php?Controller=inscription&action=register'); exit;
        }

        $email = trim($_POST['email'] ?? '');
        $nom   = trim($_POST['nom'] ?? '');
        $pre   = trim($_POST['prenom'] ?? '');
        $tel   = trim($_POST['telephone'] ?? '');
        $pass1 = $_POST['password'] ?? '';
        $pass2 = $_POST['password_confirm'] ?? '';
        $cgu   = isset($_POST['agree_cgu']);
        $verif = isset($_POST['agree_truth']);

        $errors = [];
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) $errors['email'] = "Email invalide.";
        if ($nom==='')   $errors['nom']   = "Nom requis.";
        if ($pre==='')   $errors['prenom']= "Prénom requis.";
        if (strlen($pass1) < 8) $errors['password'] = "Mot de passe trop court (min. 8).";
        if ($pass1 !== $pass2)  $errors['password_confirm'] = "La confirmation ne correspond pas.";
        if (!$cgu)  $errors['agree_cgu']   = "Vous devez accepter les CGU.";
        if (!$verif)$errors['agree_truth'] = "Vous attestez l'exactitude des informations.";

        $m = Model::getModel();
        if ($m->userExists($email)) $errors['email'] = "Un compte existe déjà avec cet email.";

        // Upload avatar
        $tmpAvatar = null;
        if (!empty($_FILES['avatar']['tmp_name']) && is_uploaded_file($_FILES['avatar']['tmp_name'])) {
            $okTypes = ['image/jpeg','image/png','image/webp'];
            if (!in_array(mime_content_type($_FILES['avatar']['tmp_name']), $okTypes, true)) {
                $errors['avatar'] = "Format d'image non supporté.";
            } else {
                $tmpAvatar = sys_get_temp_dir() . '/upl_' . uniqid() . '.' .
                             (pathinfo($_FILES['avatar']['name'], PATHINFO_EXTENSION) ?: 'jpg');
                move_uploaded_file($_FILES['avatar']['tmp_name'], $tmpAvatar);
            }
        }

        if ($errors) {
            $_SESSION['flash_errors'] = $errors;
            $_SESSION['flash_old'] = [
                'email'=>$email,'nom'=>$nom,'prenom'=>$pre,'telephone'=>$tel,
                'agree_cgu'=>$cgu,'agree_truth'=>$verif
            ];
            header('Location: index.php?Controller=inscription&action=register'); exit;
        }

        try {
            $idUser = $m->createPatientWithUser([
                'mail'=>$email,'nom'=>$nom,'prenom'=>$pre,
                'telephone'=>$tel,'mot_de_passe'=>$pass1,
                'avatar_tmp'=>$tmpAvatar
            ]);
        } catch (\Throwable $e) {
            $_SESSION['flash_errors'] = ['global'=>"Impossible de créer le compte."];
            $_SESSION['flash_old'] = ['email'=>$email,'nom'=>$nom,'prenom'=>$pre,'telephone'=>$tel];
            header('Location: index.php?Controller=inscription&action=register'); exit;
        }

        // ✅ Redirige vers la page de connexion après succès
        header('Location: index.php?Controller=connexion_patient&action=index');
        exit;
    }

    // 🔹 Implémentation de la méthode obligatoire
    public function action_default() {
        $this->action_register();
    }
}
