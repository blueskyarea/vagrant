#!/bin/bash 
# @(#)This is script to initialize hdfs
# @(#)Usage: initHDFS.sh

USER=hdfs
CLIENT_USER=hdpuser

## remove old HDFS image
rm -rf /var/local/hadoop/cache/hdfs/nn/current/
rm -rf /var/local/hadoop/cache/hdfs/dn/current/

## initialize HDFS
/usr/hdp/current/hadoop-hdfs-namenode/bin/hdfs --config /etc/hadoop/conf namenode -format
