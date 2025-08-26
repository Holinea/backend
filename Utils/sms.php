<?php
require_once __DIR__ . '/../vendor/autoload.php';
use Twilio\Rest\Client;

function send_sms($to, $msg) {
    $sid = 'ACd701786cb5d74aec1a32b82c51bf9e24';     // Ton SID
    $token = '3808d5410d5b1a5a59af41f92ff34284';    // Ton Auth Token
    $from = '+18735030208'; // <-- c'est TON numéro Twilio affiché à l'écran

    $client = new Client($sid, $token);

    try {
        $client->messages->create(
            $to, // au format international : +33612345678 pour un FR
            [
                'from' => $from,
                'body' => $msg
            ]
        );
    } catch (Exception $e) {
        error_log("[TWILIO ERROR] ".$e->getMessage());
    }
}
