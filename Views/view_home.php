<?php
    require "view_begin.php";
?>


<section class="hero">
  <div class="container hero-content">
    <div>
      <h1>La santé personnalisée, accessible à tous</h1>
      <p>La première plateforme qui combine intelligence artificielle et médecine douce pour un accompagnement holistique, personnalisé et sécurisé.</p>
      



<?php
// view_recherche_praticiens.php
$modalite   = $modalite   ?? ($_POST['modalite']   ?? 'cabinet');
$specialite = $specialite ?? ($_POST['specialite'] ?? '');
$approche   = $approche   ?? ($_POST['approche']   ?? '');
$ville_cp   = $ville_cp   ?? ($_POST['ville_cp']   ?? '');
?>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link rel="stylesheet" href="./Content/css/holinea_recherche.css"/>

<div class="holinea-search-wrap">
  <form method="POST" action="index.php?Controller=recherche&action=recherche" class="holinea-search-form">
    <!-- Toggle CABINET / DISTANCE -->
    <div class="toggle-pill">
      <input class="toggle-radio" type="radio" id="cabinet"  name="modalite" value="cabinet"  <?= ($modalite==='cabinet'?'checked':'') ?>>
      <input class="toggle-radio" type="radio" id="distance" name="modalite" value="distance" <?= ($modalite==='distance'?'checked':'') ?>>
      <div class="pill">
        <label for="cabinet" class="pill-opt">
          <i class="fa-solid fa-building"></i>
          <span>CABINET</span>
        </label>
        <label for="distance" class="pill-opt">
          <i class="fa-solid fa-video"></i>
          <span>DISTANCE</span>
        </label>
        <span class="pill-slider" aria-hidden="true"></span>
      </div>
    </div>

    <!-- Filtres -->
    <div class="filters-row">
      <!-- Spécialité (écriture + suggestions) -->
      <div class="select">
        <input
          type="text"
          name="specialite"
          list="dl-specialites"
          placeholder="Spécialité (ex : Naturopathe)"
          value="<?= htmlspecialchars($specialite) ?>"
          class="input-text"
          aria-label="Spécialité (saisie libre)">
        <datalist id="dl-specialites">
          <?php foreach (($specialites ?? []) as $s): ?>
            <option value="<?= htmlspecialchars($s) ?>"></option>
          <?php endforeach; ?>
        </datalist>
      </div>

      <!-- Champ visible uniquement en mode CABINET -->
      <div class="select field-localisation">
        <input
          type="text"
          name="ville_cp"
          placeholder="Ville ou code postal"
          value="<?= htmlspecialchars($ville_cp) ?>"
          class="input-loc"
          aria-label="Ville ou code postal">
      </div>

      <!-- Type d'approche (écriture + suggestions) -->
      <div class="select">
        <input
          type="text"
          name="approche"
          list="dl-approches"
          placeholder="Type d’approche"
          value="<?= htmlspecialchars($approche) ?>"
          class="input-text"
          aria-label="Type d’approche (saisie libre)">
        <datalist id="dl-approches">
          <?php foreach (($approches ?? []) as $a): ?>
            <option value="<?= htmlspecialchars($a) ?>"></option>
          <?php endforeach; ?>
        </datalist>
      </div>

      <!-- Bouton -->
      <button class="btn-search" type="submit">
        <i class="fa-solid fa-magnifying-glass"></i>
        <span>Rechercher</span>
      </button>
    </div>
  </form>
</div>


    </div>
  </div>
</section>
<section class="advantages">
  <div class="container">
    <h2>Pour qui ?</h2>
    <div class="cards">
      <div class="card">
        <h3>Patients</h3>
        <p>Un parcours de santé global, des recommandations personnalisées, accès à des praticiens de confiance, suivi et communauté.</p>
      </div>
      <div class="card">
        <h3>Praticiens</h3>
        <p>Développez votre activité, touchez plus de clients, outils digitaux, visibilité et suivi simplifié de vos clients.</p>
      </div>
      
    </div>
  </div>
</section>


<?php
    require "view_end.php";
?>

