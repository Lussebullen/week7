-- 1. There are 2 foreign key constraints in the bookings table, 
-- fk_bookings_facid comes from the facility table and fk_bookings_memid comes from the members table.
-- 2. As such, there is a many-to-many relationship between the facility and members tables, where the bookings table acts as a junction table.
-- 3. When a column in a table points back to the same table, it is called a self-referencing relationship.

-- 1. Retrieve the start times of members' bookings
SELECT cd.bookings.starttime
FROM cd.members
JOIN cd.bookings ON cd.members.memid = cd.bookings.memid 
WHERE cd.members.firstname = 'David' AND cd.members.surname = 'Farrell';

-- 2. Work out the start times of bookings for tennis courts on the 21st of September 2012, and the name of the facility booked. Order the results by start time.
SELECT cd.bookings.starttime, cd.facilities.name
FROM cd.facilities
JOIN cd.bookings ON cd.facilities.facid = cd.bookings.facid
WHERE cd.facilities.name LIKE 'Tennis Court%' AND cd.bookings.starttime BETWEEN '2012-09-21 00:00:00' AND '2012-09-21 23:59:59'
ORDER BY cd.bookings.starttime;

-- 3. Produce a list of all members who have recommended another member. Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).
SELECT DISTINCT cd.members.firstname, cd.members.surname
FROM cd.members
JOIN cd.members AS referred_members ON cd.members.memid = referred_members.recommendedby
ORDER BY cd.members.surname, cd.members.firstname;

-- 4. Produce a list of all members, along with their recommender (if any)? Ensure that results are ordered by (surname, firstname).
SELECT cd.members.firstname, cd.members.surname, referred_members.firstname AS recommender_firstname, referred_members.surname AS recommender_surname
FROM cd.members
LEFT JOIN cd.members AS referred_members ON cd.members.recommendedby = referred_members.memid
ORDER BY cd.members.surname, cd.members.firstname;

-- 5. Produce a list of all members who have used a tennis court. 
--  Include in your output the name of the court, and the name of the member formatted as a single column. Ensure no duplicate data, and order by the member name followed by the facility name.
SELECT DISTINCT concat(cd.members.firstname, ' ', cd.members.surname) as member_name, cd.facilities.name as facility_name
FROM cd.members
JOIN cd.bookings ON cd.members.memid = cd.bookings.memid
JOIN cd.facilities ON cd.bookings.facid = cd.facilities.facid
WHERE cd.facilities.name LIKE 'Tennis Court%'
ORDER BY member_name, facility_name;

-- 6. Produce a list of costly bookings on the day of 2012-09-14 which will cost the member (or guest) more than $30
-- Remember that guests have different costs to members (the listed costs are per half-hour 'slot'), and the guest user is always ID 0.
-- Include in your output the name of the facility, the name of the member formatted as a single column, and the cost. 
-- Order by descending cost. 
SELECT cd.bookings.starttime, cd.facilities.name, concat(cd.members.firstname, ' ', cd.members.surname) as member_name,
CASE 
		WHEN cd.members.memid = 0 THEN 
            cd.bookings.slots*cd.facilities.guestcost
        ELSE cd.bookings.slots*cd.facilities.membercost
	END AS cost
FROM cd.members
JOIN cd.bookings ON cd.members.memid = cd.bookings.memid
JOIN cd.facilities ON cd.bookings.facid = cd.facilities.facid
WHERE cd.bookings.starttime BETWEEN '2012-09-14 00:00:00' AND '2012-09-14 23:59:59'
AND ((cd.members.memid != 0 AND cd.bookings.slots * cd.facilities.membercost > 30 ) or (cd.members.memid = 0 AND cd.bookings.slots * cd.facilities.guestcost > 30))
ORDER BY cost DESC;

-- 7-8. Too tricky!