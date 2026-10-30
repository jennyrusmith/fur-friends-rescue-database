USE fur_friends_rescue;


-- add 'unavailable' to chk_status CONSTRAINT
ALTER TABLE animal DROP CONSTRAINT chk_status;

ALTER TABLE animal ADD CONSTRAINT chk_status 
CHECK (status IS NULL OR status IN ('available', 'unavailable', 'adopted', 'in foster care'));


-- setting status for animals
UPDATE animal SET status = 'adopted' WHERE animal_ID IN (4, 6, 11, 12, 15);
UPDATE animal SET status = 'unavailable' WHERE animal_ID IN (1, 2, 3, 5, 7, 8, 9, 10, 13, 14);
UPDATE animal SET status = 'in foster care' WHERE animal_ID IN (2, 4);
UPDATE animal SET status = 'available' WHERE animal_ID BETWEEN 16 AND 30;

