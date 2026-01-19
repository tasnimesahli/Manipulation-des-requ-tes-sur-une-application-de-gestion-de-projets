CREATE DATABASE bibliotheques;
USE bibliotheques;

CREATE TABLE rayon(
    id_rayon INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(120) NOT NULL 
);

CREATE TABLE ouvrage(
    id_ouvrage INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(300) NOT NULL,
    date_publication DATE,
    id_rayon INT,
    FOREIGN KEY (id_rayon) REFERENCES rayon(id_rayon)
);

CREATE TABLE auteur(
    id_auteur INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    prenom VARCHAR(200) NOT NULL
);

CREATE TABLE lecteur(
    id_lecteur INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    prenom VARCHAR(200) NOT NULL,
    email VARCHAR(500) NOT NULL UNIQUE,
    cin VARCHAR(100) NOT NULL UNIQUE,
    tel VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE auteur_ouvrage(
    id_ouvrage INT,
    id_auteur INT,
    PRIMARY KEY (id_ouvrage, id_auteur),
    FOREIGN KEY (id_ouvrage) REFERENCES ouvrage(id_ouvrage),
    FOREIGN KEY (id_auteur) REFERENCES auteur(id_auteur)
);

CREATE TABLE emprunt(
    id_emprunt INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_emprunt DATE NOT NULL,
    date_retour_prevue DATE NOT NULL,
    date_retour_reel DATE NULL,
    id_ouvrage INT,
    id_lecteur INT,
    FOREIGN KEY(id_lecteur) REFERENCES lecteur(id_lecteur),
    FOREIGN KEY(id_ouvrage) REFERENCES ouvrage(id_ouvrage)
);

CREATE TABLE personnel(
    id_personnel INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(300) NOT NULL,
    prenom VARCHAR(300) NOT NULL,
    email VARCHAR(500) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(600) NOT NULL,
    id_chef INT,
    FOREIGN KEY(id_chef) REFERENCES personnel(id_personnel)
);

INSERT INTO rayon (nom) VALUES
('Informatique'),
('Littérature'),
('Science'),
('Histoire');

INSERT INTO ouvrage (titre, date_publication, id_rayon) VALUES
('Python pour débutants', '2021-03-10', 1),
('Les Misérables', '1862-01-01', 2),
('Physique moderne', '2015-07-15', 3),
('Histoire du Maroc', '2018-05-20', 4);

INSERT INTO auteur (nom, prenom) VALUES
('Dupont', 'Jean'),
('Hugo', 'Victor'),
('Einstein', 'Albert'),
('El Mansouri', 'Ahmed');

INSERT INTO lecteur (nom, prenom, email, cin, tel) VALUES
('Ali', 'Karim', 'ali.karim@mail.com', 'AB123456', '0612345678'),
('Sara', 'Mouad', 'sara.mouad@mail.com', 'CD789012', '0698765432'),
('Maryam', 'El Fassi', 'maryam.elfassi@mail.com', 'EF345678', '0611122233');

INSERT INTO auteur_ouvrage VALUES
(1,1),
(2,2),
(3,3),
(4,4);

INSERT INTO emprunt (date_emprunt, date_retour_prevue, date_retour_reel, id_ouvrage, id_lecteur) VALUES
('2025-12-01', '2025-12-15','2025-12-17', 1, 1),
('2025-12-05', '2025-12-20', '2025-12-30', 2, 2),
('2025-12-10', '2025-12-25', NULL, 3, 3);

INSERT INTO personnel (nom, prenom, email, mot_de_passe, id_chef) VALUES
('Benzouina', 'Rachid', 'rachid.benzouina@mail.com', 'pass123', NULL),
('Haddad', 'Laila', 'laila.haddad@mail.com', 'pass456', 1);
 