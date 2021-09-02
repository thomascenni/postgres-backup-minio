# postgres-backup-minio

Backup PostgreSQL to MinIO server (supports periodic backups)

This work is heavily inspired by [schickling/postgres-backup-s3](https://github.com/schickling/dockerfiles/tree/master/postgres-backup-s3).
Alpine is updated to 3.14 version with support for PostgreSQL 13.4-r0.
MinIO client is updated to version RELEASE.2021-09-02T09-21-27Z.

## Usage

Docker:
```
docker run \
  -e MINIO_HOST=https://minio.example.com \
  -e MINIO_ACCESSKEY=key \
  -e MINIO_SECRETKEY=secret \
  -e MINIO_BUCKET=mybucket \
  -e POSTGRES_DATABASE=dbname \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_HOST=host.docker.internal \
  thomascenni/postgres-backup-minio
```

### Automatic Periodic Backups

You can additionally set the `SCHEDULE` environment variable like `-e SCHEDULE="@daily"` to run the backup automatically.

More information about the scheduling can be found [here](http://godoc.org/github.com/robfig/cron#hdr-Predefined_schedules).
