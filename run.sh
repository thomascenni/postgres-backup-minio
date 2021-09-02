#! /bin/sh

set -e

if [ -z "$SCHEDULE" ]
then
      echo "No schedule provided, run once."
      sh backup.sh
else
      echo "Schedule provided: ${SCHEDULE}"
      exec go-cron -s="$SCHEDULE" -p=0 -- /bin/sh backup.sh
fi
