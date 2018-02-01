apt_repository 'ondrej-php' do
  uri        'ppa:ondrej/php'
end

include_recipe "php"
include_recipe 'php::module_mysql'
include_recipe 'php::module_curl'
include_recipe 'php::module_sqlite3' # for debug_kit

# Copy the php.ini for cli into apaches dir
execute "copy php.ini for apache" do
  command "cp -p " + node[:lamp][:php_conf_dir_cli] + '/php.ini ' + node[:lamp][:php_conf_dir_apache] + '/php.ini'
end

# Apache setting for PHP
# file "#{node['apache']['dir']}/mods-available/php7.1.conf" do
#   content '# conf is under mods-available/php7.conf - apache2 cookbook\n'
# end
# file "#{node['apache']['dir']}/mods-available/php7.1.load" do
#   content '# conf is under mods-available/php7.load - apache2 cookbook\n'
# end
# apache_conf 'php7' do
#   cookbook 'apache2'
#   source 'default/mods/php.conf.erb'
# end
# apache_module 'php7' do
#   conf false
#   filename 'libphp7.1.so'
# end

# apache restart
execute "apache_restart" do
  command "apachectl graceful"
end
