WITH A AS (
	SELECT *
	FROM Advisors_in_Schools
	WHERE Advisor_ID = 2
),
B AS (
	SELECT * 
	FROM Schools
	WHERE School_ID IN (SELECT School_ID FROM A)
),
C AS (
	SELECT * 
	FROM Delegates
	WHERE School IN (SELECT School_ID FROM B)
),
D AS (
	SELECT *
	FROM C, Delegates_in_Countries S
	WHERE C.Delegate_ID = S.Participant_ID
)
SELECT Participant.Name, Participant.Surname, D.Name AS CountryName
FROM Participant, D
WHERE Participant.Participant_ID = D.Delegate_ID