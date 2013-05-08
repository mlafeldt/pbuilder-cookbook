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
- `node['pbuilder']['config_file']` - Path to pbuilder configuration file
- `node['pbuilder']['cache_dir']` - Path to directory where chroots, cache
  files, and build results are stored
- `node['pbuilder']['chroots']` - Hash of chroots to create; attributes will be
  passed 1:1 to `pbuilder_chroot` LWRP

See `attributes/default.rb` for default values.

Here is how `node['pbuilder']['chroots']` might look like in JSON:

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

Recipes
=======

## pbuilder::default

Installs and configures pbuilder. Optionally sets up chroot environments as
specified in `node['pbuilder']['chroots']`.

Resources/Providers
===================

This cookbook contains the `pbuilder_chroot` LWRP.

## pbuilder_chroot

### Actions

- `:create` - Create a new chroot environment for specified distribution inside
  `node['pbuilder']['cache_dir']`. Will be skipped if chroot already exists and
  its size is non-zero. This is the default action.
- `:delete` - Delete an existing chroot environment from
  `node['pbuilder']['cache_dir']`.

### Attributes

- `distribution` - Name of distribution to use, e.g. `squeeze` (name attribute)
- `architecture` - Architecture of distribution: `i386` or `amd64` (optional,
  defaults to host architecture)
- `mirror` - URL of Debian mirror to be specified in `sources.list` inside the
  chroot (optional)
- `debootstrapopts` - Extra options to be passed to `debootstrap` (optional)

After installing the chroots, you can tell pbuilder which chroot to use via the
environment variables `DIST` (distribution) and `ARCH` (architecture), e.g.

```sh
$ DIST=lenny ARCH=i386 pdebuild
$ DIST=squeeze ARCH=amd64 pdebuild
$ DIST=wheezy pdebuild  # use host architecture as ARCH is unset
```

### Examples

Creating chroots:

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

Deleting a chroot:

```ruby
pbuilder_chroot "lenny32" do
  distribution "lenny"
  architecture "i386"
  action       :delete
end
```

Testing
=======

Everything you need to know about testing this cookbook is explained in
`TESTING.md`.

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
