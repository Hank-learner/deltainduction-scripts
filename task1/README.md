# task1

## created for linux
new server, system admin.

 accounts for the following users:
-> A Master Scientist named ‘MasterH’.
-> Scientists named ‘Heisenberg’, ‘Hertz’, ‘Holland’.
-> 20 intern users with names ‘Scientist_nameX’(X is 1-20) for each scientist.

Assigning permissions such that:
-> The scientists can access their corresponding intern’s directory while the opposite is not possible.
-> The scientists can’t access each other’s directories.
-> The master scientist can access everyone’s files.
-> The intern’s shouldn’t be able to access each other’s folders.
-> Any file henceforth created on the intern’s user, should not be executable unless changed after creation.

Creating 5 folders by the name ‘taskX’ (X = 1-5) for each student, scientist.
Filling the ‘taskX’ folder of the scientists with 50 files scientistName_taskY (1-50), with 128 random ASCII characters.

For every intern , putting 5 random tasks from their corresponding scientist into their taskX directory. This should be done everyday at 12:00 am.
All the task files, within the taskX directory is undeletable.

Hacker mode stage
-> the access logs of the server (https://delta.nitt.edu/~deeraj/server_logs.txt 81).
 two files success and failure in the home directory of each user, which is a list of successful and unsuccessful access attempts.
-> The success and failure are decided by the permissions set above.
-> Finding out the number of hits on each of the interns, and displaying them in a table / with properly defined rows and columns with a file format of - “TimeStamp : HostName”.
