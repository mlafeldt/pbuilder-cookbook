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

# TODO turn this into a LWRP
unless node['pbuilder']['chroot'].nil?
  node['pbuilder']['chroot'].each do |distro, options|
    execute "pbuilder create --basetgz #{options['basetgz']} --distribution #{distro} " \
            "--mirror #{options['mirror']} --debootstrapopts #{options['debootstrap_opts']}" do
      creates options['basetgz']
      action :run
    end
  end
end

template node['pbuilder']['config_file'] do
  source "pbuilderrc.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end
