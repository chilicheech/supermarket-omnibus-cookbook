#
# Cookbook Name:: supermarket-omnibus-cookbook
# Spec:: custom_repo_setup
#
# Copyright (c) 2016 Yvonne Lam, All Rights Reserved.

describe 'test::custom_repo_setup' do
  context 'When a custom recipe is specified, the custom recipe should be used' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'redhat', version: '6.5', step_into: %w(chef_ingredient supermarket_server)) do |node|
        node.set['supermarket_omnibus']['chef_server_url'] = 'https://chefserver.mycorp.com'
        node.set['supermarket_omnibus']['chef_oauth2_app_id'] = 'blahblah'
        node.set['supermarket_omnibus']['chef_oauth2_secret'] = 'bob_lawblaw'
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command('grep Fauxhai /etc/hosts').and_return('33.33.33.11 Fauxhai')
    end

    it 'includes the custom_repo_setup_recipe' do
      expect(chef_run).to include_recipe 'custom_repo::custom_repo_recipe'
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end
  end
end
