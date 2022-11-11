#!/bin/bash

echo "PostgreSQLデータベースのパスワードを入力してEnter (何も入力せずEnterで自動生成)"
read -s PASSWORD_INPUT

if [ -z "$PASSWORD_INPUT" ]; then
  PASSWORD=$(openssl rand -hex 31)
else
  PASSWORD=$PASSWORD_INPUT
fi

sed \
  -e "s|<<DB_PASSWORD>>|$PASSWORD|" \
  -e "s|<<UID>>|$(id -u $USER)|" \
  -e "s|<<GID>>|$(id -g $USER)|" \
  .env.base > .env
