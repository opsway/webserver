# Including this on recipe level intentionally
node.default['apache']['default_site_enabled'] = false

include_recipe "apache2"
include_recipe "apache2::mod_expires"
include_recipe "apache2::mod_deflate"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_status"
include_recipe "apache2::mod_headers"
include_recipe "webserver::mod_rpaf"

template "#{node['apache']['dir']}/sites-available/worker" do
  if node['webserver']['worker_cookbook']
  	cookbook node['webserver']['worker_cookbook']
  end
  source 'worker.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[apache2]'
end

apache_site 'worker'

bash "create_php_apache_dir" do
  code <<-EOF
if [ ! -d "/etc/php5/apache2/" ]; then
mkdir /etc/php5/apache2/
fi
EOF
end


template "/etc/php5/apache2/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(:directives => node['php']['directives'])
  notifies :restart, 'service[apache2]'
end