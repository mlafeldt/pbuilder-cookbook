require 'chefspec'

describe 'The recipe pbuilder::default' do
  let (:chef_run) do
    chef_run = ChefSpec::ChefRunner.new(:step_into => ['pbuilder_chroot'])
    chef_run.node.set['pbuilder'] = {
      "chroots" => {
        "wheezy64" => {
          "distribution"    => "wheezy",
          "architecture"    => "amd64",
          "mirror"          => "ftp://ftp2.de.debian.org/debian/",
          "debootstrapopts" => ["--variant=buildd"]
        }
      }
    }
    chef_run.converge 'pbuilder::default'
    chef_run
  end

  %w(pbuilder debootstrap devscripts).each do |pkg|
    it "should install the package #{pkg}" do
      chef_run.should install_package pkg
    end
  end

  it 'should create the pbuilder config file' do
    chef_run.should create_file chef_run.node['pbuilder']['config_file']
  end

  it 'should create the wheezy64 chroot' do
    basetgz = ::File.join(chef_run.node['pbuilder']['cache_dir'],
                          "wheezy-amd64-base.tgz")
    chef_run.should execute_command \
      "pbuilder create --basetgz #{basetgz} " \
      "--distribution wheezy --architecture amd64 " \
      "--mirror ftp://ftp2.de.debian.org/debian/ " \
      "--debootstrapopts --variant=buildd"
  end
end
