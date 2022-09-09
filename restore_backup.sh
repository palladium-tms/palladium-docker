#!/bin/bash

# Correctly configure aws cli before running this script
# `aws configure`

BACKUP_NAME=''

aws s3 cp s3://palladium-backup/"$BACKUP_NAME" .
docker cp "$BACKUP_NAME" palladium-docker-db-1:/tmp/
docker exec -i palladium-docker-db-1 pg_restore -U postgres -f /tmp/"$BACKUP_NAME"
docker exec palladium-docker-db-1 'rm /tmp/$BACKUP_NAME'
rm "$BACKUP_NAME"
