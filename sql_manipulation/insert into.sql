INSERT INTO Utilisateur (nom, email, mot_de_passe)
VALUES ('Alice', 'alice@test.com', '1234');
INSERT INTO Article (titre, contenu, date_pub, id_utilisateur)
VALUES ('Bienvenue sur le blog', 'Ceci est le premier article.', '2025-07-18', 1);
INSERT INTO Utilisateur (nom, email, mot_de_passe)
VALUES 
  ('Bob', 'bob@test.com', 'passbob'),
  ('Charlie', 'charlie@test.com', 'passcharlie');
SELECT * FROM Utilisateur;
SELECT * FROM Article;
