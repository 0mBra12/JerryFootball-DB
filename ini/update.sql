INSERT INTO university (university_id, university_name)
VALUES (100, "TEXAS A&M UNIVERSITY");

INSERT INTO locate (university_id, address_id)
VALUES (100, 1000);

INSERT INTO address (address_id, number, street, city, state, zip)
VALUES (1000, 1, "Texas AVE", "College Station", "Texas", 77840);

UPDATE address
SET city = "college station"
WHERE zip = "77840";

UPDATE university
SET university_name = "TAMU"
WHERE university_name = "TEXAS A&M UNIVERSITY";

DELETE
FROM address
WHERE address_id = 1000;

DELETE
FROM university
WHERE university_name = "TAMU";

DELETE
FROM locate
WHERE address_id = 1000;