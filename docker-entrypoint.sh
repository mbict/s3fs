#!/bin/bash
set -euo pipefail
set -o errexit
set -o errtrace
IFS=$'\n\t'

test $MOUNT_POINT
mkdir -p ${MOUNT_POINT}

echo "${ACCESS_KEY_ID}:${SECRET_ACCESS_KEY}" > /etc/passwd-s3fs && \
chmod 0400 /etc/passwd-s3fs
/usr/bin/s3fs $BUCKET $MOUNT_POINT -f -o url=${ENDPOINT} -o uid=1001,umask=0007,gid=1001 -o endpoint=${REGION},nonempty,allow_other,use_cache=/tmp,max_stat_cache_size=1000,stat_cache_expire=900,retries=5,connect_timeout=10

exec "$@"


