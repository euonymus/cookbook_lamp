#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright (C) 2018 euonymus
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'lamp::server'
include_recipe 'lamp::apache'
include_recipe 'lamp::mysql'
include_recipe 'lamp::php'
include_recipe 'lamp::certbot'
