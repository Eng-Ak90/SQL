/* In riferimento al database creato, procedere con:
1.	Verificare che i campi definiti come PK siano univoci. 
2.	Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.  
3.	Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. 
4.  Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato? 
5.	Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti. 
6.	Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).
*/

-- 1.	Verificare che i campi definiti come PK siano univoci: Verificare che non vi siano duplicati come differenza tra i valori distinti e i valori totali

USE Epicode_ToysGroup;

Select if( (count(distinct ID_Categoria)-count(ID_Categoria))=0, "Valori univoci in Category","Valori duplicati") as "Verifica"
From category
UNION
Select if( (count(distinct ID_Prodotto )-count(ID_Prodotto))=0, "Valori univoci in Product","Valori duplicati") as "Verifica"
From product
union
Select if( (count(distinct ID_regione )-count(ID_regione))=0, "Valori univoci in Region","Valori duplicati") as "Verifica"
From region
union
Select if( (count(distinct ID_transazione )-count(ID_transazione))=0, "Valori univoci in Sales","Valori duplicati") as "Verifica"
From sales;

-- 2.	Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.  

-- Calcolo del fatturato diverso da 0 ( per esser sicuri di eventuali storni o simili) per anno:

-- 2021
select sales.ID_prodotto, sum( Quantità)*Prezzo_vendita AS "2021"
from sales
join product on product.ID_Prodotto=sales.ID_Prodotto
where year(Data_Transazione)=2021 and Quantità <>0
group by ID_prodotto, year(Data_Transazione)
order by ID_Prodotto asc;

-- 2022

select sales.ID_prodotto, sum( Quantità)*Prezzo_vendita AS "2022"
from sales
join product on product.ID_Prodotto=sales.ID_Prodotto
where year(Data_Transazione)=2022 and Quantità <>0
group by ID_prodotto, year(Data_Transazione)
order by ID_Prodotto asc;

-- 2023

select sales.ID_prodotto, sum( Quantità)*Prezzo_vendita AS "2023"
from sales
join product on product.ID_Prodotto=sales.ID_Prodotto
where year(Data_Transazione)=2023 and Quantità <>0
group by ID_prodotto, year(Data_Transazione)
order by ID_Prodotto asc;

-- 2024

select sales.ID_prodotto, sum( Quantità)*Prezzo_vendita AS "2024"
from sales
join product on product.ID_Prodotto=sales.ID_Prodotto
where year(Data_Transazione)=2024 and Quantità <>0
group by ID_prodotto, year(Data_Transazione)
order by ID_Prodotto asc;

-- Tabella riassuntiva

select Table1.ID_Prodotto,p.Nome_Prodotto, Table1.Anno_2021, Table2.Anno_2022,Table3.Anno_2023,Table4.Anno_2024
from 	(	select sales.ID_prodotto as ID_Prodotto, sum( Quantità)*Prezzo_vendita AS Anno_2021
			from sales
			join product on product.ID_Prodotto=sales.ID_Prodotto
			where year(Data_Transazione)=2021 and Quantità <>0
			group by ID_prodotto, year(Data_Transazione)) as Table1
join    (	select sales.ID_prodotto as ID_Prodotto, sum( Quantità)*Prezzo_vendita AS Anno_2022
			from sales
			join product on product.ID_Prodotto=sales.ID_Prodotto
			where year(Data_Transazione)=2022 and Quantità <>0
			group by ID_prodotto, year(Data_Transazione)) as Table2
on Table1.ID_Prodotto=Table2.ID_Prodotto
join	(	select sales.ID_prodotto as ID_Prodotto, sum( Quantità)*Prezzo_vendita AS Anno_2023
			from sales
			join product on product.ID_Prodotto=sales.ID_Prodotto
			where year(Data_Transazione)=2023 and Quantità <>0
			group by ID_prodotto, year(Data_Transazione)) as Table3
on Table1.ID_Prodotto=Table3.ID_Prodotto
join	(	select sales.ID_prodotto as ID_Prodotto, sum( Quantità)*Prezzo_vendita AS Anno_2024
			from sales
			join product on product.ID_Prodotto=sales.ID_Prodotto
			where year(Data_Transazione)=2024 and Quantità <>0
			group by ID_prodotto, year(Data_Transazione)) as Table4
on Table1.ID_Prodotto=Table4.ID_Prodotto
join product as p
on p.ID_Prodotto=table1.ID_Prodotto
;

-- 3.Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. 

select r.Nome_regione, sum(s.Quantità*p.Prezzo_vendita) as Fatturato, year(s.Data_Transazione) as Anno
from sales s
join product p on p.ID_Prodotto=s.ID_Prodotto
join region r  on r.ID_regione=s.ID_regione
group by s.ID_regione, Anno
order by Anno desc, Fatturato desc;

-- 4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
 
select c.Nome_Categoria, sum(s.Quantità*p.Prezzo_vendita) as Fatturato
from sales s
join product p on p.ID_Prodotto=s.ID_Prodotto
join category c on c.ID_Categoria=p.ID_Categoria
group by c.Nome_Categoria
order by Fatturato Desc
limit 1;

-- 5.	Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti. 

-- Soluzione 1 Verificare che la tabella del totale venduto raggruppato per prodotti, abbia un numero di righe pari al numero di prodotti (se ci fossero prodotti invenduti non vi sarebbero righe a riguardo)

-- Numero prodotti a database
select count(distinct(ID_prodotto)) as Nr_Prodotti_Database
from product
;
-- Numero prodotti distinti con movimenti di vendita
select count(table1.ID_prodotto) as Nr_Prodotti_Venduti
FROM (select ID_prodotto,sum(Quantità) as Tot_Venduto
from sales
where Quantità<>0
group by ID_prodotto)AS table1
;
-- Lista eventuali prodotti invenduti
select table1.ID_prodotto as Prodotti_Venduti
from product p
left join (select ID_prodotto,sum(Quantità) as Tot_Venduto
			from sales
			group by ID_prodotto)AS table1
on table1.ID_Prodotto=p.ID_Prodotto
where p.ID_prodotto IS NULL
;

select if (((select count(distinct(ID_prodotto)) as Nr_Prodotti_Database from product))= (	select count(table1.ID_prodotto) as Nr_Prodotti_Venduti
																									FROM (select ID_prodotto,sum(Quantità) as Tot_Venduto from sales group by ID_prodotto)as Table1),"Nessun prodotto invenduto","Vi sono prodotti invenduti") as Verifica
                                                                                                    ;


-- Soluzione 2 Filtrare la tabella dei conteggi del numero di transazioni prodotti per valori pari a 0

-- Numero prodotti a database
select count(distinct(ID_prodotto)) as Nr_Prodotti_Database
from product;

-- Numero prodotti distinti nei movimenti di vendita
select count(distinct(s.ID_prodotto)) as Nr_Prodotti_Venduti
from sales s
join product p on s.ID_prodotto=p.ID_Prodotto
;

-- Lista eventuali prodotti invenduti

select group_concat(p.ID_prodotto) as Prodotti_Venduti
from product p
left join sales s
on s.ID_Prodotto=p.ID_Prodotto
where s.ID_prodotto IS NULL;

-- Verifica se non vi sono prodotti invenduti o, se presenti, l'elenco dei prodotti

select if 
(
		(select count(distinct(ID_prodotto)) as Nr_Prodotti_Database from product) 
		= 
		(	select count(distinct(s.ID_prodotto)) as Nr_Prodotti_Venduti
	from sales s join product p on s.ID_prodotto=p.ID_Prodotto
		where s.Quantità<>0)
,
"Nessun prodotto invenduto"
,
(select group_concat(p.Nome_Prodotto) as Prodotti_Venduti
from product p
left join sales s
on s.ID_Prodotto=p.ID_Prodotto
where s.ID_prodotto IS NULL)
) 
as Verifica_Prodotti_invenduti;
   

-- 6.	Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).

select p.Nome_Prodotto, max(s.Data_Transazione) as Ultima_Transazione
from sales s
join product p on p.ID_Prodotto=s.ID_prodotto
group by p.Nome_Prodotto
order by Ultima_Transazione desc
;

