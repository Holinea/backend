<?php
function h($s){ return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8'); }
$me = $me ?? [];  $scope = $scope ?? 'day';
?>

<link rel="stylesheet" href="./Content/css/holinea_agenda.css">
<link rel="stylesheet" href="./Content/css/holinea_sessions.css">


<div class="layout agenda-layout" style="grid-template-columns:72px 1fr">
<aside class="sidebar">
    <div class="brand">
      <button class="collapse-btn" aria-label="Replier la navigation" aria-expanded="true">
        <i class="fa-solid fa-bars"></i>
      </button>
      <img src="./Content/img/logo-holinea.svg" alt="Holinea" />
    </div>

    <nav class="menu">
      <a href="index.php?Controller=clients&action=index" class="item">
        <i class="fa-solid fa-users"></i> <span class="txt">Mes clients</span>
      </a>
      <a href="index.php?Controller=agenda&action=index" class="item active">
        <i class="fa-solid fa-calendar"></i> <span class="txt">Agenda</span>
      </a>
      <a href="#" class="item"><i class="fa-solid fa-chart-line"></i> <span class="txt">Mes Statistiques</span></a>
      <a href="#" class="item"><i class="fa-solid fa-message"></i> <span class="txt">Messagerie</span></a>
      <a href="index.php?Controller=agenda&action=settings" class="item"><i class="fa-solid fa-gear"></i> <span class="txt">Paramètres</span></a>
    </nav>

    <div class="sidebar-cta">
      <div class="me">
        <img src="<?= h($me['avatar'] ?? 'Content/img/avatar.png') ?>" class="me-avatar" alt="">
        <div class="me-meta">
          <div class="me-name"><?= h($me['name'] ?? '—') ?></div>
          <div class="me-role"><?= h($me['role'] ?? '') ?></div>
        </div>
      </div>
    </div>
  </aside>

  <main class="content card settings-main">
    <header class="settings-head">
      <a href="index.php?Controller=agenda&action=index" class="btn icon-only" title="Retour">
        <i class="fa-solid fa-arrow-left"></i>
      </a>
      <h1>Tableau de bord des séances</h1>
      <div class="spacer"></div>

      <!-- Portée -->
      <a class="btn <?php echo $scope==='day'?'primary':''; ?>"
         href="index.php?Controller=agenda&action=sessions&scope=day">Vue du jour</a>
      <a class="btn <?php echo $scope==='week'?'primary':''; ?>"
         href="index.php?Controller=agenda&action=sessions&scope=week">Vue de la semaine</a>
      <a class="btn <?php echo $scope==='month'?'primary':''; ?>"
         href="index.php?Controller=agenda&action=sessions&scope=month">Vue du mois</a>
    </header>

    <form class="settings-toolbar" method="get" action="index.php">
      <input type="hidden" name="Controller" value="agenda">
      <input type="hidden" name="action" value="sessions">
      <input type="hidden" name="scope" value="<?= h($scope) ?>">

      <div class="field">
        <label>Patients</label>
        <select name="patient">
          <option value="">Tous les patients</option>
          <?php foreach(($patients ?? []) as $p): ?>
            <option value="<?= (int)$p['id'] ?>" <?= (!empty($patientId) && (int)$patientId===(int)$p['id'])?'selected':'' ?>>
              <?= h($p['nom']) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="field">
        <label>Spécialité</label>
        <select name="specialite">
          <option value="">Toutes spécialités</option>
          <?php foreach(($specialites ?? []) as $s): ?>
            <option value="<?= h($s) ?>" <?= (!empty($specialite) && $specialite===$s)?'selected':'' ?>>
              <?= h($s) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="field">
        <label>Statut</label>
        <select name="status">
          <option value="">Tous</option>
          <option value="upcoming" <?= ($status==='upcoming'?'selected':'') ?>>À venir</option>
          <option value="past"     <?= ($status==='past'?'selected':'') ?>>Passé</option>
        </select>
      </div>

      <div class="inline">
        <button class="btn dark btn-sm" type="submit"><i class="fa-solid fa-filter"></i> Filtrer</button>
      </div>
    </form>

    <section class="card">
      <table class="sessions">
        <thead>
          <tr>
            <th>Avatar</th>
            <th>Date</th>
            <th>Heure</th>
            <th>Patient</th>
            <th>Spécialité</th>
            <th class="text-right">Statut</th>
          </tr>
        </thead>
        <tbody>
          <?php if (empty($sessions)): ?>
            <tr><td colspan="6" class="empty">Aucune séance sur la période.</td></tr>
          <?php else: foreach ($sessions as $s): 
            $d = $s['date_rdv'] ?? '';
            $hd= $s['heure_debut'] ?? '';
            $hf= $s['heure_fin'] ?? '';
            $badge = (strpos($s['statut'],'past')!==false) ? 'past' : 'upcoming';
          ?>
          <tr>
            <td>
              <img class="avatar" src="<?= h($s['patient_avatar'] ?: 'Content/img/avatar.png') ?>" alt="">
            </td>
            <td><?= h(date('d/m/Y', strtotime($d))) ?></td>
            <td><?= h(substr($hd,0,5)) ?><?= $hf ? ' — '.h(substr($hf,0,5)) : '' ?></td>
            <td><?= h($s['patient_nom']) ?></td>
            <td><?= h($s['specialite']) ?></td>
            <td class="text-right">
              <?php if ($badge==='upcoming'): ?>
                <span class="badge badge-ok"><i class="fa-regular fa-clock"></i> À venir</span>
              <?php else: ?>
                <span class="badge badge-warn"><i class="fa-solid fa-check"></i> Passé</span>
              <?php endif; ?>
            </td>
          </tr>
          <?php endforeach; endif; ?>
        </tbody>
      </table>
    </section>
  </main>
</div>


