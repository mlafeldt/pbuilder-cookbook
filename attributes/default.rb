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

# List of packages to install
default['pbuilder']['install_packages'] = %w(pbuilder debootstrap devscripts)

# Path to pbuilder configuration file
default['pbuilder']['config_file'] = '/etc/pbuilderrc'

# Path to directory where chroots, cache files, and build results are stored
default['pbuilder']['cache_dir'] = '/var/cache/pbuilder'

# Hash of chroots to create
default['pbuilder']['chroots'] = Hash.new
