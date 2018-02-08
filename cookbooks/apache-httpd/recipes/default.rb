log '>>>>>>>> apache httpd <<<<<<<<<<'
# Installing apache httpd
yum_package "httpd" do
  action :install
end

log '>>>>>>>> apache httpd done <<<<<<<<<<'
