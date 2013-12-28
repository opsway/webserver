#Copy SSL certificates and keys

directory "#{node['nginx']['dir']}/ssl" do
	owner "root"
    group "#{node['nginx']['group']}"
    mode "0644"
    recursive true
end

%w{cer key}.each do |key_type|
	key_filename = "#{node['nginx']['dir']}/ssl/#{node['nginx']['ssl']['filename']}.#{key_type}"
	file key_filename do
	    owner "root"
	    group "root"
	    mode "0644"
	    action :create_if_missing
	end

	case node['plafrorm']
        when "debian","ubuntu"
            echo_command = "echo \"#{node['nginx']['ssl'][key_type]}\" > #{key_filename}"
        when "redhat","centos","scientific","fedora","suse","amazon"
            echo_command = "echo -e \"#{node['nginx']['ssl'][key_type]}\" > #{key_filename}"
        else 
            echo_command = "echo \"#{node['nginx']['ssl'][key_type]}\" > #{key_filename}"
    end

    execute "Create file with given content" do
	  command "#{echo_command}"
	  action :run
	end
end