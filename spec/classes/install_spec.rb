require 'spec_helper'
describe 'linuxcounter::install' do

  context 'with defaults for all parameters' do
    it {
      should contain_class('wget')
      should_not contain_user('lico_user')
      should contain_file('lico_path').with(
        'ensure' => 'directory',
        'path'   => '/usr/local/linuxcounter',
        'owner'  => 'linuxcounter',
        'group'  => 'linuxcounter',
        'mode'   => '0755'
      )
      should contain_file('lico-update.sh').with(
        'ensure' => 'present',
        'path'   => '/usr/local/linuxcounter/lico-update.sh',
        'owner'  => 'linuxcounter',
        'group'  => 'linuxcounter',
        'mode'   => '0755'
      )
    }
  end

  context 'with user creation' do
    let :params do
      {
        :manage_user => true
#        :user        => 'linuxcounter',
#        :group       => 'linuxcounter'
      }
    end

    it {
      should contain_user('lico_user').with(
        'ensure' => 'present',
        'name'   => 'linuxcounter',
        'gid'    => 'linuxcounter'
      )
    }
  end

end
