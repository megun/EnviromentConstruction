0. ECRリポジトリ作成

1. Dockerログイン
```
$(aws ecr get-login --no-include-email --region ap-northeast-1)
```

2. BuildしてDockerイメージ作成
```
docker build -t sample-nginx .
```

3. イメージにタグ付け
```
docker tag sample-nginx:latest 123456789123.dkr.ecr.ap-northeast-1.amazonaws.com/sample-nginx:latest
```

4. イメージのプッシュ
```
docker push 123456789123.dkr.ecr.ap-northeast-1.amazonaws.com/sample-nginx:latest
```
