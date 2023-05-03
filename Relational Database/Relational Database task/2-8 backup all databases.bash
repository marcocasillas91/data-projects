#!/bin/sh

if mysqldump --all-databases --user=root --password > all-databases-backup.sql
then
    echo "Backup of all databases performed succesfully."
else
    echo "Something went wrong while performing backup."
    rm all-databases-backup.sql
    exit
fi

if [ -f '/home/project/all_databases-backup.sql' ]
then 
    echo "File was not created"
else
    echo "File was indeed created!"
fi 

#Create folder in tmp

current_time_folder=$(date +%Y%m%d)
folderpath=/tmp/$current_time_folder
#folderpath can also be /tmp/mysqldumps/<current date>/ 

if [ ! -d $folderpath ]
then 
    echo "Creating new backup folder"
    mkdir $folderpath
fi


#move backup
mv all-databases-backup.sql  $folderpath

if [ ! -f '/home/project/all_databases-backup.sql' ]
then
    echo "File was moved"
else
    echo "An issue ocurred while moving the file"
fi