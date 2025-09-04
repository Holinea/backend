<?php require 'view_begin.php'; ?>
<?php
// Views/patient_register.php
if (!function_exists('h')) { function h($s){return htmlspecialchars($s??'',ENT_QUOTES,'UTF-8');} }
?>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<link rel="stylesheet" href="./Content/css/holinea_register.css"/>

<div class="reg-hero">
  <div class="reg-card" role="region" aria-label="Inscription patient">
    <h1>Inscription</h1>

    <form class="reg-form"
      method="post"
      action="index.php?Controller=inscription&action=register_submit"
      enctype="multipart/form-data" novalidate>


      <div class="field">
        <input type="email" name="email" placeholder="Email" required>
      </div>

      <div class="field">
        <input type="text" name="nom" placeholder="Nom" required>
      </div>

      <div class="field">
        <input type="text" name="prenom" placeholder="Prénom" required>
      </div>

      <div class="field">
        <input type="tel" name="telephone" placeholder="Téléphone" inputmode="tel">
      </div>

      <div class="field">
        <input type="password" name="password" placeholder="Mot de passe" required>
      </div>

      <div class="field">
        <input type="password" name="password_confirm" placeholder="Confirmation mot de passe" required>
      </div>

      <!-- Upload stylé -->
      <label class="upload">
        <i class="fa-solid fa-upload"></i>
        <span>Télécharger ma photo de profil</span>
        <input type="file" name="avatar" accept="image/*" hidden>
      </label>

      <!-- Checkboxes -->
      <label class="check">
        <input type="checkbox" name="agree_cgu" required>
        <span>Je confirme être un professionnel certifié et j’accepte les conditions générales d’utilisation.</span>
      </label>

      <label class="check">
        <input type="checkbox" name="agree_truth" required>
        <span>J’atteste de l’exactitude des informations fournies.</span>
      </label>

      <button type="submit" class="btn btn-primary" id="btnSubmit">S’inscrire</button>
      <a class="btn btn-outline" href="index.php?Controller=connexion_patient&action=index">  J’ai déjà un compte </a>

    </form>
  </div>
</div>

<script>
// petit confort : on désactive le submit tant que les 2 cases ne sont pas cochées
(function(){
  const f = document.querySelector('.reg-form');
  const btn = document.getElementById('btnSubmit');
  const cbs = [...f.querySelectorAll('input[type=checkbox]')];
  const pw  = f.querySelector('[name=password]');
  const pw2 = f.querySelector('[name=password_confirm]');
  function toggle(){
    const ok = cbs.every(cb=>cb.checked) && pw.value && pw2.value && pw.value===pw2.value;
    btn.disabled = !ok;
  }
  cbs.forEach(cb=>cb.addEventListener('change',toggle));
  [pw,pw2].forEach(i=>i.addEventListener('input',toggle));
  toggle();
})();
</script>
