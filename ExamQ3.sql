USE WideWorldImporters


GO
CREATE or ALTER PROCEDURE dbo.ReportCustomerTurnover 
	@Choice int = 1
	,
	@Year int = 2013
	AS

	IF @Choice = 1
		SELECT Cu.CustomerName, 
		(CASE WHEN TJAN.Jan > 0 THEN TJAN.Jan ELSE 0 END) AS Jan,
		(CASE WHEN TFEV.Fev > 0 THEN TFEV.Fev ELSE 0 END) AS Fev,
		(CASE WHEN TMAR.Mar > 0 THEN TMar.Mar ELSE 0 END) AS Mar,
		(CASE WHEN TAPR.Apr > 0 THEN TAPR.Apr ELSE 0 END) AS Apr, 
		(CASE WHEN TMAY.May > 0 THEN TMAY.May ELSE 0 END) AS May,
		(CASE WHEN TJUN.Jun > 0 THEN TJUN.Jun ELSE 0 END) AS Jun,
		(CASE WHEN TJUL.Jul > 0 THEN TJUL.Jul ELSE 0 END) AS Jul,
		(CASE WHEN TAUG.Aug > 0 THEN TAUG.Aug ELSE 0 END) AS Aug,
		(CASE WHEN TSEP.Sep > 0 THEN TSEP.Sep ELSE 0 END) AS Sep,
		(CASE WHEN TOCT.Oct > 0 THEN TOCT.Oct ELSE 0 END) AS Oct,
		(CASE WHEN TNOV.Nov > 0 THEN TNOV.Nov ELSE 0 END) AS Nov,
		(CASE WHEN TDEC.Dec > 0 THEN TDEC.Dec ELSE 0 END) AS Dec
		FROM Sales.Customers AS Cu
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Jan
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 1
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TJAN
			ON Cu.CustomerName = TJAN.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Fev
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 2
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TFEV
			ON Cu.CustomerName = TFEV.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Mar
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 3
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TMAR
			ON Cu.CustomerName = TMAR.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Apr
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 4
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TAPR
			ON Cu.CustomerName = TAPR.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS May
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 5
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TMAY
			ON Cu.CustomerName = TMAY.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Jun
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 6
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TJUN
			ON Cu.CustomerName = TJUN.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Jul
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 7
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TJUL
			ON Cu.CustomerName = TJUL.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Aug
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 8
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TAUG
			ON Cu.CustomerName = TAUG.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Sep
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 9
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TSEP
			ON Cu.CustomerName = TSEP.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Oct
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 10
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TOCT
			ON Cu.CustomerName = TOCT.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS Nov
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 11
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TNOV
			ON Cu.CustomerName = TNOV.CustomerName
		LEFT JOIN
			(SELECT Cu.CustomerName, SUM (IL.Quantity*IL.UnitPrice) AS 'Dec'
			FROM Sales.Customers AS Cu
			JOIN Sales.Invoices AS Iv
			ON Iv.CustomerID = Cu.CustomerID
			JOIN Sales.InvoiceLines AS IL
			ON IL.InvoiceID = Iv.InvoiceID
			WHERE MONTH(Iv.InvoiceDate) = 12
			AND YEAR(Iv.InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS TDEC
			ON Cu.CustomerName = TDEC.CustomerName
		ORDER BY Cu.CustomerName

	IF @Choice = 2
		SELECT Cu.CustomerName,
		(CASE WHEN tQ1.Q1 > 0 THEN tQ1.Q1 ELSE 0 END) AS Q1,
		(CASE WHEN tQ2.Q2 > 0 THEN tQ2.Q2 ELSE 0 END) AS Q2,
		(CASE WHEN tQ3.Q3 > 0 THEN tQ3.Q3 ELSE 0 END) AS Q3,
		(CASE WHEN tQ4.Q4 > 0 THEN tQ4.Q4 ELSE 0 END) AS Q4
		FROM Sales.Customers AS Cu
		LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Q1
			FROM Sales.Customers AS Cu
			FULL JOIN Sales.Invoices AS Iv
			ON Cu.CustomerID = Iv.CustomerID
			JOIN Sales.InvoiceLines as IL
			ON Iv.InvoiceID = IL.InvoiceID
			WHERE DATEPART(QUARTER,InvoiceDate)=1
			AND YEAR(InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS tQ1
		ON Cu.CustomerName = tQ1.CustomerName
		LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Q2
			FROM Sales.Customers AS Cu
			FULL JOIN Sales.Invoices AS Iv
			ON Cu.CustomerID = Iv.CustomerID
			JOIN Sales.InvoiceLines as IL
			ON Iv.InvoiceID = IL.InvoiceID
			WHERE DATEPART(QUARTER,InvoiceDate)=2
			AND YEAR(InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS tQ2
		ON Cu.CustomerName = tQ2.CustomerName
		LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Q3
			FROM Sales.Customers AS Cu
			FULL JOIN Sales.Invoices AS Iv
			ON Cu.CustomerID = Iv.CustomerID
			JOIN Sales.InvoiceLines as IL
			ON Iv.InvoiceID = IL.InvoiceID
			WHERE DATEPART(QUARTER,InvoiceDate)=3
			AND YEAR(InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS tQ3
		ON Cu.CustomerName = tQ3.CustomerName
		LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Q4
			FROM Sales.Customers AS Cu
			FULL JOIN Sales.Invoices AS Iv
			ON Cu.CustomerID = Iv.CustomerID
			JOIN Sales.InvoiceLines as IL
			ON Iv.InvoiceID = IL.InvoiceID
			WHERE DATEPART(QUARTER,InvoiceDate)=4
			AND YEAR(InvoiceDate) = @Year
			GROUP BY Cu.CustomerName) AS tQ4
		ON Cu.CustomerName = tQ4.CustomerName
		ORDER BY CustomerName

	IF @Choice = 3
		SELECT Cu.CustomerName, 
		(CASE WHEN t2013.Sum2013 > 0 THEN t2013.Sum2013 ELSE 0 END) AS S2013,
		(CASE WHEN t2014.Sum2014 > 0 THEN t2014.Sum2014 ELSE 0 END) AS S2014,
		(CASE WHEN t2015.Sum2015 > 0 THEN t2015.Sum2015 ELSE 0 END) AS S2015,
		(CASE WHEN t2016.Sum2016 > 0 THEN t2016.Sum2016 ELSE 0 END) AS S2016
		FROM Sales.Customers AS Cu
		LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Sum2013
					FROM Sales.Customers AS Cu
					FULL JOIN Sales.Invoices AS Iv
					ON Cu.CustomerID = Iv.CustomerID
					JOIN Sales.InvoiceLines as IL
					ON Iv.InvoiceID = IL.InvoiceID
					WHERE 2013 = YEAR(Iv.InvoiceDate)
					GROUP BY Cu.CustomerName) AS t2013
		ON Cu.CustomerName = t2013.CustomerName
				LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Sum2014
					FROM Sales.Customers AS Cu
					FULL JOIN Sales.Invoices AS Iv
					ON Cu.CustomerID = Iv.CustomerID
					JOIN Sales.InvoiceLines as IL
					ON Iv.InvoiceID = IL.InvoiceID
					WHERE 2014 = YEAR(Iv.InvoiceDate)
					GROUP BY Cu.CustomerName) AS t2014
		ON Cu.CustomerName = t2014.CustomerName
				LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Sum2015
					FROM Sales.Customers AS Cu
					FULL JOIN Sales.Invoices AS Iv
					ON Cu.CustomerID = Iv.CustomerID
					JOIN Sales.InvoiceLines as IL
					ON Iv.InvoiceID = IL.InvoiceID
					WHERE 2015 = YEAR(Iv.InvoiceDate)
					GROUP BY Cu.CustomerName) AS t2015
		ON Cu.CustomerName = t2015.CustomerName
				LEFT JOIN (	SELECT Cu.CustomerName, SUM(IL.Quantity*IL.UnitPrice) AS Sum2016
					FROM Sales.Customers AS Cu
					FULL JOIN Sales.Invoices AS Iv
					ON Cu.CustomerID = Iv.CustomerID
					JOIN Sales.InvoiceLines as IL
					ON Iv.InvoiceID = IL.InvoiceID
					WHERE 2016 = YEAR(Iv.InvoiceDate)
					GROUP BY Cu.CustomerName) AS t2016
		ON Cu.CustomerName = t2016.CustomerName
		ORDER BY CustomerName
GO

EXEC dbo.ReportCustomerTurnover 1, 2014;
GO
