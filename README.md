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
