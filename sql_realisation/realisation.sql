/*l’adresse email d’un lecteur*/
alter table lecteur add constraint uq_email unique(email);
/*le numéro CIN d’un membre du personnel*/
alter table personnel add cin varchar(55) unique;
/*la combinaison : titre + auteur + année de publication dun ouvrage*/
alter table ouvrage add constraint  uq_ouvrage_titre_date unique(titre, date_publication);
alter table auteur_ouvrage add constraint uq_id unique(id_ouvrage, id_auteur);
/*l’année de publication d’un ouvrage doit être comprise entre 1900 et l’année courante*/
alter table ouvrage add constraint check_publication check(date_publication between '1900-01-01' and '2026-12-31') ;
/*le numéro de téléphone doit contenir au moins 10 caractères*/
alter table lecteur add constraint num_tel check(length(tel)>=10);
/*la date d’emprunt ne peut pas être dans le future*/
alter table emprunt add constraint date_emprunt check(date_emprunt <= '2026-12-31');
/*la durée prévue d’emprunt ne doit pas dépasser 30 jours*/
alter table emprunt add constraint date_prevue check(datediff(date_retour_prevue, date_emprunt) <= 30);
/*le nom d'un rayon doit appartenir à une liste prédéfinie*/
alter table rayon add constraint check_nom check(nom in('Informatique','Littérature','Science','Histoire'));
/*empêcher qu’un lecteur ait plus de 3 emprunts en cours*/
delimiter $$
create trigger max_3_emprunt before insert on emprunt for each row begin declare nb_emprunt int; select count(id_emprunt) into nb_emprunt from emprunt where id_lecteur=new.id_lecteur and date_retour_reel is null; if nb_emprunt >=3 then signal sqlstate'45000' set message_text='deja emprunte 3 ouvrage'; end if; end $$
/*interdire l’emprunt d’un ouvrage déjà emprunté et non retourné*/
create trigger deja_emprunte before insert on emprunt for each row begin if(select 1 from emprunt where id_ouvrage=new.id_ouvrage and date_retour_reel is null) then signal sqlstate'45000' set message_text='a deja emprunte a quelquun';end if; end $$
/*vérifier lors de la mise à jour que la date de retour effective est supérieure ou égale à la date d’emprunt*/
create trigger date_correct before update on emprunt for each row begin if new.date_retour_reel < new.date_emprunt then signal sqlstate'45000' set message_text='il ya un prblm dans la date de retour reel'; end if;end $$
/*interdire la suppression d’un ouvrage qui est actuellement emprunté*/
create trigger interdit_suppression before delete on ouvrage for each row begin if(select 1 from emprunt where id_ouvrage=old.id_ouvrage and date_retour_reel is null) then signal sqlstate'45000' set message_text='impossible de supprime cette ouvrage car il est emprunte'; end if; end $$
/*bloquer la suppression d’un ouvrage lié à un historique d’emprunts (ou prévoir une règle d’archivage selon choix de conception)*/
create trigger bloquer_suppression before delete on ouvrage for each row begin if(select 1 from emprunt where id_ouvrage=old.id_ouvrage) then signal sqlstate'45000' set message_text='impposible car ouvrage a deja dans histoire'; end if; end $$
delimiter ;
/*Top 5 des ouvrages les plus empruntés*/
select ouvrage.titre , count(emprunt.id_emprunt) as nb_total from ouvrage join emprunt on ouvrage.id_ouvrage = emprunt.id_emprunt group by ouvrage.id_ouvrage order by nb_total desc limit 5;
/*Liste des lecteurs « fidèles » (ayant effectué plus de 3 emprunts)*/ 
select lecteur.nom , lecteur.prenom ,count(emprunt.id_emprunt) as total_emprunt from lecteur join emprunt on lecteur.id_lecteur = emprunt.id_lecteur group by lecteur.id_lecteur having total_emprunt > 3;
/*Rayons populaires classés par nombre d’emprunts*/
select rayon.nom, count(emprunt.id_emprunt ) as rayon_ppl from rayon join ouvrage on rayon.id_rayon = ouvrage.id_rayon join emprunt on ouvrage.id_ouvrage = emprunt.id_ouvrage group by rayon.id_rayon order by rayon_ppl desc;
/*Durée moyenne d’emprunt des ouvrages retournés*/
select avg(datediff(date_retour_reel , date_emprunt)) as avg_emprunt from emprunt where date_retour_reel is not null;
/*Taux de retard global : nombre d’emprunts en retard / nombre total d’emprunts*/
select  count(case when date_retour_reel>date_retour_prevue then 1 end) *100 /count(emprunt.id_emprunt)  as totale_emprunt from emprunt;
/*Nombre d’ouvrages empruntés par mois*/
select month(date_emprunt) as mois , count(id_emprunt) as total from emprunt group by mois order by mois asc;
/*Auteur dont les ouvrages sont les plus demandés*/
select  auteur.nom , count(emprunt.id_emprunt) as total_emprunt from auteur join auteur_ouvrage on auteur.id_auteur = auteur_ouvrage.id_auteur join emprunt on auteur_ouvrage.id_ouvrage=emprunt.id_ouvrage group by auteur.id_auteur order by total_emprunt limit 1; 
