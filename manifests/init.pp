# This class downloads and installs the linuxcounter script
class linuxcounter (
  $counter_number,
  $path = $linuxcounter::params::path,
  $version = $linuxcounter::params::version,
  $download_url = $linuxcounter::params::download_url,
  $user = $linuxcounter::params::user,
  $group = $linuxcounter::params::group,
  $lico_config = $linuxcounter::params::lico_config,
  $update_key = undef,
  $machine_number = undef,
  $manage_user = false,
  $manage_cron = true
) {
  include linuxcounter::params

  # Sanity checks
  if $::kernel != 'Linux' {
    fail('This module installs the Linuxcounter client. What\'s the point if it\'s not Linux?')
  }

  unless is_numeric($counter_number) {
    fail('counter_number must be numeric')
  }

  if $update_key {
    unless is_numeric($update_key) {
      fail('update_key must be numeric')
    }
  }

  if $machine_number {
    unless is_numeric($machine_number) {
      fail('machine_number must be numeric')
    }
  }

  class { 'linuxcounter::install':
    user         => $user,
    group        => $group,
    path         => $path,
    download_url => $download_url,
    manage_user  => $manage_user
  } ->
  class { 'linuxcounter::config':
    manage_cron  => $manage_cron
  }
}
