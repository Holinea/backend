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
    // === À AJOUTER dans la classe Model (PostgreSQL via PDO) ===

/**
 * Retourne la liste des spécialités distinctes.
 * Adaptez le nom de table/colonne si besoin.
 */
public function getSpecialites(): array {
    $sql = "SELECT DISTINCT UNNEST(string_to_array(specialites, ',')) AS s
            FROM praticien
            WHERE specialites IS NOT NULL AND specialites <> ''
            ORDER BY s ASC";
    $req = $this->bd->query($sql);
    return array_values(array_filter(array_map('trim', array_column($req->fetchAll(PDO::FETCH_ASSOC),'s'))));
}

// --- Facette : types d'approche --------------------------------------------
public function getTypesApproche(): array {
    // Essaie de lire depuis la DB si la colonne existe, sinon fallback statique.
    try {
        $sql = "SELECT DISTINCT TRIM(type_approche) AS approche
                FROM praticien
                WHERE type_approche IS NOT NULL AND type_approche <> ''
                ORDER BY 1;";
        $rows = $this->bd->query($sql)->fetchAll(PDO::FETCH_ASSOC);
        $out = [];
        foreach ($rows as $r) { if (!empty($r['approche'])) $out[] = $r['approche']; }
        if ($out) return $out;
    } catch (\Throwable $e) { /* colonne absente => fallback */ }

    // Fallback (modifie librement cette liste)
    return ["Énergétique", "Manuelle", "Intégrative", "Prévention", "Coaching"];
}

// --- Recherche praticiens (filtres & sélection des colonnes nécessaires) ----
public function rechercherPraticiensSimple(array $filters): array {
    // Filtres attendus : modalite, specialite, approche, ville_cp, order
    $where  = ["p.statut_validation = 'valide'"];
    $params = [];

    if (!empty($filters['modalite'])) {
        $where[] = "p.mode_consultation = :modalite";
        $params[':modalite'] = $filters['modalite'];
    }

    if (!empty($filters['specialite'])) {
        // match dans la chaîne CSV specialites (insensible à la casse)
        $where[] = "p.specialites ILIKE :spec";
        $params[':spec'] = '%'.$filters['specialite'].'%';
    }

    if (!empty($filters['approche'])) {
        // n’applique que si la colonne existe
        try {
            $this->bd->query("SELECT p.type_approche FROM praticien p LIMIT 1");
            $where[] = "p.type_approche ILIKE :approche";
            $params[':approche'] = '%'.$filters['approche'].'%';
        } catch (\Throwable $e) { /* ignore si colonne absente */ }
    }

    if (!empty($filters['ville_cp'])) {
        // recherche souple : code postal, ville, ou adresse
        $where[] = "(p.code_postal ILIKE :villecp OR COALESCE(p.ville,'') ILIKE :villecp OR p.adresse_cabinet ILIKE :villecp)";
        $params[':villecp'] = '%'.$filters['ville_cp'].'%';
    }

    // Tri
    $order = "p.taux_satisfaction DESC NULLS LAST,
              p.annees_experience DESC NULLS LAST,
              u.nom ASC";
    if (!empty($filters['order'])) {
        switch ($filters['order']) {
            case 'nom':         $order = "u.nom ASC, u.prenom ASC"; break;
            case 'experience':  $order = "p.annees_experience DESC NULLS LAST, u.nom ASC"; break;
            case 'tarif_min':   $order = "NULLIF(regexp_replace(p.tarifs_consultation, '\\D', '', 'g'), '')::int ASC NULLS LAST, u.nom ASC"; break;
            case 'tarif_max':   $order = "NULLIF(regexp_replace(p.tarifs_consultation, '\\D', '', 'g'), '')::int DESC NULLS LAST, u.nom ASC"; break;
            default: /* garde l’ordre par défaut */ break;
        }
    }

    // Sélection : toutes les colonnes utiles à la vue
    $sql = "
        SELECT
            p.id_praticien,
            p.mode_consultation,
            p.adresse_cabinet,
            p.code_postal,
            COALESCE(p.ville, '') AS ville,               -- ajoute la colonne en base si possible
            p.photo_profil_url,
            p.specialites,
            p.description,
            p.tarifs_consultation,
            p.annees_experience,
            p.taux_satisfaction,
            p.diplomes,
            /* colonne optionnelle -> renvoyée si elle existe, sinon NULL */
            " . (function_exists('pg_parameter_status') ? "" : "") . "
            NULL::int AS nb_avis,
            " . (/* essaye d'inclure type_approche si présent */ "
            (SELECT CASE WHEN EXISTS (
                SELECT 1 FROM information_schema.columns
                 WHERE table_name='praticien' AND column_name='type_approche'
            ) THEN p.type_approche ELSE NULL END
            ) AS type_approche
            ") . ",
            u.nom, u.prenom, u.mail, u.telephone_
        FROM praticien p
        JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
        " . (count($where) ? "WHERE ".implode(" AND ", $where) : "") . "
        ORDER BY $order
        LIMIT 50;
    ";

    $stmt = $this->bd->prepare($sql);
    foreach ($params as $k => $v) {
        $stmt->bindValue($k, $v, PDO::PARAM_STR);
    }
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
    
// Model.php
public function searchCommunes(string $term, int $limit = 10): array
{
    // IMPORTANT : avec PDO pgsql, on n'utilise PAS $1/$2 → utiliser ? ou :named
    $isCp = preg_match('/^\d{2,5}$/', $term) === 1;

    if ($isCp) {
        $sql = "SELECT code_postal, nom_commune
                FROM commune
                WHERE code_postal LIKE :t || '%'
                ORDER BY code_postal, nom_commune
                LIMIT :lim";
    } else {
        $sql = "SELECT code_postal, nom_commune
                FROM commune
                WHERE LOWER(nom_commune) LIKE '%' || LOWER(:t) || '%'
                   OR code_postal LIKE :t || '%'
                ORDER BY code_postal, nom_commune
                LIMIT :lim";
    }

    // ⚠️ Utilise le bon handle PDO de TA classe (souvent $this->pdo)
    $pdo = $this->bd; // au cas où ton modèle s'appelle $pdo

    $stmt = $pdo->prepare($sql);
    $stmt->bindValue(':t', $term, PDO::PARAM_STR);
    $stmt->bindValue(':lim', (int)$limit, PDO::PARAM_INT); // LIMIT doit être un entier
    $stmt->execute();

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}




public function getPraticienById2(int $id): ?array {
    $sql = "
        SELECT
            p.*,
            u.prenom,
            u.nom,
            u.mail      AS mail,        -- pour la vue
            u.telephone_ AS telephone   -- pour la vue
        FROM praticien p
        JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
        WHERE p.id_praticien = :id
    ";
    $st = $this->bd->prepare($sql);
    $st->execute([':id' => $id]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    return $row ?: null;
}


  
  public function getApprochesByPraticien(int $id): array {
    // 1) si stocké en CSV dans p.type_approche
    $sql = "SELECT type_approche FROM praticien WHERE id_praticien = :id";
    $req = $this->bd->prepare($sql); $req->execute([':id'=>$id]);
    $v = $req->fetchColumn();
    if (!$v) return [];
    return array_values(array_filter(array_map('trim', explode(',', $v))));
    // 2) sinon, si table n-n praticien_approche(praticien_id, libelle) :
    // return $this->fetchCol("SELECT libelle FROM praticien_approche WHERE praticien_id=:id", [':id'=>$id]);
  }
  
  public function getSpecialitesByPraticien(int $id): array {
    // idem : soit CSV p.specialites, soit table n-n
    $sql = "SELECT specialites FROM praticien WHERE id_praticien = :id";
    $req = $this->bd->prepare($sql); $req->execute([':id'=>$id]);
    $v = $req->fetchColumn();
    if (!$v) return [];
    return array_values(array_filter(array_map('trim', explode(',', $v))));
  }
  
  /**
 * Renvoie un petit extrait (n prochains créneaux) pour un praticien.
 * S’appuie sur la table `creneaux`.
 * - Cas 1 (recommandé) : creneaux.id_agenda -> agenda.id_agenda -> agenda.id_praticien
 * - Cas 2 (fallback)   : creneaux.id_agenda = id_praticien (si pas de table agenda)
 */
public function getDisposExtrait(int $idPraticien, int $limit = 6): array
{
    // Tentative avec agenda
    $sqlJoin = "
        SELECT
          c.jour::date                             AS jour,
          to_char(c.heure_debut, 'HH24:MI')        AS heure_debut,
          to_char(c.heure_fin,   'HH24:MI')        AS heure_fin
        FROM creneaux c
        JOIN agenda a ON a.id_agenda = c.id_agenda
        WHERE a.id_praticien = :id
          AND (c.jour + c.heure_debut) >= NOW()
        ORDER BY c.jour ASC, c.heure_debut ASC
        LIMIT :lim
    ";
    try {
        $st = $this->bd->prepare($sqlJoin);
        $st->bindValue(':id',  $idPraticien, PDO::PARAM_INT);
        $st->bindValue(':lim', $limit,       PDO::PARAM_INT);
        $st->execute();
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (\PDOException $e) {
        $rows = [];
    }

    // Fallback : pas de table agenda (ou pas de jointure possible)
    if (empty($rows)) {
        $sqlFallback = "
            SELECT
              c.jour::date                          AS jour,
              to_char(c.heure_debut, 'HH24:MI')     AS heure_debut,
              to_char(c.heure_fin,   'HH24:MI')     AS heure_fin
            FROM creneaux c
            WHERE c.id_agenda = :id     -- hypothèse: id_agenda == id_praticien
              AND (c.jour + c.heure_debut) >= NOW()
            ORDER BY c.jour ASC, c.heure_debut ASC
            LIMIT :lim
        ";
        $st = $this->bd->prepare($sqlFallback);
        $st->bindValue(':id',  $idPraticien, PDO::PARAM_INT);
        $st->bindValue(':lim', $limit,       PDO::PARAM_INT);
        $st->execute();
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    }

    return $rows ?: [];
}
  
  // Models/Model.php
public function getAvisRecents(int $idPraticien, int $limit = 3): array {
    $sql = "SELECT note, commentaire, date_avis
            FROM avis
            WHERE id_praticien = :id
            ORDER BY date_avis DESC
            LIMIT :lim";
    $stmt = $this->bd->prepare($sql);
    $stmt->bindValue(':id', $idPraticien, PDO::PARAM_INT);
    $stmt->bindValue(':lim', $limit, PDO::PARAM_INT);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

  
  // petit utilitaire si tu veux
  private function fetchCol(string $sql, array $params=[]): array {
    $req = $this->bd->prepare($sql); $req->execute($params);
    return array_map('current', $req->fetchAll(PDO::FETCH_NUM));
  }
  
  // --- AJOUTS DANS LA CLASSE Model ---

/** Récupère un praticien (joint à utilisateur) par email. */
public function getPraticienByEmail(string $email): ?array
{
    $sql = "
        SELECT 
            p.id_praticien,
            p.specialites,
            p.photo_profil_url AS avatar,
            u.id_utilisateur,
            u.prenom,
            u.nom,
            u.mail
        FROM praticien p
        JOIN utilisateur u ON u.id_utilisateur = p.id_utilisateur
        WHERE LOWER(u.mail) = LOWER(:email)
        LIMIT 1
    ";
    $st = $this->bd->prepare($sql);
    $st->execute([':email' => $email]);
    $row = $st->fetch(PDO::FETCH_ASSOC);
    return $row ?: null;
}

/** Lit un CSV de patients et renvoie un tableau normalisé. */
public function readCsvPatients(string $path): array
{
    if (!is_readable($path)) return [];
    $rows = [];

    if (($h = fopen($path, 'r')) !== false) {
        $headers = fgetcsv($h, 0, ',');
        if (!$headers) { fclose($h); return []; }

        $norm = function($s){
            $s = trim($s);
            $s = iconv('UTF-8','ASCII//TRANSLIT',$s);
            $s = preg_replace('~[^a-z0-9]+~i','_', $s);
            return strtolower(trim($s,'_'));
        };
        $headers = array_map($norm, $headers);

        while (($data = fgetcsv($h, 0, ',')) !== false) {
            $row = [];
            foreach ($headers as $i => $key) $row[$key] = $data[$i] ?? '';

            $rows[] = [
                'id'          => $row['id'] ?? null,
                'nom'         => $row['nom'] ?? ($row['name'] ?? ''),
                'prenom'      => $row['prenom'] ?? ($row['first_name'] ?? ''),
                'email'       => $row['email'] ?? ($row['mail'] ?? ''),
                'avatar'      => $row['avatar'] ?? '',
                'acces'       => $row['acces'] ?? ($row['access'] ?? 'partage'),
                'stress'      => $row['stress'] ?? '',
                'douleur'     => $row['douleur'] ?? '',
                'energie'     => $row['energie'] ?? '',
                'sommeil'     => $row['sommeil'] ?? '',
                'objectif'    => $row['objectif'] ?? '',
                'dernier_rdv' => $row['dernier_rdv'] ?? ($row['last_appointment'] ?? ''),
                'specialite'  => $row['specialite'] ?? '',
            ];
        }
        fclose($h);
    }
    return $rows;
}

/** Recherche un patient par email dans le CSV et renvoie sa fiche normalisée. */
public function findPatientInCsvByEmail(string $csvPath, string $email): ?array
{
    if (!is_readable($csvPath) || ($h = fopen($csvPath, 'r')) === false) return null;

    $headers = fgetcsv($h, 0, ',');
    if (!$headers) { fclose($h); return null; }

    $norm = function($s){
        $s = trim($s);
        $s = iconv('UTF-8','ASCII//TRANSLIT',$s);
        $s = preg_replace('~[^a-z0-9]+~i','_', $s);
        return strtolower(trim($s,'_'));
    };
    $headers = array_map($norm, $headers);

    while (($data = fgetcsv($h, 0, ',')) !== false) {
        $row = [];
        foreach ($headers as $i => $key) $row[$key] = $data[$i] ?? '';

        $emailRow = strtolower(trim($row['email'] ?? ($row['mail'] ?? '')));
        if ($emailRow !== '' && $emailRow === strtolower($email)) {
            fclose($h);
            return [
                'id'          => $row['id'] ?? null,
                'prenom'      => $row['prenom'] ?? ($row['first_name'] ?? ''),
                'nom'         => $row['nom'] ?? ($row['name'] ?? ''),
                'avatar'      => $row['avatar'] ?? '',
                'email'       => $emailRow,
                'stress'      => $row['stress'] ?? '',
                'douleur'     => $row['douleur'] ?? '',
                'energie'     => $row['energie'] ?? '',
                'sommeil'     => $row['sommeil'] ?? '',
                'objectif'    => $row['objectif'] ?? '',
                'dernier_rdv' => $row['dernier_rdv'] ?? ($row['last_appointment'] ?? ''),
            ];
        }
    }
    fclose($h);
    return null;
}
    public function findPatientByEmailFromCsv(string $path): ?array
{
    if (!is_readable($path)) return null;
    if (($h = fopen($path, 'r')) !== false) {
        $headers = fgetcsv($h, 0, ',');
        if ($headers) {
            $norm = function($s){ $s = trim($s); $s = iconv('UTF-8','ASCII//TRANSLIT',$s);
                $s = preg_replace('~[^a-z0-9]+~i','_', $s); return strtolower(trim($s,'_')); };
            $headers = array_map($norm, $headers);

            $idxEmail = array_search('email', $headers);
            if ($idxEmail === false) $idxEmail = array_search('mail', $headers);

            while (($data = fgetcsv($h, 0, ',')) !== false) {
                $row = [];
                foreach ($headers as $i => $k) { $row[$k] = $data[$i] ?? ''; }
                $emailRow = strtolower(trim($row['email'] ?? ($row['mail'] ?? '')));
                if ($emailRow !== '' && $emailRow === strtolower($_POST['mail'] ?? '')) {
                    fclose($h);
                    return [
                        'id'          => $row['id'] ?? null,
                        'prenom'      => $row['prenom'] ?? ($row['first_name'] ?? ''),
                        'nom'         => $row['nom'] ?? ($row['name'] ?? ''),
                        'avatar'      => $row['avatar'] ?? '',
                        'email'       => $emailRow,
                        'stress'      => $row['stress'] ?? '',
                        'douleur'     => $row['douleur'] ?? '',
                        'energie'     => $row['energie'] ?? '',
                        'sommeil'     => $row['sommeil'] ?? '',
                        'objectif'    => $row['objectif'] ?? '',
                        'dernier_rdv' => $row['dernier_rdv'] ?? ($row['last_appointment'] ?? ''),
                    ];
                }
            }
        }
        fclose($h);
    }
    return null;
    
}
public function findPatientByEmail(string $email): ?array
{
    $csv = 'Content/data/patients.csv';
    if (!is_readable($csv)) {
        return null;
    }

    if (($h = fopen($csv, 'r')) === false) {
        return null;
    }

    // Lire la première ligne (en-têtes)
    $headers = fgetcsv($h, 0, ',');
    if (!$headers) {
        fclose($h);
        return null;
    }

    // Normaliser les en-têtes -> snake_case
    $norm = function($s) {
        $s = trim($s);
        $s = iconv('UTF-8','ASCII//TRANSLIT',$s);
        $s = preg_replace('~[^a-z0-9]+~i','_', $s);
        return strtolower(trim($s, '_'));
    };
    $headers = array_map($norm, $headers);

    // Trouver l’index de l’email
    $idxEmail = array_search('email', $headers);
    if ($idxEmail === false) {
        $idxEmail = array_search('mail', $headers);
    }

    // Parcours des lignes
    while (($data = fgetcsv($h, 0, ',')) !== false) {
        $row = [];
        foreach ($headers as $i => $key) {
            $row[$key] = $data[$i] ?? '';
        }

        $emailRow = strtolower(trim($row['email'] ?? ($row['mail'] ?? '')));
        if ($emailRow !== '' && $emailRow === strtolower($email)) {
            fclose($h);
            return [
                'id'         => $row['id'] ?? null,
                'prenom'     => $row['prenom'] ?? ($row['first_name'] ?? ''),
                'nom'        => $row['nom'] ?? ($row['name'] ?? ''),
                'avatar'     => $row['avatar'] ?? '',
                'email'      => $emailRow,
                'stress'     => $row['stress'] ?? '',
                'douleur'    => $row['douleur'] ?? '',
                'energie'    => $row['energie'] ?? '',
                'sommeil'    => $row['sommeil'] ?? '',
                'objectif'   => $row['objectif'] ?? '',
                'dernier_rdv'=> $row['dernier_rdv'] ?? ($row['last_appointment'] ?? ''),
            ];
        }
    }

    fclose($h);
    return null;
}
public function agenda_listSlotsInRange(int $praticienId, string $from, string $to): array {
    $sql = "SELECT id, date,
                   start_time AS start,
                   end_time   AS end,
                   status, title, place
            FROM agenda_slots
            WHERE praticien_id = :pid AND date BETWEEN :from AND :to
            ORDER BY date ASC, start_time ASC";
    $st = $this->bd->prepare($sql);
    $st->execute([':pid'=>$praticienId, ':from'=>$from, ':to'=>$to]);
    return $st->fetchAll(PDO::FETCH_ASSOC) ?: [];
}

public function agenda_allDaysHaveFree(int $praticienId, string $from, string $to): bool {
    $sql = "SELECT date FROM agenda_slots
            WHERE praticien_id=:pid AND date BETWEEN :from AND :to AND status='free'
            GROUP BY date";
    $st = $this->bd->prepare($sql);
    $st->execute([':pid'=>$praticienId, ':from'=>$from, ':to'=>$to]);
    $dates = array_column($st->fetchAll(PDO::FETCH_ASSOC), 'date');

    $d1 = new DateTime($from); $d2 = new DateTime($to);
    for($d = clone $d1; $d <= $d2; $d->modify('+1 day')){
        if (!in_array($d->format('Y-m-d'), $dates, true)) return false;
    }
    return true;
}

public function agenda_slotExists(int $praticienId, string $date, string $start, string $end, string $status): bool {
    $sql = "SELECT 1 FROM agenda_slots
            WHERE praticien_id=:pid AND date=:d
              AND start_time=:s AND end_time=:e AND status=:st
            LIMIT 1";
    $st = $this->bd->prepare($sql);
    $st->execute([':pid'=>$praticienId, ':d'=>$date, ':s'=>$start, ':e'=>$end, ':st'=>$status]);
    return (bool)$st->fetchColumn();
}

public function agenda_saveSlot(int $praticienId, string $date, string $start, string $end,
                                string $status, string $title='', string $place='cabinet'): int {
    $sql = "INSERT INTO agenda_slots (praticien_id, date, start_time, end_time, status, title, place)
            VALUES (:pid,:d,:s,:e,:st,:t,:p)";
    $st = $this->bd->prepare($sql);
    $st->execute([
        ':pid'=>$praticienId, ':d'=>$date, ':s'=>$start, ':e'=>$end,
        ':st'=>$status, ':t'=>$title, ':p'=>$place
    ]);
    return (int)$this->bd->lastInsertId();
}

public function agenda_markMonthAllFree(int $praticienId, string $month, string $start, string $end): int {
    $from = $month.'-01';
    $to   = date('Y-m-t', strtotime($from));

    $sql = "SELECT date FROM agenda_slots
            WHERE praticien_id=:pid AND date BETWEEN :from AND :to AND status='free'
            GROUP BY date";
    $st = $this->bd->prepare($sql);
    $st->execute([':pid'=>$praticienId, ':from'=>$from, ':to'=>$to]);
    $already = array_column($st->fetchAll(PDO::FETCH_ASSOC), 'date');

    $added = 0;
    $d1 = new DateTime($from); $d2 = new DateTime($to);
    $ins = $this->bd->prepare("INSERT INTO agenda_slots
                               (praticien_id,date,start_time,end_time,status,title,place)
                               VALUES (:pid,:d,:s,:e,'free','Créneau dispo','cabinet')");
    for($d = clone $d1; $d <= $d2; $d->modify('+1 day')){
        $date = $d->format('Y-m-d');
        if (in_array($date, $already, true)) continue;
        $ins->execute([':pid'=>$praticienId, ':d'=>$date, ':s'=>$start, ':e'=>$end]);
        $added++;
    }
    return $added;
}

public function agenda_nextAvailabilities(int $praticienId, string $from, int $limit=10): array {
    $sql = "SELECT date,
                   start_time AS start,
                   end_time   AS end
            FROM agenda_slots
            WHERE praticien_id=:pid AND status='free' AND date >= :from
            ORDER BY date ASC, start_time ASC
            LIMIT ".(int)$limit;
    $st = $this->bd->prepare($sql);
    $st->execute([':pid'=>$praticienId, ':from'=>$from]);
    return $st->fetchAll(PDO::FETCH_ASSOC) ?: [];
}
/** Retourne les séances d’un praticien dans un intervalle, avec statut calculé + infos patient. */
public function agenda_listSessions(
    int $praticienId, string $from, string $to,
    string $statusFilter = '', ?int $patientId = null, string $specialiteFilter = ''
): array {
    // On supporte 2 variantes:
    // 1) Table rdv avec (date_rdv, heure_debut/heure_fin) et statut
    // 2) Table agenda_slots + jointure rdv/booking (au besoin tu pourras l’étendre)
    //
    // Ici on cible d’abord une table "rdv" (la plus fréquente), avec fallback
    // sur des alias si tes colonnes s'appellent autrement.

    $sql = "
        SELECT
            r.id_rdv                                   AS id,
            -- date/heure (essayons les noms usuels, sinon alias)
            COALESCE(r.date_rdv, r.date)               AS date_rdv,
            COALESCE(r.heure_debut, r.start_time, r.start) AS heure_debut,
            COALESCE(r.heure_fin,   r.end_time,   r.end)   AS heure_fin,
            -- statut explicite si présent, sinon calcul en fonction de NOW()
            COALESCE(
                NULLIF(r.statut, ''),
                CASE WHEN (COALESCE(r.date_rdv, r.date)::timestamp
                      + COALESCE(r.heure_debut, r.start_time, r.start)) < NOW()
                     THEN 'past' ELSE 'upcoming' END
            ) AS statut,
            -- patient
            u.id_utilisateur            AS patient_id,
            TRIM(CONCAT(u.prenom, ' ', u.nom)) AS patient_nom,
            COALESCE(u.photo_profil_url, u.avatar, '') AS patient_avatar,
            -- spécialité liée au praticien ou au RDV
            COALESCE(p.specialites, r.specialite, '')   AS specialite
        FROM rdv r
        JOIN utilisateur u ON u.id_utilisateur = COALESCE(r.id_patient, r.id_utilisateur, r.id_client)
        JOIN praticien p   ON p.id_praticien   = r.id_praticien
        WHERE r.id_praticien = :pid
          AND COALESCE(r.date_rdv, r.date) BETWEEN :from AND :to
    ";

    $params = [':pid'=>$praticienId, ':from'=>$from, ':to'=>$to];

    if ($statusFilter === 'upcoming') {
        $sql .= " AND (COALESCE(r.date_rdv, r.date)::timestamp +
                       COALESCE(r.heure_debut, r.start_time, r.start)) >= NOW() ";
    } elseif ($statusFilter === 'past') {
        $sql .= " AND (COALESCE(r.date_rdv, r.date)::timestamp +
                       COALESCE(r.heure_debut, r.start_time, r.start)) < NOW() ";
    }

    if (!empty($patientId)) {
        $sql .= " AND u.id_utilisateur = :pid_user ";
        $params[':pid_user'] = $patientId;
    }
    if ($specialiteFilter !== '') {
        $sql .= " AND COALESCE(p.specialites, r.specialite, '') ILIKE :spec ";
        $params[':spec'] = '%'.$specialiteFilter.'%';
    }

    $sql .= " ORDER BY COALESCE(r.date_rdv, r.date) ASC,
                     COALESCE(r.heure_debut, r.start_time, r.start) ASC ";

    try {
        $st = $this->bd->prepare($sql);
        $st->execute($params);
        return $st->fetchAll(PDO::FETCH_ASSOC) ?: [];
    } catch (\Throwable $e) {
        // Fallback minimal si la table/colonnes diffèrent trop :
        return [];
    }
}

/** Facette : liste des patients présents dans l’intervalle. */
public function agenda_sessionsDistinctPatients(int $praticienId, string $from, string $to): array {
    $sql = "
        SELECT DISTINCT u.id_utilisateur AS id, TRIM(CONCAT(u.prenom,' ',u.nom)) AS nom
        FROM rdv r
        JOIN utilisateur u ON u.id_utilisateur = COALESCE(r.id_patient, r.id_utilisateur, r.id_client)
        WHERE r.id_praticien = :pid AND COALESCE(r.date_rdv, r.date) BETWEEN :from AND :to
        ORDER BY nom ASC
    ";
    try {
        $st = $this->bd->prepare($sql);
        $st->execute([':pid'=>$praticienId, ':from'=>$from, ':to'=>$to]);
        return $st->fetchAll(PDO::FETCH_ASSOC) ?: [];
    } catch (\Throwable $e) { return []; }
}

/** Facette : spécialités vues dans l’intervalle. */
public function agenda_sessionsDistinctSpecialites(int $praticienId, string $from, string $to): array {
    $sql = "
        SELECT DISTINCT COALESCE(p.specialites, r.specialite, '') AS specialite
        FROM rdv r
        JOIN praticien p ON p.id_praticien = r.id_praticien
        WHERE r.id_praticien = :pid AND COALESCE(r.date_rdv, r.date) BETWEEN :from AND :to
          AND COALESCE(p.specialites, r.specialite, '') <> ''
        ORDER BY 1 ASC
    ";
    try {
        $st = $this->bd->prepare($sql);
        $st->execute([':pid'=>$praticienId, ':from'=>$from, ':to'=>$to]);
        return array_column($st->fetchAll(PDO::FETCH_ASSOC), 'specialite');
    } catch (\Throwable $e) { return []; }
}
// --- utilitaires ---
public function userExists(string $email): bool {
    $st = $this->bd->prepare("SELECT 1 FROM utilisateur WHERE LOWER(mail)=LOWER(:m) LIMIT 1");
    $st->execute([':m'=>$email]);
    return (bool)$st->fetchColumn();
}

/**
 * Crée un utilisateur (role 'patient') + sa fiche patient.
 * - $payload = [
 *     'mail','nom','prenom','telephone','mot_de_passe','avatar_tmp'(chemin tmp)
 *   ]
 * Retourne l'id_utilisateur créé.
 */

public function getAllPatients(): array {
    $sql = "SELECT u.id_utilisateur, u.nom, u.prenom, u.mail, u.statut_compte, u.photo_profil_url, u.date_inscription
            FROM utilisateur u
            JOIN patient p ON u.id_utilisateur = p.id_utilisateur
            ORDER BY u.date_inscription DESC";
    return $this->bd->query($sql)->fetchAll(PDO::FETCH_ASSOC);
}

public function updateUserStatus(int $id, string $status): bool {
    $allowed = ['actif','refuse','incomplet','en_attente'];
    if (!in_array($status, $allowed, true)) return false;
    $st = $this->bd->prepare("UPDATE utilisateur SET statut_compte = :s WHERE id_utilisateur = :id");
    return $st->execute([':s'=>$status, ':id'=>$id]);
}


/* ----- Création utilisateur(patient) + fiche patient ----- */
public function createPatientWithUser(array $payload, string $statutInitial = 'en_attente'): int
{
    $this->bd->beginTransaction();
    try {
        // 1) utilisateur
        $sqlU = "INSERT INTO utilisateur
                 (mail, nom, prenom, date_inscription, derniere_connexion,
                  role_utilisateur, statut_compte, mot_de_passe,
                  consentement_cgu, consentement_partage_donnees_sante_, telephone_)
                 VALUES
                 (:mail, :nom, :prenom, CURRENT_DATE, NOW(),
                  'patient', :statut, :hash,
                  true, false, :tel)
                 RETURNING id_utilisateur";
        $stU = $this->bd->prepare($sqlU);
        $stU->execute([
            ':mail'   => $payload['mail'],
            ':nom'    => $payload['nom'],
            ':prenom' => $payload['prenom'],
            ':statut' => $statutInitial,
            ':hash'   => password_hash($payload['mot_de_passe'], PASSWORD_DEFAULT),
            ':tel'    => $payload['telephone'] ?? null,
        ]);
        $idUser = (int)$stU->fetchColumn();

        // 2) avatar (optionnel)
        if (!empty($payload['avatar_tmp']) && is_file($payload['avatar_tmp'])) {
            $dir = 'Content/uploads/avatars';
            if (!is_dir($dir)) @mkdir($dir, 0775, true);
            $ext  = strtolower(pathinfo($payload['avatar_tmp'], PATHINFO_EXTENSION) ?: 'jpg');
            $dest = $dir . '/u' . $idUser . '.' . $ext;
            @rename($payload['avatar_tmp'], $dest);
            $this->bd->prepare("UPDATE utilisateur SET photo_profil_url = :p WHERE id_utilisateur=:id")
                     ->execute([':p'=>$dest, ':id'=>$idUser]);
        }

        // 3) patient (fiche minimale) — on ALIMENTE date_de_naissance
        $sqlP = "INSERT INTO patient (id_utilisateur, date_inscription, date_de_naissance)
                 VALUES (:id, CURRENT_DATE, :dna)";
        $this->bd->prepare($sqlP)->execute([
            ':id'  => $idUser,
            ':dna' => $payload['date_naissance'] ?? null,   // requis si colonne NOT NULL
        ]);

        $this->bd->commit();
        return $idUser;

    } catch (\Throwable $e) {
        $this->bd->rollBack();
        throw $e;
    }
}


/* ----- Status helpers ----- */
public function activateUser(int $id): void
{
    $this->bd->prepare("UPDATE utilisateur SET statut_compte='actif' WHERE id_utilisateur=:id")
             ->execute([':id'=>$id]);
}

public function setUserPending(int $id): void
{
    $this->bd->prepare("UPDATE utilisateur SET statut_compte='en_attente' WHERE id_utilisateur=:id")
             ->execute([':id'=>$id]);
}

public function getUserName(int $id): ?string
{
    $st = $this->bd->prepare("SELECT prenom||' '||nom AS n FROM utilisateur WHERE id_utilisateur=:id");
    $st->execute([':id'=>$id]);
    $v = $st->fetchColumn();
    return $v !== false ? $v : null;
}

/* ----- Vérification email ----- */
/* Table SQL : user_email_verifications(user_id int fk, token text pk, expires_at timestamptz, sent_at timestamptz) */

public function createVerificationToken(int $userId, string $token, string $ttl = '+24 hours'): void
{
    $st = $this->bd->prepare("
        INSERT INTO user_email_verifications (user_id, token, expires_at, sent_at)
        VALUES (:uid, :t, (NOW() + INTERVAL '1 second') + (:ttl)::interval, NOW())
    ");
    $st->execute([':uid'=>$userId, ':t'=>$token, ':ttl'=>$ttl]);
}

public function consumeVerificationToken(string $token): ?int
{
    // supprime et retourne l'user si non expiré
    $st = $this->bd->prepare("
        DELETE FROM user_email_verifications
        WHERE token = :t AND expires_at >= NOW()
        RETURNING user_id
    ");
    $st->execute([':t'=>$token]);
    $uid = $st->fetchColumn();
    return $uid ? (int)$uid : null;
}

/* Anti-spam resend: true si on peut renvoyer un mail maintenant */
public function canResendVerification(int $userId, int $cooldownSeconds = 60): bool
{
    $st = $this->bd->prepare("
        SELECT sent_at FROM user_email_verifications
        WHERE user_id = :uid
        ORDER BY sent_at DESC
        LIMIT 1
    ");
    $st->execute([':uid'=>$userId]);
    $last = $st->fetchColumn();
    if (!$last) return true;
    return (time() - strtotime($last)) >= $cooldownSeconds;
}

}
