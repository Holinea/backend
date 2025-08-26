<?php require "view_begin.php"; ?>

<?php
$order = $_GET['order'] ?? ''; // Nouveau : récupère le tri actif dans l’URL
?>

<div class="resultats-recherche-header">
  <h2>Résultats de votre recherche
    <span style="cursor:pointer;font-size:1.4em" onclick="window.location.href='index.php?controller=recherche';">&times;</span>
  </h2>
</div>

<div class="zone-filtres">
  <button class="btn-filtre-actif"><i class="fa fa-filter"></i> Filtrer par :</button>
  <a href="?Controller=recherche&action=recherche&order=localisation"
     class="btn-filtre<?= ($order === 'localisation' ? ' btn-filtre-selected' : '') ?>">Localisation</a>
  <a href="?Controller=recherche&action=recherche&order=experience"
     class="btn-filtre<?= ($order === 'experience' ? ' btn-filtre-selected' : '') ?>">Expérience</a>
  <a href="?Controller=recherche&action=recherche&order=notes"
     class="btn-filtre<?= ($order === 'notes' ? ' btn-filtre-selected' : '') ?>">Notes</a>
</div>

<!-- ... (le reste de ton affichage des praticiens ne change pas) ... -->

<?php if (isset($resultats) && is_array($resultats) && count($resultats) > 0): ?>
  <div class="cartes-praticiens">
    <?php foreach ($resultats as $p): ?>
      <div class="carte-praticien">
        <img src="<?= htmlspecialchars($p['photo_profil_url']) ?>" class="pp-praticien" alt="photo" />
        <div class="infos-praticien">
          <div class="nom-praticien"><?= isset($p['nom']) ? mb_strtoupper(htmlspecialchars($p['nom'])) : "Praticien" ?> <?= isset($p['prenom']) ? mb_strtoupper(htmlspecialchars($p['prenom'])) : "Praticien" ?></div>
          <div class="note-praticien">
          <span style="font-size:1.2em; color:#ffd447; margin-right:4px;">⭐</span>
          <?= isset($p['taux_satisfaction']) ? htmlspecialchars($p['taux_satisfaction']) : "4.7" ?> / 5
        </div>
          <div class="spec-praticien"><i class="fa fa-shield"></i> <?= isset($p['description']) ? htmlspecialchars($p['description']) : "" ?></div>

          <div class="tags-specs">
            <?php if (!empty($p['specialites'])): ?><span class="tag-spec"><?= htmlspecialchars($p['specialites']) ?></span><?php endif; ?>
            <?php if (!empty($p['annees_experience'])): ?><span class="tag-spec"><?= htmlspecialchars($p['annees_experience']) ?> ans exp.</span><?php endif; ?>
            <?php if (!empty($p['nombre_heures_pratique'])): ?><span class="tag-spec"><?= htmlspecialchars($p['nombre_heures_pratique']) ?> h pratique</span><?php endif; ?>
          </div>
          <div class="adresse-praticien"><i class="fa fa-map-marker-alt"></i> <?= htmlspecialchars($p['adresse_cabinet']) ?></div>
          <div class="prix-praticien"><i class="fa fa-euro-sign"></i> A partir de <?= htmlspecialchars($p['tarifs_consultation']) ?> €</div>
          <div class="prochain-rdv">
            <button class="btn-prochain-rdv">
              Prochain Rendez-vous : <span style="font-weight:600;">Voir fiche</span> <i class="fa fa-chevron-right"></i>
            </button>
          </div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
  <div style="text-align:center;margin:2em 0;">
    <button class="btn-voir-plus">Voir plus</button>
  </div>
<?php else: ?>
  <div class="aucun-resultat">Aucun praticien disponible pour cette recherche.</div>
<?php endif; ?>

<?php require "view_end.php"; ?>
