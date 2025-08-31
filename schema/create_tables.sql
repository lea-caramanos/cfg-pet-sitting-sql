-- ============================ --
-- Create the animal_type table --
-- ============================ --

CREATE TABLE animal_type (
animal_type_id INT UNSIGNED,
animal_type_name VARCHAR(50) NOT NULL,
PRIMARY KEY (animal_type_id));

-- ====================== --
-- Create the breed table --
-- ====================== --

CREATE TABLE breed (
breed_id INT UNSIGNED,
breed_name VARCHAR(50) NOT NULL,
breed_size ENUM('S', 'M', 'L', 'XL'),
animal_type_id INT UNSIGNED,
PRIMARY KEY (breed_id),
FOREIGN KEY (animal_type_id) REFERENCES animal_type(animal_type_id)); 

-- ====================== --
-- Create the owner table --
-- ====================== --

CREATE TABLE owner (
owner_id INT UNSIGNED,
first_name VARCHAR(50),
last_name VARCHAR(50) NOT NULL,
phone_number VARCHAR(50),
PRIMARY KEY(owner_id));

-- ============================== --
-- Create the owner_address table --
-- ============================== --

CREATE TABLE owner_address (
owner_address_id INT UNSIGNED,
owner_id INT UNSIGNED,
house_number INT UNSIGNED,
house_name VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50) NOT NULL,
postcode VARCHAR(8) NOT NULL,
PRIMARY KEY(owner_address_id),
FOREIGN KEY (owner_id) REFERENCES owner(owner_id));

-- ==================== --
-- Create the pet table --
-- ==================== --

CREATE TABLE pet (
pet_id INT UNSIGNED,
pet_name VARCHAR(50) NOT NULL,
breed_id INT UNSIGNED,
gender ENUM('male', 'female'),
PRIMARY KEY(pet_id),
FOREIGN KEY (breed_id) REFERENCES breed(breed_id));

-- ============================= --
-- Create the booking type table --
-- ============================= --

CREATE TABLE booking_type (
booking_type_id INT UNSIGNED,
booking_type_name VARCHAR(50) NOT NULL,
price_hourly DECIMAL(4,2),
PRIMARY KEY(booking_type_id));

-- ======================== --
-- Create the booking table --
-- ======================== --

CREATE TABLE booking (
booking_id INT UNSIGNED,
start_datetime datetime NOT NULL,
end_datetime datetime NOT NULL,
booking_type_id INT UNSIGNED,
paid ENUM('YES', 'NO') DEFAULT 'NO',
notes VARCHAR(500),
PRIMARY KEY(booking_id),
FOREIGN KEY (booking_type_id) REFERENCES booking_type(booking_type_id));

-- =============================== --
-- Create the pet_owner_link table --
-- =============================== --

CREATE TABLE pet_owner_link (
pet_owner_link_id INT UNSIGNED,
pet_id INT UNSIGNED,
owner_id INT UNSIGNED,
PRIMARY KEY (pet_owner_link_id),
FOREIGN KEY (pet_id) REFERENCES pet(pet_id),
FOREIGN KEY (owner_id) REFERENCES owner(owner_id)
);

-- ================================= --
-- Create the booking_pet_link table --
-- ================================= --

CREATE TABLE booking_pet_link (
booking_pet_link_id INT UNSIGNED,
booking_id INT UNSIGNED,
pet_id INT UNSIGNED,
PRIMARY KEY (booking_pet_link_id),
FOREIGN KEY (pet_id) REFERENCES pet(pet_id),
FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);
