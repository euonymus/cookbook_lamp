default[:lamp][:app_name]     = 'lampapp'

default[:lamp][:www_root]     = "/var/www"
default[:lamp][:app_root]     = "#{node[:lamp][:www_root]}/#{node[:lamp][:app_name]}"

default[:lamp][:app_source]  = "/vagrant/src/#{node[:lamp][:app_name]}"

default[:lamp][:shell_base]  = '/usr/local/bin'

# The path to the data_bag_key on the remote server
default[:lamp][:secretpath] = "/vagrant/src/secrets/data_bag_key"

# look for secret in file pointed to with lamp attribute :secretpath
data_bag_secret = Chef::EncryptedDataBagItem.load_secret("#{node[:lamp][:secretpath]}")

# Set domains from data_bag
domain_creds = Chef::EncryptedDataBagItem.load("envs", "domain", data_bag_secret)
if data_bag_secret && domain_envs = domain_creds[node.chef_environment]
  default[:lamp][:domain] = domain_envs['domain']
end

# Set MySQL info from data_bag
mysqlinfo_creds = Chef::EncryptedDataBagItem.load("envs", "mysql", data_bag_secret)
if data_bag_secret && mysql_envs = mysqlinfo_creds[node.chef_environment]
  default[:lamp][:db_name]      = mysql_envs['db_name']
  default[:lamp][:db_user]      = mysql_envs['db_user']
  default[:lamp][:testdb_name]  = mysql_envs['testdb_name']
  default[:lamp][:testdb_user]  = mysql_envs['testdb_user']
end
# Set MySQL passwords from data_bag
mysql_creds = Chef::EncryptedDataBagItem.load("passwords", "mysql", data_bag_secret)
if data_bag_secret && mysql_passwords = mysql_creds[node.chef_environment]
  default[:lamp][:db_password_root] = mysql_passwords['root']
  default[:lamp][:db_password] = mysql_passwords['app']
end

# php.ini
default['php']['directives'] = {
  "date.timezone" => "Asia/Tokyo",
  "short_open_tag" => "On",
  "memory_limit" => "128M"
}
default[:lamp][:php_conf_dir_apache] = '/etc/php/7.1/apache2'
default[:lamp][:php_conf_dir_cli] = '/etc/php/7.1/cli'

# Settings for php7.1
default['php']['conf_dir'] = '/etc/php/7.1/cli'
default['php']['ext_conf_dir']  = '/etc/php/7.1/apache2/conf.d'
default['php']['src_deps']         = %w(libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev libkrb5-dev libmcrypt-dev libpng12-dev libssl-dev pkg-config)

default['php']['packages'] = %w(php7.1 libapache2-mod-php7.1 php7.1-cli php7.1-common php7.1-mbstring php7.1-gd php7.1-intl php7.1-xml php7.1-mcrypt php7.1-zip php-pear)
default['php']['mysql']['package'] = 'php7.1-mysql'
default['php']['curl']['package']  = 'php7.1-curl'

default['php']['apc']['package']   = 'php-apc'
default['php']['apcu']['package']  = 'php-apcu'
default['php']['gd']['package']    = 'php7.1-gd'
default['php']['ldap']['package']  = 'php7.1-ldap'
default['php']['pgsql']['package'] = 'php7.1-pgsql'
default['php']['sqlite']['package'] = 'php7.1-sqlite3'

default['php']['fpm_package']   = 'php7.1-fpm'
default['php']['fpm_pooldir']   = '/etc/php/7.1/fpm/pool.d'
default['php']['fpm_user']      = 'www-data'
default['php']['fpm_group']     = 'www-data'
default['php']['fpm_listen_user']  = 'www-data'
default['php']['fpm_listen_group'] = 'www-data'
default['php']['fpm_service']      = 'php7.1-fpm'

default['php']['fpm_socket']       = '/var/run/php/php7.1-fpm.sock'
default['php']['fpm_default_conf'] = '/etc/php/7.1/fpm/pool.d/www.conf'
default['php']['fpm_default_conf'] = '/etc/php/7.1/fpm/pool.d/www.conf'
default['php']['enable_mod']       = '/usr/sbin/phpenmod'
default['php']['disable_mod']      = '/usr/sbin/phpdismod'
default['php']['ext_conf_dir']     = '/etc/php/7.1/mods-available'
