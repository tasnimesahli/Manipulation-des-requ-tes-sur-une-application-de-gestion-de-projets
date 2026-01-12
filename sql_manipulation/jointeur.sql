select a.titre, a.date_pub, u.nom
from article a
inner join utilisateur u on a.id_utilisateur=u.id;

select a.titre, u.nom
from article a
inner join utilisateur u on a.id_utilisateur=u.id
where u.nom='Imane khoury';

select a.titre, u.nom
from article a
left join utilisateur u on a.id_utilisateur=u.id

select a.titre, u.nom, c.contenu
from article a
inner join utilisateur u on a.id_utilisateur=u.id
inner join commentaire c on a.id=c.id_article