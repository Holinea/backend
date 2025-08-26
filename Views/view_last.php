<?php
require "view_begin.php";

?>
<table>
    <tr><th>Name</th><th>Categorie</th><th>Year</th></tr>
    <?php foreach($last as $valtab):?>
        <tr>
            <td>
                <a href = '?Controller=list&action=last&id=<?=$valtab["id"]?>'><?=$valtab["name"]?></a>
            </td>
            <td>
                <?=$valtab["category"]?>
            </td>
            <td>
                <?=$valtab["year"]?>
            </td>
            <td class="sansBordure">
                <a href='?Controller=set&action=remove&id=<?=$valtab["id"]?>'>
                    <img class="icone" src="./Content/img/remove-icon.png">
                </a>
            </td> 
                <td class="sansBordure">
                    <a href='?Controller=set&action=check&id=<?=$valtab["id"]?>'>
                    <img class="icone" src="./Content/img/edit-icon.png"/>
                </a>
            </td>
        
        </tr>
    <?php endforeach?>
</table>
    

<?php
require "view_end.php";
?>