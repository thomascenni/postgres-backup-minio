#! /bin/sh

set -e
set -o pipefail

if [ -z "$MINIO_ACCESSKEY" ]; then
    echo "You need to set the MINIO_ACCESSKEY environment variable."
    exit 1
fi

if [ -z "$MINIO_SECRETKEY" ]; then
    echo "You need to set the MINIO_SECRETKEY environment variable."
    exit 1
fi

if [ -z "$MINIO_HOST" ]; then
    echo "You need to set the MINIO_HOST environment variable."
    exit 1
fi

if [ -z "$MINIO_BUCKET" ]; then
    echo "You need to set the MINIO_BUCKET environment variable."
    exit 1
fi

if [ -z "$POSTGRES_DATABASE" ]; then
  echo "You need to set the POSTGRES_DATABASE environment variable."
  exit 1
fi

if [ -z "$POSTGRES_HOST" ]; then
  echo "You need to set the POSTGRES_HOST environment variable."
  exit 1
fi

if [ -z "$POSTGRES_PORT" ]; then
  POSTGRES_PORT=5432
fi

if [ -z "$POSTGRES_USER" ]; then
  echo "You need to set the POSTGRES_USER environment variable."
  exit 1
fi

if [ -z "$POSTGRES_PASSWORD" ]; then
  echo "You need to set the POSTGRES_PASSWORD environment variable."
  exit 1
fi

export PGPASSWORD=$POSTGRES_PASSWORD
POSTGRES_HOST_OPTS="-h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -F t"

echo "Creating dump of ${POSTGRES_DATABASE} database from ${POSTGRES_HOST} ..."

pg_dump $POSTGRES_HOST_OPTS $POSTGRES_DATABASE > dump.tar

echo "Creating MinIO alias ..."
mc alias set minio_alias $MINIO_HOST $MINIO_ACCESSKEY $MINIO_SECRETKEY

echo "Uploading dump to $MINIO_BUCKET ..."
mc cp dump.tar $ALIAS/$MINIO_BUCKET/${POSTGRES_DATABASE}_$(date +"%Y-%m-%dT%H:%M:%SZ").tar
echo "SQL backup uploaded successfully."

rm dump.tar
