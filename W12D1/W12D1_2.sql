-- Esercizio 1 Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006. 

select c.first_name as Nome, c.last_name as Cognome
from 		(	select c.customer_id as Cod_Cliente, c.first_name as Nome, c.last_name as Cognome, r.rental_date as Data_Noleggio
				from customer c
				join rental r
				on r.customer_id=c.customer_id
				where year(rental_date) = "2006" and month(rental_date)= "01") as Table1
right join customer c
on c.customer_id=Table1.Cod_cliente
;

-- Esercizio 2 Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005 

select Table1.Titolo, count(Table1.Titolo) as Numero_Noleggi
from 	(	select f.title as Titolo, r.rental_date as Data_Noleggio
			from rental r
			join inventory i
			on r.inventory_id=i.inventory_id
			join film f
			on f.film_id=i.film_id
			where r.rental_date > "2005-08-01" and r.rental_date < "2005-12-31") as Table1
group by Table1.Titolo
Having Numero_Noleggi>10
;

-- Esercizio 3 Trovate il numero totale di noleggi effettuati il giorno 1/1/2006. 

select count(Table1.Titolo) as Noleggi
from 	(	select f.title as Titolo, r.rental_date as Data_Noleggio
			from rental r
			join inventory i
			on r.inventory_id=i.inventory_id
			join film f
			on f.film_id=i.film_id
			where r.rental_date = "2006-01-01") as Table1
group by Table1.Titolo 
;

-- Esercizio 4 Calcolate la somma degli incassi generati nei weekend (sabato e domenica). 

select sum(p.amount) as Incasso
from rental r
join payment p
on p.rental_id = r.rental_id
where dayname(r.rental_date) in ("Saturday", "Sunday")
;

-- Esercizio 5 Individuate il cliente che ha speso di più in noleggi.

select c.first_name as Nome, c.last_name as Cognome, sum(p.amount) as Importo
from customer c
join rental r
on r.customer_id=c.customer_id
join payment p
on p.rental_id=r.rental_id
group by c.customer_id
order by Importo desc
limit 1
;

-- Esercizio 6 Elencate i 5 Film con maggior durata media di noleggio
select Table1.Titolo, avg(Table1.Durata_noleggio) as Dur_Media_Nol
from (	select ff.title as Titolo, r.rental_date, r.return_date, datediff(r.return_date, r.rental_date) as Giorni_Noleggio, c.name as Categoria, ff.rental_duration Durata_Noleggio
		from rental r
		join inventory i on i.inventory_id=r.inventory_id
		join film_category f on f.film_id=i.film_id
		join category c on f.category_id=c.category_id
		join film ff
		on ff.film_id=f.film_id) as Table1
group by Table1.Titolo
order by Dur_Media_Nol desc
limit 5
;
-- Esercizio 7 Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente. 

SELECT AVG(DATEDIFF(rental2.rental_date, rental1.rental_date)) AS Tempo_Medio_Noleggio
FROM rental AS rental1
JOIN rental AS rental2 
ON rental1.customer_id = rental2.customer_id AND rental1.rental_date < rental2.rental_date
LEFT JOIN rental AS rental3 
ON rental1.customer_id = rental3.customer_id AND rental1.rental_date < rental3.rental_date AND rental3.rental_date < rental2.rental_date
WHERE rental3.rental_id IS NULL;

SELECT AVG(DATEDIFF(rental2.rental_date, rental1.rental_date)) AS Tempo_Medio_Noleggio
FROM rental AS rental1
JOIN rental AS rental2 
ON rental1.customer_id = rental2.customer_id AND rental1.rental_date < rental2.rental_date
-- devo specificare che rental2 che è successivo a rental1 sia quello diretto successivo
WHERE 
    NOT EXISTS (
        SELECT * 
        FROM rental AS rental3 
        WHERE rental1.customer_id = rental3.customer_id
        AND rental1.rental_date < rental3.rental_date
        AND rental3.rental_date < rental2.rental_date
    );

-- Esercizio 8 Individuate il numero di noleggi per ogni mese del 2005. 

select 
		month(rental_date) as Mese, 
		count(rental_id) as Numero_Noleggi
from rental 
where year(rental_date)=2005
group by Mese
;

-- Esercizio 9 Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno. 
SELECT film.film_id, film.title AS Titolo, rental.rental_date AS Data_Noleggio, COUNT(*) AS Numero_Noleggi
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id, film.title, rental.rental_date
HAVING COUNT(*) >= 2;

-- Esercizio 10 Calcolate il tempo medio di noleggio.

SELECT 
    AVG(DATEDIFF(return_date, rental_date)) AS Tempo_Medio_Noleggio
FROM 
    rental;