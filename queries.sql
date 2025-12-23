-- Create Custom ENUM Types
CREATE TYPE user_role AS ENUM ('Admin', 'Customer');

CREATE TYPE vehicle_type AS ENUM ('car', 'bike', 'truck');

CREATE TYPE vehicle_status AS ENUM ('available', 'rented', 'maintenance');

CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'completed', 'cancelled');

-- 1. Users Table
CREATE TABLE
    users (
        user_id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(100) NOT NULL,
        phone_number VARCHAR(20) NOT NULL,
        role user_role NOT NULL
    );

-- 2. Vehicles Table
CREATE TABLE
    vehicles (
        vehicle_id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        type vehicle_type NOT NULL,
        model VARCHAR(50) NOT NULL,
        registration_number VARCHAR(50) UNIQUE NOT NULL,
        rental_price DECIMAL(8, 2),
        status vehicle_status DEFAULT 'available'
    );

-- 3. Bookings Table
CREATE TABLE
    bookings (
        booking_id SERIAL PRIMARY KEY,
        user_id INT REFERENCES users (user_id) ON DELETE CASCADE,
        vehicle_id INT REFERENCES vehicles (vehicle_id) ON DELETE CASCADE,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        status booking_status DEFAULT 'pending',
        total_cost DECIMAL(8, 2)
    );

-- INSERTING DATA
INSERT INTO
    users (name, email, password, phone_number, role)
VALUES
    (
        'Syed Hossain',
        'syed@gmail.com',
        'hashed_pass_1',
        '01711111111',
        'Admin'
    ),
    (
        'John Doe',
        'john@yahoo.com',
        'hashed_pass_2',
        '01822222222',
        'Customer'
    ),
    (
        'Jane Smith',
        'jane@outlook.com',
        'hashed_pass_3',
        '01933333333',
        'Customer'
    ),
    (
        'Michael Ross',
        'mike@gmail.com',
        'hashed_pass_4',
        '01644444444',
        'Customer'
    );

INSERT INTO
    vehicles (
        name,
        type,
        model,
        registration_number,
        rental_price_per_day,
        status
    )
VALUES
    (
        'Toyota Camry',
        'car',
        '2023',
        'DHA-KA-1234',
        50.00,
        'available'
    ),
    (
        'Yamaha R15',
        'bike',
        '2022',
        'CHI-GA-5678',
        20.00,
        'available'
    ),
    (
        'Ford F-150',
        'truck',
        '2021',
        'DHA-METRO-9999',
        100.00,
        'rented'
    ),
    (
        'Audi A6',
        'car',
        '2024',
        'DHA-KA-4321',
        150.00,
        'maintenance'
    ),
    (
        'Honda Civic',
        'car',
        '2022',
        'DHA-KA-8888',
        60.00,
        'available'
    );

INSERT INTO
    bookings (
        user_id,
        vehicle_id,
        start_date,
        end_date,
        total_cost,
        status
    )
VALUES
    (
        2,
        1,
        '2025-01-01',
        '2025-01-03',
        100.00,
        'completed'
    ),
    (
        3,
        1,
        '2025-01-05',
        '2025-01-06',
        50.00,
        'confirmed'
    ),
    (
        2,
        1,
        '2025-01-10',
        '2025-01-12',
        100.00,
        'pending'
    ),
    (
        4,
        2,
        '2025-02-01',
        '2025-02-02',
        20.00,
        'completed'
    ),
    (
        2,
        3,
        '2025-02-05',
        '2025-02-10',
        500.00,
        'confirmed'
    );

-- QUERY
-- 1
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

-- 2
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

-- 3
SELECT
    *
FROM
    vehicles
WHERE
    status = 'available'
    AND type = 'car';

-- 4
SELECT
    vehicle_id,
    COUNT(booking_id) AS total_bookings
FROM
    bookings
GROUP BY
    vehicle_id
HAVING
    COUNT(booking_id) > 2;