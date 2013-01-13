#
# Cookbook Name:: pbuilder
# Provider:: chroot
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

def whyrun_supported?
  false
end

action :create do
  distro = new_resource.distribution
  arch = new_resource.architecture || `dpkg --print-architecture`.chomp
  mirror = new_resource.mirror
  debootstrap = new_resource.debootstrap
  basetgz = ::File.join(node['pbuilder']['cache_dir'], "#{distro}-#{arch}-base.tgz")

  cmd = "pbuilder create --basetgz #{basetgz} --distribution #{distro} --architecture #{arch}"
  cmd = "#{cmd} --mirror #{mirror}" if mirror
  cmd = "#{cmd} --debootstrapopts #{debootstrap.join(' ')}" if debootstrap

  execute cmd do
    creates basetgz
    action :run
  end

  new_resource.updated_by_last_action(true)
end
