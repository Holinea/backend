<?php require "view_begin.php"; ?>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link rel="stylesheet" href="./Content/css/holinea_results.css"/>

<?php
function h($s){ return htmlspecialchars($s ?? "", ENT_QUOTES, "UTF-8"); }
function chips_from_csv($s){
  if (is_array($s)) return $s;
  $out = [];
  foreach (explode(',', (string)$s) as $c){
    $c = trim($c);
    if ($c !== '') $out[] = $c;
  }
  return $out;
}
function modeLabel($mode){
  if ($mode === 'distance') return 'Visio';
  if ($mode === 'cabinet')  return 'Présentiel';
  return ucfirst((string)$mode);
}
function ratingFromTaux($taux){
  if ($taux === null || $taux === "") return null;
  $v = max(0.0, min(100.0, floatval($taux)));
  $five = round(($v/100.0)*5.0, 1);
  return number_format($five, 1, ',', ' ');
}
?>

<div class="holinea-results">
  <div class="results-header">
    <h2>Résultats</h2>
    <div class="filters-recap">
      <?php if (!empty($modalite)): ?><span class="chip"><?= h(strtoupper($modalite)) ?></span><?php endif; ?>
      <?php if (!empty($specialite)): ?><span class="chip"><?= h($specialite) ?></span><?php endif; ?>
      <?php if (!empty($approche)): ?><span class="chip"><?= h($approche) ?></span><?php endif; ?>
    </div>
    <a class="close" href="index.php?Controller=recherche&action=index" title="Nouvelle recherche">&times;</a>
  </div>

  <?php if (!empty($resultats)): ?>
    <div class="cards-grid">
      <?php foreach ($resultats as $p): ?>
        <?php
          $chipsSpecialites = chips_from_csv($p['specialites'] ?? '');
          $chipsApproches   = chips_from_csv($p['type_approche'] ?? '');
          $rating = ratingFromTaux($p['taux_satisfaction'] ?? null);
          $ville  = $p['ville'] ?? '';
          if (!$ville && !empty($p['adresse_cabinet'])) {
            $ville = $p['adresse_cabinet'];
          }
          $presence = modeLabel($p['mode_consultation'] ?? '');
          $presence_detail = ($p['mode_consultation']==='cabinet') ? 'Présentiel uniquement'
                             : (($p['mode_consultation']==='distance') ? 'Visio uniquement' : $presence);
        ?>
        <article class="pro-card">
          <div class="pro-head">
            <div class="avatar">
              <?php if (!empty($p['photo_profil_url'])): ?>
                <img src="<?= h($p['photo_profil_url']) ?>" alt="Photo de <?= h(($p['prenom'] ?? '').' '.($p['nom'] ?? '')) ?>">
              <?php else: ?>
                <div class="avatar-fallback"><i class="fa-solid fa-user"></i></div>
              <?php endif; ?>
            </div>

            <div class="id-block">
              <a class="name" href="#"><?= h(($p['prenom'] ?? '').' '.($p['nom'] ?? '')) ?></a>

              <?php if (!empty($chipsSpecialites)): ?>
                <div class="spec-chips">
                  <?php foreach ($chipsSpecialites as $c): ?>
                    <span class="chip spec"><?= h($c) ?></span>
                  <?php endforeach; ?>
                </div>
              <?php endif; ?>
            </div>
          </div>

          <?php if (!empty($p['description'])): ?>
            <p class="desc"><?= h($p['description']) ?></p>
          <?php endif; ?>

          <div class="meta-line">
            <?php if ($rating): ?>
              <span class="rating">
                <i class="fa-solid fa-star"></i> <?= $rating ?> / 5
                <?php if (!empty($p['nb_avis'])): ?>
                  <span class="light">(<?= intval($p['nb_avis']) ?> avis)</span>
                <?php endif; ?>
              </span>
            <?php endif; ?>

            <span class="place">
              <i class="fa-solid fa-location-dot"></i>
              <?= h($ville ?: '—') ?>
              <?php if (!empty($presence_detail)): ?>
                <span class="sep">•</span> <?= h($presence_detail) ?>
              <?php endif; ?>
            </span>
          </div>

          <!-- ✅ Tarifs sur une ligne -->
          <?php if (!empty($p['tarifs_consultation'])): ?>
            <div class="price">Tarifs : <?= h($p['tarifs_consultation']) ?> €</div>
          <?php endif; ?>

          <!-- ✅ Années d’expérience sur une autre ligne -->
          <?php if (!empty($p['annees_experience'])): ?>
            <div class="experience">
              <i class="fa-solid fa-briefcase"></i> <?= intval($p['annees_experience']) ?> ans d'expérience
            </div>
          <?php endif; ?>

          <!-- ✅ Types d’approche -->
          <?php if (!empty($chipsApproches)): ?>
            <div class="spec-chips approaches">
              <?php foreach ($chipsApproches as $ap): ?>
                <span class="chip approach"><?= h($ap) ?></span>
              <?php endforeach; ?>
            </div>
          <?php endif; ?>

          <?php if (!empty($p['diplomes'])): ?>
            <div class="diplomes">
              <span class="label">Diplômes :</span>
              <span class="value"><?= h($p['diplomes']) ?></span>
            </div>
          <?php endif; ?>

          <div class="video-placeholder">
            <button class="play"><i class="fa-solid fa-play"></i></button>
          </div>

          <div class="actions">
            <a class="btn ghost" href="index.php?Controller=praticien&action=show&id=<?= intval($p['id_praticien']) ?>"> Voir profil</a>
            <a class="btn primary" href="#">Prendre rendez-vous</a>
            <a class="btn soft" href="#">Ajouter à mon parcours</a>
          </div>
        </article>
      <?php endforeach; ?>
    </div>
  <?php else: ?>
    <div class="no-results">Aucun praticien trouvé pour cette recherche.</div>
  <?php endif; ?>
</div>

<script>
(function () {
  const $  = (sel, root=document) => root.querySelector(sel);
  const $$ = (sel, root=document) => [...root.querySelectorAll(sel)];

  // 1) Reveal
  const cards = $$('.holinea-results .pro-card');
  const io = new IntersectionObserver(entries => {
    entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('enter'); });
  }, { threshold: 0.15 });
  cards.forEach(c => io.observe(c));

  // 2) Tilt
  cards.forEach(card => {
    let raf = null;
    function onMove(ev){
      const r = card.getBoundingClientRect();
      const x = (ev.clientX - r.left) / r.width - 0.5;
      const y = (ev.clientY - r.top)  / r.height - 0.5;
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(() => {
        card.style.setProperty('--rx', (y * -4).toFixed(2));
        card.style.setProperty('--ry', (x *  6).toFixed(2));
        card.classList.add('hover');
      });
    }
    function onLeave(){
      card.classList.remove('hover');
      card.style.setProperty('--rx', 0);
      card.style.setProperty('--ry', 0);
    }
    card.addEventListener('mousemove', onMove);
    card.addEventListener('mouseleave', onLeave);
  });

  // 3) Ripple
  function addRipple(e){
    const btn = e.currentTarget;
    const r = btn.getBoundingClientRect();
    const s = document.createElement('span');
    s.className = 'ripple';
    const size = Math.max(r.width, r.height);
    s.style.width = s.style.height = size + 'px';
    s.style.left = (e.clientX - r.left - size/2) + 'px';
    s.style.top  = (e.clientY - r.top  - size/2) + 'px';
    btn.appendChild(s);
    setTimeout(() => s.remove(), 500);
  }
  $$('.holinea-results .btn').forEach(b => b.addEventListener('click', addRipple));

  // 4) Favori
  cards.forEach((card, i) => {
    const id = card.dataset.pid || ('card-'+i);
    let fav = document.createElement('button');
    fav.className = 'fav-btn';
    fav.type = 'button';
    fav.innerHTML = '<i class="fa-solid fa-heart"></i>';
    if (localStorage.getItem('fav:'+id) === '1') fav.classList.add('active');
    fav.addEventListener('click', () => {
      fav.classList.toggle('active');
      localStorage.setItem('fav:'+id, fav.classList.contains('active') ? '1' : '0');
    });
    card.prepend(fav);
  });

  // 5) Lire plus
  $$('.holinea-results .desc').forEach(desc => {
    if (desc.textContent.trim().length < 160) return;
    desc.classList.add('clamp');
    const a = document.createElement('button');
    a.type = 'button';
    a.className = 'read-more';
    a.textContent = 'Lire plus';
    a.addEventListener('click', () => {
      const expand = desc.classList.toggle('clamp') === false;
      a.textContent = expand ? 'Réduire' : 'Lire plus';
    });
    desc.after(a);
  });

  // 6) Play animé
  $$('.holinea-results .video-placeholder .play').forEach(btn => {
    btn.addEventListener('mouseenter', () => btn.classList.add('pulse'));
    btn.addEventListener('mouseleave', () => btn.classList.remove('pulse'));
    btn.addEventListener('click', () => btn.classList.toggle('playing'));
  });
})();
</script>

<?php require "view_end.php"; ?>
