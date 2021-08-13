SELECT * FROM titanic3;
-- PCLASS »Ì¾Æº¸±â
SELECT name
FROM titanic3
WHERE pclass=1;

SELECT name,age
FROM titanic3
WHERE pclass=1 AND age < 20 AND survived = 1;

SELECT survived, AVG(age)
FROM titanic3
GROUP BY survived;

SELECT survived, AVG(fare)
FROM titanic3
WHERE pclass > 1
GROUP BY survived;

SELECT survived, pclass, AVG(age)
FROM titanic3
WHERE fare > 300
GROUP BY survived, pclass;

SELECT pclass, MEDIAN(age), MAX(age), MIN(age)
FROM titanic3
WHERE fare > 10
GROUP BY pclass;

SELECT AVG(age), SUM(fare)
FROM titanic3
WHERE pclass =1
GROUP BY pclass;

SELECT age
FROM titanic3
WHERE TRIM 