# settings for mod_php7
if node['apache']['mpm'] != 'prefork'
  Chef::Log.warn('apache2::mod_php generally is expected to be run under a non-threaded MPM, such as prefork')
  Chef::Log.warn('See http://php.net/manual/en/faq.installation.php#faq.installation.apache2')
  Chef::Log.warn("Currently the apache2 cookbook is configured to use the '#{node['apache']['mpm']}' MPM")
end
# file "#{node['apache']['dir']}/mods-available/php7.1.conf" do
#   content '# conf is under mods-available/php7.conf - apache2 cookbook\n'
# end
# file "#{node['apache']['dir']}/mods-available/php7.1.load" do
#   content '# conf is under mods-available/php7.load - apache2 cookbook\n'
# end
apache_conf 'php7' do
  cookbook 'apache2'
  source 'default/mods/php.conf.erb'
end
apache_module 'php7' do
  conf false
  filename 'libphp7.1.so'
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
