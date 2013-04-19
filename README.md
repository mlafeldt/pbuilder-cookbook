Description
===========

Installs and configures pbuilder. Provides LWRP to set up chroot environments.

Requirements
============

## Platform:

* Debian
* Ubuntu

To build Debian packages under Ubuntu, you additionally need to

- install the package `debian-archive-keyring`
- add the debootstrap option `--keyring=/usr/share/keyrings/debian-archive-keyring.gpg`
- set the mirror URL to a Debian repo, e.g. http://cdn.debian.net/debian/

## Cookbooks:

No dependencies

Attributes
==========

- `node['pbuilder']['install_packages']` - List of packages to install
- `node['pbuilder']['config_file']` - Path to configuration file
- `node['pbuilder']['cache_dir']` - Path to directory where chroots, cache files,
  and build results are stored
- `node['pbuilder']['chroots']` - Hash of chroots to create. Attributes will be
  passed 1:1 to `pbuilder_chroot` LWRP, for example:

```json
"pbuilder" => {
  "chroots" => {
    "wheezy64" => {
      "distribution"    => "wheezy",
      "architecture"    => "amd64",
      "mirror"          => "ftp://ftp2.de.debian.org/debian/",
      "debootstrapopts" => ["--variant=buildd"]
    }
  }
}
```

See `attributes/default.rb` for default values.

Recipes
=======

## pbuilder::default

Installs and configures pbuilder. Optionally sets up chroot environments.

Resources/Providers
===================

This cookbook contains the `pbuilder_chroot` LWRP.

## pbuilder_chroot

### Actions

- `:create` - Create a new chroot environment for specified distribution inside
  `node['pbuilder']['cache_dir']`. Will be skipped if chroot already exists and
  its size is non-zero.

### Attributes

- `distribution` - Name of distribution to use, e.g. `squeeze` (name attribute)
- `architecture` - Architecture of distribution: `i386` or `amd64` (optional)
- `mirror` - URL of Debian mirror to be specified in `sources.list` inside the
  chroot (optional)
- `debootstrapopts` - Extra options to be passed to `debootstrap` (optional)

After installing the chroots, you can tell pbuilder which chroot to use via the
environment variables `DIST` (distribution) and `ARCH` (architecture), e.g.

```sh
$ DIST=lenny ARCH=i386 pdebuild
$ DIST=squeeze ARCH=amd64 pdebuild
$ DIST=wheezy pdebuild  # will use host architecture if ARCH is unset
```

### Examples

```ruby
pbuilder_chroot "lenny32" do
  distribution "lenny"
  architecture "i386"
  mirror       "http://ftp.de.debian.org/debian-archive/debian/"
end
```

```ruby
pbuilder_chroot "squeeze64" do
  distribution    "squeeze"
  architecture    "amd64"
  debootstrapopts ["--variant=buildd"]
end
```

```ruby
pbuilder_chroot "wheezy"
```

```ruby
pbuilder_chroot "lucid" do
  mirror "http://eu.archive.ubuntu.com/ubuntu"
end
```

Testing
=======

The cookbook comes with some testing facilities allowing you to iterate quickly
on cookbook changes. After installing Vagrant and the required Ruby gems, most
of the testing can be done through convenient Rake tasks.

## Bundler

Apart from Vagrant, which is described later on, all tools you need for cookbook
development and testing are installed as Ruby gems using [Bundler](http://gembundler.com).
This gives you a lot of control over the software stack ensuring that the
testing environment matches your production environment.

First, make sure you have Bundler (which is itself a gem):

    $ gem install bundler

Then let Bundler install the required gems (as defined in `Gemfile`):

    $ bundle install

Now you can use `bundle exec` to execute a command from the gemset, for example:

    $ bundle exec rake

(You should keep `Gemfile.lock` checked in.)

## Rake

The cookbook provides a couple of helpful [Rake](http://rake.rubyforge.org)
tasks (specified in `Rakefile`):

    $ rake -T
    rake clean                      # Remove any temporary products.
    rake clobber                    # Remove any generated file.
    rake test:all                   # Run test:syntax, test:lint, test:spec, and test:integration
    rake test:integration           # Run minitest integration tests with Vagrant
    rake test:integration_teardown  # Tear down VM used for integration tests
    rake test:lint                  # Run Foodcritic lint checks
    rake test:spec                  # Run ChefSpec examples
    rake test:syntax                # Run Knife syntax checks

As mentioned above, use `bundle exec` to start a Rake task:

    $ bundle exec rake test

The `test` task is an alias for `test:all` and also happens to be the default
when no task is given. All test-related tasks are described in more detail
below.

## Knife

The Rake task `test:syntax` will use `knife cookbook test` to run syntax checks
on the cookbook, validating both Ruby files and templates.

## Foodcritic

The Rake task `test:lint` will use [Foodcritic](http://acrmp.github.com/foodcritic/)
to run lint checks on the cookbook. Foodcritic is configured to fail if there
are _any_ warnings that might stop the cookbook from working.

## ChefSpec

The Rake task `test:spec` will run all [ChefSpec](https://github.com/acrmp/chefspec)
examples in the `spec` directory. Built on top of RSpec, ChefSpec allows you to
write unit tests for Chef cookbooks. It runs your cookbook - without actually
converging a node - and lets you make assertions about the resources that were
created. This makes it the ideal tool to get fast feedback on cookbook changes.

## Minitest

The Rake task `test:integration` will run minitest integration tests inside a VM
managed by Vagrant. This is done by adding the [minitest-handler cookbook] to
Chef's run list prior to provisioning the VM. This cookbook will install
[minitest-chef-handler] inside the VM, which in turn runs all
`files/**/*_test.rb` files at the end of the provisioning process.

In case the VM is powered off, `rake test:integration` will boot it up first.
When you no longer need the VM for integration testing, `rake
test:integration_teardown` will shut it down. If you rather want to provision
from scratch, set `INTEGRATION_TEARDOWN` accordingly. For example:

    $ export INTEGRATION_TEARDOWN='vagrant destroy -f'
    $ rake test:integration_teardown
    $ rake test:integration

[minitest-chef-handler]: https://github.com/calavera/minitest-chef-handler
[minitest-handler cookbook]: https://github.com/btm/minitest-handler-cookbook

## Berkshelf

[Berkshelf](http://berkshelf.com) is used to set up the cookbook and its
dependencies prior to testing with Rake and Vagrant.

The dependencies are defined in `Berksfile`, which in turn resolves the
dependencies in `metadata.rb`. It is good practice to specify the cookbook
sources in `Berksfile`, while keeping the cookbook versions in `metadata.rb`
(the authoritative source of information for Chef).

During testing, dependencies are installed to the `fixtures` directory inside
this cookbook.

## Vagrant

With [Vagrant](http://vagrantup.com), you can spin up a virtual machine and run
your cookbook inside it via Chef Solo or Chef Client. The test setup requires to
install **Vagrant 1.2.x** from the [Vagrant downloads page](http://downloads.vagrantup.com/).

You will also need the Berkshelf Vagrant plugin, which will make your cookbook
and its dependencies automatically available to Vagrant when creating or
provisioning a VM:

    $ vagrant plugin install vagrant-berkshelf

When everything is in place, this command will boot and provision the VM as
specified in the `Vagrantfile`:

    $ vagrant up

In case the VM is already up, you can run the provisioners again with:

    $ vagrant provision

## Travis CI

The cookbook includes a configuration for [Travis CI](https://travis-ci.org) that
will run `rake test` each time changes are pushed to GitHub. Simply enable Travis
for your GitHub repository to get free continuous integration.

[![Build Status](https://travis-ci.org/mlafeldt/pbuilder-cookbook.png?branch=master)](https://travis-ci.org/mlafeldt/pbuilder-cookbook)

Implementing CI with other systems should be as simple as running the commands
in `.travis.yml`.

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
