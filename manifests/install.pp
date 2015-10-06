class pgbouncer::install (
  $pgbouncer_opts  = $pgbouncer::pgbouncer_opts,
  $pgbouncer_start = $pgbouncer::pgbouncer_start,
  $version         = $pgbouncer::version,
  ){

  package {
    'pgbouncer':
      ensure   => $version,
      provider => 'aptitude',
  }

  file {
    '/etc/default/pgbouncer':
      ensure  => 'present',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template('pgbouncer/etc/default/pgbouncer.erb'),
      notify  => Class['pgbouncer::service'],
      require => Package['pgbouncer'],
  }
}
