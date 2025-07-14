GO


-- **SECTION A** --

-- DEMO A1 -- 
-- Use this query to select all the rows from the superhero table
SELECT * FROM superhero;

-- Use this query to select certain columns from the superhero table
SELECT superhero_name, full_name, height_cm, weight_kg FROM superhero

-- DEMO A2 -- 
-- Use this query to display each recorded height of each superhero without any duplicates
-- from the superhero table
SELECT DISTINCT height_cm FROM superhero;

-- DEMO A3 --
-- Use this query to select the column 'superhero_name' as 'KnownAs' and the column 'full_name' as 'LegalName' from the table 'superhero'
-- This changes the column name and changes it to an alias as stated above
SELECT 
superhero_name AS KnownAs, full_name AS LegalName
FROM superhero;

-- DEMO A4 -- 
-- Use this query to select the superhero name and their legal name from the superhero table but where the superhero
-- does not have a legal name as it is set to NULL or a '-', set it as "No Legal Name"
SELECT 
superhero_name,
CASE 
	WHEN full_name IS NULL THEN 'No Legal Name'
	WHEN full_name = '-' THEN 'No Legal Name'
	ELSE full_name
END AS full_name
FROM superhero;

-- DEMO A5 --

-- **SECTION B** --

-- DEMO B1 --
 -- gender_id is the common key used to link these two tables
SELECT * FROM superhero
SELECT * FROM gender

-- This query links the two tables, superhero and gender to create a new table 
-- that displays the superhero name, their legal name and the gender of the super hero
SELECT s.superhero_name, s.full_name, g.gender
FROM dbo.superhero AS s JOIN dbo.gender AS g ON s.gender_id = g.id;

-- DEMO B2 -- 
-- This query selects all superheroes who have an alignment matching between the 
-- tables 'superhero' and 'alignment' It only shows matches and does not show
-- fields that have a null value for alignment
SELECT s.superhero_name, s.full_name, a.alignment
FROM dbo.superhero AS s INNER JOIN dbo.alignment AS a ON s.alignment_id = a.id;

-- DEMO B3 -- 
-- This query will join the two tables 'superhero' and 'alignment' and will show
-- if a superhero does not have an allignment by having NULL as the value in the 
-- alignment column
SELECT s.superhero_name, s.full_name, a.alignment
FROM dbo.superhero AS s FULL OUTER JOIN dbo.alignment AS a ON s.alignment_id = a.id;

-- **SECTION C** -- 

-- DEMO C1 -- 
-- Task: Sort Data by alphabetical order 
-- Sorted data by alignment in alphabetical order
SELECT s.superhero_name, s.full_name, a.alignment
FROM dbo.superhero AS s INNER JOIN dbo.alignment AS a ON s.alignment_id = a.id 
ORDER BY a.alignment;

-- Task: Sort Data by alphabetical order 
-- Sorted data by alignment in alphabetical order descending
SELECT s.superhero_name, s.full_name, a.alignment
FROM dbo.superhero AS s INNER JOIN dbo.alignment AS a ON s.alignment_id = a.id 
ORDER BY a.alignment DESC;

-- DEMO C2 -- 
-- This query uses a predicate to find all the superhero rows that has
-- a superhero name starting with the letter 'a'
SELECT * 
FROM superhero
WHERE superhero_name LIKE 'a%';

--This query uses a predicate to find all the superhero rows that have a 
--weight greater than 120kg
SELECT * 
FROM superhero
WHERE weight_kg > 120;

-- DEMO C3 --
-- This query selects the top 5 heaviest super heroes from the 
-- superhero table and orders them as the first result being the 
-- heaviest to the last result being the 5th heaviest
SELECT TOP 5 * 
FROM superhero
ORDER BY weight_kg DESC;

-- This query offsets the first 5 rows of the results so that it
-- retrieves more realistic weights that can be used by larger
-- superheroes
SELECT * 
FROM superhero 
ORDER BY weight_kg DESC
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- DEMO C4 --
-- This query will select all rows from the superhero table 
-- where the super hero does not have a race assigned.
SELECT * 
FROM superhero
WHERE race_id IS NULL;

-- This query will select all rows from the superhero table 
-- where the super heroes do have a race assigned to them
SELECT * 
FROM superhero
WHERE race_id IS NOT NULL;

-- DEMO D1 -- 

-- This query will convert any date string inputted in the
-- second argument to the datatime data type
SELECT CONVERT(datetime, '01/05/2025');

-- This query will change the inputted number as a float 
-- to a string
SELECT CONVERT(varchar, 62.3) AS [Converted Data];

-- ** SECTION E ** --

-- DEMO E1 --

-- This query adds a new row to the alignment table so that some super-heroes 
-- can be classed as anti-heroes
INSERT INTO alignment(id, alignment) 
VALUES('5', 'Anti Hero');

-- This query adds a new super hero called killmonger to the table 
INSERT INTO superhero (id, superhero_name, full_name, gender_id, eye_colour_id, hair_colour_id, skin_colour_id, race_id, publisher_id, alignment_id, height_cm, weight_kg)
VALUES(757, 'Killmonger', 'Erik Killmonger', 1, NULL, NULL, NULL, NULL, 13, 5, 180, 75);


-- DEMO E2 --
-- This query edits the fields eye_colour_id and race_id for killmonger 
-- in the superhero table
UPDATE superhero
SET eye_colour_id = 3, race_id = 24
WHERE superhero_name = 'Killmonger';

-- This query removes the row from the superhero table that contains the superhero_name
-- killmonger
DELETE
FROM superhero
WHERE superhero_name = 'Killmonger';

-- DEMO E3 --
-- THis query will select the movie released on the date specified
SELECT * 
FROM movie_releases 
WHERE movie_release = '2008-07-18'

-- This query will return all movies that were released in 2008
-- from the movie_releases table
SELECT * 
FROM movie_releases
WHERE YEAR(movie_release) = 2008;

-- This query will show me all the movies that were released 
-- after 2009
SELECT *
FROM movie_releases 
WHERE YEAR(movie_release) > 2009

-- This query will show me all movies that have been released
-- between 2012 and 2018 from the movie_releases table
SELECT * 
FROM movie_releases
WHERE YEAR(movie_release) BETWEEN '2012' AND '2018';

-- **SECTION F** --

-- DEMO F1 --

-- Using the built in functions this statement returns the select 
-- statement as upper case 
-- lower case
-- Reversed string
-- Unicode Value
SELECT UPPER(full_name) AS [Full Name Uppercase],
LOWER(full_name) AS [Full Name Lowercase],
REVERSE(full_name) AS [Reversed Full Name],
UNICODE(full_name) AS [Unicode]
FROM superhero

-- DEMO F2 -- 

-- This query will convert any inputted string of a date 
-- into the datetime datatype
SELECT CONVERT(datetime, '2025-02-01')

-- The TRY_CONVERT function is a fail safe function
-- that will output a NULL value if the conversion is
-- not possible
SELECT TRY_CONVERT(datetime, 'This is a test')


-- DEMO F3 --
-- This query selects all super hereos that are not aligned to the 
-- hero faction
SELECT * 
FROM superhero
WHERE alignment_id != 1;

-- This query will tell the database engineer whether or not 
-- a value in the table is numerical or not using the 
-- ISNUMERIC logical function
SELECT ISNUMERIC(superhero_name) 
FROM superhero 
WHERE id = 5;

-- This query will filter through all the super heroes in the 
-- superhero table and will return a column that checks if the 
-- hero is heavy or light weight
SELECT superhero_name, weight_kg, IIF(weight_kg > 150, 'Heavy', 'Light') 
	AS weight_class
FROM superhero;

-- DEMO F4 --
-- This query uses the function ISNULL to filter data and
-- replace any NULL full names with 'No Full Name'
SELECT superhero_name, ISNULL(full_name, 'No Full Name') 
FROM superhero

-- This query will return NULL for height_cm and weight_kg
-- if the values in those columns are 0
SELECT superhero_name, full_name, NULLIF(height_cm, 0) AS height_cm_new, NULLIF(weight_kg, 0) AS weight_kg_new
FROM superhero;


-- DEMO G1 --
-- This query counts how many super heroes are assigned to 
-- each gender
SELECT COUNT(id) AS [Hero Count], gender_id
FROM superhero
GROUP BY gender_id;

-- DEMO G2 -- 
-- This query selects the eye colour where the 
-- amount of heroes with said I colour is greater 
-- than 5
SELECT COUNT(id) AS [Hero Count], eye_colour_id
FROM superhero 
GROUP BY eye_colour_id
HAVING COUNT(id) > 5;
