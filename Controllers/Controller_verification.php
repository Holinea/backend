<?php
require_once 'Models/Model.php';
require_once dirname(__DIR__) . '/Utils/sms.php';

class Controller_verification extends Controller
{
    // Affiche le formulaire de code (appelé après inscription)
    public function action_default() {
        $this->action_showCodeForm();
    }

    public function action_showCodeForm() {
        $id_praticien = $_GET['id_praticien'] ?? $_POST['id_praticien'] ?? null;
        $error = $_GET['error'] ?? null;
        $this->render("code_verification", [
            "id_praticien" => $id_praticien,
            "error" => $error
        ]);
    }

    // Vérifie le code saisi par le thérapeute
    public function action_checkCode() {
        session_start();
        $code = $_POST['code'] ?? '';
        $model = Model::getModel();
    
        if (!isset($_SESSION['therapeute_inscription'])) {
            header("Location: ?Controller=therapeute&action=signup");
            exit;
        }
    
        if ($code === $_SESSION['code_verif'] && time() - $_SESSION['code_verif_time'] < 600) {
            $data = $_SESSION['therapeute_inscription'];
            $data['password'] = password_hash($data['password'], PASSWORD_DEFAULT);
    
            // Création user
            $userId = $model->insertUser(
                $data['nom'], $data['prenom'], $data['email'], $data['password'], 'therapeute', $data['telephone'],
                $data['consentement_cgu'], $data['consentement_partage_donnees']
            );
            var_dump($data['code_postal']);
            var_dump($data['specialites']);
            
            // Création praticien
            $model->insertPraticien([
                'mode_consultation' => $data['mode_consultation'],
                'adresse_cabinet' => $data['adresse_cabinet'],
                'diplomes' => $data['diplomes'],
                'nombre_heures_pratique' => $data['heures_pratique'],
                'description' => $data['description'],
                'annees_experience' => $data['annees_experience'],
                'tarifs_consultation' => $data['tarifs_consultation'],
                'photo_profil_url' => $data['photo_profil_url'],
                'code_postal' => $data['code_postal'],
                'specialites' => $data['specialites'],
                'Id_Utilisateur' => $userId
            ]);
    
            // Nettoie la session
            unset($_SESSION['therapeute_inscription'], $_SESSION['code_verif'], $_SESSION['code_verif_time']);
            header("Location: ?Controller=connexion&action=login");
            exit;
        } else {
            $this->render("code_verification", [
                "error" => "Code invalide ou expiré. Veuillez réessayer."
            ]);
        }
    }
    

    // Renvoyer un code
    public function action_resendCode() {
        $id_praticien = $_POST['id_praticien'];
        $model = Model::getModel();
        $praticien = $model->getPraticienById($id_praticien);
        if ($praticien) {
            // Générer nouveau code
            $code = str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
            $expiry = date('Y-m-d H:i:s', strtotime('+10 minutes'));
            $model->majCodeVerificationPraticien($id_praticien, $code, $expiry);

            // Récupérer le numéro dans Utilisateur
            $utilisateur = $model->getUserById($praticien['id_utilisateur'] ?? $praticien['Id_Utilisateur']);
            $telephone = $utilisateur['telephone_'] ?? null;

            if (!$telephone) {
                $this->render("code_verification", [
                    "id_praticien" => $id_praticien,
                    "error" => "Numéro de téléphone non trouvé pour ce compte. Contactez le support."
                ]);
                return;
            }

            // ===== FORMATTER LE NUMÉRO POUR TWILIO =====
            $telephone = str_replace([' ', '.', '-', '(', ')'], '', $telephone); // Nettoie les espaces
            if ($telephone && $telephone[0] !== '+') {
                if (strpos($telephone, '0') === 0) {
                    $telephone = '+33' . substr($telephone, 1); // Ex: 06... => +336...
                } elseif (strpos($telephone, '33') === 0) {
                    $telephone = '+' . $telephone; // Ex: 336... => +336...
                } elseif (strpos($telephone, '1') === 0) {
                    $telephone = '+1' . substr($telephone, 1); // Ex: 1xxxxxxxxxx => +1...
                }
            }
            error_log("Envoi SMS à $telephone");

            // Envoyer code SMS
            send_sms($telephone, "Votre code Holinea : $code");
        }
        header("Location: ?Controller=verification&action=showCodeForm&id_praticien=$id_praticien");
        exit;
    }
}
