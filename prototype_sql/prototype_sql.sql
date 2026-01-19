/*Afficher tous les rayons de la bibliothèque.*/
select * from rayon;

/*Afficher le nom et le prénom de tous les auteurs.*/
select nom, prenom from auteur;

/*Afficher le titre et l’année de publication de tous les ouvrages.*/
select titre, date_publication from ouvrage;

/*Afficher le nom, le prénom et l’email de tous les lecteurs.*/
select nom, prenom, email from lecteur;

/*Afficher les ouvrages publiés après l’année 1950.*/
select * from ouvrage where date_publication > '1950-01-01';

/*Afficher les lecteurs dont le nom commence par la lettre M.*/
select *from lecteur where nom like 'M%';

/*Afficher les ouvrages triés par année de publication (du plus récent au plus ancien).*/
select *from ouvrage order by date_publication desc;

/*Afficher les emprunts dont la date de retour effective est nulle.*/
select *from emprunt where date_retour_reel is null;

/*Afficher la liste des ouvrages avec le nom de leur rayon.*/
select ouvrage.titre, rayon.nom from ouvrage inner join rayon on ouvrage.id_rayon=rayon.id_rayon;

/*Afficher les titres des ouvrages ainsi que le nom et le prénom de leurs auteurs.*/
select ouvrage.titre, auteur.nom, auteur.prenom from ouvrage join auteur_ouvrage on ouvrage.id_ouvrage=auteur_ouvrage.id_ouvrage  join auteur on auteur_ouvrage.id_auteur=auteur.id_auteur;

/*Afficher les lecteurs ayant effectué au moins un emprunt.*/
select distinct lecteur.nom, lecteur.prenom from lecteur inner join emprunt on lecteur.id_lecteur=emprunt.id_lecteur;

/*Afficher le nombre d’ouvrages par rayon.*/
select rayon.nom, count(ouvrage.id_ouvrage) as nb_ouvrages from rayon left join ouvrage on ouvrage.id_rayon=rayon.id_rayon group by rayon.nom, rayon.id_rayon;

/*Modifier l’adresse email d’un lecteur à partir de son identifiant.*/
update lecteur  set email='loulou_ik@gmail.com' where id_lecteur=3;

/*Mettre à jour le numéro de téléphone d’un lecteur à partir de son numéro CIN.*/
update lecteur set tel='0677436720' where cin='CD789012';

/*Modifier le rayon d’un ouvrage donné.*/
update ouvrage set id_rayon=2 where id_ouvrage=1;

/*Mettre à jour la date de retour effective d’un emprunt lors du retour d’un ouvrage.*/
update emprunt set date_retour_reel='2025-08-12' where id_emprunt=3;
/*Modifier le chef d’un membre du personnel.*/
update personnel set id_chef=1 where id_personnel=2;

/*Supprimer un emprunt à partir de son identifiant.*/
delete from emprunt where id_emprunt=2;

/*Supprimer un lecteur n’ayant jamais effectué d’emprunt.*/
delete from lecteur where id_lecteur not in (select distinct id_lecteur from emprunt );

/*Supprimer un ouvrage qui n’a jamais été emprunté.*/
delete from auteur_ouvrage where id_ouvrage not in (select id_ouvrage from emprunt);
delete from ouvrage where id_ouvrage not in (select id_ouvrage from emprunt );