-- ===================================================================== --
-- ADVANCED OPTION
-- Subquery to  get the list of breeds starting with C and only for dogs --
-- Subquery to get the pets of size L --
-- ===================================================================== --

 SELECT breed.breed_name, breed.breed_size
 FROM breed 
 WHERE breed.animal_type_id IN (
 SELECT atype.animal_type_id 
 FROM animal_type AS atype 
 WHERE atype.animal_type_name = 'dog')
 AND breed.breed_name LIKE 'C%'
 ORDER BY breed_name; 
 
 
SELECT pet.pet_name, pet.gender
 FROM pet 
 WHERE pet.breed_id IN (
 SELECT breed.breed_id 
 FROM breed
 WHERE breed.breed_size = 'L')
 ORDER BY pet_name; 

-- ========================================== --
-- ADVANCED OPTION
-- Creating JOIN to display booking dashboard --
-- ========================================== --

-- DROP VIEW IF EXISTS vw_booking_dashboard;

CREATE VIEW vw_booking_dashboard AS
	SELECT b.booking_id, b.start_datetime, b.end_datetime, bt.booking_type_name,
    TIMESTAMPDIFF(HOUR, b.start_datetime, b.end_datetime) AS number_hours, 
    (bt.price_hourly * TIMESTAMPDIFF(HOUR, b.start_datetime, b.end_datetime)) AS booking_price,
    b.paid, p.pet_name, p.gender, breed.breed_name, breed.breed_size,
	at.animal_type_name, b.notes,
	owner.first_name, owner.last_name, owner.phone_number,
	oa.postcode
	FROM booking_type bt
	INNER JOIN booking b
	ON bt.booking_type_id = b.booking_type_id
	INNER JOIN booking_pet_link bpl
	ON b.booking_id = bpl.booking_id
	INNER JOIN pet p
	ON bpl.pet_id = p.pet_id
	INNER JOIN breed 
	ON p.breed_id = breed.breed_id
	INNER JOIN animal_type at
	ON breed.animal_type_id = at.animal_type_id
	INNER JOIN pet_owner_link pol
	ON p.pet_id = pol.pet_id
	INNER JOIN owner
	ON pol.owner_id = owner.owner_id
	INNER JOIN owner_address oa
	ON owner.owner_id = oa.owner_id
    ORDER BY booking_id;

SELECT * FROM vw_booking_dashboard;

-- ========================================================================== --
-- ADVANCED OPTION
-- GROUP BY & HAVING - Show how many pets have the same breed and their names --
-- ========================================================================== --

SELECT breed.breed_id, breed.breed_name, COUNT(breed.breed_id) as total_pets, group_concat(pet.pet_name) as pets
FROM pet 
JOIN breed 
ON pet.breed_id = breed.breed_id

GROUP BY breed_id
HAVING total_pets >= 2;

-- ========================================================= --
-- ADVANCED OPTION
-- Procedure - Update the paid boolean for specific bookings --
-- ========================================================= --

SELECT * FROM vw_booking_dashboard;

-- DROP PROCEDURE IF EXISTS UpdatePaid;  

DELIMITER //
CREATE PROCEDURE UpdatePaid (IN b_booking_id INT, IN b_paid VARCHAR(100))
	BEGIN
	UPDATE booking 
     SET
 	paid = b_paid WHERE booking_id = b_booking_id; 
 END//
 DELIMITER ;

CALL UpdatePaid (1, 'YES');

SELECT * FROM vw_booking_dashboard;
 
-- ====================================================================== --
-- ADVANCED OPTION
-- Procedure - Update all past bookings to paid based on a date parameter --
-- ====================================================================== --

-- Assumption: booking payments are transferred when the procedure is called
-- This can also be used with NOW() which means all past bookings from the current date & time will be updated when called  

SELECT * FROM vw_booking_dashboard;

DROP PROCEDURE IF EXISTS update_paid_pastbookings;  

DELIMITER //
CREATE PROCEDURE update_paid_pastbookings (paid_at DATETIME)
	BEGIN
	UPDATE booking 
     SET
 	paid = 'YES' 
    WHERE end_datetime < paid_at; 
 END//
 DELIMITER ;

 CALL update_paid_pastbookings ('2023-05-31');
 
 SELECT * FROM vw_booking_dashboard;

-- ================================================================================== --
-- ADVANCED OPTION
-- Trigger - Ensure End date greater than Start Date when insert data otherwise error --
-- ================================================================================== --

-- Double check that it works and take into consideration both date and time

SELECT * FROM vw_booking_dashboard;

DROP TRIGGER IF EXISTS datetime_bi;

DELIMITER //
CREATE TRIGGER datetime_bi BEFORE INSERT 
ON booking
FOR EACH ROW
IF NEW.end_datetime < NEW.start_datetime THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'End Date must be greater than Start Date.';

END IF; //
DELIMITER ;

INSERT INTO booking (booking_id, start_datetime, end_datetime, booking_type_id, notes)
VALUES 
(6, '2023-05-22 08:00:00', '2023-05-22 07:00:00', 1, 'Sleeps on the couch'); -- should return error

-- ============================================================ --
-- ADVANCED OPTION
-- Event - Plan a 25% price increase in a month, one time event -- 
-- ============================================================ --

-- Note: UPDATE statement alone verified and works

DROP EVENT IF EXISTS price_increase;

 DELIMITER //
 CREATE EVENT price_increase
 ON SCHEDULE AT NOW() + INTERVAL 1 SECOND 
 DO BEGIN
 	UPDATE booking_type
 	SET price_hourly = price_hourly * 1.25;
 END//
 DELIMITER ;

SELECT * FROM booking_type;
