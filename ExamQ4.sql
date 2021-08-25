USE WideWorldImporters
SELECT CCNML.*, Cu.CustomerName, CIDTL.CustomerID 
FROM
	(SELECT CC.CustomerCategoryName, MAX(TotalLoss) AS MaxLoss
	FROM
		(SELECT
				t.CustomerCategoryID, t.CustomerID, t.CustomerName, TL.TotalLoss
			FROM
			(
				SELECT
					Cu.CustomerID
					, Cu.CustomerName
					,	Cu.CustomerCategoryID,
					(
							SELECT	COUNT(*)
							FROM	Sales.Orders as Od
							WHERE	Od.CustomerID = Cu.CustomerID
						) AS TotalNumberOfOrders
					,	(
							SELECT COUNT(*)
							FROM	Sales.Orders as Od,
									Sales.Invoices as Iv
							WHERE	Od.CustomerID = Cu.CustomerID
									AND Od.OrderID = Iv.OrderID
						) As NumberOfInvoicedOrders
					,	(
							SELECT COUNT(*)
							FROM	Sales.Orders as Od,
									Sales.OrderLines as OL
							WHERE	Od.CustomerID = Cu.CustomerID
									AND	OL.OrderID = Od.OrderID
					) AS CustomerLoss
				FROM
					Sales.Customers as Cu
			) as t
		JOIN (
		-- OrdersNotInvoicedList
			SELECT CustomerID, SUM(TotalLoss) AS TotalLoss
			FROM (
				SELECT	Cu.CustomerID, Od.OrderID, SUM(OL.Quantity * OL.UnitPrice) AS TotalLoss
				FROM Sales.Customers as Cu
				JOIN Sales.Orders as Od
				ON Od.CustomerID = Cu.CustomerID
				AND NOT EXISTS
					(
						SELECT	*
						FROM	Sales.Invoices as Iv
						WHERE
								IV.OrderID = Od.OrderID)
				JOIN Sales.OrderLines as OL
				ON OL.OrderID = Od.OrderID
				GROUP BY Cu.CustomerID, Od.OrderID) AS t
			GROUP BY CustomerID) AS TL
		ON TL.CustomerId = t.CustomerID
		WHERE t.TotalNumberOfOrders != t.NumberOfInvoicedOrders) AS TL
	JOIN Sales.CustomerCategories AS CC
	ON CC.CustomerCategoryID = TL.CustomerCategoryID
	GROUP BY CC.CustomerCategoryName) AS CCNML
JOIN (		SELECT CustomerID, SUM(TotalLoss) AS TotalLoss
		FROM (
			SELECT	Cu.CustomerID, Od.OrderID, SUM(OL.Quantity * OL.UnitPrice) AS TotalLoss
			FROM Sales.Customers as Cu
			JOIN Sales.Orders as Od
			ON Od.CustomerID = Cu.CustomerID
			AND NOT EXISTS
				(
					SELECT	*
					FROM	Sales.Invoices as Iv
					WHERE
							IV.OrderID = Od.OrderID)
			JOIN Sales.OrderLines as OL
			ON OL.OrderID = Od.OrderID
			GROUP BY Cu.CustomerID, Od.OrderID) AS t
		GROUP BY CustomerID
) AS CIDTL
ON CCNML.MaxLoss = CIDTL.TotalLoss
JOIN Sales.Customers as Cu
ON Cu.CustomerID = CIDTL.CustomerID
ORDER BY MaxLoss DESC