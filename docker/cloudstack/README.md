# build
```
$ docker build -t cloudstack .
```

# run
```
$ docker run --name cloudstack -d -p 8080:8080 cloudstack
```

# web-console login  (It takes time to display the login screen)
http://localhost:8080/clients
admin/password

# container login
```
$ docker exec -ti cloudstack /bin/bash
```

# create zones
```
$ docker exec -ti cloudstack python /root/tools/marvin/marvin/deployDataCenter.py -i /root/setup/dev/advanced.cfg
```
