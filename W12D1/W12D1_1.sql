-- Esercizio 1 Effettuate un’esplorazione preliminare del database. 
-- Di cosa si tratta? Quante e quali tabelle contiene? 
-- Fate in modo di avere un’idea abbastanza chiara riguardo a con cosa state lavorando. 
-- Risposta: Procedo a visionare le tabelle, colonne e collegamenti tra tabelle
select *
from actor;

select *
from address;

-- Esercizio 2 Scoprite quanti clienti si sono registrati nel 2006. 

select *
from customer
where year(create_date) = "2006";

-- Esercizio 3 Trovate il numero totale di noleggi effettuati il giorno 1/1/2006. 

select count(*)
from rental
where rental_date = 2006-01-01
;

-- Esercizio 4 Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati. 

select *
from rental
where rental_date > "2006-02-07" and rental_date < "2006-02-14"
;

select max(rental_date) as Oggi
from rental
;

select concat(year(max(rental_date)),"-", month(max(rental_date)),"-", (day(max(rental_date))-7)) as Sett_fa
from rental
;

select  f.title as Titolo, c.first_name as Nome, c.last_name as Cognome, r.rental_date as Data_Noleggio
from rental r
join customer c
on c.customer_id=r.customer_id
join inventory i
on i.inventory_id=r.inventory_id
join film f
on f.film_id=i.film_id
where r.rental_date > (	select concat(year(max(rental_date)),"-", month(max(rental_date)),"-", (day(max(rental_date))-7)) as Sett_fa
						from rental)
order by Data_Noleggio asc
;

-- Esercizio 5 Calcolate la durata media del noleggio per ogni categoria di film.

select Table1.Categoria, avg(Table1.Giorni_Noleggio) as Media_Noleggio
from (select ff.title as Titolo, r.rental_date, r.return_date, datediff(r.return_date, r.rental_date) as Giorni_Noleggio, c.name as Categoria, ff.rental_duration Durata_Noleggio
from rental r
join inventory i
on i.inventory_id=r.inventory_id
join film_category f
on f.film_id=i.film_id
join category c
on f.category_id=c.category_id
join film ff
on ff.film_id=f.film_id) as Table1
group by Table1.Categoria
;

-- Esercizio 6 Trovate la durata del noleggio piu' lungo

select max(Table1.Giorni_Noleggio) as Max_Noleggio
from (select ff.title as Titolo, r.rental_date, r.return_date, datediff(r.return_date, r.rental_date) as Giorni_Noleggio, c.name as Categoria, ff.rental_duration Durata_Noleggio
from rental r
join inventory i
on i.inventory_id=r.inventory_id
join film_category f
on f.film_id=i.film_id
join category c
on f.category_id=c.category_id
join film ff
on ff.film_id=f.film_id) as Table1
;

create view Film_Categoria_Noleggio as (select ff.title as Titolo, r.rental_date, r.return_date, datediff(r.return_date, r.rental_date) as Giorni_Noleggio, c.name as Categoria, ff.rental_duration Durata_Noleggio
from rental r
join inventory i
on i.inventory_id=r.inventory_id
join film_category f
on f.film_id=i.film_id
join category c
on f.category_id=c.category_id
join film ff
on ff.film_id=f.film_id)
;