#!/bin/bash

# Correctly configure aws cli before running this script
# `aws configure`

BACKUP_NAME=''

aws s3 cp s3://palladium-backup/"$BACKUP_NAME" .
zcat "$BACKUP_NAME" | docker exec -i palladium-docker_db_1 psql -U postgres
rm "$BACKUP_NAME"
