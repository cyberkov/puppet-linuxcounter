require 'spec_helper'
describe 'linuxcounter' do
 

  context 'with defaults for all parameters' do
    let(:facts) { {:kernel => 'Linux'} }
    it { should contain_class('linuxcounter') }
  end

  context 'fail for other OS than Linux' do
    let(:facts) { {:kernel => 'Solaris'} }
    it { should raise_error(ArgumentError) }
  end

end
