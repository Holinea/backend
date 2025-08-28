<?php require "view_begin.php"; ?>
<div class="signup-bg"></div>
<div class="signup-container">
    <h2 class="signup-title">🧑‍⚕️ Inscription <span style="color:var(--holinea-jaune);">thérapeute</span></h2>
    <?php if (isset($error)) : ?>
        <div class="error-message"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form method="POST" action="?Controller=therapeute&action=checkSignup" enctype="multipart/form-data">
        <div class="signup-row">
            <input type="email" id="email" name="email" placeholder="Adresse e-mail *" required>
            <input type="password" id="password" name="password" placeholder="Mot de passe *" required>
        </div>
        <div class="signup-row">
            <input type="text" id="nom" name="nom" placeholder="Nom *" required>
            <input type="text" id="prenom" name="prenom" placeholder="Prénom *" required>
        </div>
        <div class="signup-row">
            <input type="tel" id="telephone" name="telephone" placeholder="Téléphone *" required>
            <select id="mode_consultation" name="mode_consultation">
                <option value="">Mode de consultation</option>
                <option value="cabinet">Cabinet</option>
                <option value="distance">Distance</option>
                <option value="Mixte">Mixte</option>
            </select>
        </div>
        <div class="signup-row">
            <input type="text" id="adresse_cabinet" name="adresse_cabinet" placeholder="Adresse du cabinet">
        </div>
        <div class="signup-row">
            <input type="text" id="code_postal" name="code_postal" placeholder="Code postal" required>
            <input type="number" id="tarifs_consultation" name="tarifs_consultation" placeholder="Tarif (€)">
        </div>
        <div class="signup-row">
            <input type="text" id="diplomes" name="diplomes" placeholder="Diplômes ">
            <input type="number" id="annees_experience" name="annees_experience" placeholder="Années d'expérience *" min="0" max="60" required>
        </div>
        <div class="signup-row">
            <input type="number" id="heures_pratique" name="heures_pratique" placeholder="Heures de pratique *" required>
            <input type="text" id="specialites" name="specialites" placeholder="Spécialités *" required>
        </div>
        <div class="signup-row">
            <textarea id="description" name="description" rows="2" placeholder="Description du praticien"></textarea>
            <input type="file" id="photo_profil" name="photo_profil" accept="image/*" style="background:none; padding:0;">
        </div>
        
        <div class="signup-checkboxes">
            <label>
                <input type="checkbox" id="consentement_cgu" name="consentement_cgu" required>
                J'accepte les <a href="#">CGU</a> et la politique de confidentialité *
            </label>
            <label>
                <input type="checkbox" id="consentement_partage_donnees" name="consentement_partage_donnees">
                J'accepte le partage de mes données de santé
            </label>
        </div>
        <div class="signup-buttons">
            <a href="?Controller=connexion&action=login" class="signup-btn signup-btn-light">Déjà un compte ?</a>
            <button type="submit" class="signup-btn signup-btn-main">Créer mon compte</button>
        </div>
        <p class="signup-note">* Champs obligatoires</p>
    </form>
</div>
<?php require "view_end.php"; ?>
