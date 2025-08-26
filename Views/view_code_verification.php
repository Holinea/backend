<?php require "view_begin.php"; ?>
<div class="container" style="max-width:480px;margin:auto;margin-top:48px;">
    <h2>Vérification du numéro de téléphone</h2>
    <?php if (isset($error)) : ?>
        <div class="error-message"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>
    <p>Un code de 6 chiffres a été envoyé à votre numéro. Merci de le saisir pour valider votre compte.</p>
    <form method="POST" action="?Controller=verification&action=checkCode">
        <input type="hidden" name="id_praticien" value="<?= htmlspecialchars($id_praticien) ?>">
        <div class="form-group">
            <label for="code">Code de vérification :</label>
            <input type="text" id="code" name="code" maxlength="6" pattern="\d{6}" required>
        </div>
        <button type="submit" class="btn dark">Valider</button>
    </form>
    <form method="POST" action="?Controller=verification&action=resendCode" style="margin-top:12px;">
        <input type="hidden" name="id_praticien" value="<?= htmlspecialchars($id_praticien) ?>">
        <button type="submit" class="btn light">Renvoyer le code</button>
    </form>
</div>
<?php require "view_end.php"; ?>
