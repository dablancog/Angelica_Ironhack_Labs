select * from bank.account;
use bank;
select * from account;
select client_id, birth_number from client;
SELECT *, amount - payments AS balance FROM bank.loan;

SELECT * FROM bank.loan
WHERE status NOT IN ("B","b") AND amount > 100000;

SELECT * FROM bank.loan
WHERE status <> "B" AND amount > 100000;

SELECT distinct status FROM bank.loan
ORDER BY status DESC;

SELECT * FROM bank.account
WHERE district_id IN (1,2,3,4,5);

SELECT account_id, SUM(amount) AS Total
FROM bank.loan
GROUP BY account_id
ORDER BY Total
LIMIT 1;

SELECT date, AVG(amount) AS Average FROM trans
GROUP BY date
ORDER BY Average DESC
LIMIT 5;

SELECT floor(avg(amount)) FROM bank.order;

SELECT ceiling(avg(amount)) FROM bank.order;

SELECT SUBSTRING("Hello world",7,3);

SELECT * FROM bank.district
WHERE A3 LIKE "north%";

SELECT * FROM bank.district
WHERE A3 LIKE "north_M%";