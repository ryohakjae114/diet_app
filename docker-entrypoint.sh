#!/bin/bash
set -e

# dockerでvolumeをマウントしたときのファイルのowner問題
# https://qiita.com/yohm/items/047b2e68d008ebb0f001
USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
useradd -u $USER_ID -o -m user || usermod -u $USER_ID -o user
groupmod -g $GROUP_ID user
export HOME=/home/user

echo "$(id -u user)"

echo "doing rm"
# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

echo "doing exec (using gosu)"
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec /usr/sbin/gosu user "$@"
