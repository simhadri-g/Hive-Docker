### Build the docker image:
```
./build
```

### Start docker image:
```
./start.sh
```
### To login to the docker container and access mysql rdbms
```
>docker exec --privileged=true  -it apache-hive-mr  /bin/bash
>>mysql -u hive -p 
(password: hive)
```

### JDBC url to connect via beeline
```
beeline
>>!connect jdbc:hive2://localhost:10001/
```
Username and password is "hive"