-- 1. There are 2 foreign key constraints in the bookings table, 
-- fk_bookings_facid comes from the facility table and fk_bookings_memid comes from the members table.
-- 2. As such, there is a many-to-many relationship between the facility and members tables, where the bookings table acts as a junction table.
-- 3. When a column in a table points back to the same table, it is called a self-referencing relationship.

