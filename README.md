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
docker compose up # これで起動できたか確認。 tcp:// から始まるURLが表示されていれば起動できている。

docker compose run web bash # コンテナの中に入る

# コンテナ内で
rake db:create
rake db:migrate RAILS_ENV=development
rake assets:precompile # 初回は時間かかる

# コンテナから出る
exit

# 本番起動
docker compose up -d
```

### アップデート

`cd`コマンドで`diet_app`フォルダに入ってから

```sh
git fetch origin
git pull origin master

# 以下初回起動と同じ
docker compose build
docker compose up
docker compose up -d
```

### データの削除

`docker compose down`で終了してからやること。

```sh
# Ruby on Rails側のキャッシュを削除
rm -rf tmp/cache tmp/sockets tmp/development_secret.txt tmp/restart.txt

# データベースを削除 （超注意！）
# sudo をつけないと実行できなかったりする
# rm -rf tmp/db
```
