# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  config.vm.box = "squeeze64"
  config.vm.host_name = "pbuilder-squeeze"

  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      "recipe[apt::default]",
      "recipe[pbuilder::default]"
    ]

    chef.json = {
      "pbuilder" => {
        "chroots" => {
          "lenny32" => {
            "distribution"    => "lenny",
            "architecture"    => "i386",
            "mirror"          => "http://ftp.de.debian.org/debian-archive/debian/",
            "debootstrapopts" => ["--variant=buildd"]
          },
          "squeeze64" => {
            "distribution"    => "squeeze",
            "architecture"    => "amd64",
            "mirror"          => "ftp://ftp2.de.debian.org/debian/",
            "debootstrapopts" => ["--variant=buildd"]
          },
          "wheezy64" => {
            "distribution"    => "wheezy",
            "architecture"    => "amd64",
            "mirror"          => "ftp://ftp2.de.debian.org/debian/",
            "debootstrapopts" => ["--variant=buildd"]
          }
        }
      }
    }

    chef.log_level = :debug
  end
end
