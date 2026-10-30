USE fur_friends_rescue;

-- 1. Simulate a worker updating Teddy's color field
UPDATE animal 
SET color = 'Orange' 
WHERE animal_ID = 26;

-- 2. Simulate a worker updating Richard Jones's address fields
UPDATE person 
SET street_address = '200 sanctuary way', city = 'philadelphia' 
WHERE person_ID = 15;


SELECT * FROM record_updates;
