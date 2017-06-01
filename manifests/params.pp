class hive::params {

  $version        = '2.1.1'
  $install_dir    = '/opt/hive'
  $mirror_url     = 'http://apache.rediris.es'
  $download_dir   = '/var/tmp/hive'
  $log_dir        = '/var/log/hive'
  $pid_dir        = '/var/lib/run'

  $package_name   = undef
  $package_ensure = undef

  $install_java   = false
  $java_version   = '8'

  $hive_user      = 'hive'
  $hive_uid       = undef
  $hive_group     = 'hive'
  $hive_gid       = undef

}
