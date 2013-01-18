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
