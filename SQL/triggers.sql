USE fur_friends_rescue;

DELIMITER //

-- ============================================================================
-- 1. DATA VALIDATION TRIGGERS (BEFORE INSERT)
-- ============================================================================

CREATE TRIGGER validate_animal_birth_year_before_insert
BEFORE INSERT ON animal
FOR EACH ROW
BEGIN
    IF NEW.est_birth_year IS NOT NULL THEN
        IF NEW.est_birth_year < 1800 OR NEW.est_birth_year > YEAR(CURDATE()) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: est_birth_year must be between 1800 and the current year.';
        END IF;
    END IF;
END//


-- ============================================================================
-- 2. AUTOMATED MASTER AUDIT TRAIL LOGS (AFTER UPDATE)
-- ============================================================================

-- ANIMAL TABLE AUDIT
CREATE TRIGGER animal_after_update
AFTER UPDATE ON animal
FOR EACH ROW
BEGIN
    IF !(OLD.name <=> NEW.name) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'name', OLD.name, NEW.name);
    END IF;
    IF !(OLD.species <=> NEW.species) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'species', OLD.species, NEW.species);
    END IF;
    IF !(OLD.species_detail <=> NEW.species_detail) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'species_detail', OLD.species_detail, NEW.species_detail);
    END IF;
    IF !(OLD.breed <=> NEW.breed) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'breed', OLD.breed, NEW.breed);
    END IF;
    IF !(OLD.color <=> NEW.color) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'color', OLD.color, NEW.color);
    END IF;
    IF !(OLD.est_birth_year <=> NEW.est_birth_year) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'est_birth_year', CAST(OLD.est_birth_year AS CHAR), CAST(NEW.est_birth_year AS CHAR));
    END IF;
    IF !(OLD.sex <=> NEW.sex) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'sex', OLD.sex, NEW.sex);
    END IF;
        IF !(OLD.status <=> NEW.status) THEN
        INSERT INTO record_updates (animal_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.animal_ID, 1, NOW(), 'status', OLD.status, NEW.status);
    END IF;

END//


-- PERSON TABLE AUDIT
CREATE TRIGGER person_after_update
AFTER UPDATE ON person
FOR EACH ROW
BEGIN
    IF !(OLD.first_name <=> NEW.first_name) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'first_name', OLD.first_name, NEW.first_name);
    END IF;
    IF !(OLD.last_name <=> NEW.last_name) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'last_name', OLD.last_name, NEW.last_name);
    END IF;
    IF !(OLD.phone_number <=> NEW.phone_number) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'phone_number', OLD.phone_number, NEW.phone_number);
    END IF;
    IF !(OLD.email <=> NEW.email) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'email', OLD.email, NEW.email);
    END IF;
    IF !(OLD.zip_code <=> NEW.zip_code) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'zip_code', OLD.zip_code, NEW.zip_code);
    END IF;
    IF !(OLD.street_address <=> NEW.street_address) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'street_address', OLD.street_address, NEW.street_address);
    END IF;
    IF !(OLD.city <=> NEW.city) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'city', OLD.city, NEW.city);
    END IF;
    IF !(OLD.state_abbreviation <=> NEW.state_abbreviation) THEN
        INSERT INTO record_updates (person_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.person_ID, 1, NOW(), 'state_abbreviation', OLD.state_abbreviation, NEW.state_abbreviation);
    END IF;
END//


-- WORKER TABLE AUDIT
CREATE TRIGGER worker_after_update
AFTER UPDATE ON worker
FOR EACH ROW
BEGIN
    IF !(OLD.worker_type <=> NEW.worker_type) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'worker_type', OLD.worker_type, NEW.worker_type);
    END IF;
    IF !(OLD.worker_status <=> NEW.worker_status) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'worker_status', OLD.worker_status, NEW.worker_status);
    END IF;
    IF !(OLD.first_name <=> NEW.first_name) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'first_name', OLD.first_name, NEW.first_name);
    END IF;
    IF !(OLD.last_name <=> NEW.last_name) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'last_name', OLD.last_name, NEW.last_name);
    END IF;
    IF !(OLD.phone_number <=> NEW.phone_number) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'phone_number', OLD.phone_number, NEW.phone_number);
    END IF;
    IF !(OLD.email <=> NEW.email) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'email', OLD.email, NEW.email);
    END IF;
    IF !(OLD.zip_code <=> NEW.zip_code) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'zip_code', OLD.zip_code, NEW.zip_code);
    END IF;
    IF !(OLD.street_address <=> NEW.street_address) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'street_address', OLD.street_address, NEW.street_address);
    END IF;
    IF !(OLD.city <=> NEW.city) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'city', OLD.city, NEW.city);
    END IF;
    IF !(OLD.state_abbreviation <=> NEW.state_abbreviation) THEN
        INSERT INTO record_updates (worker_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.worker_ID, 1, NOW(), 'state_abbreviation', OLD.state_abbreviation, NEW.state_abbreviation);
    END IF;
END//


-- ARRIVAL TABLE AUDIT
CREATE TRIGGER arrival_after_update
AFTER UPDATE ON arrival
FOR EACH ROW
BEGIN
    IF !(OLD.date <=> NEW.date) THEN
        INSERT INTO record_updates (arrival_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.arrival_ID, 1, NOW(), 'date', CAST(OLD.date AS CHAR), CAST(NEW.date AS CHAR));
    END IF;
    IF !(OLD.animal_ID <=> NEW.animal_ID) THEN
        INSERT INTO record_updates (arrival_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.arrival_ID, 1, NOW(), 'animal_ID', CAST(OLD.animal_ID AS CHAR), CAST(NEW.animal_ID AS CHAR));
    END IF;
    IF !(OLD.person_ID <=> NEW.person_ID) THEN
        INSERT INTO record_updates (arrival_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.arrival_ID, 1, NOW(), 'person_ID', CAST(OLD.person_ID AS CHAR), CAST(NEW.person_ID AS CHAR));
    END IF;
    IF !(OLD.arrival_type <=> NEW.arrival_type) THEN
        INSERT INTO record_updates (arrival_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.arrival_ID, 1, NOW(), 'arrival_type', OLD.arrival_type, NEW.arrival_type);
    END IF;
    IF !(OLD.worker_ID <=> NEW.worker_ID) THEN
        INSERT INTO record_updates (arrival_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.arrival_ID, 1, NOW(), 'worker_ID', CAST(OLD.worker_ID AS CHAR), CAST(NEW.worker_ID AS CHAR));
    END IF;
END//


-- DEPARTURE TABLE AUDIT
CREATE TRIGGER departure_after_update
AFTER UPDATE ON departure
FOR EACH ROW
BEGIN
    IF !(OLD.animal_ID <=> NEW.animal_ID) THEN
        INSERT INTO record_updates (departure_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.departure_ID, 1, NOW(), 'animal_ID', CAST(OLD.animal_ID AS CHAR), CAST(NEW.animal_ID AS CHAR));
    END IF;
    IF !(OLD.person_ID <=> NEW.person_ID) THEN
        INSERT INTO record_updates (departure_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.departure_ID, 1, NOW(), 'person_ID', CAST(OLD.person_ID AS CHAR), CAST(NEW.person_ID AS CHAR));
    END IF;
    IF !(OLD.date <=> NEW.date) THEN
        INSERT INTO record_updates (departure_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.departure_ID, 1, NOW(), 'date', CAST(OLD.date AS CHAR), CAST(NEW.date AS CHAR));
    END IF;
    IF !(OLD.departure_type <=> NEW.departure_type) THEN
        INSERT INTO record_updates (departure_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.departure_ID, 1, NOW(), 'departure_type', OLD.departure_type, NEW.departure_type);
    END IF;
    IF !(OLD.worker_ID <=> NEW.worker_ID) THEN
        INSERT INTO record_updates (departure_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.departure_ID, 1, NOW(), 'worker_ID', CAST(OLD.worker_ID AS CHAR), CAST(NEW.worker_ID AS CHAR));
    END IF;
END//


-- LOCATION TABLE AUDIT
CREATE TRIGGER location_after_update
AFTER UPDATE ON location
FOR EACH ROW
BEGIN
    IF !(OLD.location_type <=> NEW.location_type) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'location_type', OLD.location_type, NEW.location_type);
    END IF;
    IF !(OLD.org_name <=> NEW.org_name) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'org_name', OLD.org_name, NEW.org_name);
    END IF;
    IF !(OLD.person_ID <=> NEW.person_ID) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'person_ID', CAST(OLD.person_ID AS CHAR), CAST(NEW.person_ID AS CHAR));
    END IF;
    IF !(OLD.zip_code <=> NEW.zip_code) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'zip_code', OLD.zip_code, NEW.zip_code);
    END IF;
    IF !(OLD.street_address <=> NEW.street_address) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'street_address', OLD.street_address, NEW.street_address);
    END IF;
    IF !(OLD.city <=> NEW.city) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'city', OLD.city, NEW.city);
    END IF;
    IF !(OLD.state_abbreviation <=> NEW.state_abbreviation) THEN
        INSERT INTO record_updates (location_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.location_ID, 1, NOW(), 'state_abbreviation', OLD.state_abbreviation, NEW.state_abbreviation);
    END IF;
END//


-- PLACEMENT TABLE AUDIT
CREATE TRIGGER placement_after_update
AFTER UPDATE ON placement
FOR EACH ROW
BEGIN
    IF !(OLD.animal_ID <=> NEW.animal_ID) THEN
        INSERT INTO record_updates (placement_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.placement_ID, 1, NOW(), 'animal_ID', CAST(OLD.animal_ID AS CHAR), CAST(NEW.animal_ID AS CHAR));
    END IF;
    IF !(OLD.location_ID <=> NEW.location_ID) THEN
        INSERT INTO record_updates (placement_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.placement_ID, 1, NOW(), 'location_ID', CAST(OLD.location_ID AS CHAR), CAST(NEW.location_ID AS CHAR));
    END IF;
    IF !(OLD.start_date <=> NEW.start_date) THEN
        INSERT INTO record_updates (placement_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.placement_ID, 1, NOW(), 'start_date', CAST(OLD.start_date AS CHAR), CAST(NEW.start_date AS CHAR));
    END IF;
    IF !(OLD.end_date <=> NEW.end_date) THEN
        INSERT INTO record_updates (placement_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.placement_ID, 1, NOW(), 'end_date', CAST(OLD.end_date AS CHAR), CAST(NEW.end_date AS CHAR));
    END IF;
    IF !(OLD.worker_ID <=> NEW.worker_ID) THEN
        INSERT INTO record_updates (placement_ID, worker_ID_updater, date_time, field_updated, old_value, new_value)
        VALUES (NEW.placement_ID, 1, NOW(), 'worker_ID', CAST(OLD.worker_ID AS CHAR), CAST(NEW.worker_ID AS CHAR));
    END IF;
END//

DELIMITER ;

    



