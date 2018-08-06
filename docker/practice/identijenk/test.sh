# 作業ディレクトリの移動
pwd && ls -la
cd docker/practice/identidock/
pwd && ls -la

# composeのデフォルト引数
COMPOSE_ARGS=" -f jenkins.yml -p jenkins "

# 古いコンテナがなくなっていることを確認
sudo docker-compose $COMPOSE_ARGS stop
sudo docker-compose $COMPOSE_ARGS rm --force -v

# システムのビルド
sudo docker-compose $COMPOSE_ARGS build --no-cache
sudo docker-compose $COMPOSE_ARGS up -d

# ユニットテストの実行
sudo docker-compose $COMPOSE_ARGS run --no-deps --rm -e ENV=UNIT identidock
ERR=$?

# ユニットテストをパスしたならシステムテストを実行
if [ $ERR -eq 0 ]; then
  IP=$(sudo docker inspect -f {{.NetworkSettings.IPAddress}} jenkins_identidock_1)
  CODE=$(curl -sL -w "%{http_code}" $IP:9090/monster/bla -o /dev/null) || true
  if [ $CODE -eq 200 ]; then
    echo "Test passed - Tagging"
    HASH=$(git rev-parse --short HEAD)
    sudo docker tag jenkins_identidock megun/identidock:$HASH
    sudo docker tag jenkins_identidock megun/identidock:newest
    echo "Pushing"
    sudo docker login -e $EMAIL -u $UNAME -p $PASS
    sudo docker push megun/identidock:$HASH
    sudo docker push megun/identidock:newest
  else
    echo "Site returned " $CODE
    ERR=1
  fi
fi

# システムテスト停止
sudo docker-compose $COMPOSE_ARGS stop
sudo docker-compose $COMPOSE_ARGS rm --force -v

return $ERR
