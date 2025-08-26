<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Holinea - Accueil</title>
  <link rel="stylesheet" href="./Content/css/holinea.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
</head>
<body>
<header>
  <div class="container nav-bar">
    <div class="logo">
      <a href="?Controller=home&action=accueil">
        <img src="Content/img/holinea_2.png" alt="Logo Holinea" style="height:48px;vertical-align:middle;">
      </a>
    </div>
    <nav>
      <a href="?Controller=agenda&action=showAgenda">Agenda</a>
      <a href="?Controller=clients&action=liste">Clients</a>
      <a href="?Controller=creneaux&action=liste">creneaux</a>
      
    </nav>
    <a href="?Controller=rechercheTherapeute&action=resultats" 
      class="loupe-emoji-search" 
      title="Rechercher un thérapeute">
      <span class="emoji">🔍</span>
      <span class="search-label">Rechercher</span>
    </a>


    <div>
      
      <a href="?Controller=home&action=index" class="btn">deconnexion</a>
    </div>
  </div>
</header>
<!-- A partir d'ici, il NE DOIT Y AVOIR AUCUN <div class="container"> qui englobe le contenu principal -->
