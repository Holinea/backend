<?php require "view_begin_therapeute.php"; ?>

<div class="thera-search-header">
  <h2>Rechercher un autre thérapeute</h2>
  <p class="thera-search-desc">
    Trouvez un confrère par spécialité, ville ou recherchez ceux avec lesquels vous partagez des clients.
  </p>
</div>

<form method="GET" action="index.php" class="search-form">
  <input type="hidden" name="controller" value="rechercheTherapeute">
  <input type="hidden" name="action" value="resultats">

  <div class="search-fields">
    <input type="text" name="specialites" placeholder="Spécialité, type d’approche" value="<?= htmlspecialchars($_GET['specialites'] ?? '') ?>">
    <input type="text" name="ville" placeholder="Ville, code postal" value="<?= htmlspecialchars($_GET['ville'] ?? '') ?>">
  </div>
  <div class="search-options">
    <label class="search-checkbox">
      <input type="checkbox" name="commun" <?= !empty($_GET['commun']) ? "checked" : "" ?>>
      <span>Clients en commun</span>
    </label>
    <button type="submit" class="btn btn-search">Rechercher</button>
  </div>
</form>

<?php if (isset($resultats) && is_array($resultats) && count($resultats) > 0): ?>
  <div class="cartes-praticiens">
    <?php foreach ($resultats as $t): ?>
      <div class="carte-praticien">
        <img src="<?= htmlspecialchars($t['photo_profil_url']) ?>" class="pp-praticien" alt="photo" />
        <div class="infos-praticien">
          <div class="nom-praticien"><?= mb_strtoupper(htmlspecialchars($t['nom'])) ?> <?= mb_strtoupper(htmlspecialchars($t['prenom'])) ?></div>
          <div class="spec-praticien"><?= htmlspecialchars($t['specialites']) ?></div>
          <div class="adresse-praticien"><?= htmlspecialchars($t['adresse_cabinet']) ?></div>
          <div class="tags-specs">
            <?php if (!empty($t['annees_experience'])): ?><span class="tag-spec"><?= htmlspecialchars($t['annees_experience']) ?> ans exp.</span><?php endif; ?>
          </div>
          <?php if (isset($t['nb_clients_commun'])): ?>
