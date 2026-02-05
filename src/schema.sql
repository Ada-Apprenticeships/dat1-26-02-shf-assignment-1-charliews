.open fittrackpro.db
.mode box

DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

PRAGMA foreign_keys = ON;

CREATE TABLE locations
(location_id INTEGER PRIMARY KEY,
name TEXT NOT NULL,
address TEXT NOT NULL,
phone_number VARCHAR(20),
CHECK (email LIKE '%@%'),
opening_hours TEXT);

CREATE TABLE members
(member_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
CHECK (email LIKE'%@%'),
phone_number VARCHAR(20),
date_of_birth,
join_date,
emergency_contact_name TEXT,
emergency_contact_phone TEXT
);

CREATE TABLE staff
(staff_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
CHECK (email LIKE'%@%'),
phone_number VARCHAR(20),
position TEXT,
hire_date DATE,
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE equipment 
(equipment_id INTEGER PRIMARY KEY,
name TEXT,
type TEXT,
purchase_date DATE,
last_maintenance_date DATE,
next_maintenance_date DATE,
location_id INTEGER,
FOREIGN KEY (lcoation_id) REFERENCES location(location_id)
);

CREATE TABLE classes 
(class_id INTEGER PRIMARY KEY,
name TEXT,
description TEXT,
capacity TEXT,
duration INTEGER,
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES location(location_id)
);

CREATE TABLE class_schedule
(schedule_id PRIMARY KEY,
class_id INTEGER,
staff_id INTEGER,
start_time INTEGER,
end_time TEXT
);

CREATE TABLE membership
(membership_id PK,
member_id FK,
type,
start_date,
end_date,
status
);

CREATE TABLE attendance
(attendance_id PK,
member_id FK,
location_id FK,
check_in_time,
check_out_time
);

CREATE TABLE class_attendance
(attendance_id PK,
member_id FK,
location_id FK,
check_in_time,
check_out_time
);

CREATE TABLE payments
(payment_id PK,
member_id FK,
amount,
payment_date,
payment_method,
description
);

CREATE TABLE personal_training_sessions
(session_id PK,
member_id FK,
staff_id FK,
session_date,
start_time,
end_time,
notes
);

CREATE TABLE member_health_metrics
(metric_id PK,
member_id FK,
measurement_date,
weight,
body_fat_percentage,
muscle_mass,
bmi
);

CREATE TABLE equipment_maintenance_log
(log_id PK,
equipment_id FK,
maintenance_date,
description,
staff_id FK
);

--pragma keys, create tables, drop tables  