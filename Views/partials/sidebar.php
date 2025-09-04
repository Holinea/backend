<?php
// Views/partials/sidebar.php

// Défauts si non fournis
if (!isset($active)) { $active = ''; }
if (!isset($me) || !is_array($me)) {
  $me = [
    'name'   => '—',
    'role'   => 'Praticien',
    'avatar' => 'Content/img/avatar.png',
  ];
}

// Helper actif
$isActive = function(string $slug) use ($active) {
  return $active === $slug ? 'active' : '';
};
?>
<aside class="sidebar">
  <div class="brand">
    <button class="collapse-btn" aria-label="Replier la navigation" aria-expanded="true">
      <i class="fa-solid fa-bars"></i>
    </button>
    <img src="./Content/img/logo-holinea.svg" alt="Holinea" />
  </div>

  <nav class="menu">
    <a href="index.php?Controller=clients&action=index" class="item <?= $isActive('clients') ?>">
      <i class="fa-solid fa-users"></i> <span class="txt">Mes clients</span>
    </a>
    <a href="index.php?Controller=agenda&action=index" class="item <?= $isActive('agenda') ?>">
      <i class="fa-solid fa-calendar"></i> <span class="txt">Agenda</span>
    </a>
    <a href="#" class="item <?= $isActive('stats') ?>">
      <i class="fa-solid fa-chart-line"></i> <span class="txt">Mes Statistiques</span>
    </a>
    <a href="#" class="item <?= $isActive('messages') ?>">
      <i class="fa-solid fa-message"></i> <span class="txt">Messagerie</span>
    </a>
    <a href="index.php?Controller=agenda&action=settings" class="item <?= $isActive('settings') ?>">
      <i class="fa-solid fa-gear"></i> <span class="txt">Paramètres</span>
    </a>
  </nav>

  <div class="sidebar-cta">
    <div class="me">
      <img src="<?= htmlspecialchars($me['avatar'], ENT_QUOTES) ?>" class="me-avatar" alt="">
      <div class="me-meta">
        <div class="me-name"><?= htmlspecialchars($me['name'], ENT_QUOTES) ?></div>
        <div class="me-role"><?= htmlspecialchars($me['role'], ENT_QUOTES) ?></div>
      </div>
    </div>
  </div>
</aside>
