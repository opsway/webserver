include_recipe "webserver"
include_recipe "webserver::ssl"
include_recipe "webserver::varnish"
include_recipe "mysql::client"
include_recipe "nginx"

if node['nginx']['http_auth_user'] != "" 
  htpasswd "#{node['nginx']['dir']}/htpasswd" do
        user node['nginx']['http_auth_user']
        password node['nginx']['http_auth_pass']
        notifies :reload, 'service[nginx]'
  end
end

template "#{node['nginx']['dir']}/sites-available/main" do
  if node['webserver']['nginx_cookbook']
  	cookbook node['webserver']['nginx_cookbook']
  end
  source 'main.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

template "#{node['nginx']['dir']}/sites-available/main-ssl" do
  if node['webserver']['nginx_cookbook']
  	cookbook node['webserver']['nginx_cookbook']
  end
  source 'main-ssl.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

nginx_site 'main'
nginx_site 'main-ssl'
