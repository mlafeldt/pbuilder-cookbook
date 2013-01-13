require 'chefspec'

describe 'The recipe pbuilder::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'pbuilder::default' }

  %w(pbuilder debootstrap devscripts).each do |pkg|
    it "should install the package #{pkg}" do
      chef_run.should install_package pkg
    end
  end

  it 'should create the pbuilder config file' do
    chef_run.should create_file chef_run.node['pbuilder']['config_file']
  end
end
