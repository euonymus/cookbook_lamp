apt_repository 'ondrej-php' do
  uri 'ppa:certbot/certbot'
end

package 'python-certbot-apache' do
  action :install
end
