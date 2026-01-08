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
SELECT * FROM Article;

SELECT titre, contenu FROM Article;

SELECT titre, date_pub
FROM Article
WHERE date_pub >= '2024-01-01';

SELECT titre, date_pub
FROM Article
ORDER BY date_pub DESC;

SELECT titre
FROM Article
ORDER BY date_pub DESC
LIMIT 5;
