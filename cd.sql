-- 1. Retrieve everything from a table
SELECT * FROM cd.facilities;

-- 2. Retrieve specific columns from a table
SELECT name, membercost FROM cd.facilities;

-- 3. Control which rows are retrieved
SELECT name, membercost FROM cd.facilities WHERE membercost > 0;

-- 4. Control which rows are retrieved (part 2)
SELECT facid, name, membercost, monthlymaintenance FROM cd.facilities WHERE membercost > 0 AND membercost < monthlymaintenance/50;

-- 5. Basic string searches
SELECT name FROM cd.facilities WHERE name LIKE '%Tennis%';

-- 6. Matching against multiple possible values
SELECT * FROM cd.facilities WHERE facid IN (1, 5);

-- 7. Classify results into buckets
-- Searched CASE: full boolean conditions
SELECT
    name,
    CASE
        WHEN monthlymaintenance > 100 THEN 'expensive'
        ELSE 'cheap'
    END AS cost
FROM cd.facilities;

--8. Working with dates
SELECT * from cd.members WHERE joindate >= '2012-01-01 00:00:00'
