SELECT 
	ca.cohort_year,
	COUNT(DISTINCT ca.customerkey ) AS total_customers,
	SUM(ca.total_revenue ) AS total_net_revenue,
	SUM(ca.total_revenue ) / COUNT(DISTINCT ca.customerkey ) AS customer_revenue
FROM 
 	cohort_analysis ca 
WHERE orderdate = ca.first_purchase_date 
GROUP BY 
 	ca.cohort_year 