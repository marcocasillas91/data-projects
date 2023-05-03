#!/bin/sh

dbname=$(mysql -e "show databases"|grep $1)
#dbname=$(mysql -e "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$1'" | grep $1)
backupdir=$2

if  [ $dbname != $1 ]
then
    echo "Database does not exist  :("
    exit
else
    if [ ! -d $backupdir ] 
    then
        mkdir $backupdir
    fi

    #Setting up backup name
    now=$(date +%d-%m-%y_%H-%M-%S)
    backupname=$dbname\_$now

    echo "now is $now"
    echo "dbname is $dbname"
    echo "backupname is $backupname"

    if mysqldump $dbname > $backupdir/$backupname
    then
        echo "Backup from db $dbname was successfully applied!"
    else
        echo "Something went wrong with backup from db $dbname  :("
    fi
fi