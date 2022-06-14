###Build the docker image:
```aidl
./build
```

###Start docker image:
```aidl
./start.sh
```
###To login to the docker container and access mysql rdbms
```aidl
docker exec --privileged=true  -it apache-hive-mr  /bin/bash
>>mysql -u hive -p 
(password: hive)
```

###JDBC url to connect via beeline
```aidl
beeline
>>!connect jdbc:hive2://localhost:10001/
```
User name and password is "hive"