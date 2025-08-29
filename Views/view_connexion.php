<?php require "view_begin.php"; ?>
<link rel="stylesheet" href="./Content/css/holinea_auth.css"/>

<div class="auth-hero" style="--hero:url('Content/img/login-hero.jpg')">
  <div class="auth-card">
    <a href="index.php">
      <img src="Content/img/holinea_2.png" alt="Holinea" style="height:48px;margin-bottom:14px">
    </a>
    <h1 class="auth-title">Connexion</h1>

    <?php if (!empty($error)): ?>
      <div class="auth-alert"><?= htmlspecialchars($error, ENT_QUOTES, 'UTF-8') ?></div>
    <?php endif; ?>

    <form class="auth-form" method="post" action="?Controller=connexion&action=login" autocomplete="on">
      <input type="email" name="mail" required placeholder="Email">
      <input type="password" name="mot_de_passe" required placeholder="Mot de passe">

      <!-- ✅ lien au-dessus du bouton -->
      <div class="auth-help"><a href="?Controller=connexion&action=forgot">Mot de passe oublié</a></div>

      <button type="submit" class="btn primary">Se connecter</button>

      <!-- ✅ ligne label + bouton à droite -->
      <div class="auth-cta">
        <span>Pas encore de compte ?</span>
        <span class="spacer"></span>
        <a class="btn navy" href="?Controller=therapeute&action=signup">S’inscrire</a>
      </div>
    </form>
  </div>
</div>

<?php require "view_end.php"; ?>