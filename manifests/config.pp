class linuxcounter::config (
$user,
$group,
$counter_number,
$update_key,
$machine_number
) {

validate_int($counter_number)

file {"/home/${user}/.linuxcounter/${::hostname}":
  ensure => present,
  owner  => $user,
  group  => $group,
  mode   => '0600'
  }

cron {'linuxcounter':
  ensure  => present,
  hour    => fqdn_rand(24),
  minute  => fqdn_rand(60),
  weekday => fqdn_rand(7),
  user    => $user,
  command => "${linuxcounter::path} -m"
}

#scriptversion='lico-update.sh version 0.3.20'
#hostname='${::hostname}'
#counter_number=''
#update_key=''
#machine_number=''
#distribution='Ubuntu'
#distribversion='14.10'

}
