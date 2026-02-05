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
email TEXT,
opening_hours TEXT,
CHECK(email LIKE '%@%'));

CREATE TABLE members
(member_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT,
phone_number VARCHAR(20),
date_of_birth DATE,
join_date DATE,
emergency_contact_name TEXT,
emergency_contact_phone VARCHAR(20),
CHECK (email LIKE '%@%')
);

CREATE TABLE staff
(staff_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT,
phone_number VARCHAR(20),
position TEXT,
hire_date DATE,
location_id INTEGER,
CHECK (email LIKE '%@%'),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE equipment 
(equipment_id INTEGER PRIMARY KEY,
name TEXT,
type TEXT,
purchase_date DATE,
last_maintenance_date DATE,
next_maintenance_date DATE,
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE classes 
(class_id INTEGER PRIMARY KEY,
name TEXT,
description TEXT,
capacity INTEGER,
duration INTEGER CHECK (duration > 0),
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_schedule
(schedule_id INTEGER PRIMARY KEY,
class_id INTEGER,
staff_id INTEGER,
start_time DATETIME,
end_time DATETIME,
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE memberships
(membership_id INTEGER PRIMARY KEY,
member_id INTEGER NOT NULL,
type TEXT NOT NULL,
start_date DATE NOT NULL,
end_date DATE,
status TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE attendance
(attendance_id INTEGER PRIMARY KEY,
member_id INTEGER,
location_id INTEGER,
check_in_time DATETIME,
check_out_time DATETIME,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_attendance
(class_attendance_id INTEGER PRIMARY KEY,
schedule_id INTEGER,
member_id INTEGER,
attendance_status TEXT,
FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE payments
(payment_id INTEGER PRIMARY KEY,
member_id INTEGER,
amount REAL,
payment_date DATETIME,
payment_method TEXT,
payment_type TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions
(session_id INTEGER PRIMARY KEY,
member_id INTEGER,
staff_id INTEGER,
session_date DATE,
start_time DATETIME,
end_time DATETIME,
notes TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics
(metric_id INTEGER PRIMARY KEY,
member_id INTEGER,
measurement_date DATE,
weight REAL,
body_fat_percentage REAL,
muscle_mass REAL,
bmi REAL,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE equipment_maintenance_log
(log_id INTEGER PRIMARY KEY,
equipment_id INTEGER,
maintenance_date DATE,
description TEXT,
staff_id INTEGER,
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);