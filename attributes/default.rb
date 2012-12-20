#
# Cookbook Name:: pbuilder
# Attributes:: default
#
# Copyright (C) 2012 Mathias Lafeldt <mathias.lafeldt@gmail.com>
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

default['pbuilder']['install_packages'] = %w(pbuilder debootstrap devscripts cdbs)

default['pbuilder']['config_file'] = '/etc/pbuilderrc'

# Debian Lenny
#default['pbuilder']['chroot']['lenny']['basetgz'] = '/var/cache/pbuilder/lenny-base.tgz'
#default['pbuilder']['chroot']['lenny']['mirror'] = 'http://ftp.de.debian.org/debian-archive/debian/'
#default['pbuilder']['chroot']['lenny']['debootstrap_opts'] = ['--variant=buildd']

# Debian Squeeze
default['pbuilder']['chroot']['squeeze']['basetgz'] = '/var/cache/pbuilder/squeeze-base.tgz'
default['pbuilder']['chroot']['squeeze']['mirror'] = 'ftp://ftp2.de.debian.org/debian/'
default['pbuilder']['chroot']['squeeze']['debootstrap_opts'] = ['--variant=buildd']

# Debian Wheezy
#default['pbuilder']['chroot']['wheezy']['basetgz'] = '/var/cache/pbuilder/wheezy-base.tgz'
#default['pbuilder']['chroot']['wheezy']['mirror'] = 'ftp://ftp2.de.debian.org/debian/'
#default['pbuilder']['chroot']['wheezy']['debootstrap_opts'] = ['--variant=buildd']
