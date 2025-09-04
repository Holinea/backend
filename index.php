<?php

//Pour avoir la fonction e()
require_once "Utils/functions.php";
//Inclusion du modèle
require_once "Models/Model.php";
//Inclusion de la classe Controller
require_once "Controllers/Controller.php";

$controllers = ["home","connexion", "therapeute", "agenda","verification", "clients","creneaux","recherche","rechercheTherapeute", "connexion_patient","api","praticien","dossier","patient","inscription","admin"]; 
$controller_default = "home";

//On teste si le paramètre controller existe et correspond à un contrôleur de la liste $controllers
if (isset($_GET['Controller']) and in_array($_GET['Controller'], $controllers)) {
    $nom_controller = $_GET['Controller'];
} else {
    $nom_controller = $controller_default;
}

//On détermine le nom de la classe du contrôleur
$nom_classe = 'Controller_' . $nom_controller;

//On détermine le nom du fichier contenant la définition du contrôleur
$nom_fichier = 'Controllers/' . $nom_classe . '.php';

//Si le fichier existe et est accessible en lecture
if (is_readable($nom_fichier)) {
    //On l'inclut et on instancie un objet de cette classe
    require_once $nom_fichier;
    new $nom_classe();
} else {
    die("Error 404: not found!");
}
?>
