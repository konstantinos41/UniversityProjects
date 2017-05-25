SELECT P.Name, P.Surname, O.Mail FROM Officers O, Participant P
WHERE  O.Officer_ID = P.Participant_ID and O.Phone IS NULL