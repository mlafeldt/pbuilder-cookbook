#
# Cookbook Name:: pbuilder
# Resource:: chroot
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

actions :create, :delete

default_action :create

attribute :distribution,    :kind_of => String, :name_attribute => true
attribute :architecture,    :kind_of => String, :equal_to => ['i386', 'amd64']
attribute :mirror,          :kind_of => String
attribute :debootstrapopts, :kind_of => Array
