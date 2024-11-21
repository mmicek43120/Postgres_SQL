--------------------------------------------------------------------------------
/*				                 Query 1            		  		          */
--------------------------------------------------------------------------------
SELECT b.cust_id, d.account_number,b.loan_number
	FROM borrower b
	INNER JOIN depositor d 
	ON b.cust_id = d.cust_id;

--------------------------------------------------------------------------------
/*				                  Query 2           		  		          */
--------------------------------------------------------------------------------

SELECT c.cust_id, c.customer_city, b.branch_city, b.branch_name, a.account_number
FROM customer c
FULL OUTER JOIN depositor d
ON c.cust_id = d.cust_id
FULL OUTER JOIN account a
ON d.account_number = a.account_number
FULL OUTER JOIN branch b
ON a.branch_name = b.branch_name
		WHERE branch_city = customer_city;



--------------------------------------------------------------------------------
/*				                  Query 3           		  		          */
--------------------------------------------------------------------------------


SELECT c.cust_id, c.customer_name FROM customer c
	WHERE c.cust_id IN
		(SELECT cust_id FROM borrower b
		EXCEPT 
		SELECT cust_id FROM depositor d);
   
--------------------------------------------------------------------------------
/*				                  Query 4           		  		          */
--------------------------------------------------------------------------------


SELECT cust_id, customer_name FROM customer 
WHERE customer_street = (
	SELECT customer_street FROM customer WHERE cust_id='12345');


--------------------------------------------------------------------------------
/*				                  Query 5           		  		          */
--------------------------------------------------------------------------------


SELECT DISTINCT branch_name FROM account a
FULL OUTER JOIN depositor d
	ON a.account_number = d.account_number
INNER JOIN(
	SELECT c.cust_id
	FROM customer c
	WHERE c.customer_city = 'Harrison')
	AS cust ON d.cust_id = cust.cust_id;
	
	
   
--------------------------------------------------------------------------------
/*				                  Query 6           		  		          */
--------------------------------------------------------------------------------
SELECT c.cust_id,c.customer_name FROM customer c
FULL OUTER JOIN depositor d ON c.cust_id = d.cust_id
FULL OUTER JOIN account a ON d.account_number = a.account_number
FULL OUTER JOIN branch b ON a.branch_name = b.branch_name
GROUP BY c.cust_id,c.customer_name
HAVING COUNT(DISTINCT b.branch_name) = (
	SELECT COUNT(branch_city) FROM branch
	WHERE branch_city = 'Brooklyn'
);
--------------------------------------------------------------------------------
/*				                  Query 7           		  		          */
--------------------------------------------------------------------------------
SELECT l.loan_number, c.customer_name, l.branch_name FROM loan l
FULL OUTER JOIN borrower b ON l.loan_number = b.loan_number
FULL OUTER JOIN customer c ON b.cust_id = c.cust_id
WHERE l.branch_name = 'Yonkahs Bankahs' AND CAST(l.amount AS numeric(10,2)) >(
	SELECT AVG(CAST(l.amount AS numeric(10,2)))
	FROM loan l
	WHERE l.branch_name = 'Yonkahs Bankahs');