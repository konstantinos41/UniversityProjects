SELECT NAME FROM Countries_in_Committees
WHERE Committee_ID = (
	SELECT Committee_ID FROM Committees
	WHERE NAME = 'Security Council 2015')