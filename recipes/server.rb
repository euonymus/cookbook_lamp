# Change the timezone to JST. Step1: cp original localtime file for backup
file "/etc/localtime.org" do
  content IO.read("/etc/localtime")
  not_if { File.exists?("/etc/localtime.org") }
end
# Change the timezone to JST. Step2: create symlink to Tokyo region
link '/etc/localtime' do
  to '/usr/share/zoneinfo/Asia/Tokyo'
end
# In order to config daemon auto start
package "sysv-rc-conf"
# restart cron. Somearticle said, "service crond restart", but crond has not been installed here, and below just works.
execute "Restart cron" do
  command 'service cron restart'
end

# Memory Swap settings
execute "build_swapfile" do
  command "dd if=/dev/zero of=/swapfile bs=32M count=32"
  not_if { File.exists?("/swapfile") }
end

if File.readlines("/etc/fstab").grep(/swapfile/).size == 0
  execute "init_swapfile" do
    command "mkswap /swapfile"
  end

  execute "activate_swapfile" do
    command "swapon /swapfile"
  end

  execute "swap_setting_to_fstab" do
    command "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
  end
end
