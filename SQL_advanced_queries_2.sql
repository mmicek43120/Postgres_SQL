--------------------------------------------------------------------------------
/*				                 Query 8            		  		          */
--------------------------------------------------------------------------------
SELECT dept_name 
FROM department
INTERSECT 
SELECT dept_name
FROM instructor
ORDER BY dept_name;
--------------------------------------------------------------------------------
/*				                  Query 9           		  		          */
--------------------------------------------------------------------------------

SELECT course_id
FROM course
EXCEPT
SELECT course_id
FROM prereq
ORDER BY course_id;

--------------------------------------------------------------------------------
/*				                  Query 10           		  		          */
--------------------------------------------------------------------------------

SELECT dept_name 
FROM department
WHERE budget < 50000
UNION
SELECT dept_name
FROM instructor
WHERE salary > 100000
UNION
SELECT dept_name
FROM student
WHERE tot_cred =
	(SELECT MAX(tot_cred)
	FROM student)
ORDER BY dept_name;



   
--------------------------------------------------------------------------------
/*				                  Query 11           		  		          */
--------------------------------------------------------------------------------
SELECT c1.course_id, c1.title AS course_name, p.prereq_id, c2.title AS prereq_name FROM course c1
FULL OUTER JOIN course c2 ON c1.course_id = c2.course_id
RIGHT JOIN prereq p ON c1.course_id = p.course_id;

--------------------------------------------------------------------------------
/*				                  Query 12           		  		          */
--------------------------------------------------------------------------------

    
SELECT s.id FROM student s
LEFT JOIN takes t ON s.id = t.id 
	WHERE t.id IS NULL;


  