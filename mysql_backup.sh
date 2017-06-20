#!/bin/bash
# Configure --login-path before running this script. See https://stackoverflow.com/questions/20751352/suppress-warning-messages-using-mysql-from-within-terminal-but-password-written
OUTPUT="/backup/mysql"

#rm "$OUTPUT/*gz" > /dev/null 2>&1

#find "$OUTPUT/" -mtime +180 -delete

#databases=`mysql --user=$USER --password=$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
databases=`mysql --login-path=readonly -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != _* ]] ; then
        backupname="$OUTPUT/$db/`date +%Y%m%d`.sql"
        mkdir -p $OUTPUT/$db
        mysqldump --force --single-transaction --opt --login-path=readonly --databases $db > $backupname
        gzip $backupname
    fi
done

