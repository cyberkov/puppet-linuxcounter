class linuxcounter::params {
  $version = '0.3.20'
  $path = '/usr/local/linuxcounter'
  $user = 'linuxcounter'
  $group = 'linuxcounter'
  $lico_config = "~${::linuxcounter::params::user}/.linuxcounter/${::hostname}"
  $download_url = $linuxcounter::version ? {
    'latest' => 'http://linuxcounter.net/script/lico-update.sh',
    default => "http://linuxcounter.net/script/old/lico-update-${version}.sh"
  }
}
