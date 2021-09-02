#! /bin/sh
# exit if a command fails
set -e

apk update

# install pg_dump
apk add postgresql-client


# install go-cron
apk add curl
curl -L --insecure https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron
chmod u+x /usr/local/bin/go-cron

# install minio client
wget -O mc https://dl.min.io/client/mc/release/linux-amd64/$MINIO_MC_VERSION
mv mc /usr/local/bin
chmod u+x /usr/local/bin/mc

# cleanup
apk del curl
rm -rf /var/cache/apk/*