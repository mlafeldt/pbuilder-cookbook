name              "pbuilder"
maintainer        "Mathias Lafeldt"
maintainer_email  "mathias.lafeldt@gmail.com"
license           "Apache 2.0"
description       "Installs and configures pbuilder. Provides LWRP to set up chroot environments."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.4"
recipe            "pbuilder::default", "Installs and configures pbuilder. Optionally sets up chroot environments."

supports "debian"
supports "ubuntu"
