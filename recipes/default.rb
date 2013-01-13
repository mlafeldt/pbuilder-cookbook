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

# TODO turn this into a LWRP
def pbuilder_create(name, options)
  distro = options['distribution'] || name
  arch = options['architecture'] || `dpkg --print-architecture`.chomp
  basetgz = ::File.join(node['pbuilder']['cache_dir'], "#{distro}-#{arch}-base.tgz")
  mirror = options['mirror']
  debootstrap = Array(options['debootstrap']).join(' ')

  execute "pbuilder create " \
          "--basetgz #{basetgz} " \
          "--distribution #{distro} " \
          "--architecture #{arch} " \
          "--mirror #{mirror} " \
          "--debootstrapopts #{debootstrap}" do
    creates basetgz
    action :run
  end
end

node['pbuilder']['install_packages'].each { |pkg| package pkg }

template node['pbuilder']['config_file'] do
  source "pbuilderrc.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

unless node['pbuilder']['chroots'].nil?
  node['pbuilder']['chroots'].each do |name, options|
    pbuilder_create(name, options)
  end
end
