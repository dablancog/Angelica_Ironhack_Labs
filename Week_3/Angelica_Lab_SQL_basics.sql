
use bank;

# Query 1 : Get the id values of the first 5 clients from district_id with a value equal to 1.
SELECT client_id FROM bank.client
WHERE district_id = 1
LIMIT 5;
# Result: 2, 3, 22, 23, 28

# Query 2: In the client table, get an id value of the last client where the district_id is equal to 72.
SELECT client_ID FROM bank.client
WHERE district_id = 72
ORDER BY client_id DESC
LIMIT 1;
# Result: 13576

# Query 3: Get the 3 lowest amounts in the loan table.
SELECT amount FROM loan
ORDER BY amount
LIMIT 3;
# Result: 4980, 5148, 7656

# Query 4: What are the possible values for status, ordered alphabetically in ascending order in the loan table?
SELECT DISTINCT(status) FROM loan
ORDER BY status;
# Restult: A, B, C, D

# Query 5: What is the loan_id of the highest payment received in the loan table?
SELECT loan_id FROM loan
ORDER BY payments DESC
LIMIT 1;
# Result: 6415

# Query 6: What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
SELECT account_id, amount FROM loan
ORDER BY account_id
LIMIT 5;
# Result:
# account_id.  amount
# 2.            80952
# 19.           30276
# 25.           30276
# 37.           318480
# 38.           110736

# Query 7: What are the top 5 account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT account_id FROM loan
WHERE duration = 60
ORDER BY amount
LIMIT 5;
# Result: 10954, 938, 10711, 1766, 10799

# Query 8: What are the unique values of k_symbol in the order table?
SELECT DISTINCT(k_symbol) FROM `order`;
# Result: SIPO, UVER, POJISTNE, LEASING

# Query 9: In the order table, what are the order_ids of the client with the account_id 34?
SELECT order_id FROM `order`
WHERE account_id = 34;
# Result: 29445, 29446, 29447

# Query 10: In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
SELECT DISTINCT(account_id) FROM `order`
WHERE order_id BETWEEN 29540 AND 29560;
# Result: 88, 90, 96, 97

# Query 11: In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
SELECT DISTINCT(amount) FROM `order`
WHERE account_to = 30067122;
# Result: 5123

# Query 12: In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
SELECT trans_id, date, type, amount FROM trans
WHERE account_id = 793
ORDER BY date DESC
LIMIT 10;
# Result:
# trans_id	data	type	amount
#3556468	981231	PRIJEM	78.6
#233254		981216	VYDAJ	600
#233104		981212	VYDAJ	1212
#233248		981211	VYDAJ	851
#233176		981207	VYDAJ	204
#233395		981130	VYDAJ	14.6
#3556467	981130	PRIJEM	75.1
#233103		981112	VYDAJ	1212
#233247		981111	VYDAJ	851
#233175		981107	VYDAJ	204

# Query 13: In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
SELECT district_id, COUNT(client_id) AS clients FROM client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id;
# Result:
# district_id	clients
#	1			663
#	2			46
#	3			63
#	4			50
#	5			71
#	6			53
#	7			45
#	8			69
#	9			60

#Query 14: In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
SELECT type, COUNT(card_id) AS cards FROM card
GROUP BY type
ORDER BY cards DESC;
# Result:
# type 	 	cards
# classic 	659
# junior	145
# gold		88

#Query 15: Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
SELECT account_id, SUM(amount) AS total_amount FROM loan
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;
#Result:
#account_id 	total_amount
#7542			590820
#8926			566640
#2335			541200
#817		    538500
#2936			504000
#7049			495180
#10451			482940
#6950			475680
#7966			473280
#339		    468060

#Query 16: In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
SELECT date, COUNT(loan_id) AS total_loans FROM loan
WHERE date < 930907
GROUP BY date
ORDER BY date DESC;
# Result:
#date	total_loans
#930906	1
#930803	1
#930728	1
#930711	1
#930705	1

#Query 17: In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
SELECT distinct (duration), `date`, COUNT(loan_id) FROM loan
WHERE `date` BETWEEN 971201 AND 971231
GROUP BY `date`, duration
ORDER BY `date`, duration;

# Query 18: In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.
SELECT account_id, type, SUM(amount) AS total_amount FROM trans
WHERE account_id = 396
GROUP BY type
ORDER BY type;
#Result: account_id		type	total_amount
#			396			PRIJEM	1028138.6999740601
#			396			VYDAJ	1485814.400024414

# Query 19: From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer
SELECT account_id, 
       CASE `type`
           WHEN 'PRIJEM' THEN 'Incoming'
           WHEN 'VYDAJ' THEN 'Outgoing'
       END AS transaction_type, 
       FLOOR(SUM(amount)) AS total_amount 
FROM trans
WHERE account_id = 396
GROUP BY `type`
ORDER BY `type`;
#Result:
#account_id transaction_type total_amount
#396		INCOMING			1028138
#396		OUTGOING			1485814

#Query 20: From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.
SELECT account_id,
       SUM(CASE `type` WHEN 'PRIJEM' THEN amount ELSE 0 END) AS incoming_amount,
       SUM(CASE `type` WHEN 'VYDAJ' THEN amount ELSE 0 END) AS outgoing_amount,
       SUM(CASE `type` WHEN 'PRIJEM' THEN amount ELSE -amount END) AS difference
FROM trans
WHERE account_id = 396
GROUP BY account_id;
#Result:
#accont_id incoming_amount outgoing_amount difference
#396		1028138			1485814			-457676

#Query 21: Continuing with the previous example, rank the top 10 account_ids based on their difference.
SELECT account_id, difference
FROM (
    SELECT account_id,
           SUM(CASE `type` WHEN 'PRIJEM' THEN amount ELSE 0 END) AS incoming_amount,
           SUM(CASE `type` WHEN 'VYDAJ' THEN amount ELSE 0 END) AS outgoing_amount,
           SUM(CASE `type` WHEN 'PRIJEM' THEN amount ELSE -amount END) AS difference
    FROM trans
    GROUP BY account_id
) AS subquery
ORDER BY difference DESC
LIMIT 10;




