<?php require 'view_begin.php';
if (!function_exists('h')) { function h($s){return htmlspecialchars($s??'',ENT_QUOTES,'UTF-8');} }
$err = $errors['global'] ?? '';
?>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="./Content/css/holinea_login_patient.css"/>

<div class="login-hero">
  <div class="login-card" role="region" aria-label="Connexion patient">
    <h1>Connexion</h1>

    <?php if ($err): ?>
      <div class="alert"><?= h($err) ?></div>
    <?php endif; ?>

    <form method="post" action="index.php?Controller=connexion_patient&action=login_submit" class="login-form" novalidate>
      <input type="email" name="email" placeholder="Email" required>
      <input type="password" name="password" placeholder="Mot de passe" required>

      <div class="row-forgot">
        <a class="link" href="#">Mot de passe oublié</a>
      </div>

      <button class="btn btn-primary" type="submit">Se connecter</button>

      <div class="row-signup">
        <span>Pas encore de compte ?</span>
        <a class="btn btn-secondary" href="index.php?Controller=inscription&action=register">S’inscrire</a>
      </div>
    </form>
  </div>
</div>
