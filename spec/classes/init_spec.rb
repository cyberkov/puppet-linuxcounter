require 'spec_helper'
describe 'linuxcounter' do
  let :params do
    {
      :counter_number => '42'
    }
  end
  let(:facts) { {:kernel => 'Linux'} }
 
  context 'with defaults for all parameters' do
    it {
      should contain_class('linuxcounter')
      should_not contain_user('linuxcounter')
      should contain_cron('linuxcounter')
    }

    it {
      should contain_wget__fetch('download lico script').with(
        'source'      => 'http://linuxcounter.net/script/old/lico-update-0.3.20.sh',
        'destination' => "/usr/local/linuxcounter/lico-update.sh"
      )
    }

    it {
      should contain_class('linuxcounter::install')
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

  context 'fail for other OS than Linux' do
    let(:facts) { {:kernel => 'Solaris'} }
    it do
      expect {
        should contain_class('linuxcounter')
      }.to raise_error(Puppet::Error, /not Linux/)
    end
  end

  context 'install to /opt' do
    let :params do
      {
        :counter_number => '666',
        :user => 'tom',
        :group => 'tom',
        :path => '/opt/linuxcounter',
        :manage_cron => false,
        :manage_user => true
      }
    end
    it {
      should contain_wget__fetch('download lico script').with(
        'destination' => "/opt/linuxcounter/lico-update.sh"
      )
      should contain_file('lico_path').with(
        'ensure' => 'directory',
        'path'   => '/opt/linuxcounter',
        'owner' => 'tom',
        'group' => 'tom',
        'mode' => '0755'
      )

      should contain_file('lico-update.sh').with(
        'path'   => '/opt/linuxcounter/lico-update.sh',
        'ensure' => 'present',
        'owner' => 'tom',
        'group' => 'tom',
        'mode' => '0755'
      )

      should_not contain_cron('linuxcounter').with(
        'command' => "/opt/linuxcounter/lico-update.sh -m"
      )

      should contain_user('tom').with(
        'ensure' => 'present',
        'gid'    => 'tom'
      )
    }
  end

end
