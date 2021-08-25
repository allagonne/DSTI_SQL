USE WideWorldImporters

SELECT t.*, OTV.OrdersTotalValue, ITV.InvoicesTotalValue, (ITV.InvoicesTotalValue - OTV.OrdersTotalValue) AS AbsoluteValueDifference
FROM (
	SELECT Cu.CustomerID, 
	Cu.CustomerName,
	(	SELECT COUNT(*) 
		FROM Sales.Orders AS Od
		WHERE Od.CustomerID = Cu.CustomerID
		AND Od.PickingCompletedWhen IS NOT NULL) AS TotalNBOrders,
	(	SELECT COUNT(*)
		FROM Sales.Invoices AS Iv
		WHERE Iv.CustomerID = Cu.CustomerID) AS TotalNBInvoices
	FROM Sales.Customers AS Cu
	) AS t
	JOIN (	SELECT Cu.CustomerId, SUM(OL.Quantity * OL.UnitPrice) AS OrdersTotalValue
			FROM Sales.Customers AS Cu
			JOIN Sales.Orders AS Od
			ON Od.CustomerID = Cu.CustomerID
			JOIN Sales.OrderLines AS OL
			ON Od.OrderID = OL.OrderID
			WHERE Od.PickingCompletedWhen IS NOT NULL
			GROUP BY Cu.CustomerID) AS OTV
	ON OTV.CustomerID = t.CustomerID
	JOIN (	SELECT Cu.CustomerId, SUM(IL.Quantity * IL.UnitPrice) AS InvoicesTotalValue
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON Iv.InvoiceID = IL.InvoiceID
			GROUP BY Cu.CustomerID) AS ITV
	ON ITV.CustomerID = t.CustomerID
	ORDER BY AbsoluteValueDifference DESC, TotalNBOrders ASC, CustomerName ASC


