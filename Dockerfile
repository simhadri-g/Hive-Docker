FROM ubuntu:18.04
LABEL key="simhadri-g"

RUN apt-get update && \
      apt-get -y install sudo


RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER root
RUN sudo apt-get -y install software-properties-common
RUN sudo add-apt-repository ppa:openjdk-r/ppa
RUN sudo apt-get update


RUN apt-get -y install openjdk-8-jdk 
#RUN ln -s /usr/lib/jvm/java-1.8.0-openjdk-amd64/ đ
#RUN ln -s /usr/lib/jvm/java-1.7.0-openjdk-amd64/ /usr/lib/jvm/java-1.7.0

RUN ln -s /usr/lib/jvm/java-1.8.0-openjdk-arm64/ /usr/lib/jvm/java-1.8.0


RUN apt -y install vim
RUN apt -y install nano
RUN apt -y install wget tar sudo rsync
RUN sudo apt-get update
RUN sudo apt-get -y install apache2
RUN sudo apt-get -y install tree

RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
RUN tar -xvzf hadoop-3.3.6.tar.gz
RUN ln -sf /hadoop-3.3.6 /hadoop

# # replace the path here for local hive jar
# #COPY /<host-machine-path>/apache-hive-4.0.0-alpha-2-SNAPSHOT-bin.tar.gz /
# COPY ./apache-hive-4.0.0-beta-1-SNAPSHOT-bin.tar.gz /
# #RUN wget https://dlcdn.apache.org/hive/hive-4.0.0-alpha-2/apache-hive-4.0.0-alpha-2-bin.tar.gz
# RUN tar -xvzf apache-hive-4.0.0-beta-1-SNAPSHOT-bin.tar.gz
# RUN ln -sf /apache-hive-4.0.0-beta-1-SNAPSHOT-bin /hive

RUN wget https://archive.apache.org/dist/tez/0.10.2/apache-tez-0.10.2-bin.tar.gz
RUN tar -xvzf apache-tez-0.10.2-bin.tar.gz
RUN ln -sf /apache-tez-0.10.2-bin /tez

RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar
RUN apt-get -y install mysql-server mysql-client libmysql-java

# replace the path here for local hive jar
#COPY /<host-machine-path>/apache-hive-4.0.0-alpha-2-SNAPSHOT-bin.tar.gz /
COPY ./apache-hive-4.0.0-beta-2-SNAPSHOT-bin.tar.gz /
#RUN wget https://dlcdn.apache.org/hive/hive-4.0.0-beta-1/apache-hive-4.0.0-alpha-2-bin.tar.gz
RUN tar -xvzf apache-hive-4.0.0-beta-2-SNAPSHOT-bin.tar.gz
RUN ln -sf /apache-hive-4.0.0-beta-2-SNAPSHOT-bin /hive


    

     
RUN  apt-get -y clean all && rm -rf /tmp/* /var/tmp/* 

# Setup sock proxy
RUN apt-get install -y  openssh-server


# passwordless ssh
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN chmod 755 /root && chmod 700 /root/.ssh
RUN passwd --unlock root

RUN apt-get install -y vim mlocate unzip


# Copy configuration files
RUN mkdir /conf
COPY core-site.xml /conf/core-site.xml
COPY hdfs-site.xml /conf/hdfs-site.xml
COPY hadoop-env.sh /conf/hadoop-env.sh
#COPY yarn-site.xml /conf/yarn-site.xml

# COPY mapred-site.xml /conf/mapred-site.xml
COPY hive-site.xml /conf/hive-site.xml
COPY bootstrap.sh /bootstrap.sh

RUN sudo addgroup hadoop
RUN sudo adduser --ingroup hadoop hadoop
RUN sudo addgroup hive
RUN sudo adduser --ingroup hive hive
RUN sudo usermod -a -G hadoop hive

# HDFS ports
EXPOSE 1004 1006 8020 9866 9867 9870 9864 50470 9000

# YARN ports
EXPOSE 8030 8031 8032 8033 8040 8041 8042 8088 10020 19888

# HIVE ports
EXPOSE 9083 10000 8000

# SOCKS port
EXPOSE 1180

# mysql expose
EXPOSE 3306

# HDFS datnode
EXPOSE 9866

# debugger
EXPOSE 8015
