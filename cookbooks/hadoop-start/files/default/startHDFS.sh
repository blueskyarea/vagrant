#!/bin/bash 
# @(#)This is script to start hdfs
# @(#)Usage: startHDFS.sh

USER=hdfs

## start HDFS
count=`ps aux | grep namenode | grep -v grep | wc -l`
if [ $count = 0 ]; then
  /usr/hdp/current/hadoop-hdfs-namenode/../hadoop/sbin/hadoop-daemon.sh start namenode
fi

count=`ps aux | grep datanode | grep -v grep | wc -l`
if [ $count = 0 ]; then
  /usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh start datanode
fi

## distribute mapreduce jar to HDFS beside application
hdfs dfs -chown -R hdfs:hadoop /
hdfs dfs -chmod -R 775 /
hdfs dfs -mkdir -p /user/hdfs
hdfs dfs -mkdir -p /hdp/apps/2.6.2.0/mapreduce/
hdfs dfs -put /usr/hdp/current/hadoop-client/mapreduce.tar.gz /hdp/apps/2.6.2.0/mapreduce/
hdfs dfs -chown -R hdfs:hadoop /hdp
hdfs dfs -chmod -R 555 /hdp/apps/2.6.2.0/mapreduce
hdfs dfs -chmod -R 444 /hdp/apps/2.6.2.0/mapreduce/mapreduce.tar.gz

## create work directory for mapreduce job history
hdfs dfs -mkdir -p /mr-history/tmp 
hdfs dfs -chmod -R 1777 /mr-history/tmp 
hdfs dfs -mkdir -p /mr-history/done 
hdfs dfs -chmod -R 1777 /mr-history/done
hdfs dfs -chown -R mapred:hadoop /mr-history
hdfs dfs -mkdir -p /app-logs
hdfs dfs -chmod -R 1777 /app-logs 
hdfs dfs -chown yarn /app-logs

## start mapreduce job history 
/usr/hdp/current/hadoop-mapreduce-historyserver/sbin/mr-jobhistory-daemon.sh start historyserver

## definitions for application user
## create application user work directory on HDFS
hdfs dfs -mkdir /user/${CLIENT_USER}
hdfs dfs -chown ${CLIENT_USER}:${CLIENT_USER} /user/${CLIENT_USER}
hdfs dfs -chmod -R 755 /user/${CLIENT_USER}

