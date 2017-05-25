SELECT Name, Surname FROM Participant
WHERE Participant_ID = (
	SELECT Press_ID FROM Press
	WHERE Press_ID NOT IN (
	SELECT P1.Press_ID FROM Press P1, Press P2
	WHERE P1.Experience < P2.Experience
	)
)