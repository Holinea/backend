<?php
if (!function_exists('h')) {
  function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
}
if (!function_exists('modeLabel')) {
  function modeLabel($m){
    if ($m === 'distance') return 'Visio';
    if ($m === 'cabinet')  return 'Présentiel';
    return ucfirst((string)$m);
  }
}

/**
 * Formate un créneau qu'il vienne sous la forme
 * - ['jour','heure_debut','heure_fin'] (table creneaux)
 * - ou ['start_at','end_at'] (timestamps déjà calculés côté modèle)
 */
if (!function_exists('format_slot')) {
  function format_slot(array $r): ?string {
    // Cas start_at / end_at
    if (!empty($r['start_at'])) {
      $t1 = strtotime((string)$r['start_at']); if ($t1 === false) return null;
      $t2 = !empty($r['end_at']) ? strtotime((string)$r['end_at']) : null;
      $d  = date('D d/m', $t1);
      $h1 = date('H:i',   $t1);
      $h2 = $t2 ? date('H:i', $t2) : '';
      return $d.' • '.$h1.($h2 ? ' → '.$h2 : '');
    }

    // Cas jour + heures
    $jour = $r['jour'] ?? null; if (!$jour) return null;
    $t1 = strtotime(trim($jour.' '.(($r['heure_debut'] ?? '00:00')))); if ($t1 === false) return null;
    $t2 = !empty($r['heure_fin']) ? strtotime(trim($jour.' '.($r['heure_fin']))) : null;
    $d  = date('D d/m', $t1);
    $h1 = date('H:i',   $t1);
    $h2 = $t2 ? date('H:i', $t2) : '';
    return $d.' • '.$h1.($h2 ? ' → '.$h2 : '');
  }
}

/** @var array $p, $specialites, $approches, $dispos, $avis */

$noteAff = !empty($p['taux_satisfaction'])
            ? number_format(($p['taux_satisfaction']/100)*5, 1, ',', ' ') . ' / 5'
            : '—';
$compat  = !empty($p['taux_satisfaction']) ? intval($p['taux_satisfaction']).'%' : '—';
$format  = ($p['mode_consultation'] ?? '') === 'distance' ? 'Visio'
         : (($p['mode_consultation'] ?? '') === 'cabinet' ? 'Présentiel' : 'Présentiel & Visio');

$nomComplet = trim(($p['prenom'] ?? '').' '.($p['nom'] ?? ''));

// Contacts (essaie depuis utilisateur si tu as joint ; sinon crée $p['telephone'] / $p['mail'] côté modèle)
$tel  = $p['telephone'] ?? ($p['telephone_utilisateur'] ?? '');
$mail = $p['mail'] ?? ($p['mail_utilisateur'] ?? '');
$site = $p['site_web'] ?? ''; // si tu as un champ site_web un jour
?>

<?php require 'view_begin.php'; ?>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link rel="stylesheet" href="./Content/css/holinea_profile.css"/>

<div class="profile-wrap">
  <header class="profile-head">
    <div class="ph-left">
      <img class="ph-avatar" src="<?= h($p['photo_profil_url'] ?: 'Content/img/avatar.png') ?>" alt="">
      <div>
        <h1><?= h($nomComplet) ?></h1>

        <?php if (!empty($specialites)): ?>
          <div class="chips">
            <?php foreach ($specialites as $s): ?>
              <span class="chip"><?= h($s) ?></span>
            <?php endforeach; ?>
          </div>
        <?php endif; ?>

        <!-- KPIs -->
        <div class="kpis">
          <div class="kpi">
            <div class="k-title">Note moyenne</div>
            <div class="k-value"><?= h($noteAff) ?></div>
          </div>
          <div class="kpi">
            <div class="k-title">Compatibilité IA</div>
            <div class="k-value"><?= h($compat) ?> <small>selon votre profil</small></div>
          </div>
          <div class="kpi">
            <div class="k-title">Formats</div>
            <div class="k-value"><?= h($format) ?></div>
          </div>
        </div>

        <!-- Boutons principaux -->
        <div class="cta-row">
          <a class="btn primary" href="index.php?Controller=agenda&action=prendre&id=<?= (int)$p['id_praticien'] ?>">
            Prendre rendez-vous
          </a>
          <a class="btn ghost navy" href="index.php?Controller=messagerie&action=nouveau&to=<?= (int)$p['id_praticien'] ?>">
            Envoyer un message
          </a>
          <a class="btn soft" href="#bio">Voir la bio</a>
        </div>
      </div>
    </div>

    <!-- Bloc latéral “Infos pratiques” (maquette: en haut à droite) -->
    <div class="ph-right card top-info">
      <div class="top-bar">
        <button class="btn print" onclick="window.print()"><i class="fa-solid fa-print"></i> Imprimer</button>
        <button class="btn share" id="shareBtn"><i class="fa-solid fa-share-nodes"></i> Partager</button>
        <a class="btn primary sm" href="index.php?Controller=agenda&action=prendre&id=<?= (int)$p['id_praticien'] ?>">
          Prendre rendez-vous
        </a>
      </div>

      <h2>Infos pratiques</h2>
      <ul class="meta">
        <li><i class="fa-solid fa-clock"></i> Lun-Sam, 9h-19h</li>
        <li><i class="fa-solid fa-location-dot"></i> <?= h($p['ville'] ?: $p['adresse_cabinet'] ?: '—') ?></li>
        <?php if (!empty($p['tarifs_consultation'])): ?>
          <li><i class="fa-solid fa-euro-sign"></i> <?= h($p['tarifs_consultation']) ?> € / séance</li>
        <?php endif; ?>
      </ul>
      <a class="btn full soft" href="index.php?Controller=agenda&action=prendre&id=<?= (int)$p['id_praticien'] ?>">Voir les disponibilités</a>
      <a class="btn full ghost" href="#">Ajouter à mon parcours</a>
    </div>
  </header>

  <section class="profile-grid">
    <article class="card about" id="bio">
    <h2>À propos</h2>
    <p><?= nl2br(h($p['longue_description'] ?? $p['description'] ?? '')) ?></p>


      <?php if (!empty($approches)): ?>
        <h3>Spécialités & approches</h3>
        <div class="chips">
          <?php foreach ($approches as $a): ?>
            <span class="chip"><?= h($a) ?></span>
          <?php endforeach; ?>
        </div>
      <?php endif; ?>

      <?php if (!empty($p['diplomes'])): ?>
        <h3>Diplômes</h3>
        <p><?= h($p['diplomes']) ?></p>
      <?php endif; ?>

      <h3>Vidéo de présentation</h3>
      <?php if (!empty($p['video_url'])): ?>
        <a class="video-box link" href="<?= h($p['video_url']) ?>" target="_blank" rel="noopener">
          <span class="play"><i class="fa-solid fa-play"></i></span>
          <span>Voir la vidéo</span>
        </a>
      <?php else: ?>
        <div class="video-box empty">
          <span class="play"><i class="fa-solid fa-play"></i></span>
        </div>
      <?php endif; ?>
    </article>

    <aside class="card side">
       <!-- Disponibilités (extrait) -->
       <h2>Disponibilités (extrait)</h2>
    <?php if (!empty($dispos)): ?>
      <div class="slots-green">
        <?php foreach ($dispos as $row):
          $txt = format_slot($row);
          if (!$txt) continue; ?>
          <div class="bar">
            <i class="fa-regular fa-calendar-check"></i>
            <span><?= h($txt) ?></span>
          </div>
        <?php endforeach; ?>
      </div>
      <a class="btn small primary" href="index.php?Controller=agenda&action=show&id=<?= (int)$p['id_praticien'] ?>">
        Voir l'agenda complet
      </a>
    <?php else: ?>
      <p class="muted">Aucun créneau prochainement.</p>
    <?php endif; ?>

    <h2>Cabinet</h2>
    <p><?= h($p['adresse_cabinet'] ?: ($p['ville'] ?: '—')) ?></p>
    <div class="map-ph" aria-hidden="true">carte / plan (placeholder)</div>

    <!-- Contacts -->
    <h2>Contacts</h2>
    <ul class="contacts list-clean">
      <?php if (!empty($site)): ?>
        <li><i class="fa-solid fa-globe"></i> <a href="<?= h($site) ?>" target="_blank" rel="noopener">Site web</a></li>
      <?php endif; ?>
      <?php if (!empty($tel)): ?>
        <li><i class="fa-solid fa-phone"></i> <a href="tel:<?= h($tel) ?>"><?= h($tel) ?></a></li>
      <?php endif; ?>
      <?php if (!empty($mail)): ?>
        <li><i class="fa-solid fa-envelope"></i> <a href="mailto:<?= h($mail) ?>"><?= h($mail) ?></a></li>
      <?php endif; ?>
    </ul>


      <?php if (!empty($avis)): ?>
        <h2>Avis</h2>
        <?php foreach ($avis as $a): ?>
          <div class="review">
            <strong><?= h($a['auteur'] ?? 'Anonyme') ?></strong>
            <span class="note"><?= (int)$a['note'] ?>/5</span>
            <div class="txt"><?= h($a['commentaire']) ?></div>
            <small><?= h(date('Y-m-d', strtotime($a['date_avis']))) ?></small>
          </div>
        <?php endforeach; ?>
      <?php endif; ?>
    </aside>
  </section>
</div>

<script>
document.getElementById('shareBtn')?.addEventListener('click', async () => {
  const data = { title: document.title, text: 'Découvrez ce praticien sur Holinea', url: location.href };
  if (navigator.share) { try { await navigator.share(data); } catch (e) {} }
  else {
    try {
      await navigator.clipboard.writeText(location.href);
      alert('Lien copié dans le presse-papiers ✅');
    } catch(e) { prompt('Copier le lien :', location.href); }
  }
});
</script>

<?php require 'view_end.php'; ?>
