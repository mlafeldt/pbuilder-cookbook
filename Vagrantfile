# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'jimdo-debian-7.0.0'
  config.vm.box_url = 'https://jimdo-vagrant-boxes.s3.amazonaws.com/jimdo-debian-7.0.0.box'
  config.vm.hostname = 'pbuilder-debian'

  # Give us enough RAM to build chroots
  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--memory', 1024]
  end

  # Enable Berkshelf plugin which will make cookbooks available to Vagrant
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt'
    chef.add_recipe 'pbuilder'

    chef.json = {
      "pbuilder" => {
        "chroots" => {
#          "squeeze64" => {
#            "distribution"    => "squeeze",
#            "architecture"    => "amd64",
#            "debootstrapopts" => ["--variant=buildd"]
#          },
          "wheezy64" => {
            "distribution"    => "wheezy",
            "architecture"    => "amd64",
            "debootstrapopts" => ["--variant=buildd"]
          }
        }
      }
    }

    chef.log_level = :debug
  end
end
