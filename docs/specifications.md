# Spécifications fonctionnelles – FantasyRealm

## Rôles
| Rôle | Comment on l'obtient | Ce qu'il peut faire |
|---|---|---|
| Visiteur | RIEN |n as pas de compte peut regarger les perso mais ne peut pas commenter ou publier |
| Utilisateur | CREATION COMPTE |possede un compte mm droit que visiteur + peu creer son perso et commenter  | 
| Employé | ADMIN | gere les publication et comptes(validation ,supression,ban) |
| Administrateur |CREATION EN DEHORS DE L APPLI |gere les compte employé + a accès a tout les logs 

## livrable a rendre 
- Bonne pratique git (main,develop,merging etc)
- fichiers création de base de données + intégration de données (L’utilisation de fixture et / ou de migration n’implique pas que vous maitrisez le SQL)
-  présenter l’application et donner des identifiants afin de réaliser
les différents parcours possibles
- charte graphique en format PDF (palettes de couleur + police,3
maquettes bureautiques et 3 maquettes mobiles)
- Explication de votre gestion de projet
- documentation technique de votre application

## règles de gestion 
- RG01 : avant l'envoi d'un message de contact, le pseudo saisi doit exister dans la base.
- RG02 : le menu affiche « Connexion » si la personne n'est pas connectée, et « Déconnexion » si elle l'est.
- RG03 : le formulaire de contact envoie un mail à l'adresse de l'entreprise.
- RG04 : seul un utilisateur connecté peut déposer un avis sur un personnage.
- RG05 : un personnage doit être validé par un employé avant de pouvoir être personnalisé.
- RG06 : un employé qui rejette un personnage doit obligatoirement indiquer un motif.
- RG07 : un personnage rejeté est supprimé définitivement.
- RG08 : quand un employé valide ou rejette un personnage, le propriétaire reçoit un mail.
- RG09 : le compte administrateur ne peut pas être créé depuis l'application.
- RG10 : le mail et le pseudo doivent être uniques : deux comptes ne peuvent pas avoir le même.
- RG11 : après la connexion, l'utilisateur est redirigé automatiquement vers son espace.
- RG12 : un avis n'est visible qu'après validation par un employé.
- RG13 : quand un avis est validé par un employé, le propriétaire du personnage reçoit un mail.
- RG14 : le pseudo de l'auteur d'un avis est enregistré avec l'avis.
- RG15 : la page globale n'affiche que les personnages partagés par leur propriétaire.
- RG16 : un personnage dupliqué garde les mêmes accessoires que l'original.
- RG17 : le nom d'un personnage est unique : la copie doit avoir un nom différent.
- RG18 : si l'utilisateur est connecté, les champs mail et pseudo du formulaire de contact sont remplis automatiquement.
- RG19 : le mot de passe doit respecter les recommandations CNIL : au moins une majuscule, une minuscule, un chiffre et un caractère spécial.
- RG20 : en cas de mot de passe oublié, l'utilisateur fournit son mail et son pseudo ; s'ils correspondent à un compte, il reçoit par mail un nouveau mot de passe sécurisé.
- RG21 : ce mot de passe temporaire doit obligatoirement être changé à la première connexion.
- RG22 : si le personnage est partagé, le bouton « Partager » devient « Arrêt du partage ».
- RG23 : un personnage dupliqué doit être revalidé par un employé, car son nom est nouveau. (?)
- RG24 : un compte suspendu ne peut plus se connecter.
- RG25 : un article désactivé n'est plus proposé lors de la personnalisation. (?)
- RG26 : l'administrateur crée les comptes employés en fournissant un mail et un mot de passe.
- RG27 : l'administrateur peut modifier le mot de passe, suspendre ou supprimer un compte employé.
- RG28 : l'administrateur peut réaliser toutes les opérations d'un employé.
- RG29 : toute modification d'un personnage (nom, apparence, équipements) est enregistrée dans des logs consultables par l'administrateur.


