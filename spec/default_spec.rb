require 'chefspec'

describe 'The recipe pbuilder::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'pbuilder::default' }

  it 'should install the package pbuilder' do
    chef_run.should install_package 'pbuilder'
  end
end
