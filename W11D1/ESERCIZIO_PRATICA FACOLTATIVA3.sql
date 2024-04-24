-- Esercizio 1 Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce. 

select g.Name, count(t.Name) as Num_Tracce
from track t
join genre g
on  g.GenreId=t.GenreId 
group by g.Name
;

-- Esercizio 2 Trovate le tre canzoni più costose. 

select t.name, t.UnitPrice
from track t
order by t.UnitPrice desc
limit 3
;

-- Esercizio 3 Elencate gli artisti che hanno canzoni più lunghe di 6 minuti. 

WITH TAB1 AS (
select f.Name as Artista, t.Name as Nome_Canzone, t.Milliseconds div 60000 as Minuti
from track t
join album g
on  g.AlbumId = t.AlbumId
join artist f
on f.ArtistId=g.ArtistId
where t.Milliseconds div 60000 > 6)

SELECT distinct (TAB1.Artista)
FROM TAB1
;

select distinct (f.Name)
from track t
join album g
on  g.AlbumId = t.AlbumId
join artist f
on f.ArtistId=g.ArtistId
where t.Milliseconds div 60000 > 6 ;


-- Esercizio 4 Individuate la durata media delle tracce per ogni genere. 

select g.Name, avg(t.Milliseconds) div 60000 as Dur_Media
from track t
join genre g
on t.GenreId=g.GenreId
group by g.name
;

-- Esercizio 5 Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome

select TrackId, Name	  
from track
where Name like "%Love%"
;

-- Esercizio 6 Trovate il costo medio per ogni tipologia di media 

select m.Name as Formato_Media, avg(t.UnitPrice) as Media_costo_formato
from track t
join mediatype m
on t.MediaTypeId=m.MediaTypeId
group by m.name
;

-- Esercizio 7 Individuate il genere con piu tracce 

select g.Name as Genere, count(t.Name) as Numero_canzoni
from track t
join genre g
on g.GenreId=t.GenreId
group by g.name
order by count(t.Name) desc
limit 1
;

-- Esercizio 8 Trovate gli artisti che hanno lo stesso numero di album dei Rolling 

Select art.name, count(alb.Title) as Numero_Album
from artist art
join album alb
on art.ArtistId=alb.ArtistId
group by art.Name
having count(alb.Title)  =     (Select count(alb.Title)
								from artist art
								join album alb
								on art.ArtistId=alb.ArtistId
								where art.Name like "%rolling%"
								group by art.name )
;

-- Esercizio 9 Trovate l artista con l album piu costoso  

select art.Name
from artist art 
join album  alb
on art.ArtistId=alb.ArtistId
where AlbumId =	(select alb.Albumid
				from track t
				join album alb
				on t.AlbumId=alb.AlbumId
				group by alb.AlbumId
				order by sum(t.UnitPrice) desc
				limit 1)
;

-- Esercizio 10 Trova il totale delle vendite per ciascun cliente  

select concat(cus.FirstName," ",cus.LastName) as Cliente, sum(Total) as Totale_Vendite
from invoice inv
join customer cus
on cus.CustomerId=inv.CustomerId
group by inv.CustomerId;

-- Esercizio 11 Trova il numero medio di articoli acquistati in ciascuna transazione: 

select count(InvoiceLineId)
from invoiceline
where InvoiceId=5
;

select Table1.InvoiceId, avg(table1.Num_Art) as Media_Art_Trans 
from 		(	select InvoiceId, count(InvoiceId) as Num_Art
				from invoiceline
				group by InvoiceId) as Table1
group by table1.InvoiceId
;

 Select iline.InvoiceId, avg(t.TrackId) as Media_Art  
 from track as t
 join invoiceline as iline
 on t.TrackId = iline.TrackId
 group by iline.InvoiceId
 ;

-- Esercizio 12 Trova il cliente che ha speso di più in una singola transazione: 

 select concat(c.FirstName," ", c.LastName) as Cliente, sum(i.Total) as Totale
 from customer as c
 join invoice as i
 on c.CustomerId=i.CustomerId
 group by c.CustomerId
 order by sum(i.Total) desc
 limit 1

 ;

-- Esercizio 13 crea VIEW calcola il totale fatturato del mese corrente 

create view Fattutato as (
 select sum(Quantity*UnitPrice) as Fatturato
 from invoiceline)
 ;
 

-- Esercizio 14 crea VIEW Prodotti più venduti dell'ultimo mese: 

select * 
from invoice
;

select TrackId, sum(Quantity)
from invoiceline
group by InvoiceLineId
;

select i.TrackId, t.Name, sum(Quantity) as Tot, concat(year (ii.InvoiceDate), "-", month(ii.InvoiceDate)) as Riferimento
from invoiceline i
join invoice ii
on ii.InvoiceId=i.InvoiceId
join track t
on t.TrackId=i.TrackId
where ii.InvoiceDate like "2013-12%"
group by i.TrackId, Riferimento
;
 
-- Esercizio 15 crea VIEW Paesi con fatturato maggiore: 

-- Calcolo il valore totale
select sum(Total) as TOT
from invoice
;

-- Calcolo il valore percentuale Medio

select avg (Table1.Perc_Tot)
from (	select BillingCountry, sum(Total) as TOT, CAST((sum((Total)/(select sum(Total) from invoice)*100)) AS decimal(10,0)) as Perc_Tot
		from invoice
		group by BillingCountry
		order by TOT desc) as Table1
;

-- Determino gli Stati con valore percentuale sul totale maggiore del valore percentuale medio:
select BillingCountry, sum(Total) as TOT, CAST((sum((Total)/(select sum(Total) from invoice)*100)) AS decimal(10,0)) as Perc_Tot
from invoice
group by BillingCountry
having Perc_Tot > 	(	select avg (Table1.Perc_Tot)
						from (	select BillingCountry, sum(Total) as TOT, CAST((sum((Total)/(select sum(Total) from invoice)*100)) AS decimal(10,0)) as Perc_Tot
								from invoice
								group by BillingCountry
								order by TOT desc) as Table1) 
order by TOT desc
;
-- Creo la VIEW:

Create View Stati_Magg_Vendite as (
select BillingCountry, sum(Total) as TOT, CAST((sum((Total)/(select sum(Total) from invoice)*100)) AS decimal(10,0)) as Perc_Tot
from invoice
group by BillingCountry
having Perc_Tot > 	(	select avg (Table1.Perc_Tot)
						from (	select BillingCountry, sum(Total) as TOT, CAST((sum((Total)/(select sum(Total) from invoice)*100)) AS decimal(10,0)) as Perc_Tot
								from invoice
								group by BillingCountry
								order by TOT desc) as Table1) 
order by TOT desc)
;



