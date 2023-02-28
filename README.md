# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Docker Composeで起動する

### 初回起動

```sh
git clone "リポジトリのURL"
```

してから

```sh
cd diet_app

# 初期設定
bash docker-env-gen.sh

# ビルド。時間かかる
docker compose build

# 起動可能か確認。できたらCtrl+Cで終了。
# tcp:// から始まるURLが表示されていれば起動できている。
# 起動できてなければ何回か試してみる
docker compose up # できたらCtrl+Cで終了

docker compose run web bash # コンテナの中に入る

# コンテナ内で
rake db:create
rake db:migrate RAILS_ENV=development
rake assets:precompile # 初回は時間かかる
exit # コンテナから出る

docker compose down

# 本番起動
docker compose up -d
```

### IPアドレスでなくドメイン名でもアクセスできるようにする

- [config/environments/development.rb](config/environments/development.rb#L63) を書き換えてホストを設定する。
  - `docker compose restart` で反映。
  - 本来は環境変数でやるべきなのだがまぁ・・・
- Ubuntuの場合、 `apt install nginx` してから、 [dist/nginx.conf](dist/nginx.conf) を適当に弄って `/etc/nginx/sites-enabled/dietapp.conf` あたりに置く。
  - `sudo nginx -t` で設定ミスをチェック。
  - `sudo systemctl restart nginx` で反映。
  - OSによってconfファイルの置き場所が変わるかも。インストールされた `/etc/nginx` の構造を見て適当に。

### アップデート

`cd`コマンドで`diet_app`フォルダーに入ってから

```sh
git fetch origin
git pull origin main --ff-only
# できなければ(mainの内容でローカルフォルダを完全初期化): git reset --hard origin/main

# 以下初回起動と同じ
docker compose build
docker compose down
docker compose up # できたらCtrl+C
docker compose run web bash

# コンテナ内
rake db:migrate RAILS_ENV=development
rake assets:precompile
exit # コンテナから出る

docker compose restart
```

### データの削除

`docker compose down`で終了してからやること。

```sh
# Ruby on Rails側のキャッシュを削除
rm -rf tmp/cache tmp/sockets tmp/development_secret.txt tmp/restart.txt

# データベースを削除 （超注意！）
# 環境により sudo をつけないと実行できないことがある
# rm -rf tmp/db
```

### データのバックアップ・復元

```sh
# カスタム形式(バイナリ)でバックアップ
docker compose run -T db pg_dump -hdb -Uuser -Fc diet_app_development > pgdump.bin

# カスタム形式(バイナリ)から上書き復元
docker compose run -T db pg_restore -hdb -Uuser -ddiet_app_development -c < pgdump.bin
```
