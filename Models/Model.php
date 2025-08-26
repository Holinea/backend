<?php

class Model
{
    /**
     * Attribut contenant l'instance PDO
     */
    private $bd;

    /**
     * Attribut statique qui contiendra l'unique instance de Model
     */
    private static $instance = null;

    /**
     * Constructeur : effectue la connexion à la base de données.
     */
    private function __construct()
    {
        include "./Content/credentials.php";
        $this->bd = new PDO($dsn, $login, $mdp);
        $this->bd->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $this->bd->query("SET nameS 'utf8'");
    }

    /**
     * Méthode permettant de récupérer un modèle car le constructeur est privé (Implémentation du Design Pattern Singleton)
     */
    public static function getModel()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
   
    public function insertPraticien($data) {
        $sql = "INSERT INTO praticien (
                    mode_consultation, adresse_cabinet, diplomes, nombre_heures_pratique, description,
                    annees_experience, tarifs_consultation, photo_profil_url, taux_satisfaction, statut_validation, Id_Utilisateur, code_postal, specialites
                ) VALUES (
                    :mode_consultation, :adresse_cabinet, :diplomes, :nombre_heures_pratique, :description,
                    :annees_experience, :tarifs_consultation, :photo_profil_url, NULL, 'en attente', :Id_Utilisateur, :code_postal, :specialites
                )";
            $stmt = $this->bd->prepare($sql);
            $stmt->bindValue(':mode_consultation', $data['mode_consultation'] ?? null);
            $stmt->bindValue(':adresse_cabinet', $data['adresse_cabinet'] ?? null);
            $stmt->bindValue(':diplomes', $data['diplomes'] ?? null);
            $stmt->bindValue(':nombre_heures_pratique', $data['nombre_heures_pratique'] ?? null);
            $stmt->bindValue(':description', $data['description'] ?? null);
            $stmt->bindValue(':annees_experience', $data['annees_experience'] ?? null);
            $stmt->bindValue(':tarifs_consultation', $data['tarifs_consultation'] ?? null);
            $stmt->bindValue(':photo_profil_url', $data['photo_profil_url'] ?? null);
            $stmt->bindValue(':Id_Utilisateur', $data['Id_Utilisateur']);
            $stmt->bindValue(':code_postal', $data['code_postal'] ?? null);
            $stmt->bindValue(':specialites', $data['specialites'] ?? null);
            $success = $stmt->execute();
    
        if (!$success) {
            $error = $stmt->errorInfo();
            error_log(print_r($error, true)); // Pour voir l'erreur dans les logs
        }
    
        return $success;
    }
        

    public function getUserByEmail($email) {
        $stmt = $this->bd->prepare("SELECT * FROM utilisateur WHERE mail = :email");
        $stmt->bindParam(':email', $email);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    public function insertUser($nom, $prenom, $email, $hashedPassword, $role = 'therapeute', $telephone = null, $consentement_cgu = true, $consentement_partage = false) {
        $sql = "INSERT INTO utilisateur (
                    mail, nom, prenom, date_inscription, derniere_connexion,
                    role_utilisateur, statut_compte, mot_de_passe,
                    consentement_cgu, consentement_partage_donnees_sante_,
                    telephone_
                )
                VALUES (
                    :mail, :nom, :prenom, CURRENT_DATE, NOW(),
                    :role_utilisateur, 'actif', :mot_de_passe,
                    :consentement_cgu, :consentement_partage_donnees_sante_,
                    :telephone_
                )";
                
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':mail', $email);
        $stmt->bindParam(':nom', $nom);
        $stmt->bindParam(':prenom', $prenom);
        $stmt->bindParam(':role_utilisateur', $role);
        $stmt->bindParam(':mot_de_passe', $hashedPassword);
        $stmt->bindParam(':consentement_cgu', $consentement_cgu, PDO::PARAM_BOOL);
        $stmt->bindParam(':consentement_partage_donnees_sante_', $consentement_partage, PDO::PARAM_BOOL);
        $stmt->bindParam(':telephone_', $telephone, $telephone !== null ? PDO::PARAM_INT : PDO::PARAM_NULL);

        if ($stmt->execute()) {
            return $this->bd->lastInsertId();
        } else {
            return false;
        }
    }
    public function getByEmail($mail) {
     
        $stmt = $this->bd->prepare("SELECT * FROM utilisateur WHERE mail = :mail");
        $stmt->execute(['mail' => $mail]);
        return $stmt->fetch(PDO::FETCH_ASSOC); 
    }

    
        public function getUserById($id)
    {
        $sql = "SELECT * FROM utilisateur WHERE id_utilisateur = :id";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
        // Récupère un praticien par ID
    public function getPraticienById($id) {
        $stmt = $this->bd->prepare("SELECT * FROM praticien WHERE id_praticien = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    // Met à jour le code de vérification + expiration
    public function majCodeVerificationPraticien($id, $code, $expiry) {
        $sql = "UPDATE praticien SET code_verification = :code, code_expiry = :expiry WHERE id_praticien = :id";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':code', $code);
        $stmt->bindParam(':expiry', $expiry);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
    }

    // Valide le téléphone
    public function validerTelephonePraticien($id) {
        $sql = "UPDATE praticien SET telephone_verifie = TRUE, code_verification = NULL, code_expiry = NULL WHERE id_praticien = :id";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':id', $id);
        $stmt->execute();
    }
    public function getLastPraticienIdByUser($userId) {
        $stmt = $this->bd->prepare("SELECT id_praticien FROM praticien WHERE id_utilisateur = :uid ORDER BY id_praticien DESC LIMIT 1");
        $stmt->bindParam(':uid', $userId);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        return $row ? $row['id_praticien'] : null;
    }
    
    // Récupère tous les patients avec toutes les infos (jointure utilisateur + patient)
    public function getAllPatientsWithInfos() {
        $sql = "SELECT utilisateur.*, patient.*
                FROM patient
                JOIN utilisateur ON patient.id_utilisateur = utilisateur.id_utilisateur
                ORDER BY utilisateur.nom, utilisateur.prenom";
        $stmt = $this->bd->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // (optionnel) Récupère toutes les infos d'un patient donné
    public function getPatientFullInfos($numero_dossier) {
        $sql = "SELECT utilisateur.*, patient.*
                FROM patient
                JOIN utilisateur ON patient.id_utilisateur = utilisateur.id_utilisateur
                WHERE patient.numero_dossier = :num";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':num', $numero_dossier);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    public function getPatientsOfPraticien($id_praticien) {
        $sql = "SELECT u.*, p.*
                FROM praticien_consulte pc
                JOIN patient p ON pc.numero_dossier = p.numero_dossier
                JOIN utilisateur u ON p.id_utilisateur = u.id_utilisateur
                WHERE pc.id_praticien = :idp
                ORDER BY u.nom, u.prenom";
        $stmt = $this->bd->prepare($sql);
        $stmt->bindParam(':idp', $id_praticien);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    public function getPraticienByUserId($id_utilisateur) {
        $stmt = $this->bd->prepare("SELECT * FROM praticien WHERE id_utilisateur = :id");
        $stmt->bindParam(':id', $id_utilisateur);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
    // Récupère tous les praticiens avec leurs infos + créneaux
    public function getAllPraticiensWithCreneaux() {
        $sql = "
            SELECT 
                p.id_praticien, u.nom, u.prenom, p.photo_profil_url,
                p.description, p.tarifs_consultation, p.mode_consultation,
                c.jour, c.heure_debut, c.heure_fin
            FROM praticien p
            JOIN utilisateur u ON p.id_utilisateur = u.id_utilisateur
            LEFT JOIN agenda a ON p.id_praticien = a.id_praticien
            LEFT JOIN creneaux c ON a.id_agenda = c.id_agenda
            WHERE c.jour BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '30 days'
            ORDER BY u.nom, c.jour, c.heure_debut
        ";
        $stmt = $this->bd->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    // (Facultatif) Créer un créneau pour un praticien
    public function insertCreneau($id_praticien, $jour, $heure_debut, $heure_fin) {
        // Récupérer ou créer l'agenda du praticien
        $sql = "SELECT id_agenda FROM agenda WHERE id_praticien = :pid";
        $stmt = $this->bd->prepare($sql);
        $stmt->execute(['pid' => $id_praticien]);
        $agenda = $stmt->fetch(PDO::FETCH_ASSOC);

        if (!$agenda) {
            $this->bd->prepare("INSERT INTO agenda (id_praticien) VALUES (:pid)")
                ->execute(['pid' => $id_praticien]);
            $id_agenda = $this->bd->lastInsertId();
        } else {
            $id_agenda = $agenda['id_agenda'];
        }

        // Insérer le créneau
        $sql = "INSERT INTO creneaux (id_agenda, jour, heure_debut, heure_fin)
                VALUES (:id_agenda, :jour, :heure_debut, :heure_fin)";
        $this->bd->prepare($sql)->execute([
            'id_agenda' => $id_agenda,
            'jour' => $jour,
            'heure_debut' => $heure_debut,
            'heure_fin' => $heure_fin,
        ]);
    }
    
    public function rechercherPraticiens($modalite, $specialite, $localisation, $autour, $order = '') {
        $sql = "SELECT praticien.*, utilisateur.nom, utilisateur.prenom
                FROM praticien
                JOIN utilisateur ON praticien.id_utilisateur = utilisateur.id_utilisateur
                WHERE 1=1 ";
        $params = [];
    
        // Filtrage modalité (cabinet/distance)
        if ($modalite == "cabinet") {
            $sql .= " AND (mode_consultation = 'cabinet')";
        } else if ($modalite == "distance") {
            $sql .= " AND (mode_consultation = 'distance')";
        }
    
        // Filtrage spécialité
        if (!empty($specialite)) {
            $sql .= " AND (specialites ILIKE :spec)";
            $params[':spec'] = '%'.$specialite.'%';
        }
    
        // Filtrage localisation
        if ($modalite == "cabinet" && !empty($localisation)) {
            $sql .= " AND (code_postal LIKE :loc)";
            $params[':loc'] = '%'.$localisation.'%';
        }
    
        // Tri dynamique selon le filtre
        if ($order === 'experience') {
            $sql .= " ORDER BY praticien.annees_experience DESC";
        } elseif ($order === 'localisation') {
            $sql .= " ORDER BY praticien.code_postal ASC"; // Par code postal croissant
        } elseif ($order === 'notes') {
            $sql .= " ORDER BY praticien.taux_satisfaction DESC";
        } else {
            $sql .= " ORDER BY praticien.id_praticien ASC";
        }
    
        $requete = $this->bd->prepare($sql);
        $requete->execute($params);
        return $requete->fetchAll(PDO::FETCH_ASSOC);
    }

    ///A ...................................................VOIR
    public function rechercherAutresTherapeutes($id_therapeute, $specialites = '', $ville = '', $commun = false) {
        $params = [':id_therapeute' => $id_therapeute];
        $sql = "SELECT p.*, u.nom, u.prenom, u.email, u.telephone, u.photo_profil_url";
    
        // Si client en commun, on ajoute le nombre de clients partagés
        if ($commun) {
            $sql .= ",
                (
                    SELECT COUNT(DISTINCT r2.id_client)
                    FROM rdv r1
                    JOIN rdv r2 ON r1.id_client = r2.id_client
                    WHERE r1.id_praticien = :id_therapeute
                      AND r2.id_praticien = p.id_praticien
                      AND r2.id_praticien != r1.id_praticien
                ) as nb_clients_commun
            ";
        }
    
        $sql .= "
            FROM praticien p
            JOIN utilisateur u ON p.id_utilisateur = u.id_utilisateur
            WHERE p.id_praticien != :id_therapeute
        ";
    
        if (!empty($specialites)) {
            $sql .= " AND p.specialites ILIKE :spec";
            $params[':spec'] = '%' . $specialites . '%';
        }
        if (!empty($ville)) {
            $sql .= " AND p.adresse_cabinet ILIKE :ville";
            $params[':ville'] = '%' . $ville . '%';
        }
        if ($commun) {
            $sql .= " HAVING nb_clients_commun > 0";
        }
    
        $sql .= " ORDER BY u.nom, u.prenom";
    
        $req = $this->bd->prepare($sql);
        $req->execute($params);
        return $req->fetchAll(PDO::FETCH_ASSOC);
    }
    
    public function getIdPraticienByUtilisateur($id_utilisateur) {
        $sql = "SELECT id_praticien FROM praticien WHERE id_utilisateur = :id_utilisateur LIMIT 1";
        $req = $this->bd->prepare($sql);
        $req->execute([':id_utilisateur' => $id_utilisateur]);
        $row = $req->fetch(PDO::FETCH_ASSOC);
        return $row ? $row['id_praticien'] : null;
    }    
    

}
