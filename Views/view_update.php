<?php
    require "view_begin.php";
?>
<h2>Modifiaction de NBPrize </h2>

<form action='?Controller=set&action=update&id=<?=$_GET["id"]?>' method="post">

    <label >Name :<input type="text" name = "name" value = '<?=$infos["name"]?>' required> </label>
    <label >Year :<input type="text" name = "year" value = '<?=$infos["year"]?>' required> </label>
    <label >Birthdate :<input type="month" name = "birthdate" value = '<?=$infos["birthdate"]?>' required> </label>
    <label >Country:<input type="text" name = "county" value = '<?=$infos["county"]?>' required> </label>
    <label >Birthplace:<input type="text" name = "birthplace" value = '<?=$infos["birthplace"]?>' required> </label>
    <br>
    <label for="category">Catégorie :</label>
    <select name="category" id="category" required>
        <option value = '<?=$infos["name"]?>' disabled selected>Choisissez une catégorie</option>
        <?php foreach($tabCat as $cat): ?>
            <option value="<?= htmlspecialchars($cat) ?>"><?= htmlspecialchars($cat) ?></option>
        <?php endforeach; ?>
    </select>
    <label for="motivations">Motivations :</label>
    <textarea id="motivations" name="motivations" value = '<?=$infos["motivation"]?>' rows="5" cols="50" required></textarea>


    <p>
    <input type="submit" value="add to database">
    </p>
</form>
<?php
    require "view_end.php";
    ?>
