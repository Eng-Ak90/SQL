-- Importate il database presente nel file .sql usando il DBMS scelto. 

-- Esercizio 1 Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”. 
SELECT t.TrackId, t.Name, g.Name
FROM track t
join genre g
on t.GenreId = g.GenreId
-- where g.Name="Pop" or g.Name="Rock"
where g.Name IN ("Pop","Rock")
;

-- Esercizio 2 Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”. 

select a.Name, Alb.Title 
from artist A
join album Alb
on A.ArtistId = Alb.ArtistId
-- where Name like 'A%' and Title like 'A%'
-- where Name like 'A%' or Title like 'A%'
;

-- Esercizio 3 Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti. 

SELECT t.Name, t.Milliseconds div 60000 as Minuti
FROM track t
join genre g
on t.GenreId = g.GenreId
-- where g.Name="Pop" or g.Name="Rock"
where g.Name = 'Jazz' and t.Milliseconds div 60000 > 3
;

-- Esercizio 4 Recuperate tutte le tracce più lunghe della durata media.
select avg(Milliseconds) div 1000 as Media_Secondi
from track
;
SELECT t.Name, t.Milliseconds div 1000 as Secondi, (select avg(Milliseconds) div 1000 as Media_Secondi from track ) as Media_Secondi
FROM track t
join genre g
on t.GenreId = g.GenreId
where t.Milliseconds > (SELECT AVG(t.Milliseconds)
                    FROM track t)
;

-- Esercizio 5 Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti

SELECT g.name, avg(t.Milliseconds div 60000) as Media_minuti
FROM track t
join genre g
on t.GenreId = g.GenreId
group by (g.name)
having avg(t.Milliseconds div 60000) > 4
;

-- Esercizio 6 Individuate gli artisti che hanno rilasciato più di un album. 

select a.Name, count(alb.Title) as Nr_Album
from artist a
join album alb
on a.ArtistId=alb.ArtistId
group by a.Name
having count(alb.Title)>1
;
-- Esercizio 7 Trovate la traccia più lunga in ogni album. Massimo valore per Album

SELECT alb.Title,
max(t.Milliseconds) Max_Traccia
FROM track t
join album alb
on t.AlbumId= alb.AlbumId
group by alb.Title;

select concat(tab1.Max_Traccia,' - ',tab1.Title) as RifId, tab1.Title, tab1.Max_Traccia
		from (	SELECT
				alb.Title,
				max(t.Milliseconds) Max_Traccia
				FROM track t
				join album alb
				on t.AlbumId= alb.AlbumId
				group by alb.Title) as tab1 ;

(SELECT concat ( t.Milliseconds , ' - ',alb.Title) as RifId, alb.Title, t.Name, t.Milliseconds as Minuti
FROM track t
join album alb
on t.AlbumId= alb.AlbumId);

Select Tabella1.Nome_Canzone, Tabella2.Nome_Album, Tabella2.Max_Traccia div 60000 Minuti
from 
			(SELECT alb.Title as Nome_Album, t.Name as Nome_Canzone, t.Milliseconds as Minuti, concat ( t.Milliseconds, ' - ',alb.Title) as RifId
			FROM track t
			join album alb
			on t.AlbumId= alb.AlbumId) as Tabella1
join 
			(select concat(tab1.Max_Traccia,' - ',tab1.Title) as RifId, tab1.Title as Nome_Album, tab1.Max_Traccia as Max_Traccia
			from (	SELECT
					alb.Title,
					max(t.Milliseconds) as Max_Traccia
					FROM track t
					join album alb
					on t.AlbumId= alb.AlbumId
					group by alb.Title) as tab1) as Tabella2
on Tabella1.RifId = Tabella2.RifId;

-- Esercizio 8 Individuate la durata media delle tracce per ogni album. 

SELECT t.name, alb.Title, t.Milliseconds div 60000 as Durata
			FROM track t
			join album alb
			on t.AlbumId= alb.AlbumId
            order by alb.Title desc;

SELECT alb.Title, avg (t.Milliseconds) div 60000 as Media
			FROM track t
			join album alb
			on t.AlbumId= alb.AlbumId
            group by alb.Title 
			order by alb.Title desc;

-- Esercizio 9 Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute.



SELECT alb.Title, count(t.Name) as Num_Tracce
			FROM track t
			join album alb
			on t.AlbumId= alb.AlbumId
            group by alb.Title
            having count(t.Name)>20;

-- Calcolo del valore "Minha Historia" a verificare

SELECT alb.Title, count(t.Name)
			FROM track t
			join album alb
			on t.AlbumId= alb.AlbumId
            where alb.Title = "Minha Historia";
            
