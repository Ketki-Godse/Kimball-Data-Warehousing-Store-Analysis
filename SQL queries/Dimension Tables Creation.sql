CREATE OR REPLACE TABLE Dim_Location(
    DimLocationID INT IDENTITY(1,1) CONSTRAINT PK_DimLocationID PRIMARY KEY NOT NULL --Surrogate Key
    ,Address VARCHAR(255)
    ,City VARCHAR(255)
    ,PostalCode VARCHAR(255) 
    ,State_Province VARCHAR(255) 
    ,Country VARCHAR(255) 
);

CREATE OR REPLACE TABLE Dim_Channel(
    DimChannelID INT IDENTITY(1,1) CONSTRAINT PK_DimChannelID PRIMARY KEY NOT NULL --Surrogate Key
    ,ChannelID INTEGER
    ,ChannelCategoryID INTEGER
    ,ChannelName VARCHAR(255) 
    ,ChannelCategory VARCHAR(255)
);

CREATE OR REPLACE TABLE Dim_Customer(
    DimCustomerID INT IDENTITY(1,1) CONSTRAINT PK_DimCustomerID PRIMARY KEY NOT NULL --Surrogate Key
    ,CustomerID VARCHAR(16777216)
    ,CustomerFullName VARCHAR(255)
    ,CustomerFirstName VARCHAR(255) 
    ,CustomerLastName VARCHAR(255)
    ,CustomerGender VARCHAR(255)
    ,DimLocationID INT NOT NULL, -- Assuming DimLocationID is an INT in Dim_Location
    CONSTRAINT FK_DimCustomer_DimLocation FOREIGN KEY (DimLocationID)
        REFERENCES Dim_Location(DimLocationID) -- Make sure Dim_Location and DimLocationID exist and are properly defined
);

CREATE OR REPLACE TABLE Dim_Store(
     DimStoreID INT IDENTITY(1,1) CONSTRAINT DimStoreID PRIMARY KEY NOT NULL, 
     DimLocationID INTEGER NOT NULL
    ,SourceStoreID INTEGER NOT NULL --Natural Key
    ,StoreName VARCHAR(255)
    ,StoreNumber Number(38,0)
    ,StoreManager VARCHAR(255)
    ,CONSTRAINT DimLocationID FOREIGN KEY (DimLocationID) REFERENCES Dim_Location(DimLocationID) -- Foreign Key Constraint
);

CREATE OR REPLACE TABLE Dim_Reseller (
    DimResellerID INT IDENTITY(1,1) CONSTRAINT DimStoreID PRIMARY KEY NOT NULL,
    DimLocationID INTEGER NOT NULL,
    ResellerID VARCHAR NOT NULL,
    ResellerName VARCHAR(255),
    ContactName VARCHAR(255),
    PhoneNumber VARCHAR(255),
    Email VARCHAR(255)
    ,CONSTRAINT Dim_LocationID_ResellerID FOREIGN KEY (DimLocationID) REFERENCES Dim_Location(DimLocationID) -- Foreign Key Constraint
);

CREATE TABLE Dim_Product (
    DimProductID INT IDENTITY(1,1) CONSTRAINT PK_DimProductID PRIMARY KEY NOT NULL, -- Surrogate Key
    ProductID INTEGER,
    ProductTypeID INTEGER,
    ProductCategoryID INTEGER,
    ProductName VARCHAR(255),
    ProductType VARCHAR(255),
    ProductCategory VARCHAR(255),
    ProductRetailPrice FLOAT,
    ProductWholesalePrice FLOAT,
    ProductCost FLOAT,
    ProductRetailProfit FLOAT AS (ProductRetailPrice - ProductCost) ,
    ProductWholesaleUnitProfit FLOAT AS (ProductWholesalePrice - ProductCost) ,
    ProductProfitMarginUnitPercent FLOAT AS 
        CASE WHEN ProductRetailPrice <> 0 
            THEN (ProductRetailPrice - ProductCost) / ProductRetailPrice * 100 
            ELSE NULL 
        END 
);

create or replace table DIM_DATE (
	DATE_PKEY				number(9) PRIMARY KEY,
	DATE					date not null,
	FULL_DATE_DESC			varchar(64) not null,
	DAY_NUM_IN_WEEK			number(1) not null,
	DAY_NUM_IN_MONTH		number(2) not null,
	DAY_NUM_IN_YEAR			number(3) not null,
	DAY_NAME				varchar(10) not null,
	DAY_ABBREV				varchar(3) not null,
	WEEKDAY_IND				varchar(64) not null,
	US_HOLIDAY_IND			varchar(64) not null,
	/*<COMPANYNAME>*/_HOLIDAY_IND varchar(64) not null,
	MONTH_END_IND			varchar(64) not null,
	WEEK_BEGIN_DATE_NKEY		number(9) not null,
	WEEK_BEGIN_DATE			date not null,
	WEEK_END_DATE_NKEY		number(9) not null,
	WEEK_END_DATE			date not null,
	WEEK_NUM_IN_YEAR		number(9) not null,
	MONTH_NAME				varchar(10) not null,
	MONTH_ABBREV			varchar(3) not null,
	MONTH_NUM_IN_YEAR		number(2) not null,
	YEARMONTH				varchar(10) not null,
	QUARTER					number(1) not null,
	YEARQUARTER				varchar(10) not null,
	YEAR					number(5) not null,
	FISCAL_WEEK_NUM			number(2) not null,
	FISCAL_MONTH_NUM		number(2) not null,
	FISCAL_YEARMONTH		varchar(10) not null,
	FISCAL_QUARTER			number(1) not null,
	FISCAL_YEARQUARTER		varchar(10) not null,
	FISCAL_HALFYEAR			number(1) not null,
	FISCAL_YEAR				number(5) not null,
	SQL_TIMESTAMP			timestamp_ntz,
	CURRENT_ROW_IND			char(1) default 'Y',
	EFFECTIVE_DATE			date default to_date(current_timestamp),
	EXPIRATION_DATE			date default To_date('9999-12-31') 
)
comment = 'Type 0 Dimension Table Housing Calendar and Fiscal Year Date Attributes'; 

