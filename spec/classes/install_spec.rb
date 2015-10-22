require 'spec_helper'

describe 'jmxtrans' do

  context 'no parameters' do
    it { should include_class('jmxtrans') }
    it { should contain_file('/etc/default/jmxtrans') }
    it do
      should contain_service('jmxtrans').with(
        'ensure' => 'running'
      )
    end
    it do
      should contain_file('/etc/jmxtrans').with(
        'ensure' => 'directory'
      )
    end
  end

  context 'installed is false' do
    let(:params) { {'installed' => false}}
    it { should include_class('jmxtrans') }
    it { should contain_service('jmxtrans').with('ensure' => 'stopped') }
    it { should contain_package('jmxtrans').with('ensure' => 'purged') }
    it { should contain_file('/etc/default/jmxtrans').with('ensure' => 'absent') }
    it { should contain_file('/etc/jmxtrans').with('ensure' => 'absent', 'force' => true) }
  end


end

