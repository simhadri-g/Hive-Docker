#!/bin/bash

eg='\033[0;32m'
enc='\033[0m'
echoe () {
	OIFS=${IFS}
	IFS='%'
	echo -e $@
	IFS=${OIFS}
}

gprn() {
	echoe "${eg} >> ${1}${enc}"
}


## Setup ENV variables

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

export HDFS_NAMENODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"

export HADOOP_HOME="/hadoop"
export HADOOP_ROOT_LOGGER=DEBUG
export HADOOP_COMMON_LIB_NATIVE_DIR="/hadoop/lib/native"

## Add it to bashrc for starting hadoop
echo 'export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' >> ~/.bashrc
echo 'export HADOOP_HOME="/hadoop"' >> ~/.bashrc


rm /hadoop
ln -sf /hadoop-3.3.1 /hadoop

ln -sf /apache-hive-4.0.0-alpha-2-SNAPSHOT-bin /hive

cp /conf/core-site.xml /hadoop/etc/hadoop
cp /conf/hdfs-site.xml /hadoop/etc/hadoop
cp /conf/hadoop-env.sh /hadoop/etc/hadoop
cp /conf/mapred-site.xml /hadoop/etc/hadoop
cp /conf/yarn-site.xml /hadoop/etc/hadoop
cp /conf/hive-site.xml /hive/conf/

cp /mysql-connector-java-8.0.28.jar /hive/lib

gprn "set up mysql"
sudo service mysql start

# Set root password
mysql -uroot -e "set password = PASSWORD('root');"
mysql -uroot -e "grant all privileges on *.* to 'root'@'localhost' identified by 'root';"
mysql -uroot -e "CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'hive'@'localhost';"
mysql -uroot -e "CREATE USER 'hive'@'%' IDENTIFIED BY 'hive';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'hive'@'%';"
mysql -uroot -e "FLUSH PRIVILEGES;"

service ssh start

gprn "start yarn"
hadoop/sbin/start-yarn.sh &
sleep 5

gprn "Formatting name node"
hadoop/bin/hdfs namenode -format

gprn "Start hdfs"
hadoop/sbin/start-dfs.sh

jps

#mkdir -p /hive/warehouse -dbType mysql  -initSchemaTo 4.0.0-alpha-1


gprn "Set up metastore DB"
hive/bin/schematool -userName hive -passWord 'hive' -dbType mysql  -initSchemaTo 4.0.0-alpha-2

gprn "Start HMS server"
hive/bin/hive --service metastore -p  10000 &

gprn "Sleep and wait for HMS to be up and running"
sleep 20

gprn "Start HiveServer2"
hive/bin/hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10001 --hiveconf hive.execution.engine=mr

#To attach a debugger use --debug as follows. The remote debugger can be attached on port 8000.
#hive/bin/hive --service hiveserver2 --debug --hiveconf hive.server2.thrift.port=10001 --hiveconf hive.execution.engine=mr

sleep 20000
