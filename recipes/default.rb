#
# Cookbook Name:: pbuilder
# Recipe:: default
#
# Copyright (C) 2012-2013 Mathias Lafeldt <mathias.lafeldt@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node['pbuilder']['install_packages'].each { |pkg| package pkg }

template node['pbuilder']['config_file'] do
  source 'pbuilderrc.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  action :create
end

directory node['pbuilder']['chroot_dir'] do
  owner     'root'
  group     'root'
  mode      '0755'
  recursive true
  action    :create
end

unless node['pbuilder']['chroots'].nil?
  node['pbuilder']['chroots'].each do |name, options|
    pbuilder_chroot name do
      distribution    options['distribution']
      architecture    options['architecture']
      mirror          options['mirror']
      debootstrapopts options['debootstrapopts']
      action          options['action']
    end
  end
end
