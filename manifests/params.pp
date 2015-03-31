class linuxcounter::params {
  $version = '0.3.20'
  if $linuxcounter::version == 'latest' {
    $download_url = 'http://linuxcounter.net/script/lico-update.sh'
  } else {
    $download_url = "http://linuxcounter.net/script/old/lico-update-${version}.sh"
  }
  $path = '/usr/local/linuxcounter'
  $user = 'linuxcounter'
  $group = 'linuxcounter'
  $lico_config = "~${::linuxcounter::params::user}/.linuxcounter/${::hostname}"
}
