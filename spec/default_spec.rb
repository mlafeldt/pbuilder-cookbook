require 'chefspec'

describe 'The recipe pbuilder::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'pbuilder::default' }
  let (:chef_run_with_chroots) do
    chef_run = ChefSpec::ChefRunner.new(:step_into => ['pbuilder_chroot']) do |node|
      node.set['pbuilder'] = {
        "chroots" => {
          "squeeze32" => {
            "distribution"    => "squeeze",
            "architecture"    => "i386"
          },
          "wheezy64" => {
            "distribution"    => "wheezy",
            "architecture"    => "amd64",
            "mirror"          => "ftp://ftp2.de.debian.org/debian/",
            "debootstrapopts" => ["--variant=buildd"]
          },
          "lenny32" => {
            "distribution"    => "lenny",
            "architecture"    => "i386",
            "action"          => "delete"
          }
        }
      }
    end
    chef_run.converge 'pbuilder::default'
    chef_run
  end

  it 'installs the required packages' do
    chef_run.node['pbuilder']['install_packages'].each do |pkg|
      expect(chef_run).to install_package pkg
    end
  end

  it 'creates the pbuilder config file' do
    expect(chef_run).to create_file chef_run.node['pbuilder']['config_file']
  end

  it 'creates the directory to hold chroot environments' do
    expect(chef_run).to create_directory chef_run.node['pbuilder']['chroot_dir']
  end

  def chroot_file(distro, arch)
    ::File.join(chef_run.node['pbuilder']['chroot_dir'], "#{distro}-#{arch}-base.tgz")
  end

  it 'creates the squeeze32 chroot' do
    expect(chef_run_with_chroots).to execute_command \
      "pbuilder create --basetgz #{chroot_file('squeeze', 'i386')} " \
      "--distribution squeeze --architecture i386"
  end

  it 'creates the wheezy64 chroot' do
    expect(chef_run_with_chroots).to execute_command \
      "pbuilder create --basetgz #{chroot_file('wheezy', 'amd64')} " \
      "--distribution wheezy --architecture amd64 " \
      "--mirror ftp://ftp2.de.debian.org/debian/ " \
      "--debootstrapopts --variant=buildd"
  end

  it 'deletes the lenny32 chroot' do
    expect(chef_run_with_chroots).to delete_file chroot_file('lenny', 'i386')
  end
end
