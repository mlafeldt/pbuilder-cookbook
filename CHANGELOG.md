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
