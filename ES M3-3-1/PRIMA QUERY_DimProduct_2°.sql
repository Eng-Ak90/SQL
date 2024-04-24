select 
ProductKey as Id_Prodotto, 
ProductAlternateKey as Modello, 
EnglishProductName as Nome_Inglese, 
Color as Colore, 
FinishedGoodsFlag as Prodotto_Finito , 
StandardCost as Costo, 
ListPrice as Prezzo,
ListPrice - StandardCost as Markup
from
dimproduct
where ProductAlternateKey LIKE 'BK%' OR ProductAlternateKey  LIKE 'FK%'