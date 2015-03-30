# This class downloads and installs the linuxcounter script
class linuxcounter (
  $path = $linuxcounter::params::path,
  $version = $linuxcounter::params::version,
  $download_url = $linuxcounter::params::download_url,
  $user = linuxcounter::params::user,
  $group = linuxcounter::params::group,
  $manage_user = false,
  $manage_cron = true
) {
  if $::kernel != 'Linux' {
    fail('This module installs the Linuxcounter client. What\'s the point if it\'s not Linux?')
  }
  #class { 'linuxcounter::download': }
  class { 'linuxcounter::config': }
}
