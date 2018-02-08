log '>>>>>>>>  hadoop env setup start <<<<<<<<<<'

# Adding HDP repository to yum
bash 'get_hdp_repo' do
  user "root"
  code <<-EOL
    wget -nv #{node["hdp"]["repo"]} -O /etc/yum.repos.d/hdp.repo
  EOL
end

# Installing hadoop core package
%w(
  zookeeper
  hadoop
  hadoop-hdfs
  hadoop-yarn
  hadoop-mapreduce
  hadoop-client
).each do |package_name|
  package package_name do
    action :install
  end
end

# Creating hadoop setup directory
directory "/hadoop-setup" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Copying modules for hadoop
%w(
  hadoopDir.conf
  usersAndGroups.conf
  createHadoopDir.sh
  hadoop_bash_profile
  initHDFS.sh
).each do |module_name|
  cookbook_file "#{node["hadoop"]["setup"]}/#{module_name}" do
    source "#{module_name}"
    owner 'root'
    group 'root'
    mode '0755'
  end
end

# Creating hadoop directory
bash 'create_hadoop_directory' do
  user "root"
  code <<-EOL
    "#{node["hadoop"]["setup"]}"/createHadoopDir.sh > "#{node["hadoop"]["setup"]}"/createHadoopDir.log
  EOL
end

# Creating hadoop conf directory
directory '/hadoop_conf' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Copying hadoop conf files
%w(
  core-site.xml
  hadoop-env.sh
  hdfs-site.xml
  mapred-env.sh
  mapred-site.xml
  slaves
  yarn-env.sh
  yarn-site.xml 
  capacity-scheduler.xml
).each do |conf_file_name|
  cookbook_file "/hadoop_conf/#{conf_file_name}" do
    source "conf/#{conf_file_name}"
    owner 'root'
    group 'root'
    mode '0755'
  end
end

bash 'deploy_hadoop_conf' do
  user "root"
  code <<-EOL
    if [ -d /etc/hadoop/conf.bak ]; then
      rm -rf /etc/hadoop/conf.bak
    fi
    if [ -d /etc/hadoop/conf ]; then 
      mv /etc/hadoop/conf /etc/hadoop/conf.bak
    fi
    mkdir -p /etc/hadoop
    cp -r /hadoop_conf /etc/hadoop/conf
  EOL
end

# Deploying .bash_profile for each user
bash 'deploy_common_bash_profile' do
  user "root"
  code <<-EOL
    HDFS_HOME=$(eval echo ~hdfs)
    cp /hadoop-setup/hadoop_bash_profile ${HDFS_HOME}/.bash_profile

    YARN_HOME=$(eval echo ~yarn)
    cp /hadoop-setup/hadoop_bash_profile ${YARN_HOME}/.bash_profile

    MAPRED_HOME=$(eval echo ~mapred)
    cp /hadoop-setup/hadoop_bash_profile ${MAPRED_HOME}/.bash_profile

    ZOOKEEPER_HOME=$(eval echo ~zookeeper)
    cp /hadoop-setup/hadoop_bash_profile ${ZOOKEEPER_HOME}/.bash_profile
  EOL
end

# Deploying zookeeper configuration
%w(
  zoo.cfg
  zookeeper-env.sh
).each do |conf_element_name|
  cookbook_file "/etc/zookeeper/conf/#{conf_element_name}" do
    source "#{conf_element_name}"
    owner 'root'
    group 'root'
    mode '0755'
  end
end

bash 'set_containter_executor_permission' do
  user 'root'
  code <<-EOL
    chown -R root:hadoop /usr/hdp/current/hadoop-yarn-nodemanager/bin/container-executor
    chmod -R 650 /usr/hdp/current/hadoop-yarn-nodemanager/bin/container-executor
  EOL
end

bash 'create_directory_for_hadoop_cache' do
  user 'root'
  code <<-EOL
    if [ ! -d /var/local/hadoop/cache ]; then 
      mkdir -p /var/local/hadoop/cache
      chmod 777 /var/local/hadoop/cache
    fi
  EOL
end

# Define hadoop client user
CLIENT_USER="hdpuser"
group "hadoop" do
  action :modify
  members "#{CLIENT_USER}"
  append true
end

# Initialize HDFS
bash 'init_hdfs' do
  user 'hdfs'
  code <<-EOL
    HDFS_HOME=$(eval echo ~hdfs)
    /hadoop-setup/initHDFS.sh > ${HDFS_HOME}/initHDFS.log
  EOL
end

log '>>>>>>>>  hadoop env setup done <<<<<<<<<<'

