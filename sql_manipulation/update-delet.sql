UPDATE Utilisateur
SET nom = 'Alice Dupont', email = 'alice.dupont@test.com'
WHERE id = 1;
UPDATE Article
SET titre = 'Article mis à jour'
WHERE id_utilisateur = 1;
DELETE FROM Commentaire
WHERE id = 2;
DELETE FROM Article
WHERE date_pub < '2024-01-01';
SELECT * FROM Utilisateur;
SELECT * FROM Article;
