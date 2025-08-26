<?php

require_once __DIR__.'/Database.php';
require_once __DIR__.'/Response.php';

class PraticiensController {
  public static function list(): void {
    try {
      $pdo = Database::pdo();
      $sql = "SELECT id_praticien, specialites, adresse_cabinet, tarifs_consultation
              FROM praticien
              ORDER BY id_praticien ASC";
      $stmt = $pdo->query($sql);
      $rows = $stmt->fetchAll();
      Response::json($rows);
    } catch (Throwable $e) {
      Response::error('DB error: '.$e->getMessage(), 500);
    }
  }
}
