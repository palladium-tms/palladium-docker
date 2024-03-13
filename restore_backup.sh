#!/bin/bash

echo 'The script restores the default state of the \
     public schema, which will delete all data'

source lib/survey.sh

# Correctly configure aws cli before running this script
# `aws configure`

CPU_COUNT=4
DB_CONTAINER_ID=$(docker-compose ps -q db)
BACKUP_NAME="${BACKUP_NAME:-unknown-backup}"

# download dump
aws s3 cp s3://palladium-backup/"$BACKUP_NAME" .

# reset the public schema & define access privileges
docker exec \
-u postgres \
"$DB_CONTAINER_ID" \
psql -c \
'DROP SCHEMA public CASCADE; CREATE SCHEMA public; GRANT ALL ON SCHEMA public TO postgres; GRANT ALL ON SCHEMA public TO public;'

# restore pg_backup
docker cp "$BACKUP_NAME" "$DB_CONTAINER_ID":/tmp/
docker exec "$DB_CONTAINER_ID" \
                    pg_restore \
                    -j $CPU_COUNT \
                    -U postgres \
                    -d postgres \
                    /tmp/"$BACKUP_NAME"
docker exec "$DB_CONTAINER_ID" rm /tmp/"$BACKUP_NAME"

rm "$BACKUP_NAME"
