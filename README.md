# Fur Friends Animal Rescue Database Project

This relational database system was built for a fictional non-profit, animal rescue called Fur Friends Animal Rescue.

## Project Overview & Core Requirements
The goal of this project was to transition an animal rescue organization from spreadsheets to an enterprise relational system to cleanly execute the following logistics:
* **Track Animal Logs:** Monitor admissions, foster care deployments, and final outcomes (adoptions, transfers, owner returns).
* **Automated Master Audit Logging:** Track every data update across the core tables, automatically recording the altered field, its old value, its new value, and the timestamp.
* **View Available Animals:** Provide a view that shows ready-to-adopt animals.

## Database Architecture (ERD)
The database features 8 relational tables linked via many-to-one (`>`) foreign key associations to map real-world operations cleanly:

* **Primary Entities:** `animal`, `person`, `worker`, `location`
* **Transactional Logs:** `arrival`, `departure`, `placement`
* **System Logs:** `record_updates`

> **Interactive Visuals:** [View Live Entity-Relationship Diagram on DBDocs](https://dbdiagram.io/d/Fur-Friends-6abb05e45869425612bf422d)

---

## Core Database Features

### 1. Data Validation and Constraints
I built strict checks directly into the schema to keep the data clean and prevent formatting errors:
* **Format Checking with Regex:** Used regular expressions to force correct structures for 10-digit phone numbers, 5-digit ZIP codes, and standard email formats.
* **Conditional Rules:** Added table constraints to handle specific rescue logic. For example, if an animal is listed as a 'rodent', 'reptile', 'bird', or 'other', a specific `species_detail` must be provided. Also, any location set as a 'foster home' is required to link back to a valid caretaker's `person_ID`.

### 2. Audit Trail Trigger Engine
To track data changes automatically over time, I wrote `AFTER UPDATE` row triggers for the master tables. 
* **Null-Safe Checks:** The triggers use the null-safe equality operator (`<=>`) so that changes are accurately logged even when a field switches to or from a `NULL` state.
* **Automatic Logging:** Whenever a user edits a record, the database instantly captures the specific field name, the old value, and the new value, and saves it directly into the `record_updates` table.

### 3. Adoption Board View
I created a view to turn raw database data into a clean operational tool:
* **`v_animals_available_for_adoption`**: This view filters for animals actively marked as 'available' and automatically calculates their approximate ages on the fly based on their estimated birth year.

---

## Testing and Verification
I verified the entire setup locally by simulating common shelter updates. When you run an update script to modify an animal's attributes or a person's contact info, the system immediately tracks the changes:

```sql
-- Test query simulating a record update
UPDATE animal SET color = 'Orange' WHERE animal_ID = 26;

-- Check the audit log table
SELECT * FROM record_updates;
```

**Result:** The update trigger immediately catches the change, extracts the old and new text strings, and creates a new tracking row in the `record_updates` log table.
