<?php
// backend/Views/view_agenda_settings.php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
$me = $me ?? [];

$active = 'agenda';

?>


<link rel="stylesheet" href="./Content/css/holinea_agenda.css">
<link rel="stylesheet" href="./Content/css/holinea_agenda_settings.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<div class="layout agenda-layout">
  <!-- Sidebar réutilisée -->
  <?php require __DIR__ . '/partials/sidebar.php'; ?>

  <main class="settings-main card">
    <header class="settings-head">
      <a href="index.php?Controller=agenda&action=index" class="btn ghost">
        <i class="fa-solid fa-arrow-left"></i>
      </a>
      <h1>Paramétrer mon agenda</h1>
      <div class="spacer"></div>
      <a href="index.php?Controller=agenda&action=index" class="btn soft">Voir mes séances</a>
    </header>

    <section class="settings-toolbar">
      <div class="field">
        <label>Limiter</label>
        <div class="inline">
          <select id="limitPerDay">
            <option>1</option><option>2</option><option selected>3</option><option>4</option><option>5</option>
          </select>
          <span>RDV/Jour</span>
        </div>
      </div>

      <button id="applyLimit" class="btn green">Appliquer</button>
      <button id="defineHours" class="btn dark">Définir mes horaires</button>
    </section>

    <!-- Grille hebdomadaire simple façon maquette -->
    <section class="week-grid">
      <?php
        $days = ['Lun','Mar','Mer','Jeu','Ven','Sam','Dim'];
        foreach ($days as $d):
      ?>
      <article class="day-card">
        <h3><?= $d ?></h3>

        <div class="slot">
          <div class="slot-time">09:00 – 09:45</div>
          <div class="slot-actions">
            <span class="badge free">Disponible</span>
            <button class="btn ghost btn-sm act-block">Bloquer</button>
          </div>
        </div>

        <div class="slot">
          <div class="slot-time">10:00 – 10:45</div>
          <div class="slot-actions">
            <span class="badge busy">Réservé</span>
            <button class="btn ghost btn-sm act-unblock" disabled>Débloquer</button>
          </div>
        </div>

        <div class="slot">
          <div class="slot-time">11:00 – 11:45</div>
          <div class="slot-actions">
            <span class="badge free">Disponible</span>
            <button class="btn ghost btn-sm act-block">Bloquer</button>
          </div>
        </div>
      </article>
      <?php endforeach; ?>
    </section>

    <!-- Panneau d’action -->
    <section class="settings-panel">
      <div class="row">
        <div class="field">
          <label>Créneau</label>
          <select>
            <option>Jeudi 10 sept. 09:00–09:45</option>
            <option>Jeudi 10 sept. 10:00–10:45</option>
          </select>
        </div>
        <div class="field">
          <label>Type de séance</label>
          <select>
            <option>Présentiel</option>
            <option>Visio</option>
          </select>
        </div>
      </div>

      <div class="conditions">
        <h4>Conditions générales de réservation</h4>
        <p>Toute séance non annulée 24h à l’avance est due.</p>
        <p><a href="#">Clause obligatoire lors de la réservation</a></p>
      </div>

      <button class="btn primary full">Prendre RDV</button>
    </section>
  </main>
</div>

