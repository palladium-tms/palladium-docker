# apt install awscli
# aws configure

DB_USER='postgres'
DB_PASS=''
DB_BASE='postgres'
CONTAINER_NAME='palladium-docker_db_1_2ee01774bd29'


DATE=`date '+%Y-%m-%d-%H-%M-%S'`
BACKUP_NAME=palladium-backup-$DATE.tar.gz

docker exec -it $CONTAINER_NAME bash -c 'pg_dump -U postgres postgres > /tmp/outfile'
docker cp $CONTAINER_NAME:/tmp/outfile $BACKUP_NAME
docker exec -it $CONTAINER_NAME bash -c 'rm /tmp/outfile'

aws s3 cp $BACKUP_NAME s3://palladium-backup/$BACKUP_NAME
rm $BACKUP_NAME



