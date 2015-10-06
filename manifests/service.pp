# Class to manage pgbouncer service
class pgbouncer::service {
  service {
    'pgbouncer':
      ensure     => $::pgbouncer::service_ensure,
      enable     => $::pgbouncer::service_enable,
      hasstatus  => true,
      hasrestart => true,
      restart    => $::pgbouncer::restart_cmd,
      require    => Package['pgbouncer'],
  }
}
