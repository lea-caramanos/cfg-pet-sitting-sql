-- SELECT w/ JOIN, to know whether the breed is for a dog or a cat
SELECT breed.breed_id, breed.breed_name, breed.breed_size, atype.animal_type_name
FROM breed 
JOIN animal_type atype ON breed.animal_type_id = atype.animal_type_id
ORDER BY breed_id; 

SELECT pol.pet_owner_link_id, pet.pet_name, owner.first_name
FROM pet_owner_link pol
INNER JOIN pet  
ON pol.pet_id = pet.pet_id
INNER JOIN owner
ON pol.owner_id = owner.owner_id;


SELECT bpl.booking_pet_link_id, bpl.booking_id, pet.pet_name
FROM booking_pet_link bpl
INNER JOIN pet  
ON bpl.pet_id = pet.pet_id
ORDER BY bpl.booking_id;

-- ====================================================================== --
-- CORE REQUIREMENT
-- Simple JOIN (storing as a VIEW) to display addresses with owner's name -- 
-- ====================================================================== --

-- DROP VIEW IF EXISTS vw_owner_address;

SELECT * FROM owner_address; 

CREATE VIEW vw_owner_address AS
	SELECT oa.owner_address_id, CONCAT(owner.first_name, " ", owner.last_name) AS full_name, 
	oa.house_number, oa.house_name, oa.street, oa.city, oa.postcode
	FROM owner_address oa 
	JOIN owner ON oa.owner_id = owner.owner_id;
    
SELECT * FROM vw_owner_address;

-- ============================================================================= --
-- CORE REQUIREMENT
-- Function - Check eligibility for discount based on number of hours of booking --
-- ============================================================================= --

-- DROP FUNCTION IF EXISTS discount_eligibility;

DELIMITER //
CREATE FUNCTION discount_eligibility (number_hours INT)
RETURNS VARCHAR(20)
DETERMINISTIC 
BEGIN
	DECLARE owner_eligibility VARCHAR(20);
	IF number_hours >= 10 THEN
		SET owner_eligibility = 'YES';
	ELSEIF number_hours < 10 THEN
		SET owner_eligibility = 'NO';
	END IF;
RETURN owner_eligibility;
END // 
DELIMITER ;

SELECT booking_id, start_datetime, end_datetime, TIMESTAMPDIFF(HOUR, start_datetime, end_datetime) AS number_hours, discount_eligibility(TIMESTAMPDIFF(HOUR, start_datetime, end_datetime)) AS discount_eligibility
FROM booking;
