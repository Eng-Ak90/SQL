select 
ProductKey as Id_Prodotto, ProductAlternateKey as Codice_Prodotto, EnglishProductName as Nome_Inglese, Color as Colore, FinishedGoodsFlag as Prodotto_Finito , StandardCost as Costo
from
dimproduct
where 
FinishedGoodsFlag=1;