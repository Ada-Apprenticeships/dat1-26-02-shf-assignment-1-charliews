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
phone_number VARCHAR(20)
CHECK (phone_number GLOB '[0-9]*'),
email TEXT
CHECK(email LIKE '%@%'),
opening_hours TEXT
CHECK (opening_hours GLOB '[0-2][0-9]:[0-5][0-9]-[0-2][0-9]:[0-5][0-9]')
);

CREATE TABLE members
(member_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT
CHECK (email LIKE '%@%'),
phone_number VARCHAR(20)
CHECK (phone_number GLOB '[0-9]*'),
date_of_birth TEXT
CHECK (date_of_birth GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
join_date TEXT
CHECK (join_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
emergency_contact_name TEXT,
emergency_contact_phone VARCHAR(20)
CHECK (emergency_contact_phone GLOB '[0-9]*')
);

CREATE TABLE staff
(staff_id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT
CHECK (email LIKE '%@%'),
phone_number VARCHAR(20)
CHECK (phone_number GLOB '[0-9]*'),
position TEXT,
hire_date TEXT
CHECK (hire_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE equipment 
(equipment_id INTEGER PRIMARY KEY,
name TEXT,
type TEXT,
purchase_date TEXT
CHECK (purchase_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
last_maintenance_date TEXT
CHECK (last_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
next_maintenance_date TEXT
CHECK (next_maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE classes 
(class_id INTEGER PRIMARY KEY,
name TEXT,
description TEXT,
capacity INTEGER CHECK (capacity > 0),
duration INTEGER CHECK (duration > 0),
location_id INTEGER,
FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE class_schedule
(schedule_id INTEGER PRIMARY KEY,
class_id INTEGER,
staff_id INTEGER,
start_time TEXT
CHECK (start_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
end_time TEXT
CHECK (end_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE memberships
(membership_id INTEGER PRIMARY KEY,
member_id INTEGER NOT NULL,
type TEXT NOT NULL,
start_date DATE TEXT
CHECK (start_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
end_date TEXT
CHECK (end_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
status TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE attendance
(attendance_id INTEGER PRIMARY KEY,
member_id INTEGER,
location_id INTEGER,
check_in_time TEXT
CHECK (check_in_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
check_out_time TEXT
CHECK (check_out_time GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
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
amount REAL
CHECK (amount >= 0),
payment_date TEXT
CHECK (payment_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
payment_method TEXT,
payment_type TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE personal_training_sessions
(session_id INTEGER PRIMARY KEY,
member_id INTEGER,
staff_id INTEGER,
session_date TEXT
CHECK (session_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
start_time TEXT
CHECK (start_time GLOB '[0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
end_time TEXT
CHECK (end_time GLOB '[0-2][0-9]:[0-5][0-9]:[0-5][0-9]'),
notes TEXT,
FOREIGN KEY (member_id) REFERENCES members(member_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE member_health_metrics
(metric_id INTEGER PRIMARY KEY,
member_id INTEGER,
measurement_date TEXT
CHECK (measurement_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
weight REAL,
body_fat_percentage REAL,
muscle_mass REAL,
bmi REAL,
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE equipment_maintenance_log
(log_id INTEGER PRIMARY KEY,
equipment_id INTEGER,
maintenance_date TEXT
CHECK (maintenance_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
description TEXT,
staff_id INTEGER,
FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);