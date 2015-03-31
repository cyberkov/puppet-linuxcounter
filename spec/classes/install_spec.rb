require 'spec_helper'
describe 'linuxcounter::install' do

  context 'with defaults for all parameters' do
    it {
      should contain_class('wget')
    }
  end

end
