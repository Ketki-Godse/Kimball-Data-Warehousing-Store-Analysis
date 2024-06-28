--Question 1 View
CREATE OR REPLACE SECURE VIEW question1 AS
SELECT 
    fs.DimStoreID,
    ds.DATE_PKEY AS SaleDate,
    dt.DATE_PKEY AS TargetDate,
    ds.DAY_NAME as DAY_NAME,
    ds.YEAR as YEAR,
    ds.MONTH_NAME as MONTH_NAME,
    ds._holiday_ind as ISHOLIDAY,
    SUM(fs.SaleAmount) AS TotalSalesAmount,
    SUM(fst.SalesTargetAmount) AS TotalSalesTarget,
    SUM(fs.SaleTotalProfit) AS TotalProfit
FROM
    (Select DIMSTOREID,DIMRESELLERID,DIMCHANNELID,DIMSALEDATEID,count(*),SUM(SALEAMOUNT) as SaleAmount,
    SUm(SALEQUANTITY) as SALEQUANTITY,
    SUM(SALETOTALPROFIT) as SALETOTALPROFIT from Fact_SalesActual group by DIMSTOREID,DIMRESELLERID,DIMCHANNELID,DIMSALEDATEID) fs
    JOIN Dim_Date ds ON fs.DimSaleDateID = ds.DATE_PKEY
    LEFT JOIN Fact_SRCSalesTarget fst ON fs.DimStoreID = fst.DimStoreID
        --AND fs.DimResellerID = fst.DimResellerID
        --AND fs.DimChannelID = fst.DimChannelID
        AND ds.DATE_PKEY = fst.DimTargetDateID
    JOIN Dim_Date dt ON fst.DimTargetDateID = dt.DATE_PKEY
WHERE
    fs.DimStoreID IN (1, 5)
GROUP BY
    fs.DimStoreID,
    ds.DATE_PKEY,
    dt.DATE_PKEY,
    ds.DAY_NAME,
    ds.MONTH_NAME,
    ds.YEAR,
    ds._holiday_ind



-- Question 2 View
CREATE OR REPLACE SECURE VIEW question2 AS
SELECT 
    s.DimStoreID,
    s.StoreNumber,
    p.ProductType,
    d.DATE_PKEY AS SaleYear,
    d.DAY_NAME as DAY_NAME,
    d.YEAR as YEAR,
    d.MONTH_NAME as MONTH_NAME,
    d._holiday_ind as ISHOLIDAY,
    SUM(f.SaleAmount) AS TotalSales
FROM 
    Fact_SalesActual f
JOIN 
    Dim_Store s ON f.DimStoreID = s.DimStoreID
JOIN 
    Dim_Product p ON f.DimProductID = p.DimProductID
JOIN 
    Dim_Date d ON f.DimSaleDateID = d.DATE_PKEY
WHERE 
    p.ProductType IN ('Men\'s Casual', 'Women\'s Casual')
    AND s.StoreNumber IN (5, 8)
GROUP BY 
    s.DimStoreID,
    s.StoreNumber,
    p.ProductType,
    d.DATE_PKEY,
    d.DAY_NAME,
    d.MONTH_NAME,
    d.YEAR,
    d._holiday_ind
;



-- Question 3 View
CREATE OR REPLACE SECURE VIEW question3 AS
SELECT 
    s.DimStoreID,
    s.StoreNumber,
    p.PRODUCTNAME,
    p.ProductType,
    d.DATE_PKEY AS SaleYear,
    d.DAY_NAME as DAY_NAME,
    d.YEAR as YEAR,
    d.MONTH_NAME as MONTH_NAME,
    d._holiday_ind as ISHOLIDAY,
    SUM(f.SaleAmount) AS TotalSales,
    SUM(f.SaleQuantity) AS TotalQuantity
FROM 
    Fact_SalesActual f
JOIN 
    Dim_Store s ON f.DimStoreID = s.DimStoreID
JOIN 
    Dim_Product p ON f.DimProductID = p.DimProductID
JOIN 
    Dim_Date d ON f.DimSaleDateID = d.DATE_PKEY
WHERE 
    s.StoreNumber IN (5, 8)
GROUP BY 
    s.DimStoreID,
    s.StoreNumber,
    p.productname,
    p.ProductType,
    d.DATE_PKEY,
    d.DAY_NAME,
    d.MONTH_NAME,
    d.YEAR,
    d._holiday_ind;




-- Question 4 View
CREATE OR REPLACE SECURE VIEW question4 AS
SELECT
    l.State_Province,
    s.StoreNumber,
    p.PRODUCTNAME,
    p.ProductType,
    d.DATE_PKEY AS SaleYear,
    d.DAY_NAME as DAY_NAME,
    d.YEAR as YEAR,
    d.MONTH_NAME as MONTH_NAME,
    (SELECT COUNT(DISTINCT s2.DimStoreID)
     FROM Dim_Store s2
     JOIN Dim_Location l2 ON s2.DimLocationID = l2.DimLocationID
     WHERE l2.State_Province = l.State_Province) AS number_of_stores_in_state,
    SUM(sa.SaleAmount) AS Total_Sales_Amount,
    SUM(sa.SaleQuantity) AS Total_Sales_Quantity
FROM
    Fact_SalesActual sa
JOIN
    Dim_Store s ON sa.DimStoreID = s.DimStoreID
JOIN
    Dim_Location l ON s.DimLocationID = l.DimLocationID
JOIN 
    Dim_Product p ON sa.DimProductID = p.DimProductID
JOIN
    Dim_Date d ON sa.DimSaleDateID = d.Date_PKey
GROUP BY
    l.State_Province,
    s.StoreNumber,
    p.PRODUCTNAME,
    p.ProductType,
    d.DATE_PKEY,
    d.DAY_NAME,
    d.YEAR,
    d.MONTH_NAME
    ;


// Standard views
CREATE OR REPLACE SECURE VIEW View_Dim_Location AS
SELECT
    DimLocationID,
    Address,
    City,
    PostalCode,
    State_Province,
    Country
FROM
    Dim_Location;

CREATE OR REPLACE SECURE VIEW View_Dim_Customer AS
SELECT
    DimCustomerID,
    CustomerID,
    CustomerFullName,
    CustomerFirstName,
    CustomerLastName,
    CustomerGender,
    DimLocationID
FROM
    Dim_Customer;

CREATE OR REPLACE SECURE VIEW View_Dim_Channel AS
SELECT
    DimChannelID,
    ChannelID,
    ChannelCategoryID,
    ChannelName,
    ChannelCategory
FROM
    Dim_Channel;

CREATE OR REPLACE SECURE VIEW View_Dim_Store AS
SELECT
    DimStoreID,
    DimLocationID,
    SourceStoreID,
    StoreNumber,
    StoreManager
FROM
    Dim_Store;

CREATE OR REPLACE SECURE VIEW View_Dim_Reseller AS
SELECT
    DimResellerID,
    DimLocationID,
    ResellerID,
    ResellerName,
    ContactName,
    PhoneNumber,
    Email
FROM
    Dim_Reseller;

CREATE OR REPLACE SECURE VIEW View_Dim_Product AS
SELECT
    DimProductID,
    ProductID,
    ProductTypeID,
    ProductCategoryID,
    ProductName,
    ProductType,
    ProductCategory,
    ProductRetailPrice,
    ProductWholesalePrice,
    ProductCost,
    ProductRetailProfit,
    ProductWholesaleUnitProfit,
    ProductProfitMarginUnitPercent
FROM
    Dim_Product;

CREATE OR REPLACE SECURE VIEW View_Fact_ProductSalesTarget AS
SELECT
    DimProductID,
    DimTargetDateID,
    ProductTargetSalesQuantity
FROM
    Fact_ProductSalesTarget;

CREATE OR REPLACE SECURE VIEW View_Fact_SRCSalesTarget AS
SELECT
    DimStoreID,
    DimResellerID,
    DimChannelID,
    DimTargetDateID,
    SalesTargetAmount
FROM
    Fact_SRCSalesTarget;

CREATE OR REPLACE SECURE VIEW View_Fact_SalesActual AS
SELECT
    DimProductID,
    DimStoreID,
    DimResellerID,
    DimCustomerID,
    DimChannelID,
    DimSaleDateID,
    DimLocationID,
    SalesDetailID,
    SalesHeaderID,
    SaleAmount,
    SaleQuantity,
    SaleUnitPrice,
    SaleExtendedCost,
    SaleTotalProfit
FROM
    Fact_SalesActual;


