<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
$p = $p ?? [];
?>
<?php require 'view_begin.php'; ?>
<link rel="stylesheet" href="./Content/css/holinea_clients.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<div class="layout">
  <aside class="sidebar">
    <div class="brand">
      <img src="./Content/img/logo-holinea.svg" alt="Holinea" />
    </div>
    <nav class="menu">
      <a href="#" class="item active"><i class="fa-solid fa-user"></i> Mon espace</a>
      <a href="#" class="item"><i class="fa-solid fa-calendar-check"></i> Mes rendez-vous</a>
      <a href="#" class="item"><i class="fa-solid fa-message"></i> Messagerie</a>
      <a href="#" class="item"><i class="fa-solid fa-gear"></i> Paramètres</a>
    </nav>
    <div class="sidebar-cta">
      <div class="me">
        <img src="<?= h($p['avatar'] ?: 'Content/img/avatar.png') ?>" class="me-avatar" alt="">
        <div>
          <div class="me-name"><?= h(trim(($p['prenom'] ?? '').' '.($p['nom'] ?? ''))) ?></div>
          <div class="me-role"><?= h($p['email'] ?? '') ?></div>
        </div>
      </div>
    </div>
  </aside>

  <main class="content">
    <header class="top">
      <h1>Bienvenue, <?= h($p['prenom'] ?? 'vous') ?> 👋</h1>
    </header>

    <section class="cards" style="max-width:900px">
      <article class="patient-card">
        <div class="pc-left">
          <img class="avatar" src="<?= h($p['avatar'] ?: 'Content/img/avatar.png') ?>" alt="">
          <div>
            <div class="name"><?= h(trim(($p['prenom'] ?? '').' '.($p['nom'] ?? ''))) ?></div>
            <div class="status">
              <span class="badge green">Compte connecté</span>
            </div>
          </div>
        </div>

        <ul class="kpis">
          <li><span class="pill"><i>😌</i> Stress <b><?= h($p['stress'] ?: '—') ?></b></span></li>
          <li><span class="pill"><i>❌</i> Douleur <b><?= h($p['douleur'] ?: '—') ?></b></span></li>
          <li><span class="pill"><i>⚡</i> Énergie <b><?= h($p['energie'] ?: '—') ?></b></span></li>
          <li><span class="pill"><i>😴</i> Sommeil <b><?= h($p['sommeil'] ?: '—') ?></b></span></li>
        </ul>

        <div class="pc-meta">
          <span>Dernier RDV : <?= h($p['dernier_rdv'] ?: '—') ?></span>
          <?php if (!empty($p['objectif'])): ?>
            <span class="sep">•</span><span>Objectif : <?= h($p['objectif']) ?></span>
          <?php endif; ?>
        </div>

        <div class="pc-actions">
          <a class="btn ghost" href="#"><i class="fa-regular fa-calendar"></i> Prendre un RDV</a>
          <a class="btn light" href="#"><i class="fa-regular fa-paper-plane"></i> Contacter mon thérapeute</a>
        </div>
      </article>
    </section>
  </main>
</div>

<?php require 'view_end.php'; ?>
