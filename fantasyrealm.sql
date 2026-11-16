CREATE DATABASE fantasyrealm;

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

    
    
   