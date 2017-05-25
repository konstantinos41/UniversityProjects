WITH A AS (
SELECT Committee_ID FROM Countries_in_Committees
WHERE NAME LIKE '%Germany%')


SELECT NAME FROM Committees
WHERE Committee_ID IN (SELECT Committee_ID FROM A) AND Conference = 4
