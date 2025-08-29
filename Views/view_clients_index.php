<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
$me = $me ?? ['name'=>'', 'avatar'=>'Content/img/avatar.png', 'specialites'=>'', 'email'=>''];
?>
<link rel="stylesheet" href="./Content/css/holinea_clients.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<div class="layout">
  <!-- Sidebar -->
  <aside class="sidebar">
    <div class="brand">
      <img src="./Content/img/logo-holinea.svg" alt="Holinea" />
    </div>

    <nav class="menu">
      <a href="#" class="item"><i class="fa-solid fa-gauge-high"></i> Tableau de bord</a>
      <a href="#" class="item active"><i class="fa-solid fa-users"></i> Mes clients</a>
      <a href="#" class="item"><i class="fa-solid fa-eye"></i> Voir mes séances</a>
      <a href="#" class="item"><i class="fa-solid fa-calendar"></i> Agenda</a>
      <a href="#" class="item"><i class="fa-solid fa-book"></i> Annuaires</a>
      <a href="#" class="item"><i class="fa-solid fa-chart-line"></i> Mes Statistiques</a>
      <a href="#" class="item"><i class="fa-solid fa-message"></i> Messagerie <span class="badge">5</span></a>
      <a href="#" class="item"><i class="fa-solid fa-file-invoice-dollar"></i> Facturation</a>
      <a href="#" class="item"><i class="fa-solid fa-gear"></i> Paramètres</a>
    </nav>

    <div class="sidebar-cta">
      <a class="btn primary" href="#"><i class="fa-solid fa-plus"></i> Nouveau RDV</a>

      <!-- ✅ Profil thérapeute connecté -->
      <div class="me">
        <img src="<?= h($me['avatar']) ?>" class="me-avatar" alt="">
        <div>
          <div class="me-name"><?= h($me['name']) ?></div>
          <?php if (!empty($me['specialites'])): ?>
            <div class="me-role"><?= h($me['specialites']) ?></div>
          <?php endif; ?>
          <?php if (!empty($me['email'])): ?>
            <div class="me-mail"><?= h($me['email']) ?></div>
          <?php endif; ?>
        </div>
      </div>
    </div>
  </aside>

  <main class="content">
    <header class="top">
      <a href="#" class="back"><i class="fa-solid fa-chevron-left"></i></a>
      <h1>Mes patients</h1>

      <div class="top-actions">
        <a class="btn ghost" href="#"><i class="fa-solid fa-user-plus"></i> Ajouter un patient</a>
        <a class="btn dark" href="#"><i class="fa-solid fa-file-export"></i> Exporter (.csv)</a>
      </div>
    </header>

    <!-- Filtres -->
    <form class="filters" method="get">
      <div class="field icon-left">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" name="q" placeholder="Rechercher par nom, email…" value="<?= h($_GET['q'] ?? '') ?>">
      </div>
      <select name="order">
        <option value="nom">Nom</option>
        <option value="dernier_rdv">Dernier RDV</option>
      </select>
      <input type="date" name="date" value="<?= h($_GET['date'] ?? '') ?>">
      <select name="specialite">
        <option value="">Spécialité</option>
        <option>Yoga</option><option>Naturopathie</option><option>Massage</option>
      </select>
      <select name="dernier">
        <option>Dernier RDV</option>
        <option>Premier RDV</option>
      </select>
    </form>

    <!-- Cartes patients -->
    <section class="cards">
      <?php foreach (($patients ?? []) as $p): ?>
        <article class="patient-card">
          <div class="pc-left">
            <img class="avatar" src="<?= h($p['avatar'] ?: './Content/img/avatar.png') ?>" alt="">
            <div>
              <div class="name"><?= h(($p['prenom'] ?: '').' '.($p['nom'] ?: '')) ?></div>
              <div class="status">
                <?php if (($p['acces'] ?? 'partage') === 'refuse'): ?>
                  <span class="badge red">Accès refusé</span>
                <?php else: ?>
                  <span class="badge green">Accès partagé</span>
                <?php endif; ?>
              </div>
            </div>
          </div>

          <ul class="kpis">
            <li><span class="pill"><i>😌</i> Stress <b><?= h($p['stress']) ?></b></span></li>
            <li><span class="pill"><i>❌</i> Douleur <b><?= h($p['douleur']) ?></b></span></li>
            <li><span class="pill"><i>⚡</i> Énergie <b><?= h($p['energie']) ?></b></span></li>
            <li><span class="pill"><i>😴</i> Sommeil <b><?= h($p['sommeil']) ?></b></span></li>
          </ul>

          <div class="pc-meta">
            <span>Dernier RDV : <?= h($p['dernier_rdv'] ?: '—') ?></span>
            <?php if (!empty($p['objectif'])): ?>
              <span class="sep">•</span><span>Objectif : <?= h($p['objectif']) ?></span>
            <?php endif; ?>
          </div>

          <div class="pc-actions">
            <a class="btn light" href="#"><i class="fa-regular fa-paper-plane"></i> Message</a>
            <a class="btn ghost" href="#"><i class="fa-regular fa-folder-open"></i> Voir le dossier</a>
          </div>
        </article>
      <?php endforeach; ?>

      <?php if (empty($patients)): ?>
        <div class="empty">Aucun patient trouvé.</div>
      <?php endif; ?>
    </section>
  </main>
</div>
