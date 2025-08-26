<?php
require_once __DIR__ . '/vendor/autoload.php';
use Twilio\Rest\Client;

$sid = 'ACd701786cb5d74aec1a32b82c51bf9e24';
$token = '3808d5410d5b1a5a59af41f92ff34284';
$from = '+33625628751'; // Ton numéro Twilio
$to = '+33625628751'; // Mets ici ton numéro mobile VÉRIFIÉ

$client = new Client($sid, $token);

try {
    $client->messages->create(
        $to,
        [
            'from' => $from,
            'body' => 'Ceci est un test Twilio direct'
        ]
    );
    echo "SMS envoyé !";
} catch (Exception $e) {
    echo "Erreur Twilio : ".$e->getMessage();
}
