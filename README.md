# GrapeSlack

Slackの投稿をまとめるためのアプリケーションです。

## 動作環境

* ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin14]

* Rails 5.1.0

* mysql  Ver 14.14 Distrib 5.7.12, for osx10.10 (x86_64) using  EditLine wrapper

* Redis server v=3.2.9

## 事前準備

以下の環境変数を用意する。

```bash
export SLACK_API_KEY=
export SLACK_API_SECRET=
export SLACK_API_TOKEN=

# 以下はデプロイ時に必要
export DEVISE_KEY_BASE=
export SECRET_KEY_BASE=
export GRAPESLACK_DATABASE_PASSWORD=
export GRAPESLACK_DATABASE_HOST=
export GRAPESLACK_REDIS_PASSWORD=
export GRAPESLACK_REDIS_HOST=
```

[direnvを使うとプロジェクト毎に環境変数を設定出来る](http://qiita.com/kompiro/items/5fc46089247a56243a62)

## 動作確認

### redisを起動させる
[foreman](https://github.com/ddollar/foreman)を使っている。

```
bunlde exec foreman start
```

### rails側(セットアップ・サーバー起動)
```
bundle exec rake db:setup
rails s
```
