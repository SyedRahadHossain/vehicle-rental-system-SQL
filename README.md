# Vehicle Rental System - Database Design & SQL

This repository contains the database design and SQL implementation for a **Vehicle Rental System**. The project demonstrates efficient schema design, the use of custom PostgreSQL types (ENUMs), and complex SQL querying.

---

## 📊 Entity Relationship Diagram (ERD)

The system is designed with a relational structure to ensure data integrity and scalability.

### Key Relationships:

- **Users to Bookings:** One-to-Many (A user can have multiple rental records).
- **Vehicles to Bookings:** One-to-Many (A vehicle can be part of multiple historical bookings).

**ERD Tool Link:** [View on DrawSQL](https://drawsql.app/teams/syed-hosssain/diagrams/vehicle-rental-system)

---

## 🛠️ Database Schema Implementation

### 1. Custom Types (ENUMs)

We use `ENUM` types to restrict inputs to valid business categories, improving performance and data safety.

- **user_role:** `Admin`, `Customer`
- **vehicle_type:** `car`, `bike`, `truck`
- **vehicle_status:** `available`, `rented`, `maintenance`
- **booking_status:** `pending`, `confirmed`, `completed`, `cancelled`

### 2. Table Structures

- **Users:** Manages authentication and user roles.
- **Vehicles:** Tracks inventory, registration details, and rental pricing.
- **Bookings:** Records the link between users and vehicles, including dates and total costs.

---

## 🔍 SQL Queries

The `queries.sql` file provides the full implementation, including:

1. **Table Creation:** Schema setup with primary/foreign keys and constraints.
2. **Data Seeding:** Realistic dummy data to populate the system.
3. **Logic Queries:**
   - **Join Operations:** Fetching customer names alongside their vehicle rentals.
   - **Filtering:** Identifying available cars for customers.
   - **Subqueries/Exists:** Finding vehicles that have never been utilized.
   - **Aggregations:** Grouping data to find high-demand vehicles.

---

---

## 🚀 How to Use

1. Clone this repository.
2. Run the code in `queries.sql` within your PostgreSQL environment.
3. Use the provided test queries to verify the database relationships.
