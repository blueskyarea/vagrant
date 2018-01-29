log '>>>>>>>>  hadoop env setup start <<<<<<<<<<'

# Adding HDP repository to yum
bash 'get_hdp_repo' do
  user "root"
  code <<-EOL
    wget -nv "#{node['hdp']['repo']}" -O /etc/yum.repos.d/hdp.repo
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

# Creating hadoop temporary work directory
directory '/hadoop-tmp-work' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

log '>>>>>>>>  hadoop env setup done <<<<<<<<<<'

