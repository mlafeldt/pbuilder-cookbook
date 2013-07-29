require 'chef_bones/integration_spec_helper'

describe 'default machine' do
  it 'installs required packages' do
    expect(package 'pbuilder').to be_installed
    expect(package 'debootstrap').to be_installed
    expect(package 'devscripts').to be_installed
  end

  # TODO: add more tests
end
