zabbix-server環境構築
===

# 使用方法
`vagrant up` で一通り環境作成されます。
```bash
$ vagrant up
```

# 初回接続
`http://127.0.0.1:8080` に接続。
wizard従い設定してく。
`Configure DB connection` の user/passowrd は　デフォルト `zabbix/password`

web-guiログインアカウントは
Admin/zabbix

# provisionだけ流し直す
```bash
$ vagrant provision
```
