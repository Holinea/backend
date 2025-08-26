<?php
namespace App;

require_once __DIR__ . '/Database.php';
require_once __DIR__ . '/Response.php';

$db = Database::getConnection();
$stmt = $db->query("SELECT * FROM praticien");
$therapeutes = $stmt->fetchAll(\PDO::FETCH_ASSOC);

Response::json($therapeutes);
