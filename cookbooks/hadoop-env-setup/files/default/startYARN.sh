#!/bin/bash 
# @(#)This is script to start yarn
# @(#)Usage: startYARN.sh

USER=yarn

## start resource manager and node manager
/usr/hdp/current/hadoop-yarn-resourcemanager/sbin/yarn-daemon.sh start resourcemanager
/usr/hdp/current/hadoop-yarn-nodemanager/sbin/yarn-daemon.sh start nodemanager
