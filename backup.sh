#!/bin/bash

FILE_NAME="backup-`date +%Y%m%d`.sql.gz"

# Get variables
source ./.env

mysqldump -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${DB_NAME} | gzip > ${SAVE_DIR}/${FILE_NAME}

if [ -e ${SAVE_DIR}/${FILE_NAME} ]; then

    # Upload to aws
    scp ${SAVE_DIR}/${FILE_NAME} ${REMOTE_USER}@${REMOTE_HOST}:${FILE_NAME}

    # Test results of last command
    if [ "$?" -ne "0" ]; then
        echo "Upload to backups server failed"
        exit 1
    fi

    # Remove the file locally
    rm ${SAVE_DIR}/${FILE_NAME}

    exit 0
fi

echo "Backup file not created"
exit 1