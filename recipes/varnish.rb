package "varnish"

service "varnish" do
  supports :restart => true, :reload => true
  action [ :enable]
end

service "varnishlog" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

template "#{node['varnish']['dir']}/#{node['varnish']['vcl_conf']}" do
  source node['varnish']['vcl_source']
  if node['varnish']['vcl_cookbook']
    cookbook node['varnish']['vcl_cookbook']
  end
  owner "root"
  group "root"
  mode 0644
  notifies :reload, "service[varnish]"
end

template node['varnish']['default'] do
  source "custom-default.erb"
  if node['varnish']['custom_default_cookbook']
    cookbook node['varnish']['custom_default_cookbook']
  end
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[varnish]"
end


temp_file = "/tmp/bad_list";
cookbook_file "#{temp_file}" do
    source "varnish_bad_bot.lst"
    if node['varnish']['bad_bot_list_cookbook']
      cookbook node['varnish']['bad_bot_list_cookbook']
    end
    mode "0644"
    action :create
end

if File.exists?("#{temp_file}")
  bad_list = IO.readlines("#{temp_file}");
  bad_list.each { |a| a.chomp! }
  bad_list.delete_if(&:empty?)
else
  bad_list = []
end

template "#{node['varnish']['dir']}/handle_bot.vcl" do
  if node['varnish']['handle_bot_cookbook']
      cookbook node['varnish']['handle_bot_cookbook']
  end
  owner "root"
  group "root"
  mode 0644
  variables(
      :bad_list => bad_list,
      :ban_user_agent_patterns => node['varnish']['ban_user_agent_patterns'],
      :other_list => node['varnish']['other_bot_list']
  )
  notifies :reload, resources(:service => "varnish")
end

