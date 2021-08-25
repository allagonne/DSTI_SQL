USE WideWorldImporters

UPDATE Sales.InvoiceLines
SET UnitPrice = UnitPrice + 20
WHERE InvoiceLineID = (SELECT InvoiceLineId
FROM (
SELECT TOP 1 IL.InvoiceID, IL.InvoiceLineID, IL.UnitPrice
FROM Sales.InvoiceLines AS IL
JOIN Sales.Invoices AS Iv
ON Iv.InvoiceID = IL.InvoiceID
JOIN Sales.Customers as Cu
ON Cu.CustomerID = Iv.CustomerID
WHERE Cu.CustomerID = 1060
ORDER BY IL.InvoiceID ASC, IL.InvoiceLineID ASC) FirstLineofAllCustomerOrders)


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


