<?php require 'view_begin.php'; ?>
<link rel="stylesheet" href="./Content/css/holinea_admin.css">

<h1>Espace administrateur</h1>

<table class="admin-table">
  <thead>
    <tr><th>Avatar</th><th>Nom</th><th>Email</th><th>Statut</th><th>Actions</th></tr>
  </thead>
  <tbody>
  <?php foreach ($users as $u): ?>
    <tr>
      <td><img src="<?= h($u['photo_profil_url'] ?? 'Content/img/avatar.png') ?>" width="50"></td>
      <td><?= h($u['prenom'].' '.$u['nom']) ?></td>
      <td><?= h($u['mail']) ?></td>
      <td><span class="badge <?= h($u['statut_compte']) ?>"><?= h($u['statut_compte']) ?></span></td>
      <td>
        <form method="post" action="index.php?Controller=admin&action=update_status">
          <input type="hidden" name="id" value="<?= (int)$u['id_utilisateur'] ?>">
          <button name="status" value="actif" class="btn green">Valider</button>
          <button name="status" value="incomplet" class="btn orange">Incomplet</button>
          <button name="status" value="refuse" class="btn red">Refuser</button>
        </form>
      </td>
    </tr>
  <?php endforeach; ?>
  </tbody>
</table>

<?php require 'view_end.php'; ?>
