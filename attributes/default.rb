#
# Cookbook Name:: pbuilder
# Attributes:: default
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

default['pbuilder']['install_packages'] = %w(pbuilder debootstrap devscripts)
default['pbuilder']['config_file'] = '/etc/pbuilderrc'
default['pbuilder']['cache_dir'] = '/var/cache/pbuilder'

# Debian Lenny
#default['pbuilder']['chroots']['lenny']['distribution'] = 'lenny'
#default['pbuilder']['chroots']['lenny']['architecture'] = 'i386'
#default['pbuilder']['chroots']['lenny']['mirror'] = 'http://ftp.de.debian.org/debian-archive/debian/'
#default['pbuilder']['chroots']['lenny']['debootstrap'] = ['--variant=buildd']

# Debian Squeeze
default['pbuilder']['chroots']['squeeze']['distribution'] = 'squeeze'
default['pbuilder']['chroots']['squeeze']['architecture'] = 'amd64'
default['pbuilder']['chroots']['squeeze']['mirror'] = 'ftp://ftp2.de.debian.org/debian/'
default['pbuilder']['chroots']['squeeze']['debootstrap'] = ['--variant=buildd']

# Debian Wheezy
#default['pbuilder']['chroots']['wheezy']['distribution'] = 'wheezy'
#default['pbuilder']['chroots']['wheezy']['architecture'] = 'amd64'
#default['pbuilder']['chroots']['wheezy']['mirror'] = 'ftp://ftp2.de.debian.org/debian/'
#default['pbuilder']['chroots']['wheezy']['debootstrap'] = ['--variant=buildd']
