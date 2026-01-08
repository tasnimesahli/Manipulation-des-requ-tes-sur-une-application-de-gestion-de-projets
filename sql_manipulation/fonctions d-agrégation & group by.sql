CREATE DATABASE blogs;
USE blogs;
CREATE TABLE utilisateur (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(120) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    password VARCHAR(300) NOT NULL
);
CREATE TABLE categorie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(55) NOT NULL
);
CREATE TABLE article (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(55) NOT NULL,
    contenu TEXT,
    date_pub DATE,
    statut ENUM('publié','brouillon'),
    id_utilisateur INT,
    id_categorie INT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id),
    FOREIGN KEY (id_categorie) REFERENCES categorie(id)
);
CREATE TABLE commentaire (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contenu TEXT,
    date_commentaire DATE,
    id_utilisateur INT,
    id_article INT,
    FOREIGN KEY (id_utilisateur) REFERENCES utilisateur(id),
    FOREIGN KEY (id_article) REFERENCES article(id)
);
SELECT COUNT(*) AS total_articles FROM Article;
SELECT MAX(date_pub) AS derniere_publication FROM Article;
SELECT id_utilisateur, COUNT(*) AS nb_articles
FROM Article
GROUP BY id_utilisateur;
SELECT id_utilisateur, COUNT(*) AS nb_articles
FROM Article
GROUP BY id_utilisateur
HAVING COUNT(*) >= 3;
SELECT AVG(nb_vues) AS moyenne_vues FROM Article;
