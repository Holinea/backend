<?php require 'view_begin.php'; ?>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link rel="stylesheet" href="./Content/css/holinea_dossier.css"/>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES,'UTF-8'); }
$d = $data; $id = $data['identite'];
?>

<div class="dossier">

  <!-- Sidebar (fixe à gauche) -->
  <aside class="sidebar">
    <a class="logo" href="index.php">H</a>
    <nav>
      <a class="active"><i class="fa-solid fa-chart-simple"></i></a>
      <a><i class="fa-regular fa-user"></i></a>
      <a><i class="fa-regular fa-message"></i></a>
      <a><i class="fa-regular fa-calendar"></i></a>
      <a><i class="fa-solid fa-gear"></i></a>
    </nav>
    <div class="me">
      <img src="<?= h($id['avatar'] ?: 'Content/img/avatar.png') ?>" alt="">
    </div>
  </aside>

  <main>
    <header class="topbar">
      <a class="back" href="javascript:history.back()"><i class="fa-solid fa-chevron-left"></i></a>
      <h1>Dossier de <?= h($id['nom'] ?: 'YASMINE') ?></h1>
    </header>

    <!-- KPIs -->
    <section class="kpi-row">
      <div class="kpi">
        <div class="k-label">Énergie</div>
        <div class="k-value"><?= h($d['energie_note'] ? number_format($d['energie_note'],0).'/10' : '—') ?></div>
        <div class="k-sub">👍 au-dessus de la moyenne</div>
      </div>
      <div class="kpi peach">
        <div class="k-label">Sommeil (qualité)</div>
        <div class="k-value"><?= h($d['sommeil_pct']!==null ? intval($d['sommeil_pct']).'%' : '—') ?></div>
        <div class="k-sub">Correct</div>
      </div>
      <div class="kpi">
        <div class="k-label">Humeur</div>
        <div class="k-value"><?= h(ucfirst($d['humeur'])) ?></div>
        <div class="k-sub">6/10 en intensité</div>
      </div>
      <div class="kpi mint">
        <div class="k-label">Douleurs</div>
        <div class="k-value"><?= h($d['douleur_note'] ? number_format($d['douleur_note'],0).'/10' : '—') ?></div>
        <div class="k-sub">Zone: <?= h($d['douleur_zone'] ?: '—') ?></div>
      </div>
    </section>

    <section class="grid">
      <div class="card span-2">
        <h3>Visualisations rapides</h3>
        <div class="charts">
          <div class="plot"><canvas id="cLoisirs"></canvas></div>
          <div class="plot"><canvas id="cStress"></canvas></div>
          <div class="plot"><canvas id="cSommeil"></canvas></div>
          <div class="plot"><canvas id="cDouleurs"></canvas></div>
        </div>
      </div>

      <!-- Colonne droite (panneaux) -->
      <div class="col-r">
        <div class="card">
          <h3>Priorités détectées</h3>
          <div class="chips">
            <?php foreach($d['priorites'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
          </div>
        </div>

        <div class="card">
          <h3>Indicateurs suivis <?= !empty($d['indicateurs']) ? '(' . count($d['indicateurs']) . ')' : '' ?></h3>
          <div class="chips green">
            <?php foreach($d['indicateurs'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
          </div>
        </div>

        <div class="card">
          <h3>Attentes</h3>
          <div class="chips orange">
            <?php foreach($d['attentes'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
          </div>
        </div>
      </div>

      <!-- Bas : 2 rangées de cartes -->
      <div class="card">
        <h3>Environnement & Mode de vie</h3>
        <div class="chips">
          <?php foreach($d['env'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
        </div>
      </div>

      <div class="card">
        <h3>Indicateurs suivis</h3>
        <div class="chips green">
          <?php foreach($d['indicateurs'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
        </div>
      </div>

      <div class="card">
        <h3>Corps & Symptômes</h3>
        <ul class="bullets">
          <li>Douleur moy. : <b><?= h($d['symptomes']['douleur_moy'] ?? '—') ?></b></li>
          <li>Pic : <b><?= h($d['symptomes']['douleur_pic'] ?? '—') ?></b> — Zone : <b><?= h($d['symptomes']['zone'] ?? '—') ?></b></li>
          <li>Sommeil : <b><?= h($d['symptomes']['sommeil_pct']!==null ? intval($d['symptomes']['sommeil_pct']).'%' : '—') ?></b></li>
          <?php if(!empty($d['symptomes']['pb_sommeil'])): ?>
            <li>Problèmes sommeil : <?= h($d['symptomes']['pb_sommeil']) ?></li>
          <?php endif; ?>
        </ul>
      </div>

      <div class="card">
        <h3>Émotions</h3>
        <ul class="bullets">
          <?php if(!empty($d['emotions']['liste'])): ?>
            <li>Émotions : <?= h(implode(', ', $d['emotions']['liste'])) ?></li>
          <?php endif; ?>
          <li>Intensité : <b><?= h($d['emotions']['intensite'] ?? '—') ?></b></li>
          <li>Stress : <b><?= h($d['emotions']['stress'] ?? '—') ?></b></li>
          <?php if(!empty($d['emotions']['isolement'])): ?>
            <li>Isolement : <?= h($d['emotions']['isolement']) ?></li>
          <?php endif; ?>
          <?php if(!empty($d['emotions']['moments'])): ?>
            <li>Moments sensibles : <?= h($d['emotions']['moments']) ?></li>
          <?php endif; ?>
        </ul>
      </div>

      <div class="card">
        <h3>Objectifs & Intentions</h3>
        <div class="chips green">
          <?php foreach($d['objectifs'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
        </div>
        <?php if(!empty($d['intentions'])): ?>
          <div class="chips orange">
            <?php foreach($d['intentions'] as $t): ?><span class="chip"><?= h($t) ?></span><?php endforeach; ?>
          </div>
        <?php endif; ?>
      </div>

      <div class="card">
        <h3>Suivi & Partage</h3>
        <ul class="bullets">
          <li>Accompagnement : <b><?= h($d['accompagnement'] ?: '—') ?></b></li>
          <li>Fréquence rappels : <b><?= h($d['rappels_freq'] ?: '—') ?></b></li>
          <li>Partage : <b><?= h($d['partage'] ?: '—') ?></b></li>
        </ul>
        <?php if(!empty($d['notes_suivi'])): ?>
          <p class="muted"><?= h($d['notes_suivi']) ?></p>
        <?php endif; ?>
      </div>
    </section>
  </main>
</div>

<script>
/* Charts (données du contrôleur) */
const loisir = <?= json_encode($d['loisir_notes'] ?: [3,4,2,4]) ?>;
const stress = <?= json_encode($d['stress_series'] ?: [5,6,6,5,5]) ?>;
const emo    = <?= json_encode($d['emo_series'] ?: [6,6,7,6,6]) ?>;
const sleep  = <?= json_encode($d['sleep_scores'] ?: [60,55,62,70]) ?>;
const pavg   = <?= json_encode($d['pain_avg'] ?: 4) ?>;
const ppic   = <?= json_encode($d['pain_peak'] ?: 7) ?>;

const mkBar = (id, labels, data, label) => new Chart(document.getElementById(id), {
  type:'bar',
  data:{labels, datasets:[{label, data}]}, options:{responsive:true, plugins:{legend:{display:false}}}
});
const mkLine = (id, labels, d1, d2, l1, l2) => new Chart(document.getElementById(id), {
  type:'line',
  data:{labels, datasets:[{label:l1, data:d1, tension:.3}, {label:l2, data:d2, tension:.3}]},
  options:{responsive:true}
});

mkBar('cLoisirs', ['L1','L2','L3','L4'], loisir, 'Score loisir (1–5)');
mkLine('cStress', ['J1','J2','J3','J4','J5'], stress, emo, 'Stress (0–10)', 'Intensité émotions (1–10)');
mkBar('cSommeil', ['Q1','Q2','Q3','Q4'], sleep, 'Qualité (0–100)');
mkBar('cDouleurs', ['Moyenne','Pic'], [pavg, ppic], 'Douleurs');
</script>

<?php require 'view_end.php'; ?>
