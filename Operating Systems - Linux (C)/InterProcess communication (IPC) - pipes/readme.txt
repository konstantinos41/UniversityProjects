## Εργασία: InterProcess communication (IPC) - pipes
### Φοιτητής: Κωνσταντίνος Μαυροδής - 7922 - mavrkons@auth.gr

Στην εργασία ζητήθηκε η κατασκευή ενός client και ενός server σε c 
γλώσσα προγραμματισμού όπως και ενός makefile.

## Υλοποίηση
Στη δική μου υλοποίηση ο Client: τυπώνει ένα μήνυμα εκκίνησης,
δημιουργεί ένα child process, που θα είναι ο server, δημιουργεί και
ανοίγει ένα κανάλι named pipe, στέλνει μέσα σε αυτό ένα μήνυμα και
το κλείνει.
O server από την άλλη: τυπώνει ένα μήνυμα εκκίνησης, ανοίγει το ίδιο
κανάλι που έχει φτιάξει ο client, δημιουργεί έναν buffer μέσα στον 
οποίο γράφει αυτά που διαβάζει από το κανάλι, τυπώνει τον buffer και
κλείνει το κανάλι.
Παράλληλα, δημιουργήκε ένα makefile για διευκόλυνση του compilation.

## Compile & Run
Όπως άλλωστε ζητήθηκε, το πρόγραμμα γίνεται compile με την εντολή 
"make ./all", τρέχει με την εντολή "./all" και καθαρίζεται από 
εκτελέσιμα αρχεία με την εντολή "make ./clean".

## Βιβλιογραφία
Για την υλοποίηση χρειάστηκα υλικό από τις σημειώσεις της 
Εργαστηριακής Ασκήσης 1 για το makefile της Εργαστηριακής Άσκησης 4
για τα pipes όπως και από το λινκ που ακολουθεί για τα named pipes
http://stackoverflow.com/questions/2784500/how-to-send-a-simple-string-between-two-programs-using-pipes


Ευχαριστώ για τον χρόνο σας. 