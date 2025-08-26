<?php
    require "view_begin.php";
?>


<section class="hero">
  <div class="container hero-content">
    <div>
      <h1>La santé personnalisée, accessible à tous</h1>
      <p>La première plateforme qui combine intelligence artificielle et médecine douce pour un accompagnement holistique, personnalisé et sécurisé.</p>
      <?php require "view_recherche_praticiens.php"; ?>
      <a href="#" class="btn btn-large">Découvrir la plateforme <br></a>
    </div>
    <img src="https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?fit=crop&w=500&q=80" alt="Bien-être" class="hero-img">
  </div>
</section>
<section class="advantages">
  <div class="container">
    <h2>Pour qui ?</h2>
    <div class="cards">
      <div class="card">
        <h3>Patients</h3>
        <p>Un parcours de santé global, des recommandations personnalisées, accès à des praticiens de confiance, suivi et communauté.</p>
      </div>
      <div class="card">
        <h3>Praticiens</h3>
        <p>Développez votre activité, touchez plus de clients, outils digitaux, visibilité et suivi simplifié de vos clients.</p>
      </div>
      
    </div>
  </div>
</section>


<?php
    require "view_end.php";
?>

