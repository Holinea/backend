<?php
class Database {
  public static function pdo(): PDO {
    static $pdo = null;
    if (!$pdo) {
      // 👇 adapte à ta config
      $host = 'localhost';
      $port = '5432';
      $db   = 'holinea';
      $user = 'postgres';
      $pass = 'fallyaram';

      $dsn = "pgsql:host=$host;port=$port;dbname=$db";
      $pdo = new PDO($dsn, $user, $pass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
      ]);
    }
    return $pdo;
  }
}
