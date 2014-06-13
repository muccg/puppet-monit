#
class monit ($alert = undef) {
  $configdir = '/etc/monit.d'
  $template = 'monit/monitrc.erb'
  $config = '/etc/monit.conf'

  package {
    'monit': ensure => installed;
  }

  service {'monit':
    ensure   => running,
    provider => init;
    require  => [ File[$config], Package['monit'] ],
    require  => Package['monit'],
  }

  file { $configdir:
    ensure => directory;
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


define monit::package() {

  file {"monit ${name}.conf":
    ensure   => present,
    path     => "${monit::configdir}/${name}.conf",
    content  => template("monit/${name}.conf.erb"),
    group    => root,
    notify   => Service['monit'],
    mode     => '0600';
  }
}
