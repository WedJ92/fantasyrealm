# FantasyRealm – ECF Développeur Web et Web Mobile

Application web de création, de personnalisation et de partage de personnages pour le jeu FantasyRealm Online (studio PixelVerse).

## État d'avancement
- [x] Cadrage : rôles, règles de gestion, contraintes
- [x] Conception : MCD, base de données SQL, données de test, cas d'utilisation
- [ ] Charte graphique et maquettes
- [ ] Développement
- [ ] Déploiement

## Documentation
- `DOCS/specifications.md` : rôles, 29 règles de gestion, cas d'utilisation par rôle
- `DOCS/cas-utilisation.png` : diagramme de cas d'utilisation
- `DOCS/fantasyrealm.loo` : MCD (Looping)
- `DOCS/journal.md` : journal de bord
- `fantasyrealm.sql` : création et remplissage de la base

## Lancer la base de données en local (Docker)
```
docker start fantasyrealm-mysql fantasyrealm-pma
Get-Content fantasyrealm.sql | docker exec -i fantasyrealm-mysql mysql -uroot -proot
```
phpMyAdmin : http://localhost:8081

## Branches
- `main` : version stable
- `develop` : travail en cours (une branche par fonctionnalité)

## Gestion de projet
Tableau GitHub Projects : https://github.com/users/WedJ92/projects/2

