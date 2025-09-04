<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= isset($pageTitle) ? htmlspecialchars($pageTitle) : 'Holinea' ?></title>

  <!-- CSS -->
   <link rel="stylesheet" href="./Content/css/holinea_new.css">
  <!-- charge après la feuille principale pour permettre les overrides -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="./Content/css/holinea_auth.css"/>
</head>
<?php
  $controller = $_GET['Controller'] ?? 'home';
  $action     = $_GET['action'] ?? 'index';
  $isHome     = ($controller === 'home' && $action === 'index');
?>
<body data-route="<?= htmlspecialchars($controller.'-'.$action) ?>">

<header>
  <div class="container nav-bar">
    <div class="logo">
      <a href="?Controller=home&action=index">
        <img src="Content/img/holinea_2.png" alt="Logo Holinea" style="height:48px;vertical-align:middle;">
      </a>
    </div>
    <nav>
  <a href="https://f06e3437-225d-419c-90e7-88bf61299626.dev11.app-preview.com/"          class="pill pill--navy">Accueil</a>
  <a href="https://f06e3437-225d-419c-90e7-88bf61299626.dev11.app-preview.com/qui-sommes-nous"                                       class="pill pill--navy">Qui sommes-nous ?</a>
  <a href="?Controller=therapeute&action=signup-"    class="pill pill--green">Je suis thérapeute</a>
  <a href="#"                                       class="pill pill--orange">Je cherche un accompagnement</a>
  <a href="#"                                       class="pill pill--navy">Blog</a>
  <a href="https://f06e3437-225d-419c-90e7-88bf61299626.dev11.app-preview.com/contact"                                       class="pill pill--navy">Contacts</a>
</nav>

  </div>
</header>

<?php if ($isHome): ?>
  <!-- HERO de la HOME -->
  <section class="homepage-hero">
    <!-- ... ton contenu hero existant ... -->
  </section>

  <!-- BARRE BLANCHE / SOUS-NAV de la HOME -->
  <div class="home-subnav">
    <!-- ... ton bloc blanc (logo + menus + boutons) ... -->
  </div>
<?php endif; ?>

<!-- À partir d’ici, tes vues injectent le contenu spécifique à la page -->
