#
define monit::monitor() {

  file {"monit ${name}.conf":
    ensure   => present,
    path     => "${monit::configdir}/${name}.conf",
    content  => template("monit/${name}.conf.erb"),
    group    => root,
    notify   => Service['monit'],
    mode     => '0600';
  }
}
