<?php require "view_begin.php"; ?>

<div class="login-section">
  <div class="login-box">
    <div class="login-header">
    <div class="logo">
        <a href="index.php">
            <img src="Content/img/holinea_2.png" alt="Logo Holinea" style="height:48px;vertical-align:middle;">
        </a>
        </div>
      <p>Connexion à Holinea</p>
    </div>
    <?php if (!empty($error)) { echo "<div class='login-error'>$error</div>"; } ?>
    <form method="post" action="?Controller=connexion&action=login" autocomplete="on">
      <label>Email</label>
      <div class="input-group">
        <input type="email" name="mail" required placeholder="Adresse email" class="input-login"/>
        <span class="input-icon">@</span>
      </div>
      <label>Mot de passe</label>
      <div class="input-group">
        <input type="password" name="mot_de_passe" required placeholder="Mot de passe" class="input-login"/>
        <span class="input-icon">&#128274;</span>
      </div>
      <button type="submit" class="btn-login">Se connecter</button>
    </form>
    <div class="login-footer">
      <span>Pas encore de compte ?</span>
      <a href="?Controller=therapeute&action=signup">Créer un compte</a>
    </div>
  </div>
</div>

<?php require "view_end.php"; ?>
