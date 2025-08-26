<?php
require_once 'Models/Model.php';
require_once dirname(__DIR__) . '/Utils/sms.php';

class Controller_therapeute extends Controller
{
    public function action_default()
    {
        $this->action_signup();
    }

    public function action_signup()
    {
        $this->render("signup", ["title" => "Création de compte Thérapeute"]);
    }

    public function action_checkSignup()
    {
        // Vérification des champs obligatoires
        $required = [
            'email', 'password', 'nom', 'prenom', 'diplomes', 'telephone',
            'annees_experience', 'heures_pratique', 'specialites', 'consentement_cgu'
        ];
        foreach ($required as $field) {
            if (empty($_POST[$field])) {
                $this->render("signup", [
                    "title" => "Création de compte Thérapeute",
                    "error" => "Veuillez remplir tous les champs obligatoires."
                ]);
                return;
            }
        }

        // Récupération des données
        $email = trim($_POST['email']);
        $password = $_POST['password'];
        $nom = trim($_POST['nom']);
        $prenom = trim($_POST['prenom']);
        $telephone = trim($_POST['telephone'] ?? null);
        $mode_consultation = $_POST['mode_consultation'] ?? null;
        $adresse_cabinet = trim($_POST['adresse_cabinet'] ?? null);
        $diplomes = trim($_POST['diplomes']);
        $annees_experience = intval($_POST['annees_experience']);
        $code_postal = trim($_POST['code_postal'] ?? '');
        $specialites = trim($_POST['specialites'] ?? '');
        $heures_pratique = intval($_POST['heures_pratique']);
        $specialites = trim($_POST['specialites']);
        $tarifs_consultation = isset($_POST['tarifs_consultation']) ? floatval($_POST['tarifs_consultation']) : null;
        $description = trim($_POST['description'] ?? '');
        $consentement_cgu = isset($_POST['consentement_cgu']) ? 1 : 0;
        $consentement_partage_donnees = isset($_POST['consentement_partage_donnees']) ? 1 : 0;

        $photo_profil_url = null;
if (!empty($_FILES['photo_profil']['name'])) {
    $uploadDir = "Uploads/photos/";
    if (!is_dir($uploadDir)) { mkdir($uploadDir, 0755, true); }
    $originalName = basename($_FILES['photo_profil']['name']);
    $fileTmp = $_FILES['photo_profil']['tmp_name'];
    $extension = strtolower(pathinfo($originalName, PATHINFO_EXTENSION));
    $fileNameBase = uniqid() . "_" . preg_replace('/[^a-zA-Z0-9._-]/', '_', $originalName);

    // Si l'extension est heic, conversion automatique en jpg (avec Imagick)
    if ($extension === 'heic') {
        if (class_exists('Imagick')) {
            $image = new Imagick();
            $image->readImage($fileTmp);
            $fileName = preg_replace('/\.heic$/i', '.jpg', $fileNameBase);
            $targetFile = $uploadDir . $fileName;
            $image->setImageFormat('jpg');
            $image->writeImage($targetFile);
            $image->clear();
            $image->destroy();
            $photo_profil_url = $targetFile;
        } else {
            // Imagick n'est pas installé, refuse l'upload
            $this->render("signup", [
                "title" => "Création de compte Thérapeute",
                "error" => "Le format .heic n'est pas supporté par ce serveur. Merci d'utiliser JPG ou PNG."
            ]);
            return;
        }
    } else {
        $targetFile = $uploadDir . $fileNameBase;
        if (move_uploaded_file($fileTmp, $targetFile)) {
            $photo_profil_url = $targetFile;
        }
    }
}


        $model = Model::getModel();

        // Vérifie si l'email existe déjà
        if ($model->getUserByEmail($email)) {
            $this->render("signup", [
                "title" => "Création de compte Thérapeute",
                "error" => "Un compte avec cet email existe déjà."
            ]);
            return;
        }

        // Ici on NE crée PAS le compte tout de suite, on stocke tout en session
        session_start();
        $_SESSION['therapeute_inscription'] = [
            'email' => $email,
            'password' => $password,
            'nom' => $nom,
            'prenom' => $prenom,
            'telephone' => $telephone,
            'mode_consultation' => $mode_consultation,
            'adresse_cabinet' => $adresse_cabinet,
            'diplomes' => $diplomes,
            'annees_experience' => $annees_experience,
            'heures_pratique' => $heures_pratique,
            'specialites' => $specialites,
            'code_postal' => $code_postal,
            'tarifs_consultation' => $tarifs_consultation,
            'description' => $description,
            'consentement_cgu' => $consentement_cgu,
            'consentement_partage_donnees' => $consentement_partage_donnees,
            'photo_profil_url' => $photo_profil_url,
        ];

        // Génère code de vérification + envoie SMS
        $code = str_pad(rand(0, 999999), 6, '0', STR_PAD_LEFT);
        $_SESSION['code_verif'] = $code;
        $_SESSION['code_verif_time'] = time();
        send_sms($telephone, "Votre code Holinea : $code");

        // Redirige vers la page de saisie du code
        header("Location: ?Controller=verification&action=showCodeForm");
        exit;
    }
}
