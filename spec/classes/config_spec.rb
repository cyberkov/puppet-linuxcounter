require 'spec_helper'
describe 'linuxcounter::config' do

  context 'with defaults for all parameters' do
    let(:facts) { {:hostname => 'sparklepony'} }
    it { should contain_class('linuxcounter::config') }
    it { 
         should contain_file('lico_config').with(
           'ensure' => 'present',
           'owner'  => 'linuxcounter',
           'group'  => 'linuxcounter',
           'path'   => '~linuxcounter/.linuxcounter/sparklepony'
         )
    }
  end

end
