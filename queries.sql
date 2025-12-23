-- Query 1: JOIN
-- Retrieve booking information along with: Customer name, Vehicle name
-- Concepts used: INNER JOIN
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- Query 2: EXISTS
-- Find all vehicles that have never been booked.
-- Concepts used: NOT EXISTS
SELECT
    *
FROM
    vehicles v
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            bookings b
        WHERE
            b.vehicle_id = v.vehicle_id
    );

-- Query 3: WHERE
-- Retrieve all available vehicles of a specific type (e.g. cars).
-- Concepts used: SELECT, WHERE
SELECT
    *
FROM
    vehicles
WHERE
    status = 'available'
    AND type = 'car';

-- Query 4: GROUP BY and HAVING
-- Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
-- Concepts used: GROUP BY, HAVING, COUNT
SELECT
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    bookings b
    JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY
    v.name
HAVING
    COUNT(b.booking_id) > 2;