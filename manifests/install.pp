class linuxcounter::install (
    $user = $linuxcounter::params::user,
    $group = $linuxcounter::params::group,
    $path   = $linuxcounter::params::path,
    $download_url = $linuxcounter::params::download_url,
    $manage_user = false
) inherits linuxcounter::params {
  include wget

  if $manage_user {
    user { 'lico_user':
      ensure     => present,
      name       => $user,
      gid        => $group,
      managehome => true,
    }
  }

  file { 'lico_path':
    ensure => directory,
    path   => $path,
    mode   => '0755',
    owner  => $user,
    group  => $group
  }

  wget::fetch { "download ${download_url}":
    source      => $download_url,
    destination => "${path}/lico-update.sh",
    verbose     => false,
    cache_dir   => '/var/cache/wget',
    require     => File['lico_path'],
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
