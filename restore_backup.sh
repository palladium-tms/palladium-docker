#!/bin/bash

# Correctly configure aws cli before running this script
# `aws configure`

CPU_COUNT=4
DB_CONTAINER_ID=$(docker-compose ps -q db)
BACKUP_NAME='palladium-backup-2022-09-09-13-25-52.pg_dump'

aws s3 cp s3://palladium-backup/"$BACKUP_NAME" .
docker cp "$BACKUP_NAME" "$DB_CONTAINER_ID":/tmp/
docker exec "$DB_CONTAINER_ID" pg_restore -j $CPU_COUNT -U postgres -d postgres /tmp/"$BACKUP_NAME"
docker exec "$DB_CONTAINER_ID" rm /tmp/$BACKUP_NAME
rm "$BACKUP_NAME"
