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
          "wheezy64" => {
            "distribution"    => "wheezy",
            "architecture"    => "amd64",
            "mirror"          => "ftp://ftp2.de.debian.org/debian/",
#           "debootstrapopts" => ["--variant=buildd"]
          }
        }
      }
    }

    chef.log_level = :debug
  end
end
