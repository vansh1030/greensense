-- SQL Script to set up the database and tables for GreenSense Waste Management System

-- Create the database
CREATE DATABASE IF NOT EXISTS waste_management;
USE waste_management;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- This will store the hashed password
    role ENUM('admin', 'citizen') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create complaints table
CREATE TABLE IF NOT EXISTS complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    citizen_id INT NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(100),
    image_path VARCHAR(500),
    latitude DOUBLE,
    longitude DOUBLE,
    status ENUM('unresolved', 'in_progress', 'resolved') DEFAULT 'unresolved',
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (citizen_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Update existing 'submitted' status to 'unresolved' for migration
UPDATE complaints SET status = 'unresolved' WHERE status = 'submitted';

-- Create updates table
CREATE TABLE IF NOT EXISTS updates (
    update_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    created_by_admin_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by_admin_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create collaborations table
CREATE TABLE IF NOT EXISTS collaborations (
    collaboration_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    contact_info VARCHAR(255),
    posted_by_admin_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (posted_by_admin_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create truck_routes table
CREATE TABLE IF NOT EXISTS truck_routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    truck_id INT NOT NULL,
    source_location VARCHAR(255) NOT NULL,
    destination_location VARCHAR(255) NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP,
    status ENUM('scheduled', 'in_transit', 'completed') DEFAULT 'scheduled'
);

-- Create truck_locations table
CREATE TABLE IF NOT EXISTS truck_locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    truck_id INT NOT NULL,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample admin user (password is hashed using BCrypt)
-- Password for admin is 'admin123' (hashed)
INSERT INTO users (full_name, email, password, role) VALUES
('Admin User', 'admin@greensense.com', '$2a$10$J7HQR9/yo3hMGVno9NXYJOZkjGIaFgR4Oulj9A93FjPIHmS8ymUc6', 'admin');

-- Insert sample citizen user (password is 'citizen123' hashed)
INSERT INTO users (full_name, email, password, role) VALUES
('John Citizen', 'john@example.com', '$2a$10$LfGIUhyc0l3UPeCTvIDEfuBwwQfXv6cDMGjGh6QeZ80qpjzC4Mkl2', 'citizen');

-- Insert sample complaints
INSERT INTO complaints (citizen_id, description, category, latitude, longitude, status) VALUES
(2, 'Garbage not collected for 3 days', 'Waste Collection', 28.6139, 77.2090, 'unresolved'),
(2, 'Illegal dumping near park', 'Illegal Dumping', 28.7041, 77.1025, 'in_progress');

-- Insert sample updates
INSERT INTO updates (title, content, created_by_admin_id) VALUES
('New Recycling Program', 'We are launching a new recycling program starting next month.', 1),
('Truck Maintenance Schedule', 'All waste collection trucks will undergo maintenance this weekend.', 1);

-- Insert sample collaborations
INSERT INTO collaborations (title, description, contact_info, posted_by_admin_id) VALUES
('Community Clean-Up Drive', 'Join us for a community clean-up drive this Saturday.', 'contact@greensense.com', 1),
('Environmental Awareness Workshop', 'Learn about sustainable waste management practices.', 'workshops@greensense.com', 1);

-- Insert sample truck routes
INSERT INTO truck_routes (truck_id, source_location, destination_location, departure_time, arrival_time, status) VALUES
(1, 'Municipal Depot', 'Sector 15', '2024-10-15 08:00:00', '2024-10-15 10:00:00', 'completed'),
(2, 'Municipal Depot', 'Sector 20', '2024-10-15 09:00:00', NULL, 'in_transit');

-- Insert sample truck locations
INSERT INTO truck_locations (truck_id, latitude, longitude) VALUES
(1, 28.6139, 77.2090),
(2, 28.7041, 77.1025);

-- Create indexes for better performance
CREATE INDEX idx_complaints_status ON complaints(status);
CREATE INDEX idx_complaints_citizen_id ON complaints(citizen_id);
CREATE INDEX idx_updates_created_at ON updates(created_at);
CREATE INDEX idx_collaborations_created_at ON collaborations(created_at);
CREATE INDEX idx_truck_routes_departure_time ON truck_routes(departure_time);
CREATE INDEX idx_truck_locations_truck_id ON truck_locations(truck_id);
