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

def load_current_resource
  @distro = new_resource.distribution
  @arch = new_resource.architecture
  @arch ||= node["kernel"]["machine"] == "x86_64" ? "amd64" : "i386"
  @mirror = new_resource.mirror
  @debootstrapopts = new_resource.debootstrapopts
end

def chroot_file
  ::File.join(node['pbuilder']['chroot_dir'], "#{@distro}-#{@arch}-base.tgz")
end

action :create do
  basetgz = chroot_file

  cmd = "pbuilder create --basetgz #{basetgz} --distribution #{@distro} --architecture #{@arch}"
  cmd = "#{cmd} --mirror #{@mirror}" unless @mirror.nil?
  unless @debootstrapopts.nil?
    opts = @debootstrapopts.map { |opt| "--debootstrapopts #{opt}" }.join(" ")
    cmd = "#{cmd} #{opts}"
  end

  execute cmd do
    action :run
    not_if do
      ::File.exists?(basetgz) &&
      ::File.size(basetgz) > 0
    end
  end

  new_resource.updated_by_last_action(true)
end

action :delete do
  basetgz = chroot_file

  file basetgz do
    action :delete
    only_if { ::File.exists?(basetgz) }
  end

  new_resource.updated_by_last_action(true)
end
