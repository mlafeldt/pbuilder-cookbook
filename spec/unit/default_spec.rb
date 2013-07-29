require 'chef_bones/unit_spec_helper'

describe 'The recipe pbuilder::default' do
  let (:chef_run) do
    chef_run = ChefSpec::ChefRunner.new(
      :platform      => 'debian',
      :version       => '7.0',
      :log_level     => :error,
      :cookbook_path => COOKBOOK_PATH
    )
    Chef::Config.force_logger true
    chef_run.converge 'pbuilder::default'
    chef_run
  end

  let (:chef_run_with_chroots) do
    chef_run = ChefSpec::ChefRunner.new(
      :platform      => 'debian',
      :version       => '7.0',
      :log_level     => :error,
      :cookbook_path => COOKBOOK_PATH,
      :step_into     => ['pbuilder_chroot']
    )
    chef_run.node.set['pbuilder'] = {
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
    Chef::Config.force_logger true
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
