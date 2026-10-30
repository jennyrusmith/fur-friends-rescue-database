USE fur_friends_rescue;

-- drop tables, if they exist, in reverse order of dependencies
DROP TABLE IF EXISTS record_updates;
DROP TABLE IF EXISTS departure;
DROP TABLE IF EXISTS placement;
DROP TABLE IF EXISTS arrival;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS worker;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS animal;

-- create tables with no parent dependencies
CREATE TABLE animal (
  animal_ID INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  species VARCHAR(20) NOT NULL,
  species_detail VARCHAR(50),
  sex VARCHAR(7) NOT NULL,
  breed VARCHAR(50),
  color VARCHAR(30),
  est_birth_year INT,
  status VARCHAR(20),
  
  CONSTRAINT chk_species CHECK (species IN ('cat', 'dog', 'rodent', 'reptile', 'bird', 'other')),
  CONSTRAINT chk_species_rule CHECK (
    (species NOT IN ('rodent', 'reptile', 'bird', 'other')) OR 
    (species IN ('rodent', 'reptile', 'bird', 'other') AND species_detail IS NOT NULL)
  ),
  CONSTRAINT chk_sex CHECK (sex IN ('male', 'female', 'unknown')),
  CONSTRAINT chk_status CHECK (status IS NULL OR status IN ('available', 'unavailable', 'adopted', 'in foster care'))
);
  
  
CREATE TABLE person (
    person_ID INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
    email VARCHAR(255),
    zip_code VARCHAR(5),
    street_address VARCHAR(100),
    city VARCHAR(50),
    state_abbreviation CHAR(2),
    CONSTRAINT chk_person_state_rule CHECK (
    state_abbreviation IS NULL OR 
    state_abbreviation IN (
        'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 
        'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 
        'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 
        'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
    )
  ),
    CONSTRAINT chk_person_phone CHECK (phone_number IS NULL
        OR phone_number REGEXP '^[0-9]{10}$'),
    CONSTRAINT chk_person_email CHECK (email IS NULL
        OR email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'),
    CONSTRAINT chk_person_zip_code CHECK (zip_code IS NULL
        OR zip_code REGEXP '^[0-9]{5}$')
);

CREATE TABLE worker (
  worker_ID INT AUTO_INCREMENT PRIMARY KEY,
  worker_type VARCHAR(20) NOT NULL,
  worker_status VARCHAR(20) NOT NULL,
  first_name  VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  phone_number VARCHAR(20),
  email VARCHAR(255),
  zip_code VARCHAR(5),
  street_address VARCHAR(100),
  city VARCHAR(50),
  state_abbreviation CHAR(2),
  
  CONSTRAINT chk_worker_type CHECK (worker_type IN ('employee', 'owner', 'volunteer', 'intern')),
  CONSTRAINT chk_worker_status CHECK (worker_status IN ('active', 'inactive')),
  CONSTRAINT chk_worker_state_rule CHECK (
    state_abbreviation IS NULL OR 
    state_abbreviation IN (
        'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 
        'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 
        'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 
        'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
    )
  ),
  CONSTRAINT chk_worker_phone CHECK (phone_number IS NULL OR phone_number REGEXP '^[0-9]{10}$'),
  CONSTRAINT chk_worker_email CHECK (
    email IS NULL OR 
    email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  ),
  CONSTRAINT chk_worker_zip_code CHECK (zip_code IS NULL OR zip_code REGEXP '^[0-9]{5}$')
  );

  -- create tables with dependencies
CREATE TABLE location (
  location_ID INT AUTO_INCREMENT PRIMARY KEY,
  location_type VARCHAR(30) NOT NULL,
  org_name VARCHAR(100),
  person_ID INT,
  zip_code VARCHAR(5),
  street_address VARCHAR(100),
  city VARCHAR(50),
  state_abbreviation CHAR(2),
  
  FOREIGN KEY (person_ID) REFERENCES person(person_ID),
  
  CONSTRAINT chk_location_type CHECK (location_type IN ('rescue facility', 'foster home', 'veterinary clinic', 'boarding facility', 'other organization', 'other')),
  CONSTRAINT chk_location_type_rule CHECK (
    (location_type NOT IN ('veterinary clinic', 'boarding facility', 'other organization', 'other')) OR 
    (location_type IN ('veterinary clinic', 'boarding facility', 'other organization', 'other') AND org_name IS NOT NULL)
  ),
  CONSTRAINT chk_foster_person_rule CHECK (
    (location_type NOT IN ('foster home')) OR 
    (location_type IN ('foster home') AND person_ID IS NOT NULL)
  ),
  CONSTRAINT chk_location_state_rule CHECK (
    state_abbreviation IS NULL OR 
    state_abbreviation IN (
        'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 
        'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 
        'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 
        'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
    )
  ),
  CONSTRAINT chk_location_zip_code CHECK (zip_code IS NULL OR zip_code REGEXP '^[0-9]{5}$')
  );
  
CREATE TABLE arrival (
  arrival_ID INT AUTO_INCREMENT PRIMARY KEY,
  date DATETIME NOT NULL,
  animal_ID INT NOT NULL,
  person_ID INT,
  arrival_type VARCHAR(20) NOT NULL,
  worker_ID INT NOT NULL,
  
  FOREIGN KEY (animal_ID) REFERENCES animal(animal_ID),
  FOREIGN KEY (person_ID) REFERENCES person(person_ID),
  FOREIGN KEY (worker_ID) REFERENCES worker(worker_ID),
  
  CONSTRAINT chk_arrival_type CHECK (arrival_type IN ('stray', 'surrender', 'return', 'transfer'))
  );
  
CREATE TABLE departure (
  departure_ID INT AUTO_INCREMENT PRIMARY KEY,
  animal_ID INT NOT NULL,
  person_ID INT,
  date DATETIME NOT NULL,
  departure_type VARCHAR(25) NOT NULL,
  worker_ID INT NOT NULL,
  
  FOREIGN KEY (animal_ID) REFERENCES animal(animal_ID),
  FOREIGN KEY (person_ID) REFERENCES person(person_ID),
  FOREIGN KEY (worker_ID) REFERENCES worker(worker_ID),
  
  CONSTRAINT chk_departure_type CHECK (departure_type IN ('deceased', 'euthanized', 'adopted', 'lost', 'returned to owner', 'transferred'))
  );
  
CREATE TABLE placement (
  placement_ID INT AUTO_INCREMENT PRIMARY KEY,
  animal_ID INT NOT NULL,
  location_ID INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  worker_ID INT NOT NULL,
  
  FOREIGN KEY (animal_ID) REFERENCES animal(animal_ID),
  FOREIGN KEY (location_ID) REFERENCES location(location_ID),
  FOREIGN KEY (worker_ID) REFERENCES worker(worker_ID)
  );

CREATE TABLE record_updates (
  update_ID INT AUTO_INCREMENT PRIMARY KEY,
  animal_ID INT,
  person_ID INT,
  worker_ID INT,
  departure_ID INT,
  arrival_ID INT,
  placement_ID INT,
  location_ID INT,
  worker_ID_updater INT NOT NULL,
  date_time DATETIME NOT NULL,
  field_updated VARCHAR(50) NOT NULL,
  old_value VARCHAR(255),
  new_value VARCHAR(255),
  
  FOREIGN KEY (animal_ID) REFERENCES animal(animal_ID),
  FOREIGN KEY (person_ID) REFERENCES person(person_ID),
  FOREIGN KEY (worker_ID) REFERENCES worker(worker_ID),
  FOREIGN KEY (worker_ID_updater) REFERENCES worker(worker_ID),
  FOREIGN KEY (arrival_ID) REFERENCES arrival(arrival_ID),
  FOREIGN KEY (departure_ID) REFERENCES departure(departure_ID),
  FOREIGN KEY (placement_ID) REFERENCES placement(placement_ID),
  FOREIGN KEY (location_ID) REFERENCES location(location_ID)
  );
  
  
  
  
  
  
  
  
  
  
  
  