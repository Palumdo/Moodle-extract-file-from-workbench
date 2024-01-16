# Moodle-extract-file-from-workbench
A bash script for mac and one for PC to extract file submitted in a workshop. 
To extract the file of a workshop :

1.Backup the workshop activity

2.Save the mbz file on a directory

3.extrat the mbz with a zip app in a directory of the name of the zip

4.extract the single file produced by the first extract in the same directory

You'll have somthing like that =>

directory : save-moodle2-activity-99999-workshop99999-20240116-0945

with these files and directories in it

.

..

.ARCHIVE_INDEX

activities

badges.xml

completion.xml

dir.txt

extract.ps1 (added)

extract.sh (added)

files

files.xml

groups.xml

moodle_backup.log

moodle_backup.xml

outcomes.xml

questions.xml

roles.xml

scales.xml

users.xml


Copy the extract.ps1 or sh file in the directory.

You can execute the .ps1 file on windows by right clicking on it and select execute with powershell

On mac you can do ./extract.sh (go first in the same directory of the script)


After that you'll have a directory _devoir under the directory files. All the file will be in a subdirectory with the username of the creator.


