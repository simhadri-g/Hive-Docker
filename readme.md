A hive jar is included by default for the build.

We can build a docker image with a custom hive jar as follow:
1. Replace hive jar in the directory with your custom jar and rename it to
apache-hive-4.0.0-alpha-2-SNAPSHOT-bin.tar.gz
2. The rest of the steps remain the same.

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
docker exec --privileged=true  -it apache-hive-mr  /bin/bash
>>mysql -u hive -p 
(password: hive)
```
Hive logs are found in  :
```/tmp/root/hive.log```

### JDBC url to connect via beeline
```
beeline
>>!connect jdbc:hive2://localhost:10001/
```
Username and password is "hive"


### To check the docker logs
```aidl
docker logs -t apache-hive-mr
```
### To stop 
```aidl
docker stop apache-hive-mr
```
