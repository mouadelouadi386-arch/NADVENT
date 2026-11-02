CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL,
password_hash VARCHAR(255) NOT NULL,
role ENUM('ADMIN','ORGANIZER','PARTICIPANT') NOT NULL DEFAULT 'PARTICIPANT',
is_active TINYINT(1) DEFAULT 1,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE events (
id INT AUTO_INCREMENT PRIMARY KEY,
organizer_id INT NOT NULL,
title VARCHAR(150) NOT NULL,
description TEXT,
image VARCHAR(255),
location VARCHAR(255),
start_date DATETIME NOT NULL,
end_date DATETIME NOT NULL,
max_capacity INT NOT NULL,
price DECIMAL(10,2) NOT NULL DEFAULT 0,
currency VARCHAR(5) DEFAULT 'MAD',
registration_start DATETIME,
registration_deadline DATETIME,
status ENUM('DRAFT','PUBLISHED','CANCELLED','COMPLETED') DEFAULT 'DRAFT',
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (organizer_id) REFERENCES users(id)
);
CREATE TABLE partners (
id INT AUTO_INCREMENT PRIMARY KEY,
organizer_id INT NOT NULL,
name VARCHAR(150) NOT NULL,
description TEXT,
email VARCHAR(150),
phone VARCHAR(30),
website VARCHAR(255),
logo VARCHAR(255),
partnership_type VARCHAR(100),
FOREIGN KEY (organizer_id) REFERENCES users(id)
);
CREATE TABLE event_partner (
event_id INT NOT NULL,
partner_id INT NOT NULL,
PRIMARY KEY (event_id, partner_id),
FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
FOREIGN KEY (partner_id) REFERENCES partners(id) ON DELETE CASCADE
);
CREATE TABLE registrations (
id INT AUTO_INCREMENT PRIMARY KEY,
event_id INT NOT NULL,
participant_id INT NOT NULL,
status ENUM('PENDING','CONFIRMED','CANCELLED','EXPIRED','REFUND_PENDING','REFUNDED')
DEFAULT 'PENDING',
amount_due DECIMAL(10,2) NOT NULL,
reserved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
expires_at DATETIME,
confirmed_at DATETIME,
FOREIGN KEY (event_id) REFERENCES events(id),
FOREIGN KEY (participant_id) REFERENCES users(id),
UNIQUE KEY unique_active_registration (event_id, participant_id) -- appuie RG03
);