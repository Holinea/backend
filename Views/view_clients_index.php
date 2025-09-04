<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
?>
<?php require 'view_begin_therapeute.php'; ?>
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
      <a href="index.php?Controller=agenda&action=index" class="item">
            <i class="fa-solid fa-calendar"></i> Agenda
      </a>
      <a href="#" class="item"><i class="fa-solid fa-book"></i> Annuaires</a>
      <a href="#" class="item"><i class="fa-solid fa-chart-line"></i> Mes Statistiques</a>
      <a href="#" class="item"><i class="fa-solid fa-message"></i> Messagerie <span class="badge">5</span></a>
      <a href="#" class="item"><i class="fa-solid fa-file-invoice-dollar"></i> Facturation</a>
      <a href="#" class="item"><i class="fa-solid fa-gear"></i> Paramètres</a>
    </nav>

    <div class="sidebar-cta">
      <a class="btn primary" href="#"><i class="fa-solid fa-plus"></i> Nouveau RDV</a>
      <div class="me">
        <img src="<?= h($me['avatar'] ?? 'Content/img/avatar.png') ?>" class="me-avatar" alt="">
        <div>
          <div class="me-name"><?= h($me['name'] ?? '—') ?></div>
          <div class="me-role"><?= h($me['role'] ?? 'Praticien') ?></div>
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

    <!-- Filtres (inactifs pour le moment) -->
    <form class="filters" method="get">
      <div class="field icon-left">
        <i class="fa-solid fa-magnifying-glass"></i>
        <input type="text" name="q" placeholder="Rechercher par nom, email…" value="">
      </div>
      <select name="order">
        <option value="nom">Nom</option>
        <option value="dernier_rdv">Dernier RDV</option>
      </select>
      <input type="date" name="date" value="">
      <select name="specialite">
        <option value="">Spécialité</option>
        <option>Yoga</option><option>Naturopathie</option><option>Massage</option>
      </select>
      <select name="dernier">
        <option>Dernier RDV</option>
        <option>Premier RDV</option>
      </select>
    </form>

    <!-- Liste vide pour l’instant -->
    <section class="cards">
      <div class="empty">Aucun patient pour le moment.</div>
    </section>
  </main>
</div>
