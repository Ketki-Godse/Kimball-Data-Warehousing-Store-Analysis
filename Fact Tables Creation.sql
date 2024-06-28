CREATE OR REPLACE TABLE Fact_ProductSalesTarget (
    DimProductID INT,
    DimTargetDateID Number(9,0),
    ProductTargetSalesQuantity FLOAT,
    CONSTRAINT Dim_ProductID_FactProductSalesTarget FOREIGN KEY (DimProductID) REFERENCES Dim_Product(DimProductID),
    CONSTRAINT Dim_TargetDateID_FactProductSalesTarget FOREIGN KEY (DimTargetDateID) REFERENCES Dim_Date(DATE_PKEY)
);

CREATE OR REPLACE TABLE Fact_SRCSalesTarget (
    DimStoreID INT,
    DimResellerID INT,
    DimChannelID INT,
    DimTargetDateID Number(9,0),
    SalesTargetAmount DECIMAL(10, 2),
    CONSTRAINT Dim_StoreID_Fact_SRCSalesTarget FOREIGN KEY (DimStoreID) REFERENCES Dim_Store(DimStoreID),
    CONSTRAINT Dim_ResellerID_Fact_SRCSalesTarget FOREIGN KEY (DimResellerID) REFERENCES Dim_Reseller(DimResellerID),
    CONSTRAINT Dim_ChannelID_Fact_SRCSalesTarget FOREIGN KEY (DimChannelID) REFERENCES Dim_Channel(DimChannelID),
    CONSTRAINT Dim_TargetDateID_Fact_SRCSalesTarget FOREIGN KEY (DimTargetDateID) REFERENCES Dim_Date(DATE_PKEY)
);

CREATE or Replace TABLE Fact_SalesActual (
    DimProductID INT,
    DimStoreID INT,
    DimResellerID INT,
    DimCustomerID INT,
    DimChannelID INT,
    DimSaleDateID Number(9,0),
    DimLocationID INT,
    SalesDetailID INT,
    SalesHeaderID INT,
    SaleAmount DECIMAL(10, 2),
    SaleQuantity INT,
    SaleUnitPrice DECIMAL(10, 2),
    SaleExtendedCost DECIMAL(10, 2),
    SaleTotalProfit DECIMAL(10, 2),
    CONSTRAINT Dim_ProductID_Fact_SalesActual FOREIGN KEY (DimProductID) REFERENCES Dim_Product(DimProductID),
    CONSTRAINT Dim_StoreID_Fact_SalesActual FOREIGN KEY (DimStoreID) REFERENCES Dim_Store(DimStoreID),
    CONSTRAINT Dim_ResellerID_Fact_SalesActual FOREIGN KEY (DimResellerID) REFERENCES Dim_Reseller(DimResellerID),
    CONSTRAINT Dim_CustomerID_Fact_SalesActual FOREIGN KEY (DimCustomerID) REFERENCES Dim_Customer(DimCustomerID),
    CONSTRAINT Dim_ChannelID_Fact_SalesActual FOREIGN KEY (DimChannelID) REFERENCES Dim_Channel(DimChannelID),
    CONSTRAINT Dim_SaleDateID_Fact_SalesActual FOREIGN KEY (DimSaleDateID) REFERENCES Dim_Date(DATE_PKEY),
    CONSTRAINT Dim_LocationID_Fact_SalesActual FOREIGN KEY (DimLocationID) REFERENCES Dim_Location(DimLocationID)
);

