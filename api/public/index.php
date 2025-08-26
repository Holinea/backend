<?php
declare(strict_types=1);
header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { http_response_code(204); exit; }

require __DIR__ . '/../vendor/autoload.php';
use Api\TherapeutesController;

// normalisation du chemin
$base = rtrim(str_replace('\\','/', dirname($_SERVER['SCRIPT_NAME'])), '/');
$reqPath = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$relPath = '/' . ltrim(preg_replace('#^' . preg_quote($base, '#') . '#','',$reqPath), '/');
$relPath = preg_replace('#^/index\.php#','', $relPath);
$relPath = '/' . ltrim($relPath, '/');

$method = $_SERVER['REQUEST_METHOD'];

try {
  if ($relPath === '/health') {
    echo json_encode(['status'=>'ok','path'=>$relPath]); exit;
  }
  if ($relPath === '/praticiens' && $method === 'GET') {
    $c = new TherapeutesController(); $c->getAll(); exit;
  }
  http_response_code(404);
  echo json_encode(['error'=>'Not Found','path'=>$relPath]);
} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['error'=>'Server error','message'=>$e->getMessage()]);
}
