# 概要

nginxコンテナのログをfluentdコンテナに送って、fluentdはローカルにファイル保存しかつ、Elasticsearchコンテナにも送信する。
Elasticsearchをkibanaで可視化する。

* 起動
```
docker-compose up -d
```

* 停止
```
docker-compose stop
```

* コンテナ削除
```
docker-compose rm
```

# 接続
* kibana
http://127.0.0.1:5601
