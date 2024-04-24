-- Interrogare, filtrare e raggruppare

-- 1.Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. 
-- Quali considerazioni/ragionamenti è necessario che tu faccia? -> VERIFICARE CHE I RECORD SIANO UNIVOCI PER PRODUCT KEY

SELECT IF ( (SELECT COUNT(*) FROM dimproduct) = (SELECT COUNT(distinct ProductKey) FROM dimproduct), "NUMERO RIGHE E' UGUALE AI VALORI DISTINTI DI PRODUCTKEY -> CHIAVE PRIMARIA", "NON CHIAVE") AS VERIFICA;

-- 2.Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK per factsales

SELECT IF( (SELECT COUNT(*) FROM factsales) = (SELECT COUNT( distinct Combinazione) FROM (SELECT CONCAT(SalesOrderNumber,"-",SalesOrderLineNumber) AS Combinazione FROM factsales) AS TABLE1), "LA COMBINAZIONE E' PK", "NON E' PK") AS VERIFICA;

-- 3.Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.

SELECT *
FROM factsales
;

SELECT COUNT(SalesOrderLineNumber)
FROM factsales
WHERE OrderDate > '2020-01-01' ;

-- 4.Calcola 	il fatturato totale (FactResellerSales.SalesAmount), 

SELECT ProductKey, SUM(SalesAmount) AS FAT_TOT_PROD
FROM factresellersales
GROUP BY ProductKey;

-- 				la quantità totale venduta (FactResellerSales.OrderQuantity)

SELECT ProductKey, SUM(OrderQuantity) AS QTA_TOT_PROD
FROM factresellersales
GROUP BY ProductKey;

--              il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 

SELECT ProductKey, AVG (UnitPrice) AS PREZZO_MEDIO_VENDITA
FROM factresellersales
WHERE OrderDate > '2020-01-01'
GROUP BY ProductKey;

-- Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
-- I campi in output devono essere parlanti!

SELECT *
FROM factresellersales;

SELECT  F.ProductKey AS COD_PROD, D.EnglishProductName AS DESCRIZIONE_INGLESE, AVG (F.UnitPrice) AS PREZZO_MEDIO_VENDITA, SUM(F.OrderQuantity) AS QTA_TOT_PROD, SUM(F.SalesAmount) AS FAT_TOT_PROD
FROM factresellersales F
JOIN dimproduct D
ON F.ProductKey = D.ProductKey
WHERE OrderDate > '2020-01-01'
GROUP BY F.ProductKey
ORDER BY F.ProductKey ASC;

-- 5.Calcola 	il fatturato totale (FactResellerSales.SalesAmount) e 
-- 				la quantità totale venduta (FactResellerSales.OrderQuantity) per Categoria prodotto (DimProductCategory). 
-- Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. 
-- I campi in output devono essere parlanti!

SELECT A.ProductCategoryKey AS COD_CAT , A.EnglishProductCategoryName AS CAT_INGLESE, SUM(D.SalesAmount) AS FATT_TOT ,SUM(D.OrderQuantity) AS QTA_TOT_VEND
FROM dimproductcategory A
JOIN dimproductsubcategory B
ON A.ProductCategoryKey = B.ProductCategoryKey
JOIN dimproduct C
ON C.ProductSubcategoryKey=B.ProductSubcategoryKey
JOIN factsales D
ON D.ProductKey=C.ProductKey
GROUP BY A.ProductCategoryKeY;

-- 6.Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
-- Il result set deve esporre l’elenco delle città con fatturato realizzato superiore a 60K.

SELECT GEO.CITY AS CITY, SUM(SalesAmount) AS FAT_TOT_CITY
FROM dimgeography GEO
JOIN dimsalesterritory TERR
ON GEO.SalesTerritoryKey=TERR.SalesTerritoryKey
JOIN factresellersales SAL
ON SAL.SalesTerritoryKey=GEO.SalesTerritoryKey
JOIN dimproduct DIM
ON DIM.ProductKey=SAL.ProductKey
GROUP BY GEO.City;

-- TIP Dove non espressamente indicato è necessario individuare in autonomia le tabelle contenenti i dati utili.
-- In alcuni casi, per maggior chiarezza è stato indicando il percorso NomeTabella.NomeCampo altrimenti la sola indicazione del campo!