<?php
namespace Api;
use Firebase\JWT\JWT;
use PDO;

class AuthController {
    static function login() {
        $in = json_decode(file_get_contents('php://input'), true) ?? [];
        $mail = trim($in['email'] ?? '');
        $pwd = $in['password'] ?? '';
        if (!$mail || !$pwd) Response::json(['error' => 'Email et mot de passe requis'], 400);

        $st = Database::pdo()->prepare("SELECT * FROM utilisateur WHERE mail = :m LIMIT 1");
        $st->execute([':m' => $mail]);
        $u = $st->fetch(PDO::FETCH_ASSOC);
        if (!$u || !password_verify($pwd, $u['mot_de_passe'])) Response::json(['error' => 'Identifiants invalides'], 401);

        $idp = null;
        if (($u['role_utilisateur'] ?? 'patient') === 'therapeute') {
            $q = Database::pdo()->prepare("SELECT id_praticien FROM praticien WHERE id_utilisateur = :id LIMIT 1");
            $q->execute([':id' => $u['id_utilisateur']]);
            $row = $q->fetch(PDO::FETCH_ASSOC);
            $idp = $row['id_praticien'] ?? null;
        }

        $payload = [
            'sub' => (int)$u['id_utilisateur'],
            'role' => $u['role_utilisateur'],
            'id_praticien' => $idp,
            'exp' => time() + 4*3600
        ];
        $token = JWT::encode($payload, $_ENV['JWT_SECRET'], 'HS256');

        Response::json([
            'token' => $token,
            'user' => [
                'id_utilisateur' => (int)$u['id_utilisateur'],
                'nom' => $u['nom'],
                'prenom' => $u['prenom'],
                'role' => $u['role_utilisateur'],
                'id_praticien' => $idp
            ]
        ]);
    }
}
