# Journal de bord – FantasyRealm

Comptes de test (base locale) :
- admin / Admin123! (administrateur)
- employe / Employe123! (employé)
- user, userban (suspendu), chgmdp (mot de passe à modifier) / User123! (utilisateurs)

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

## 16/11/2026 (suite) – données de test
- **Fait** : ajout de `DROP DATABASE IF EXISTS` en haut de `fantasyrealm.sql` pour pouvoir relancer le fichier autant de fois que nécessaire. Écriture des données de test (`INSERT INTO`) pour les 6 tables : 3 rôles, 5 utilisateurs, 6 articles, 4 personnages, 5 avis et 7 liens personnage/article. Mots de passe hashés en bcrypt avec `password_hash()` lancé dans un conteneur PHP (`docker run --rm php:8 php -r ...`), sans installer PHP. Import testé dans Docker, deux commits poussés sur `develop`. Installation de Looping et création du fichier du MCD dans `DOCS`.
- **Bloqué** : dans PowerShell, le `$` de la commande PHP était pris pour une variable PowerShell (corrigé avec un backtick devant chaque `$`). Des valeurs manquantes dans un INSERT (« column count doesn't match »), des textes sans apostrophes, un `\` dans un chemin d'image interprété comme une commande par MySQL (`Unknown command '\i'`), un hash recopié avec un caractère en moins (59 au lieu de 60 : MySQL l'accepte mais la connexion échouerait). VS Code est passé en mode refrappe (touche Inser) et a écrasé une version plus récente du fichier (réglé avec « Revert File »). Dans Looping, aucun outil ne répondait tant que je n'avais pas créé un nouveau document.
- **Choix et pourquoi** :
  - Les id sont écrits à la main dans chaque INSERT : c'est plus lisible et je sais exactement quel id utiliser dans les clés étrangères.
  - Les données de test servent à tester les règles de gestion, pas à remplir : un compte suspendu (RG08), un compte avec mot de passe à changer (RG06-RG07), un article désactivé (RG17), un perso en attente de validation (RG13), un perso validé mais pas partagé (RG19), deux avis en attente de modération (RG24), des articles portés par plusieurs persos (relation plusieurs-à-plusieurs).
  - Cohérence des données : les dates de création suivent l'ordre des id, un avis est toujours postérieur au perso, personne ne commente son propre perso, les avis portent seulement sur les persos validés et partagés, aucun article désactivé ni perso en attente dans `personnage_article`.
  - Les mots de passe de test respectent la RG02 (CNIL). Un seul mot de passe pour tous les utilisateurs simples, pour simplifier le manuel d'utilisation.
  - Un perso partagé mais non validé ne doit jamais exister (RG13) : pour l'instant c'est le code PHP qui l'empêchera. Pistes notées pour plus tard : un `CHECK (partage = FALSE OR autorise = TRUE)` dans la table, filtrer la page globale sur `partage` ET `autorise`, et remettre ces deux valeurs à FALSE lors d'une duplication.
- **Prochaine étape** : redessiner le MCD dans Looping (5 entités, 5 associations, sans clés étrangères), comparer le MLD généré avec `fantasyrealm.sql`, puis exporter l'image pour la doc technique.

## 17/11/2026
- **Fait** : MCD redessiné dans Looping : 5 entités (ROLE, UTILISATEUR, PERSONNAGE, ARTICLE, COMMENTAIRE) et 5 associations (possede, detient, post, recoit, porte), sans clés étrangères. Génération du script SQL (LDD) par Looping pour vérifier : les clés étrangères et la table de jonction sont les mêmes que dans mon `fantasyrealm.sql` écrit à la main.
- **Bloqué** : comprendre les cardinalités (min,max) et savoir de quel côté se place la clé étrangère au passage au MLD. Régler Looping pour qu'il génère des types proches des miens (VARCHAR, TEXT, accents, date sans fuseau, auto-incrément).
- **Choix et pourquoi** :
  - Pas d'identifiant relatif, et les CASCADE et CHECK restent seulement dans le SQL écrit à la main : le MCD décrit les données, pas les règles techniques.
  - Looping appelle la table de jonction `porte` (le nom de l'association) ; je garde `personnage_article` dans le SQL, plus parlant. Je l'expliquerai dans la doc technique : « l'association porte devient la table de jonction personnage_article ».

## 18-19/11/2026 – cas d'utilisation
- **Fait** : ajout d'une section « Cas d'utilisation par rôle » dans `specifications.md` : pour chaque règle de gestion, je regarde s'il y a une action, laquelle (verbe + complément) et qui la fait, avec les numéros de RG entre parenthèses. Dessin du diagramme de cas d'utilisation dans draw.io (4 acteurs, 18 cas, système FantasyRealm) et export de l'image en PNG dans `DOCS`.
- **Bloqué** : au début je voulais classer les RG entre les rôles, alors qu'il faut partir des actions de chaque rôle. Plusieurs erreurs de placement (« Déposer un avis » chez le visiteur alors que RG22 demande d'être connecté, mauvais numéros de RG). Dans draw.io : la page était enregistrée avec Ctrl+S du navigateur (copie de la page web, inutilisable) alors que le vrai fichier est sur Google Drive ; les traits avaient des pointes, des coudes qui se superposaient, et la flèche d'héritage a été difficile à régler (style `endArrow=block;endFill=0`) ; problème de lisibilité quand on dézoome.
- **Choix et pourquoi** :
  - Héritages : l'Utilisateur hérite du Visiteur (il peut tout faire comme lui, en plus du reste) et l'Administrateur hérite de l'Employé (RG26). L'Employé n'hérite pas de l'Utilisateur, car il ne crée pas de personnages : il est relié directement à « Se connecter » et « Se déconnecter ».
  - Toutes les RG ne deviennent pas des cas d'utilisation : RG03, RG15, RG16, RG23 et RG25 sont des contraintes ou des actions automatiques, que je coderai sous forme de vérifications.
  - Mise en page : deux colonnes d'ovales, une couleur par acteur (bleu visiteur, vert utilisateur, orange employé, violet administrateur, gris pour la connexion), traits noirs en 2 pt, sans pointe, pour que ce soit lisible. J'ai utilisé l'IA intégrée de draw.io pour réorganiser le diagramme, puis j'ai vérifié chaque lien et chaque héritage.
  - J'ai gardé quelques traits coudés et le fond rose : le diagramme est lisible et complet. Je demanderai au référent si c'est à reprendre.
- **Prochaine étape** : charte graphique (couleurs, police, 3 maquettes desktop et 3 mobiles).
