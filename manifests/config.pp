class linuxcounter::config (
$user = $::linuxcounter::params::user,
$group = $::linuxcounter::params::group,
$lico_config = $linuxcounter::params::lico_config,
$manage_cron = true
) inherits linuxcounter::params {
  include linuxcounter::params

  file {'lico_config':
    ensure => present,
    path   => $lico_config,
    owner  => $user,
    group  => $group,
    mode   => '0600'
  }


  file_line { 'counter_number':
    path    => $linuxcounter::lico_config,
    line    => "counter_number='${linuxcounter::counter_number}'",
    require => File['lico_config'],
  }
  file_line { 'update_key':
    path    => $linuxcounter::lico_config,
    line    => "update_key='${linuxcounter::update_key}'",
    require => File['lico_config'],
  }
  file_line { 'machine_number':
    path    => $linuxcounter::lico_config,
    line    => "machine_number='${linuxcounter::machine_number}'",
    require => File['lico_config'],
  }
  file_line { 'hostname':
    path    => $linuxcounter::lico_config,
    line    => "hostname='${::hostname}'",
    require => File['lico_config'],
  }

  if $manage_cron {
    cron {'linuxcounter':
      ensure  => present,
      hour    => fqdn_rand(24),
      minute  => fqdn_rand(60),
      weekday => fqdn_rand(7),
      user    => $user,
      command => "${linuxcounter::path}/lico-update.sh -m",
      require => Class['linuxcounter::install']
    }
  }
}
