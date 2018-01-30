#!/bin/bash 

source /hadoop-tmp-work/hadoopDir.conf
source /hadoop-tmp-work/usersAndGroups.conf

echo "Creating datanode dir"
echo ">> ${DFS_DATA_DIR}"
mkdir -p ${DFS_DATA_DIR};
chown -R ${HDFS_USER}:${HADOOP_GROUP} ${DFS_DATA_DIR};
chmod -R 750 ${DFS_DATA_DIR};
echo "====================="

echo "Creating namenode dir"
echo ">> ${DFS_NAME_DIR}"
mkdir -p ${DFS_NAME_DIR};
chown -R ${HDFS_USER}:${HADOOP_GROUP} ${DFS_NAME_DIR};
chmod -R 755 ${DFS_NAME_DIR};
echo "====================="

echo "Creating secondarynamenode dir"
echo ">> ${FS_CHECKPOINT_DIR}"
mkdir -p ${FS_CHECKPOINT_DIR};
chown -R ${HDFS_USER}:${HADOOP_GROUP} ${FS_CHECKPOINT_DIR};
chmod -R 755 ${FS_CHECKPOINT_DIR};
echo "====================="

echo "Creating yarn local dir"
echo ">> ${YARN_LOCAL_DIR}"
mkdir -p ${YARN_LOCAL_DIR};
chown -R ${YARN_USER}:${HADOOP_GROUP} ${YARN_LOCAL_DIR};
chmod -R 755 ${YARN_LOCAL_DIR};
echo "====================="

echo "Creating yarn local log dir"
echo ">> ${YARN_LOCAL_LOG_DIR}"
mkdir -p ${YARN_LOCAL_LOG_DIR};
chown -R ${YARN_USER}:${HADOOP_GROUP} ${YARN_LOCAL_LOG_DIR};
chmod -R 755 ${YARN_LOCAL_LOG_DIR};
echo "====================="

echo "Creating hdfs log and pid dir"
echo ">> ${HDFS_LOG_DIR}"
mkdir -p ${HDFS_LOG_DIR};
chown -R ${HDFS_USER}:${HADOOP_GROUP} ${HDFS_LOG_DIR};
chmod -R 755 ${HDFS_LOG_DIR};
echo "====================="

echo "Creating hdfs pid dir"
echo ">> ${HDFS_PID_DIR}"
mkdir -p ${HDFS_PID_DIR};
chown -R ${HDFS_USER}:${HADOOP_GROUP} ${HDFS_PID_DIR};
chmod -R 755 ${HDFS_PID_DIR}
echo "====================="

echo "Creating yarn log dir"
echo ">> ${YARN_LOG_DIR}"
mkdir -p ${YARN_LOG_DIR};
chown -R ${YARN_USER}:${HADOOP_GROUP} ${YARN_LOG_DIR};
chmod -R 755 ${YARN_LOG_DIR};
echo "====================="

echo "Creating yarn pid dir"
echo ">> ${YARN_PID_DIR}"
mkdir -p ${YARN_PID_DIR};
chown -R ${YARN_USER}:${HADOOP_GROUP} ${YARN_PID_DIR};
chmod -R 755 ${YARN_PID_DIR};
echo "====================="

echo "Creating mapred log dir"
echo ">> ${MAPRED_LOG_DIR}"
mkdir -p ${MAPRED_LOG_DIR};
chown -R ${MAPRED_USER}:${HADOOP_GROUP} ${MAPRED_LOG_DIR};
chmod -R 755 ${MAPRED_LOG_DIR};
echo "====================="

echo "Creating mapred pid dir"
echo ">> ${MAPRED_PID_DIR}"
mkdir -p ${MAPRED_PID_DIR};
chown -R ${MAPRED_USER}:${HADOOP_GROUP} ${MAPRED_PID_DIR};
chmod -R 755 ${MAPRED_PID_DIR};
echo "====================="

echo "Creating zookeeper log dir"
echo ">> ${ZOOKEEPER_LOG_DIR}"
mkdir -p ${ZOOKEEPER_LOG_DIR};
chown -R ${ZOOKEEPER_USER}:${HADOOP_GROUP} ${ZOOKEEPER_LOG_DIR};
chmod -R 755 ${ZOOKEEPER_LOG_DIR};
echo "====================="

echo "Create zookeeper pid dir"
echo ">> ${ZOOKEEPER_PID_DIR}"
mkdir -p ${ZOOKEEPER_PID_DIR};
chown -R ${ZOOKEEPER_USER}:${HADOOP_GROUP} ${ZOOKEEPER_PID_DIR};
chmod -R 755 ${ZOOKEEPER_PID_DIR};
echo "====================="

echo "Creating zookeeper local data dir" 
echo ">> ${ZOOKEEPER_DATA_DIR}"
mkdir -p ${ZOOKEEPER_DATA_DIR}; 
chown -R ${ZOOKEEPER_USER}:${HADOOP_GROUP} ${ZOOKEEPER_DATA_DIR};
chmod -R 755 ${ZOOKEEPER_DATA_DIR};
echo "====================="

echo "Creating zkfc log dir"
echo ">> ${ZOOKEEPER_ZKFC_LOG_DIR}"
mkdir -p ${ZOOKEEPER_ZKFC_LOG_DIR};
chown -R ${ZOOKEEPER_USER}:${HADOOP_GROUP} ${ZOOKEEPER_ZKFC_LOG_DIR};
chmod -R 755 ${ZOOKEEPER_ZKFC_LOG_DIR}
echo "====================="

