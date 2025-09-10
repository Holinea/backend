<?php require 'view_begin.php'; ?>
<link rel="stylesheet" href="./Content/css/holinea_login.css">
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700;800&display=swap" rel="stylesheet">

<div class="login-screen">
  <form class="login-card" method="post" action="index.php?Controller=connexion_patient&action=login">
    <h1 class="login-title">Connexion</h1>

    <input class="login-field" type="email" name="email" placeholder="Email" required>
    <input class="login-field" type="password" name="password" placeholder="Mot de passe" required>

    <div class="login-hint">Mot de passe oublié</div>

    <div class="login-actions">
      <button type="submit" class="btn-primary">Se connecter</button>
      <a class="btn-secondary" href="index.php?Controller=inscription&action=register">S’inscrire</a>
    </div>

    <div class="login-footer">Pas encore de compte</div>
  </form>
</div>
