#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright (C) 2018 euonymus
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'belongsto::server'
include_recipe 'belongsto::apache'
include_recipe 'belongsto::mysql'
include_recipe 'belongsto::php'
include_recipe 'belongsto::certbot'
