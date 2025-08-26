<?php
class Response {
  public static function json($data, int $status=200): void {
    header('Content-Type: application/json; charset=utf-8');
    header('Access-Control-Allow-Origin: *'); // CORS simple pour tester
    http_response_code($status);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
  }
  public static function error(string $message, int $status=400): void {
    self::json(['error'=>$message], $status);
  }
}
