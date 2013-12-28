default['nginx']['ssl']['key'] = "-----BEGIN RSA PRIVATE KEY-----\nMIICXAIBAAKBgQCkexLftkPKphiJLQbGjyDUXzIQc1fKStDW22xjDWaA+GU5Yewd\nr5qCSmqtxbaeaa6UEZXK3IGnjpDzE//4PCn9QJkGPVCycJuW8suI8UUDhD3CnR5U\nHjXOTFkUv9pOf5EPwGu0prshpOU4A8K1JhuvAPZpNAgr/m0GvMKqj3f7JwIDAQAB\nAoGBAJYMGHmxAkL6JuPtCYNVyrMybK+JKYtHmSCIZ2YtMVdyQpWIeSfTrHYzgQIp\nnaEB89rr9+RqKHU8n4rAsgA4kmwYxsVh0H9GhNO3eDTgV61UsatzTMJLnFmZgShu\n12ilGODC7Jgmh+33Scn6yD/Bcdt5LViVb3d2HbhTizOFuURhAkEA2lfVJqj6xt5S\nYhtaCROUgU+nu8YRlEICQWIpkogxmP5Ialc7B+tpguTZqO9jReLoxkME/b+L+okV\naGIUlhsQLwJBAMDZI9RAWMVbfjdIGt18Ytcwqa/0u3WRSkZnNV/djVnNaFaHLwHN\nCWG1jJJTtQnPQ2/0vCAews/gfVOTBcNSTokCQCxtSMK4CWbjn9G0jQphwIrbQV70\nu2j2UW0qYxkcuzLNMsDohOtknDB1DlDQfNuggwqsYlybWAkfUYrOwi+UzCMCQBGH\nazdOxgLiZx2VQ0Pgm4dd1/6zaxqroym1Fefp1oBUKGi9DuvF/FVSUD24uBr1KPcT\nMspkoWaNzDZ9haeUYqkCQHHQqy5LvfTo6mpxrJ4sBUL+5gMRtixsIBaPcWpIcgJA\nx+GAmvtLrrXYcze/h5fpogcuW8s/PRCn+2ljIuZ9IGU=\n-----END RSA PRIVATE KEY-----"
default['nginx']['ssl']['cer'] = "-----BEGIN CERTIFICATE-----\nMIICATCCAWoCCQC0fs9yO3Qi9TANBgkqhkiG9w0BAQUFADBFMQswCQYDVQQGEwJF\nVTETMBEGA1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50ZXJuZXQgV2lkZ2l0\\ncyBQdHkgTHRkMB4XDTEyMDgxMzA5MTUyMVoXDTEzMDgxMzA5MTUyMVowRTELMAkG\nA1UEBhMCRVUxEzARBgNVBAgMClNvbWUtU3RhdGUxITAfBgNVBAoMGEludGVybmV0\nIFdpZGdpdHMgUHR5IEx0ZDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEApHsS\n37ZDyqYYiS0Gxo8g1F8yEHNXykrQ1ttsYw1mgPhlOWHsHa+agkpqrcW2nmmulBGV\nytyBp46Q8xP/+Dwp/UCZBj1QsnCblvLLiPFFA4Q9wp0eVB41zkxZFL/aTn+RD8Br\ntKa7IaTlOAPCtSYbrwD2aTQIK/5tBrzCqo93+ycCAwEAATANBgkqhkiG9w0BAQUF\nAAOBgQCcWMWIu7Z2twR94HuYZ5STPjMtG8rZg6XvPz86OEASlZznPcYp2zHso8xc\n6CRWbonM/hdHjdBFmIhlDe3xfeODH9CJiEnI+dLiUGlwP2A6eyCcTFucK6vjxhrW\nfSS1tZFlc0+iTObKWV2km13hy96N0xAieunKagJDB0WN1rzyuw==\n-----END CERTIFICATE-----"
default['nginx']['ssl']['filename'] = "selfsigned"

default['nginx']['http_auth_user'] 				= "opsway"
default['nginx']['http_auth_pass'] 				= "opsway1"
default['nginx']['default_site_enabled']		= false
default['nginx']['rewrites']					= Array.new

default['php_worker_host'] = 'localhost'

default['varnish']['listen_address']			= "127.0.0.1"
default['varnish']['ban_user_agent_patterns'] 	= []
default['varnish']['other_bot_list'] 			= ['crawler','spider','bot']
default['varnish']['url_parameters_to_remove']	= []
default['varnish']['healthcheck_script']		= "healthchecker.txt"
default['varnish']['healthcheck_interval']		= "30s"
default['varnish']['admin_host']				= "localhost"
default['varnish']['admin_port']				= "8080"
default['varnish']['backend_host']				= "localhost"
default['varnish']['backend_port']				= "8080"
default['varnish']['bad_bot_list_cookbook']		= nil
default['varnish']['handle_bot_cookbook']		= nil
default['varnish']['vcl_cookbook']		        = nil

default['apache']['serversignature'] 			= 'Off'
default['apache']['traceenable']     			= 'Off'
default['apache']['prefork']['serverlimit'] 	= 200
default['apache']['prefork']['maxclients'] 		= 200
default['apache']['prefork']['maxrequestsperchild'] = 10000
override['apache']['listen_ports']				= ["8080"]
override['apache']['default_modules'] 			= [ "status", "alias", "auth_basic", "authn_file", "authz_default", "authz_groupfile", "authz_host", "authz_user", "dir", "env", "mime", "negotiation", "setenvif" ]
default['apache']['docroot']					= '/var/www/current'

default["sensu"]["subscriptions"]["apache"] 	= true
default['sensu']['checks']['apache-metrics']['command']		= "/etc/sensu/plugins/apache-metrics.rb -p #{node['apache']['listen_ports'].first}"

default['webserver']['worker_cookbook']			= nil
default['webserver']['nginx_cookbook']          = nil
default['webserver']['custom_default_cookbook'] = nil
