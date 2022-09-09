#!/bin/bash

# Correctly configure aws cli before running this script
# `aws configure`

DB_CONTAINER_ID=$(docker-compose ps -q db)

DATE=$(date '+%Y-%m-%d-%H-%M-%S')
BACKUP_NAME=palladium-backup-$DATE.pg_dump
echo "Dump database"
docker exec -it "$DB_CONTAINER_ID" bash -c 'pg_dump --format=custom -U postgres postgres > /tmp/outfile'
echo "Copy backup to host"
docker cp "$DB_CONTAINER_ID":/tmp/outfile "$BACKUP_NAME"
echo 'Deleting from container'
docker exec -it "$DB_CONTAINER_ID" bash -c 'rm /tmp/outfile'
echo 'Loading to s3'
aws s3 cp "$BACKUP_NAME" s3://palladium-backup/"$BACKUP_NAME"
echo 'Removing from host'
rm "$BACKUP_NAME"
