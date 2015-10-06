# == Class: pgbouncer
#
# This module ensures pgbouncer is installed and configured
#   on the system.
#
# === Parameters
#
# === USAGE
#
# class {
#   'pgbouncer':
#     databases       => {
#       'database01' => {
#         'host'            => '127.0.0.1',
#         'port'            => '5432',
#         'user'            => 'user1',
#         'password'        => 'password',
#         'client_encoding' => 'UNICODE',
#         'datestyle'       => 'ISO',
#         'connect_query'   => 'SELECT 1'
#       }
#     },
#     db_users        => {
#       'dbuser' => 'dbuser_password'
#     },
#     pool_size       => 50,
#     reserve_pool    => 10,
#     pgbouncer_conf  => {
#       'logfile'                => '/var/log/postgresql/pgbouncer.log',
#       'pidfile'                => '/var/run/postgresql/pgbouncer.pid',
#       'listen_addr'            => '127.0.0.1',
#       'listen_port'            => 5432,
#       'unix_socket_dir'        => '/var/run/postgresql',
#       'auth_type'              => 'trust',
#       'auth_file'              => '/etc/pgbouncer/userlist.txt',
#       'admin_users'            => 'admin1, admin2',
#       'stats_users'            => 'stats, root',
#       'pool_mode'              => 'session',
#       'server_reset_query'     => 'DISCARD ALL',
#       'server_check_query'     => 'select 1',
#       'server_check_delay'     => 30,
#       'max_client_conn'        => 100,
#       'default_pool_size'      => 20,
#       'reserve_pool_size'      => 5,
#       'log_connections'        => 1,
#       'log_disconnections'     => 1,
#       'log_pooler_errors'      => 1,
#       'server_round_robin'     => 0,
#       'server_lifetime'        => 1200,
#       'server_idle_timeout'    => 60,
#       'server_connect_timeout' => 15,
#       'server_login_retry'     => 15,
#       'query_timeout'          => 0,
#       'query_wait_timeout'     => 0,
#       'client_idle_timeout'    => 0,
#       'client_login_timeout'   => 60,
#       'autodb_idle_timeout'    => 3600,
#       'pkt_buf'                => 2048,
#       'listen_backlog'         => 128,
#       'tcp_defer_accept'       => 0,
#       'tcp_socket_buffer'      => 0,
#       'tcp_keepalive'          => 1,
#       'tcp_keepcnt'            => 0,
#       'tcp_keepidle'           => 0,
#       'tcp_keepintvl'          => 0,
#       'dns_max_ttl'            => 15,
#       'dns_zone_check_period'  => 0
#     },
#     pgbouncer       => undef,
#     pgbouncer_start => true,
#     version         => '1.5.5-1.pgdg12.4+1'
# }
#
# === Authors
#
# Rhommel Lamas <roml@rhommell.com>
#
# === Copyright
#
# MIT Copyright 2015 Rhommel Lamas, unless otherwise noted.
#
class pgbouncer (
  $databases       = {},
  $db_users        = {},
  $pgbouncer_conf  = {},
  $pgbouncer_opts  = undef,
  $pgbouncer_start = true,
  $pool_size       = 50,
  $reserve_pool    = 10,
  $restart_cmd     = '/etc/init.d/pgbouncer reload',
  $service_ensure  = 'running',
  $service_enable  = true,
  $version         = '1.5.5-1.pgdg12.4+1',
  ) {

  validate_hash($databases)
  validate_hash($db_users)
  validate_hash($pgbouncer_conf)
  validate_string($pgbouncer_opts)

  if !is_integer($pool_size) {
    fail('pool_size must be an integer.')
  }

  if !is_integer($reserve_pool) {
    fail('reserve_pool must be an integer.')
  }

  validate_bool($pgbouncer_start)
  validate_re($service_ensure, [ '^running$', '^stopped$' ],
    'service_ensure must be \'running\' or \'stopped\'.')

  class { 'pgbouncer::install': } ->
  class { 'pgbouncer::config':  } ~>
  class { 'pgbouncer::service': }
}
