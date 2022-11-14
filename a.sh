#!/bin/bash

echo "PostgreSQLデータベースのパスワードを入力 (何も入力せずEnterで自動生成)"
read -s PASSWORD_INPUT

if [ -z "$PASSWORD_INPUT" ]; then
  PASSWORD=$(openssl rand -hex 20)
else
  PASSWORD=$PASSWORD_INPUT
fi

echo $PASSWORD
