require 'spec_helper'

service = 'a_service'
jmx = 'localhost:1099'
objects = [
  {
    'name'        => 'JMX.object.name',
    'resultAlias' => 'pretty alias for JMX name',
    'typeNames'   => ['name'],
    'attrs'       => {
      'JMX.attribute.name' => {
        'units' => 'unit name',
      }
    }
  }
]
 

describe 'jmxtrans::metrics' do
  let(:title)   { service }
  let(:params) { { :objects => objects,
                   :jmx     => jmx } }

  it { should contain_file("/etc/jmxtrans/#{service}.json") }
  it { should contain_class('jmxtrans') }
  it { should contain_jmxtrans__metrics(service) }
end
