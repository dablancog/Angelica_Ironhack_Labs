
CREATE DATABASE ironhack;
USE ironhack;
CREATE TABLE students (
student_id INT PRIMARY KEY,
first_name VARCHAR (55),
last_name VARCHAR (55),
age INT);

INSERT INTO students (student_id, first_name, last_name, age)
VALUES (1, 'Jorge', 'Aguilar', 25);
 
SELECT * FROM students;

UPDATE students
SET age = 30
WHERE first_name = 'Jorge';

DROP TABLE students;

create temporary table bank.loan_and_account
select l.loan_id, l.account_id, a.district_id, l.amount, l.payments, a.frequency
from bank.loan l
join bank.account a
on l.account_id = a.account_id;

SELECT * FROM bank.loan_and_acount;