#
class monit ($alert = 'root@localhost') {
  $configdir = '/etc/monit.d'
  $template = 'monit/monitrc.erb'
  $config = '/etc/monit.conf'

  package {
    'monit': ensure => installed;
  }

  service {'monit':
    ensure   => running,
    provider => init,
    require  => [ File[$config], Package['monit'] ],
  }

  file { $configdir:
    ensure => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { $config:
    ensure  => present,
    content => template($template),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => File[$configdir],
    notify  => Service['monit'],
  }

}
