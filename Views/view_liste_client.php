<?php
$active = 'clients';
?>
<?php require "view_begin_therapeute.php"; ?>

<div class="container">
    <h2>Liste des clients (patients)</h2>
    <table class="table">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Genre</th>
                <th>Téléphone</th>
                <!-- ajoute ici d'autres colonnes importantes -->
            </tr>
        </thead>
        <tbody>
            <?php foreach ($patients as $p): ?>
            <tr>
                <td><?= htmlspecialchars($p['nom']) ?></td>
                <td><?= htmlspecialchars($p['prenom']) ?></td>
                <td><?= htmlspecialchars($p['genre']) ?></td>
                <td><?= htmlspecialchars($p['telephone_']) ?></td>
                <!-- idem pour d’autres champs -->
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?php require "view_end.php"; ?>
