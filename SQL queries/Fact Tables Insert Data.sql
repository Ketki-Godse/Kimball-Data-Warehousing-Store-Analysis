INSERT INTO Fact_ProductSalesTarget (DimProductID, DimTargetDateID, ProductTargetSalesQuantity)
SELECT
    dp.DIMPRODUCTID AS DimProductID,
    dd.DATE_PKEY AS DimTargetDateID,
    st.SALESQUANTITYTARGET / 365 AS ProductTargetSalesQuantity
FROM
    STAGE_TARGETDATA_PRODUCT st
LEFT JOIN
    DIM_PRODUCT dp ON st.PRODUCTID = dp.PRODUCTID
LEFT JOIN
    DIM_DATE dd ON st.YEAR = dd.YEAR;


INSERT INTO Fact_SRCSalesTarget (DimStoreID, DimResellerID, DimChannelID, DimTargetDateID, SalesTargetAmount)
SELECT
    ds.DimStoreID,
    dr.DimResellerID,
    dc.DimChannelID,
    dd.DATE_PKEY AS DimTargetDateID,
    ts.TARGETSALESAMOUNT / 365 AS SalesTargetAmount
FROM
    STAGE_TARGETDATA_CHANNELRESELLERANDSTORE ts
LEFT JOIN
    Dim_Channel dc ON ts.CHANNELNAME = dc.ChannelName
LEFT JOIN
    Dim_Store ds ON (CASE  
		WHEN ts.TargetName = 'Store Number 5'  
		THEN CAST('5' AS INT)
		WHEN ts.TargetName = 'Store Number 8'  
		THEN CAST('8' AS INT)
		WHEN ts.TargetName = 'Store Number 10'  
		THEN CAST('10' AS INT)
		WHEN ts.TargetName = 'Store Number 21'  
		THEN CAST('21' AS INT)
		WHEN ts.TargetName = 'Store Number 34'  
		THEN CAST('34' AS INT)
		WHEN ts.TargetName = 'Store Number 39'  
		THEN CAST('39' AS INT)
		WHEN ts.TargetName = 'Store Number 39'  
		THEN CAST('39' AS INT)
		ELSE -1
	END) = ds.StoreNumber
LEFT JOIN Dim_Reseller dr ON
	dr.ResellerName = ts.TargetName
LEFT JOIN
    DIM_DATE dd ON ts.YEAR = dd.YEAR;


INSERT INTO Fact_SalesActual (
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
)
SELECT
    COALESCE(dp.DimProductID, -1),
    COALESCE(ds.DimStoreID, -1),
    COALESCE(dr.DimResellerID, -1),
    COALESCE(dc.DimCustomerID, -1),
    COALESCE(dchn.DimChannelID, -1),
    dd.DATE_PKEY AS DimSaleDateID,
    COALESCE(dl.DimLocationID, -1),
    ssd.SALESDETAILID,
    ssh.SALESHEADERID,
    ssd.SALESAMOUNT,
    ssd.SALESQUANTITY,
    ssd.SALESAMOUNT / ssd.SALESQUANTITY AS SaleUnitPrice,
    CASE
        WHEN ssd.SALESAMOUNT / ssd.SALESQUANTITY = dp.ProductRetailPrice THEN dp.ProductRetailPrice
        ELSE dp.ProductWholesalePrice
    END AS SaleExtendedCost,
    CASE
        WHEN ssd.SALESAMOUNT / ssd.SALESQUANTITY = dp.ProductRetailPrice THEN dp.ProductRetailProfit * ssd.SALESQUANTITY
        ELSE dp.ProductWholesaleUnitProfit * ssd.SALESQUANTITY
    END AS SaleTotalProfit
FROM
STAGE_SALESHEADER_NEW ssh join STAGE_SALESDETAIL ssd
on ssh.SALESHEADERID = ssd.SALESHEADERID
LEFT JOIN
    Dim_Product dp ON ssd.PRODUCTID = dp.ProductID
LEFT JOIN
    Dim_Store ds ON ssh.STOREID = ds.SourceStoreID
LEFT JOIN
    Dim_Reseller dr ON ssh.RESELLERID = dr.ResellerID
LEFT JOIN
    Dim_Customer dc ON ssh.CUSTOMERID = dc.CustomerID
LEFT JOIN
    Dim_Channel dchn ON ssh.CHANNELID = dchn.ChannelID
LEFT JOIN
    Dim_Location dl ON ds.DimLocationID = dl.DimLocationID
LEFT JOIN
    Dim_Date dd ON ssh.DATE = dd.DATE;


