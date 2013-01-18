# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  config.vm.box = "squeeze64"
  config.vm.host_name = "pbuilder-squeeze"

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
          "squeeze64" => {
            "distribution"    => "squeeze",
            "architecture"    => "amd64",
            "debootstrapopts" => ["--variant=buildd"]
          },
#          "wheezy64" => {
#            "distribution"    => "wheezy",
#            "architecture"    => "amd64",
#            "debootstrapopts" => ["--variant=buildd"]
#          }
        }
      }
    }

    chef.log_level = :debug
  end
end
