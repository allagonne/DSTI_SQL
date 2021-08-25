USE SQLPlayground
SELECT CustomerId, CustomerName
FROM (
	SELECT Cu.CustomerId, Cu.CustomerName, SUM(Qty) AS SumQty
	FROM Customer AS Cu
	JOIN Purchase AS Pu
	On Cu.CustomerId = Pu.CustomerId
	GROUP BY Cu.CustomerId, Cu.CustomerName
	) AS SQT
WHERE SQT.SumQty > 50
AND CustomerId IN
(SELECT CustomerId
FROM (
	SELECT CustomerId, COUNT(ProductId) AS NumOfProductsPurchased
	FROM Purchase as Pu
	GROUP BY CustomerId) AS NumPr
WHERE NumPr.NumOfProductsPurchased = (SELECT COUNT(*)
			FROM Product)
)



/*SumQty 
*/
