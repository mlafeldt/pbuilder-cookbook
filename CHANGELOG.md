1.1.0 (Dec 8 2013)
------------------

* Use Ohai data instead of shelling out to `dpkg --print-architecture`.
* Use Test Kitchen for integration testing.
* Update to ChefSpec v3.
* Update README.

1.0.8 (Jul 29 2013)
-------------------

* Use [chef-bones](https://github.com/mlafeldt/chef-bones) gem for testing.
* Add serverspec integration test.
* No longer downgrade RubyGems on Travis.

1.0.7 (May 13 2013)
-------------------

* Store chroots in separate directory set by `node['pbuilder']['chroot_dir']`.

1.0.6 (May 8 2013)
------------------

* Allow `pbuilder_chroot` LWRP to delete chroot environments via `:delete`
  action. Test this new action and refactor spec examples.
* Tweak level of markdown headings.

1.0.5 (May 7 2013)
------------------

Take over changes from [skeleton cookbook](https://github.com/mlafeldt/skeleton-cookbook):

* Use Vagrant base box `jimdo-debian-7.0.0`.
* Update ChefSpec gem to version 1.0.0.
* Move testing-related documentation to TESTING.md.
* Add Rake task `test:travis`.

1.0.4 (Apr 19 2013)
-------------------

Take over changes from [skeleton cookbook](https://github.com/mlafeldt/skeleton-cookbook):

* Update gem dependencies (berkshelf 1.4, foodcritic 2.0, chef 10.24).
* Remove Vagrant from gems; get it from http://downloads.vagrantup.com/.
* Update Vagrantfile to v2 syntax and enable the _vagrant-berkshelf_ plugin.
* Add new tasks to Rakefile, e.g. `clobber` and `test:integration`. Replace
  `COOKBOOKS_PATH` with `FIXTURES_PATH` which defaults to _fixtures_.
* Let Travis run tests against Ruby 2.0.0.

1.0.3 (Jan 21 2013)
-------------------

* Tweak `pbuilder_chroot` LWRP to re-create chroot if the chroot file exists but
  has a size of 0.
* Vagrantfile: Use public lucid64 box instead of squeeze64.
* README: Add more information about building Debian packages under Ubuntu. Also
  add some more `pbuilder_chroot` examples.

1.0.2 (Jan 18 2013)
-------------------

* Shell out to `lsb_release` instead of using the Ohai attribute
  `node['lsb']['codename']`. For some reason, the attribute is empty during the
  first converge.
* Vagrantfile: Stop using slow FTP mirror in favor of Debian's CDN
  (http://cdn.debian.net/debian/ is blazingly fast).
* Vagrantfile: Build Squeeze box by default (current stable).

1.0.1 (Jan 14 2013)
-------------------

* Add `pbuilder_chroot` LWRP to set up chroot environments. Currently allows to
  specify distribution, architecture, Debian mirror URL, and debootstrap options.
* Define default chroots to build as JSON data in Vagrantfile.
* Add Ubuntu to list of supported platforms (see notes in README).
* Add attribute `node['pbuilder']['cache_dir']`.
* Remove `cdbs` from packages to install.
* Update gems.
* Update copyright year.
* Add this CHANGELOG file.

1.0.0 (Dec 20 2012)
-------------------

* First tagged version.
