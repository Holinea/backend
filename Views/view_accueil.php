<?php
    require "view_begin_therapeute.php";
    session_start();
?>


<section class="hero">
  <div class="container hero-content">
    <div>
    <h1>YOUPY Bienvenue <?= htmlspecialchars($_SESSION['nom'])?></h1>
</section>
<?=var_dump($_SESSION['id_praticien'])?>
<?=var_dump($_SESSION['role_utilisateur'])?>

<?php
    require "view_end.php";
?>

