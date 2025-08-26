<div class="recherche-praticien-holinea">
  <form method="POST" action="index.php?Controller=recherche&action=recherche">
    <div class="toggle-switch-modalite">
      <input type="radio" id="cabinet" name="modalite" value="cabinet" <?= (!isset($_POST['modalite']) || $_POST['modalite']=='cabinet') ? 'checked' : '' ?>>
      <input type="radio" id="distance" name="modalite" value="distance" <?= (isset($_POST['modalite']) && $_POST['modalite']=='distance') ? 'checked' : '' ?>>
      <div class="switch">
        <label for="cabinet" class="option cabinet"><i class="fa fa-building"></i> CABINET</label>
        <label for="distance" class="option distance"><i class="fa fa-video"></i> DISTANCE</label>
        <span class="slider"></span>
      </div>
    </div>

    <?php $modalite = $_POST['modalite'] ?? 'cabinet'; ?>
    <div class="champ-recherche">
      <?php if ($modalite == 'cabinet') : ?>
        <input type="text" name="specialites" placeholder="Spécialité, type d’approche" value="<?= htmlspecialchars($_POST['specialites'] ?? '') ?>">
        <input type="text" name="code_postal" placeholder="Ville, code postal" value="<?= htmlspecialchars($_POST['localisation'] ?? '') ?>">
        <div class="localisation-auto">
          <input type="checkbox" id="autour" name="autour" <?= isset($_POST['autour']) ? 'checked' : '' ?>>
          <label for="autour"><i class="fa fa-location-arrow"></i> <b>autour de moi</b></label>
        </div>
      <?php else: ?>
        <input type="text" name="specialites" placeholder="Spécialité, " value="<?= htmlspecialchars($_POST['specialites'] ?? '') ?>">
        <div class="modalite-indication">
          <i class="fa fa-video"></i> <b>Visio</b>
        </div>
      <?php endif; ?>
    </div>
    
    <div class="recherche-actions">
      <button type="submit" class="btn-rechercher">
        RECHERCHER <i class="fa fa-search"></i>
      </button>
    </div>
    <div class="recherche-tags">
      <?php
      $tags = ['Stress', 'Sommeil', 'Ostéopathie', 'Naturopathie', 'Coaching'];
      foreach ($tags as $tag) {
        echo "<span>".htmlspecialchars($tag)."</span>";
      }
      ?>
    </div>
  </form>
</div>
