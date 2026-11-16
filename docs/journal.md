# Journal de bord – FantasyRealm

admin / Admin123!

## 12/11/2026
- **Fait** : lecture du sujet ECF (FantasyRealm) et de la copie à rendre, mise en place de la feuille de route (phases 0 à 6), création du dépôt GitHub avec les branches `main` et `develop`, création du tableau GitHub Projects, création du journal de bord.
- **Bloqué** : premier `git clone` raté : j'avais collé l'URL d'exemple au lieu de celle de mon dépôt, puis tapé `cd clone` au lieu de `git clone`. Le dépôt était vide, donc il a fallu faire un premier commit (README) avant de pouvoir créer `develop`.
- **Choix et pourquoi** : GitHub Projects plutôt que Trello, pour avoir le suivi au même endroit que le code (projet mis en public pour que le jury puisse l'ouvrir). Deux branches : `main` pour la version stable, `develop` pour le travail en cours, puis une branche par fonctionnalité.

## 14/11/2026
- **Fait** : tableau des rôles (visiteur, utilisateur, employé, administrateur), liste des livrables et 29 règles de gestion dans `docs/specifications.md`.
- **Bloqué** : au début je confondais livrables, fonctionnalités et règles de gestion : j'ai d'abord listé les livrables Studi à la place des règles. Le texte du sujet coupé entre deux pages m'a aussi gêné. Plusieurs modifications n'étaient pas arrivées sur GitHub (fichier pas enregistré ou commit/push oublié).
- **Choix et pourquoi** : méthode retenue : fonctionnalité = ce que l'utilisateur fait ; règle = condition ou contrainte imposée par le système ; contrainte technique = comment le projet est livré. RG21 : un personnage dupliqué devra sans doute être revalidé, car son nom est nouveau (à confirmer). RG17 : un article désactivé n'est plus proposé (reste à décider pour les personnages qui le portent déjà).

## 16/11/2026
- **Fait** : correction du MCD de l'annexe 1, table par table, en justifiant chaque correction par une règle de gestion. Écriture à la main du fichier `fantasyrealm.sql` (création de la base et des 6 tables : `role`, `article`, `utilisateur`, `personnage`, `commentaire`, `personnage_article`). Test du fichier dans un conteneur Docker MySQL 8, puis vérification des tables dans phpMyAdmin (deuxième conteneur relié au premier).
- **Bloqué** : erreurs de syntaxe SQL au début (le mot `TYPE` recopié tel quel, des virgules en trop après la dernière colonne, des `;` oubliés ou remplacés par un point, `PRIMARY` sans `KEY`). Une `FOREIGN KEY` écrite sans avoir déclaré la colonne avant : j'ai appris qu'une clé étrangère ne crée pas la colonne, elle ajoute seulement une règle dessus. Côté Docker : Docker Desktop pas lancé, puis le port 3306 déjà pris par un autre MySQL, donc conteneur lancé sur le port 3307.
- **Choix et pourquoi** :
  - Corrections du MCD : `pseudo` et `mail` en UNIQUE (RG01) ; `password` en VARCHAR(255), car un hash bcrypt fait 60 caractères et 255 laisse de la marge ; `mail` en VARCHAR(255) ; `nom` du personnage en UNIQUE (RG12) ; ajout de `date_creation` sur le personnage pour le filtre de la page globale ; `commentaire` en TEXT ; `note` en TINYINT avec un CHECK entre 1 et 5 ; ajout du lien entre commentaire et utilisateur (RG23, le pseudo est retrouvé par jointure, pas recopié) ; images stockées dans un dossier (chemin en VARCHAR(255) au lieu d'un BLOB) pour garder la base légère ; la relation plusieurs-à-plusieurs « dispose » devient la table de jonction `personnage_article`, avec une clé primaire composée.
  - Un BOOL suffit pour `autorise` (personnage) et `valide` (avis) : un personnage rejeté est supprimé (RG15), et j'ai décidé qu'un avis refusé est supprimé aussi. Il ne reste donc que deux états : en attente ou validé. Le motif de rejet n'est pas stocké, il est envoyé par mail (RG16).
  - Un article ajouté est inactif par défaut (`actif DEFAULT FALSE`), pour que l'employé le vérifie avant de le proposer. `nom` de l'article en UNIQUE, pour éviter deux articles identiques dans la liste.
  - `ON DELETE CASCADE` sur les clés étrangères vers `personnage` et vers `utilisateur` : quand un perso ou un compte est supprimé, ses avis, ses persos et ses équipements partent avec lui (RG15, suppression de compte par un employé, RGPD). Pas de CASCADE sur `id_role` : on ne doit pas pouvoir supprimer un rôle encore utilisé.
  - Les logs de modification des personnages (RG29) iront dans MongoDB, pas dans la base relationnelle.
  - Outil pour redessiner le MCD : Looping (gratuit, standard Merise, génère le MLD pour vérifier). Le sujet n'impose pas d'outil.
  - Docker pour tester la base : rapide, et réutilisable pour l'ECF (passage à docker-compose prévu en Phase 2).
