# backend
Le backend de la plateforme Holinea
# DOCUMENTATION DE LA BDD
Étapes pour créer une base de données dans pgAdmin 4

1. Lancer pgAdmin 4
Ouvre pgAdmin 4 (il est installé avec PostgreSQL).
Connecte-toi à ton serveur PostgreSQL (mot de passe de l’utilisateur postgres).

2. Se connecter au serveur
Dans le panneau de gauche, clique sur Servers → PostgreSQL (souvent nommé PostgreSQL 16 ou autre selon ta version).
S’il demande un mot de passe → mets celui que tu as défini lors de l’installation.

3. Créer une base de données
Clique droit sur Databases → Create → Database…
Dans la fenêtre qui s’ouvre :
Database name → entre le nom (de preference mettre : holinea)
Owner → par défaut postgres 
Clique sur Save.

4. Vérifier
Dans le menu de gauche, développe Databases.
Tu devrais voir ta nouvelle base de données apparaître (holinea).

5. Créer des tables (via Query Tool)
Clique droit sur ta base (holinea_db) → Query Tool
Dans le github il y a la base de donnees en format sql a copier et coller dans le Query Tool dont le chemin est backend/db.sql.

il y a deja dans le github le fichier credential.php qui se trouve dans le dossier Content, ou vous devez modifier le mot de passe $mdp et y mettre votre mot de passe créé lors de la mise en place de pg Admin, et penser a y mettre le bon nom de la base de donnees.
