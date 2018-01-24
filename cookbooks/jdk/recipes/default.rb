log '>>>>>>>> jdk <<<<<<<<<<'
# Installing Java Development Kit
JDK_VERSION="#{node['java']['version']}"
BUILD_NO="#{node['java']['build']}"
JAVA_RPM_NAME="jdk-#{JDK_VERSION}-linux-x64.rpm"
JDK_DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jdk/#{JDK_VERSION}-#{BUILD_NO}/2f38c3b165be4555a1fa6e98c45e0808/#{JAVA_RPM_NAME}"

bash 'download_jdk' do
  not_if { ::File.exists?("/home/hdpuser/download/#{JAVA_RPM_NAME}") }
  user "hdpuser"
  code <<-EOL
    wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" #{JDK_DOWNLOAD_URL} -O /home/hdpuser/download/#{JAVA_RPM_NAME}
  EOL
end

package 'install_jdk' do
  source "/home/hdpuser/download/#{JAVA_RPM_NAME}"
  provider Chef::Provider::Package::Rpm
  action :install
end

log '>>>>>>>> jdk done <<<<<<<<<<'

