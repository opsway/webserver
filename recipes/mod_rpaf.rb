mod_rpaf_source_dir = "/usr/local/src"

mod_filename = "mod_rpaf.so"

case node['platform']
when "centos", "redhat", "fedora"
  
  package "httpd-devel" do
      action :install
  end

  package "gcc" do
      action :install
  end

  script "install_mod_rpaf" do
    interpreter "bash"
    user "root"
    cwd "#{mod_rpaf_source_dir}"
    action :nothing
    code <<-EOH
    tar xvfz #{mod_rpaf_source_dir}/mod_rpaf-0.6.tar.gz
    cd #{mod_rpaf_source_dir}/mod_rpaf-0.6
    apxs -i -c -n mod_rpaf-2.0.so mod_rpaf-2.0.c
    EOH
  end

  directory "/usr/local/src"

  remote_file "#{mod_rpaf_source_dir}/mod_rpaf-0.6.tar.gz" do
    source "http://stderr.net/apache/rpaf/download/mod_rpaf-0.6.tar.gz"
    mode "0644"
    action :create_if_missing
    notifies :run, "script[install_mod_rpaf]", :immediately
  end

  mod_filename = "mod_rpaf-2.0.so"


when "debian" , "ubuntu"
    package "libapache2-mod-rpaf" do
      action :install
    end    
end

apache_module "rpaf" do
  conf false
  filename mod_filename 
end

proxy_ip_list = Array.new

#Pushing default proxy - itself
proxy_ip_list << "127.0.0.1"

template "#{node['apache']['dir']}/mods-available/rpaf.conf" do
  source "rpaf.conf.erb"
  notifies :reload, resources(:service => "apache2")
  mode 0644
  variables(
      :proxies => proxy_ip_list
  ) 
end



