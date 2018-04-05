# MySQL Backup and Save Remote

A quick and easy mysql script to backup a mysql database and store it on a remote server

1. Clone the repo or copy the raw files to the server you want to backup the database on

2. Change the variables in `.env`. Remember we assume the user you use to store on the remote server has password free ssh access via a public key.

    export MYSQL_USER=root
    export MYSQL_PASSWORD=password
    export SAVE_DIR="/root/backups"
    export DB_NAME="mydb"
    export REMOTE_USER="ubuntu"
    export REMOTE_HOST="example.com"

3. Test out the script and fix any issues

    bash /root/utils/backup.sh

4. Once you are happy that it works add a cronjob:

    crontab -e

5. Add the entry

    0 5 * * * /usr/bin/env bash /<path>/<to>/backup.sh &>> /<path>/<to>/logs/backup.log
