# Class to configure pgbouncer
class pgbouncer::config (
  $databases      = $pgbouncer::databases,
  $db_users       = $pgbouncer::db_users,
  $pgbouncer_conf = $pgbouncer::pgbouncer_conf,
  $pool_size      = $pgbouncer::pool_size,
  $reserve_pool   = $pgbouncer::reserve_pool,
  ){

  file {
    '/etc/pgbouncer/pgbouncer.ini':
      ensure  => 'present',
      owner   => 'postgres',
      group   => 'postgres',
      mode    => '0640',
      content => template('pgbouncer/pgbouncer.ini.erb',
                          'pgbouncer/databases.ini.erb'),
      notify  => Class['pgbouncer::service'],
      require => Package['pgbouncer'],
  }

  file {
    '/etc/pgbouncer/userlist.txt':
      ensure  => 'present',
      owner   => 'postgres',
      group   => 'postgres',
      mode    => '0640',
      content => template('pgbouncer/userlist.txt.erb'),
      notify  => Class['pgbouncer::service'],
      require => Package['pgbouncer']
  }

}
