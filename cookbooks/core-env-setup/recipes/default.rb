# Set timezone to Japan
bash 'set_timezone_Japan' do
  user "root"
  code <<-EOL
    mv /etc/localtime /etc/localtime.bak
    ln -s /usr/share/zoneinfo/Japan /etc/localtime
  EOL
end

# Set hostname
bash 'hostname_localhost' do
  user "root"
  code <<-EOL
    hostname localhost
  EOL
end

# Turn off firewall function
execute 'stop-firewall' do
  user 'root'
  command 'chkconfig --level 123456 iptables off'
  action :run  
end

# Set user
user 'hdpuser' do
  password 'ABc5nAEJ2KPIs'
  home '/home/hdpuser'
  supports :manage_home => true
  shell '/bin/bash'
  comment 'Hadoop Application User'
end

directory '/home/hdpuser/.ssh' do
  owner 'hdpuser'
  group 'hdpuser'
  mode '0700'
  action :create
end

execute 'set_hdpuser_sudoer' do
  user 'root'
  command 'echo "hdpuser ALL=(ALL)ALL" >> /etc/sudoers'
  action :run  
end

# Installing wget command
yum_package "wget" do
  action :install
end
