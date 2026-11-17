DROP DATABASE IF EXISTS fantasyrealm;

CREATE DATABASE fantasyrealm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE fantasyrealm;

CREATE TABLE role ( 
    id_role  INT PRIMARY KEY AUTO_INCREMENT,
    libelle  VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE article ( 
    id_article INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) UNIQUE NOT NULL,
    actif BOOLEAN NOT NULL DEFAULT FALSE,
    image VARCHAR(255),
    type VARCHAR(50)
);

CREATE TABLE utilisateur ( 
    id_utilisateur INT PRIMARY KEY AUTO_INCREMENT,
    pseudo VARCHAR(50) UNIQUE NOT NULL,
    mail VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    suspendu BOOLEAN NOT NULL DEFAULT FALSE,
    motdepasse_a_modifier BOOLEAN NOT NULL DEFAULT FALSE,
    id_role INT NOT NULL,
    FOREIGN KEY (id_role) REFERENCES role(id_role)
);

CREATE TABLE personnage (
    id_personnage INT PRIMARY KEY AUTO_INCREMENT, 
    nom VARCHAR(50) UNIQUE NOT NULL,
    genre  VARCHAR(50),
    couleur_peau VARCHAR(50),
    couleur_yeux VARCHAR(50),
    couleur_cheveux VARCHAR(50),
    forme_yeux VARCHAR(50),
    forme_nez VARCHAR(50),
    forme_bouche VARCHAR(50),
    partage BOOLEAN NOT NULL DEFAULT FALSE,
    autorise BOOLEAN NOT NULL DEFAULT FALSE,
    image VARCHAR(255),
    date_creation DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_utilisateur INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)ON DELETE CASCADE
);

CREATE TABLE commentaire ( 
    id_commentaire INT PRIMARY KEY AUTO_INCREMENT, 
    note TINYINT NOT NULL CHECK(note BETWEEN 1 AND 5),
    commentaire TEXT NOT NULL,
    date_commentaire DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    valide BOOLEAN NOT NULL DEFAULT FALSE,
     id_utilisateur INT NOT NULL,
     id_personnage INT NOT NULL,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id_utilisateur)ON DELETE CASCADE,
    FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage) ON DELETE CASCADE
);

CREATE TABLE personnage_article (
    id_personnage INT NOT NULL,
    id_article INT NOT NULL,
    PRIMARY KEY(id_personnage,id_article),
    FOREIGN KEY (id_personnage) REFERENCES personnage(id_personnage) ON DELETE CASCADE,
    FOREIGN KEY (id_article) REFERENCES article(id_article )
);

INSERT INTO role (id_role, libelle) VALUES
(1, 'administrateur'),
(2, 'employe'),
(3, 'utilisateur');

INSERT INTO utilisateur (id_utilisateur, pseudo, mail, password, suspendu, motdepasse_a_modifier, id_role) VALUES
(1, 'admin', 'admin@fantasyrealm.fr', '$2y$12$9vdtMpviEfMqzA6EeSfld.QCOFPDKbCZTUJRosu1.Dw3.HWcYjaVG', FALSE, FALSE, 1);

INSERT INTO utilisateur (id_utilisateur, pseudo, mail, password, suspendu, motdepasse_a_modifier, id_role) VALUES
(2,'employe','employe@fantasyrealm.fr','$2y$12$3nrO0FRQ/4dq4IcqWElJOuP4Ls5/u3TagM1suYf.WvhsDt5d5NhCa',FALSE,FALSE,2);

INSERT INTO utilisateur (id_utilisateur, pseudo, mail, password, suspendu, motdepasse_a_modifier, id_role) VALUES
(3,'user','user@fantasyrealm.fr','$2y$12$Rr4oQZJzlQYKojXrY.12o.BpgzrZWMs2wEps85apkTud8zVIggdj6',FALSE,FALSE,3);

INSERT INTO utilisateur (id_utilisateur, pseudo, mail, password, suspendu, motdepasse_a_modifier, id_role) VALUES
(4,'userban','userban@fantasy.fr','$2y$12$Rr4oQZJzlQYKojXrY.12o.BpgzrZWMs2wEps85apkTud8zVIggdj6',TRUE,FALSE,3);

INSERT INTO utilisateur (id_utilisateur, pseudo, mail, password, suspendu, motdepasse_a_modifier, id_role) VALUES
(5,'chgmdp','chgmdp@fantasy.fr','$2y$12$Rr4oQZJzlQYKojXrY.12o.BpgzrZWMs2wEps85apkTud8zVIggdj6',FALSE,TRUE,3);

INSERT INTO article (id_article, nom, actif, image, type) VALUES
(1, 'Corne du dragon', TRUE, 'images/articles/corne-dragon.png', 'feu'),
(2, 'Épée de givre', TRUE, 'images/articles/epee-givre.png', 'glace'),
(3, 'Cape des ombres', TRUE, 'images/articles/cape-ombres.png', 'ombre'),
(4, 'Amulette de foudre', TRUE, 'images/articles/amulette-foudre.png', 'foudre'),
(5, 'Bouclier sylvestre', TRUE, 'images/articles/bouclier-sylvestre.png', 'nature'),
(6, 'Couronne maudite', FALSE, 'images/articles/couronne-maudite.png', 'ombre');

INSERT INTO personnage (id_personnage,nom,genre,couleur_peau,couleur_yeux,couleur_cheveux,forme_yeux,forme_bouche,forme_nez,partage,autorise,image,date_creation,id_utilisateur) VALUES
(1,'bobby','homme','rouge','orange','vert','rond','fine','zlatan',TRUE,TRUE,'images/personnages/bobby.png','2026-09-03 14:12:00',3),
(2,'sarah','femme','bleu','vert','blond','rond','large','pointue',TRUE,TRUE,'images/personnages/sarah.png','2026-09-21 09:45:30',3),
(3,'mike','homme','jaune','marron','noir','rond','large','long',FALSE,TRUE,'images/personnages/mike.png','2026-10-08 18:20:15',4),
(4,'lisa','femme','violet','bleu','roux','rond','fine','mini',FALSE,FALSE,'images/personnages/lisa.png','2026-10-27 11:05:00',5);

INSERT INTO commentaire (id_commentaire,note,commentaire,date_commentaire,valide,id_utilisateur,id_personnage) VALUES
(1,5,'Excellent personnage !','2026-09-04 10:30:00',TRUE,5,1),
(2,4,'Très bon design.','2026-09-22 14:15:00',TRUE,5,2),
(3,2,'Pas très original.','2026-10-09 16:45:00',FALSE,5,1),
(4,3,'Moyen.','2026-10-28 12:00:00',TRUE,4,2),
(5,1,'Je n''aime pas du tout les couleurs.','2026-11-12 09:10:00',FALSE,4,1);

INSERT INTO personnage_article (id_personnage,id_article) VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,4),
(3,3),
(3,5);
