WITH A AS (
SELECT Officer_ID FROM Officers
WHERE Experience > 2)


SELECT NAME FROM Committees
WHERE (Officer1 IN (SELECT Officer_ID FROM A)) and (Officer2 IN (SELECT Officer_ID FROM A))