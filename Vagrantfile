# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'lucid64'
  config.vm.box_url = 'http://files.vagrantup.com/lucid64.box'
  config.vm.hostname = 'pbuilder-ubuntu'

  # Give us enough RAM to build chroots
  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--memory', 1024]
  end

  # Enable Berkshelf plugin which will make cookbooks available to Vagrant
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'minitest-handler' unless ENV['INTEGRATION_TEST'].nil?
    chef.add_recipe 'apt'
    chef.add_recipe 'pbuilder'

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
      },
      # Only run integration tests for this cookbook
      "minitest" => { "tests" => "pbuilder/*_test.rb" },
    }

    chef.log_level = :debug
  end
end
