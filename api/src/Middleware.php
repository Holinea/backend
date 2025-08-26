<?php
namespace Api;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class Middleware {
    static function boot() {
        if (file_exists(__DIR__.'/../../.env')) {
            (Dotenv\Dotenv::createImmutable(__DIR__.'/../..'))->load();
        }
        header('Access-Control-Allow-Origin: '.($_ENV['CORS_ORIGIN'] ?? '*'));
        header('Access-Control-Allow-Methods: GET,POST,PUT,PATCH,DELETE,OPTIONS');
        header('Access-Control-Allow-Headers: Content-Type, Authorization');
        if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }
    }

    static function auth(): array {
        $h = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
        if (!preg_match('/Bearer\s+(.+)/', $h, $m)) Response::json(['error' => 'Missing token'], 401);
        try {
            return (array) JWT::decode($m[1], new Key($_ENV['JWT_SECRET'], 'HS256'));
        } catch (\Throwable $e) {
            Response::json(['error' => 'Invalid token'], 401);
        }
    }
}
