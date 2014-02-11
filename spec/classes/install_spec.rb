require 'spec_helper'

describe 'jmxtrans' do
  it { should include_class('jmxtrans') }
  it { should contain_file('/etc/default/jmxtrans') }
  it do 
    should contain_service('jmxtrans').with(
      'ensure'     => 'running'
    )
  end
end

