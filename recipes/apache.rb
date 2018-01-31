# settings for mod_php7
if node['apache']['mpm'] != 'prefork'
  Chef::Log.warn('apache2::mod_php generally is expected to be run under a non-threaded MPM, such as prefork')
  Chef::Log.warn('See http://php.net/manual/en/faq.installation.php#faq.installation.apache2')
  Chef::Log.warn("Currently the apache2 cookbook is configured to use the '#{node['apache']['mpm']}' MPM")
end

# settings for vhost
directory(node[:lamp][:www_root])
# put apache config
web_app(node[:lamp][:app_name]) do
  server_name(node[:lamp][:domain])
  docroot(node[:lamp][:app_root])
  template('vhost.conf.erb')
end

if node.chef_environment != 'virtualbox'
  link node[:lamp][:app_root] do
    to node[:lamp][:app_source]
  end
end

# disable apache event mpm mode
execute "disable_mpm_event" do
  command "a2dismod mpm_event"
end

# enable apache prefork mpm mode
execute "enable_mpm_prefork" do
  command "a2enmod mpm_prefork"
end

# apache restart
execute "apache_restart" do
  command "apachectl graceful"
end

