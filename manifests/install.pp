class linuxcounter::install (
    $user = $::linuxcounter::params::user,
    $group = $::linuxcounter::params::group,
    $path   = $::linuxcounter::path,
) inherits ::linuxcounter::params {
  include wget
  include linuxcounter::params

  if $linuxcounter::manage_user {
    user { $linuxcounter::user:
      ensure     => present,
      gid        => $linuxcounter::group,
      managehome => true,
    }
  }

  wget::fetch { 'download lico script':
    source      => $linuxcounter::params::download_url,
    destination => "${path}/lico-update.sh",
    verbose     => false,
    cache_dir   => '/var/cache/wget',
  }

  file { 'lico_path':
    ensure => directory,
    path   => $path,
    mode   => '0755',
    owner  => $user,
    group  => $group
  }

  file { 'lico-update.sh':
    ensure  => present,
    path    => "${path}/lico-update.sh",
    mode    => '0755',
    owner   => $user,
    group   => $group,
    require => File['lico_path']
  }

}
