log '>>>>>>>>  hadoop-start <<<<<<<<<<'

# Creating hadoop start directory
bash 'create_hadoop_start' do
  user "root"
  code <<-EOL
    if [ -d /hadoop_start ]; then
      rm -rf /hadoop_start
    fi
    mkdir -p /hadoop_start
  EOL
end

# Deploying script files to start hadoop
%w(
  startHDFS.sh
  startYARN.sh
).each do |script_name|
  cookbook_file "/hadoop_start/#{script_name}" do
    source "#{script_name}"
    owner 'root'
    group 'root'
    mode '0755'
  end
end

# Start HDFS
bash 'start_hdfs' do
  user 'hdfs'
  code <<-EOL
    HDFS_HOME=$(eval echo ~hdfs)
    /hadoop_start/startHDFS.sh > ${HDFS_HOME}/startHDFS.log
  EOL
end

# Start YARN
bash 'start_yarn' do
  user "yarn"
  code <<-EOL
    YARN_HOME=$(eval echo ~yarn)
    /hadoop_start/startYARN.sh > ${YARN_HOME}/startYARN.log
  EOL
end

# Start httpd for configurations
bash 'open_configuration' do
  user "root"
  code <<-EOL
    if ! [ -h /var/www/html/hadoop-conf ] || ! [ -h /var/www/html/hbase-conf ]; then 
      rm /var/www/html/*
      cd /var/www/html
      ln -s /etc/hadoop/conf hadoop-conf
      ln -s /etc/hbase/conf hbase-conf
    fi
    service httpd start
  EOL
end

log '>>>>>>>>  hadoop-start-done <<<<<<<<<<'

