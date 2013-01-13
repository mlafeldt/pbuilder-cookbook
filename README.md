Description
===========

Installs and configures pbuilder

Requirements
============

## Platform:

* Debian

## Cookbooks:

No dependencies

Attributes
==========

- `node['pbuilder']['install_packages']` - packages to install
- `node['pbuilder']['config_file']` - path to configuration file
- `node['pbuilder']['chroot']` - hash holding chroots to create

See file `attributes/default.rb` for more information.

Recipes
=======

## pbuilder::default

Installs and configures pbuilder

Testing
=======

The cookbook comes with some testing facilities allowing you to iterate quickly
on cookbook changes.

## Rake

You can execute the tests with [Rake](http://rake.rubyforge.org). The `Rakefile`
provides the following tasks:

    $ rake -T
    rake chefspec    # Run ChefSpec examples
    rake foodcritic  # Run Foodcritic lint checks
    rake knife       # Run knife cookbook test
    rake test        # Run all tests

## Bundler

If you prefer to let [Bundler](http://gembundler.com) install all required gems
(you should), run the tests this way:

    $ bundle install
    $ bundle exec rake test

## Berkshelf

[Berkshelf](http://berkshelf.com) is used to set up the cookbook and its
dependencies (as defined in `Berksfile`) prior to testing with Rake and Vagrant.

## Vagrant

With [Vagrant](http://vagrantup.com), you can spin up a virtual machine and run
your cookbook inside it via Chef Solo.

This command will boot and provision the VM as specified in the `Vagrantfile`:

    $ bundle exec vagrant up

(Berkshelf's Vagrant plugin will make your cookbook and its dependencies
automatically available to Vagrant when creating or provisioning a VM.)

## Travis CI

The cookbook includes a configuration for [Travis CI](https://travis-ci.org) that
will run `rake test` each time changes are pushed to GitHub. Simply enable Travis
for your GitHub repository to get free continuous integration.

[![Build Status](https://travis-ci.org/mlafeldt/pbuilder-cookbook.png?branch=master)](https://travis-ci.org/mlafeldt/pbuilder-cookbook)

License and Author
==================

Author:: Mathias Lafeldt (<mathias.lafeldt@gmail.com>)

Copyright:: 2012-2013, Mathias Lafeldt

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
