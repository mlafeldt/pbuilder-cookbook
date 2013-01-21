# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  config.vm.host_name = "pbuilder-ubuntu"

  # Give us enough RAM to build chroots
  config.vm.customize ["modifyvm", :id, "--memory", 1024]

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      "recipe[apt::default]",
      "recipe[pbuilder::default]"
    ]

    chef.json = {
      "pbuilder" => {
        "chroots" => {
          "lucid32" => {
            "distribution"    => "lucid",
            "architecture"    => "i386",
            "mirror"          => "http://de.archive.ubuntu.com/ubuntu",
            "debootstrapopts" => ["--variant=buildd"]
          },
#          "hardy64" => {
#            "distribution"    => "hardy",
#            "architecture"    => "amd64",
#            "mirror"          => "http://de.archive.ubuntu.com/ubuntu",
#            "debootstrapopts" => ["--variant=buildd"]
#          }
        }
      }
    }

    chef.log_level = :debug
  end
end
