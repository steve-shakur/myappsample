
--PART I--

UPDATE dbo.ClientFixedTreasuryBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.ClientFloatingTreasuryBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.ClientFixedCorporateBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.ClientFloatingCorporateBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.ClientFixedCommercialPaperPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.ClientBillPurchases
SET Fixed = 0,
ToUpdate = 1;


EXEC dbo.[Stocks.Clients.ReprocessStockTrades];

--PART II--

DECLARE @Client NVARCHAR(100);
DECLARE ClientIDCursor CURSOR FAST_FORWARD READ_ONLY FOR
SELECT ClientID
FROM dbo.Clients;

OPEN ClientIDCursor;
FETCH NEXT FROM ClientIDCursor
INTO @Client;
WHILE @@FETCH_STATUS = 0
BEGIN

EXEC dbo.[FixedTreasuryBonds.Clients.CalculateBalances] @ClientID = @Client,
@Update = 1;
EXEC dbo.[FixedCorporateBonds.Clients.CalculateBalances] @ClientID = @Client,
@Update = 1;
EXEC dbo.[FloatingTreasuryBonds.Clients.CalculateBalances] @ClientID = @Client,
@Update = 1;
EXEC dbo.[FloatingCorporateBonds.Clients.CalculateBalances] @ClientID = @Client,
@Update = 1;
EXEC dbo.[Bills.Clients.CalculateBalances] @ClientID = @Client,
@Update = 1;
EXEC dbo.[FixedDeposits.Clients.CalculateBalances] @ClientID = @Client;
EXEC dbo.[Stocks.Clients.CalculateBalances] @ClientID = @Client;

FETCH NEXT FROM ClientIDCursor
INTO @Client;

END;
CLOSE ClientIDCursor;
DEALLOCATE ClientIDCursor;


-----------------------------------FUND---------------------------------------------

--PART I--

UPDATE dbo.FundFixedTreasuryBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.FundFloatingTreasuryBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.FundFixedCorporateBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.FundFloatingCorporateBondPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.FundFixedCommercialPaperPurchases
SET Fixed = 0,
ToUpdate = 1;
UPDATE dbo.FundBillPurchases
SET Fixed = 0,
ToUpdate = 1;

EXEC dbo.[Stocks.Funds.ReprocessStockTrades];

--PART II--

DECLARE @Fund NVARCHAR(100);
DECLARE FundIDCursor CURSOR FAST_FORWARD READ_ONLY FOR
SELECT FundID
FROM dbo.Funds;

OPEN FundIDCursor;
FETCH NEXT FROM FundIDCursor
INTO @Fund;
WHILE @@FETCH_STATUS = 0
BEGIN

EXEC dbo.[FixedTreasuryBonds.Funds.CalculateBalances] @FundID = @Fund,
@Update = 1;
EXEC dbo.[FixedCorporateBonds.Funds.CalculateBalances] @FundID = @Fund,
@Update = 1;
EXEC dbo.[FloatingTreasuryBonds.Funds.CalculateBalances] @FundID = @Fund,
@Update = 1;
EXEC dbo.[FloatingCorporateBonds.Funds.CalculateBalances] @FundID = @Fund,
@Update = 1;
EXEC dbo.[Bills.Funds.CalculateBalances] @FundID = @Fund, @Update = 1;
EXEC dbo.[Stocks.Funds.CalculateBalances] @FundID = @Fund;
EXEC dbo.[fixeddeposits.Funds.CalculateBalances] @FundID = @Fund;

FETCH NEXT FROM FundIDCursor
INTO @Fund;

END;
CLOSE FundIDCursor;
DEALLOCATE FundIDCursor;