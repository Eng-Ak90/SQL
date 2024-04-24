-- W11D1 Pratica Facoltativa
-- Cominciate facendo un’analisi esplorativa del database, 
			-- ad esempio: 1) Fate un elenco di tutte le tabelle -> utilizzare il comando Show Tables 
-- 2) Visualizzate le prime 10 righe della tabella Album. 
-- 3) Trovate il numero totale di canzoni della tabella Tracks. 
-- 4) Trovate i diversi generi presenti nella tabella Genre. … … 
-- Effettuate tutte le query esplorative che vi servono per prendere confidenza con i dati
-- Esercizio 1
-- 1) Elenco tabelle:
SHOW TABLES;
-- 2) Prime 10 righe della tabella Album
select *
from album
limit 10;
-- 3) Trovate il numero totale di canzoni della tabella Tracks.
SELECT count(trackId)
FROM track
;
select *
from track; 
select 
SUM(count(TrackId)) over () as Totale
from track
group by TrackId
limit 1;

SELECT *
FROM (SELECT Name, COUNT(TrackId) as Conteggio_Canzoni
FROM track
GROUP BY Name
UNION ALL
SELECT 'SUM' Name, COUNT(TrackId) 
FROM track
) as table2;


-- 4)Trovate i diversi generi presenti nella tabella Genre. … … 

SELECT count(*)
FROM genre
;

-- Esercizio 2 Recuperate il nome di tutte le tracce e del genere associato.
select 
track.Name as Nome_Canzone, 
genre.Name as Genere
from track
join genre
on track.GenreId = genre.GenreId;
-- where genre.Name <> "Rock";

-- Esercizio 3 Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?

-- Elenco artisti con almeno 1 album
select distinct Tab1.Name
from 	(	select f.Name , g.Title
			from artist f
			join album g
			on f.ArtistId = g.ArtistId) as Tab1
;
-- Conteggio artisti senza Album
select count(*)
from (
select f.Name as Artista, g.Title as Album
from artist f
left join album g
on f.ArtistId = g.ArtistId
where g.Title is Null) as table1
;
-- Elenco Artisti senza album
select * 
from 	(select f.Name as Artista, g.Title as Album
				from artist f
				left join album g
				on f.ArtistId = g.ArtistId
		) as table1
where table1.album is Null
;

-- Esercizio 4 
-- Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. 
-- Esiste un modo per recuperare il nome della tipologia di media?

		select tab1.Canzone, tab1.Genere, m.Name
				from 	(	select t.Name as Canzone, g.Name as Genere, t.MediaTypeId as Media
							from track t
							join genre g 
							on t.GenreId=g.GenreId
							) as tab1
		join mediatype m
        on Tab1.Media = m.MediaTypeId
        ;
-- Esercizio 5 Elencate i nomi di tutti gli artisti e dei loro album.
select f.Name , g.Title
from artist f
join album g
	on f.ArtistId = g.ArtistId;