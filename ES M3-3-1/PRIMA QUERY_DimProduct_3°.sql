select 
ProductKey as Id_Prodotto, 
ProductAlternateKey as Codice_Prodotto, 
EnglishProductName as Nome_Inglese, 
Color as Colore, 
FinishedGoodsFlag as Prodotto_Finito , 
StandardCost as Costo,
ListPrice as Prezzo_Listino
from
dimproduct
where 
ListPrice between 1000 and 2000;