WITH X AS (
	SELECT Committee_ID
	FROM Committees
	WHERE Name = 'Sustainable Development 2015'
),
Y AS (
	SELECT Participant_ID
	FROM Delegates_in_Committees
	WHERE Committee_ID IN (SELECT * FROM X)
)
SELECT Name, Surname
FROM Participant
WHERE Participant_ID IN (SELECT * FROM Y)