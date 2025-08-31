-- ============================== --
-- Populate the animal_type table --
-- ============================== --

INSERT INTO animal_type (animal_type_id, animal_type_name)
VALUES
(1, 'Dog'),
(2, 'Cat');

-- ======================== --
-- Populate the breed table --
-- ======================== --

INSERT INTO breed (breed_id, breed_name, breed_size, animal_type_id)
VALUES
(1, 'Vizsla', 'L', 1),
(2, 'Golden Retriever', 'L', 1),
(3, 'Chihuahua', 'S', 1),
(4, 'French Bulldog', 'S', 1),
(5, 'Maltese', 'S',1),
(6, 'Whippet', 'M', 1),
(7, 'Greyhound', 'L', 1),
(8, 'Cavalier King Charles Spaniel', 'M', 1),
(9, 'Pomeranian', 'S', 1),
(10, 'Poodle', 'S', 1),
(11, 'Cockapoo', 'M', 1),
(12, 'Goldendoodle', 'L', 1),
(13, 'Siberian', 'S', 2), 
(14, 'British Shorthair', 'S', 2),
(15, 'Bengal', 'S', 2),
(16, 'Domestic Shorthair', 'S', 2),
(17, 'Mixed Dog', 'S', 1),
(18, 'Mixed Dog', 'M', 1),
(19, 'Mixed Dog', 'L', 1),
(20, 'Mixed Dog', 'XL', 1),
(21, 'Mixed Cat', 'S', 2);

-- ======================== --
-- Populate the owner table --
-- ======================== --

INSERT INTO owner (owner_id, first_name, last_name, phone_number)
VALUES
(1, 'Jess', 'Bridges', '079 4266 0649'),
(2, 'Simon', 'Jacobs', '079 4706 6017'),
(3, 'Marina', 'Baxter', '079 3376 5004'),
(4, 'Ellie', 'Gomez', '078 8523 6445'),
(5, 'Aleks', 'Gill', '079 0699 8020'),
(6, 'Graeme', 'Pacheco', '070 2963 4505'),
(7, 'Abby', 'Watkins', '078 8959 7719');

-- ================================ --
-- Populate the owner_address table --
-- ================================ --

INSERT INTO owner_address (owner_address_id, owner_id, house_number, house_name, street, city, postcode)
VALUES
(1, 1, 25, NULL, 'High Street', 'London', 'SE63 0UQ'),
(2, 2, 148, 'Queensway Court', 'Albert Road', 'London', 'EC60 5UD'),
(3, 3, 37, NULL, 'New Road', 'London', 'SE98 1CS'),
(4, 4, 25, NULL, 'High Street', 'London', 'SE63 0UQ'),
(5, 5, 63, 'Richmond Residence', 'Richmond Road', 'London', 'E16 3MG'),
(6, 6, 93, 'Newington Court', 'Mill Lane', 'London', 'EC85 4RT'),
(7, 7, 47, NULL, 'Station Road', 'London', 'E51 9NV');

-- ====================== --
-- Populate the pet table --
-- ====================== --

INSERT INTO pet (pet_id, pet_name, breed_id, gender)
VALUES
(1, 'Nina', 6, 'female'),
(2, 'Waffles', 2, 'male'), 
(3, 'Maple', 6, 'female'),
(4, 'Murphy', 5, 'male'),
(5, 'Nole', 1, 'male'),
(6, 'Yumi', 13, 'male'),
(7, 'Yoshi', 14, 'female'),
(8, 'Wiggles', 12, 'female');

-- =============================== --
-- Populate the booking type table --
-- =============================== --

INSERT INTO booking_type (booking_type_id, booking_type_name, price_hourly)
VALUES
(1, 'Day Care', 7.5),
(2, 'House Sitting', 10),
(3, 'Drop-in', 5),
(4, 'Walk', 10),
(5, 'Boarding', 1.8);

-- ========================== --
-- Populate the booking table --
-- ========================== --

INSERT INTO booking (booking_id, start_datetime, end_datetime, booking_type_id, notes)
VALUES
(1, '2023-05-22 08:00:00', '2023-05-22 17:00:00', 1, 'Sleeps on the couch'), 
(2, '2023-05-23 12:00:00', '2023-05-23 13:00:00', 4, 'Loves cuddles and attention'), 
(3, '2023-05-24 08:00:00', '2023-05-24 18:00:00', 1, 'Loves chasing squirrels'),
(4, '2023-05-25 09:00:00', '2023-05-25 10:00:00', 3, 'Remember to refill water'), 
(5, '2023-05-26 10:00:00', '2023-05-26 21:00:00', 2, NULL), 
(6, '2023-05-27 11:00:00', '2023-05-27 12:00:00', 3, 'Lovely cats'),
(7, '2023-05-27 19:00:00', '2023-05-27 22:00:00', 2, 'Puppy energy'),
(8, '2023-06-01 12:00:00', '2023-06-10 13:00:00', 5, 'Eats at 8am and 4pm'),
(9, '2023-06-05 16:00:00', '2023-06-05 17:00:00', 4, 'Please keep on lead'),
(10, '2023-06-15 08:00:00', '2023-06-15 17:00:00', 1, NULL);

-- ================================= --
-- Populate the pet_owner_link table --
-- ================================= --

INSERT INTO pet_owner_link (pet_owner_link_id, pet_id, owner_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 6),
(8, 8, 7);

-- =================================== --
-- Populate the booking_pet_link table --
-- =================================== --

INSERT INTO booking_pet_link (booking_pet_link_id, booking_id, pet_id)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 6, 7),
(8, 7, 8),
(9, 8, 3),
(10, 9, 5),
(11, 10, 1);
