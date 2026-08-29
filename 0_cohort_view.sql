CREATE VIEW cohort_analysis AS 
WITH customer_revenue AS (	
	SELECT
		s.customerkey,
		s.orderdate,
		SUM(s.quantity * s.netprice * s.exchangerate) AS total_revenue,
		COUNT(s.orderkey ) AS num_orders,
		c.countryfull,
		c.age,
		c.givenname,
		c.surname 
	FROM 
		sales s
	LEFT JOIN customer c ON c.customerkey = s.customerkey 
	GROUP BY
		c.countryfull,
		c.age,
		c.givenname,
		c.surname,
		s.customerkey,
		s.orderdate
)

SELECT 
	cr.*,
	MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey) AS first_purchase_date,
	EXTRACT(YEAR FROM MIN(cr.orderdate) OVER(PARTITION BY cr.customerkey)) AS cohort_year
FROM 
	customer_revenue cr