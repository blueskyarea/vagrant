#!/bin/bash 
# @(#)This is script to start yarn
# @(#)Usage: startYARN.sh

USER=yarn

## start mapreduce job history
count=`ps aux | grep historyserver | grep -v grep | wc -l`
if [ $count = 0 ]; then
  /usr/hdp/current/hadoop-mapreduce-historyserver/sbin/mr-jobhistory-daemon.sh start historyserver
fi

## start resource manager and node manager
count=`ps aux | grep resourcemanager | grep -v grep | wc -l`
if [ $count = 0 ]; then
  /usr/hdp/current/hadoop-yarn-resourcemanager/sbin/yarn-daemon.sh start resourcemanager
fi

count=`ps aux | grep nodemanager | grep -v grep | wc -l`
if [ $count = 0 ]; then
  /usr/hdp/current/hadoop-yarn-nodemanager/sbin/yarn-daemon.sh start nodemanager
fi

