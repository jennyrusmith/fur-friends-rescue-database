USE fur_friends_rescue;

-- tables
SELECT * FROM animal;
SELECT * FROM person;
SELECT * FROM worker;
SELECT * FROM location;
SELECT * FROM arrival;
SELECT * FROM departure;
SELECT * FROM placement;
SELECT * FROM record_updates;

-- views
SELECT * FROM v_animals_available_for_adoption;

SELECT * FROM v_animals_available_for_adoption WHERE species = 'Cat';

SELECT * FROM v_animals_available_for_adoption ORDER BY age_estimate DESC;





