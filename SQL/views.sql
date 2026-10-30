USE fur_friends_rescue;

CREATE OR REPLACE VIEW v_animals_available_for_adoption AS
SELECT 
    animal_ID,
    name,
    species,
    breed,
    color,
    sex,
    (YEAR(CURDATE()) - est_birth_year) AS age_estimate
FROM animal
WHERE status = 'available';

