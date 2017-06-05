# == Class: hive
#
# Full description of class hive here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'hive':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class hive (

  $version          = $hive::params::version,
  $install_dir      = $hive::params::install_dir,
  $config_dir       = "${install_dir}/conf",
  $mirror_url       = $hive::params::mirror_url,
  $download_dir     = $hive::params::download_dir,
  $log_dir          = $hive::params::log_dir,
  $pid_dir          = $hive::params::pid_dir,

  $package_name     = $hive::params::package_name,
  $package_ensure   = $hive::params::package_ensure,

  $install_java     = $hive::params::install_java,
  $java_version     = $hive::params::java_version,

  $hive_user        = $hive::params::hive_user,
  $hive_user_uid    = $hive::params::hive_uid,
  $hive_group       = $hive::params::hive_group,
  $hive_group_gid   = $hive::params::hive_gid,

  $custom_hive_site = {},

  $database_type     = 'mysql',
  $database_host     = $::fqdn,
  $database_port     = 3306,
  $datebase_name     = 'metastore',
  $database_user     = 'hive',
  $database_password = 'hivepassword',
  $metastore_host    = $::fqdn,

) inherits hive::params
{
  $basefilename = "apache-hive-${version}-bin.tar.gz"
  $package_url  = "${mirror_url}/hive/hive-${version}/${basefilename}"
  $extract_dir  = "/opt/hive-${version}"

  if $install_java {
    java::oracle { "jdk${java_version}":
      ensure  => 'present',
      version => $java_version,
      java_se => 'jdk',
      before  =>  Archive[ "${download_dir}/${basefilename}" ]
    }
  }

  group { $hive_group:
    ensure => present,
    gid    => $hive_gid,
  }

  user { $hive_user:
    ensure  => present,
    uid     => $hive_uid,
    groups  => $hive_group,
    require => Group[ $hive_group ],
  }

  if $metastore_host {
    $daemon_metastore = true
    $metastore_hive_site = {
      'hive.metastore.uris' => "thrift://${metastore_host}:9083",
    }
  }

  case $database_type {
    'mysql': {
      $database_hive_site = {
        'javax.jdo.option.ConnectionURL'        => "jdbc:mysql://${database_host}:${database_port}/${database_name}?createDatabaseIfNotExist=true",
        'javax.jdo.option.ConnectionDriverName' => 'com.mysql.jdbc.Driver',
        'javax.jdo.option.ConnectionUserName'   => $database_user,
        'javax.jdo.option.ConnectionPassword'   => $database_password,
      }
    }
    default: {
      fail('This database is not supported.')
    }

  }

  $hive_site = deep_merge($hive::params::default_hive_site, $metastore_hive_site, $database_hive_site, $custom_hive_site)
  
  anchor { '::hive::start': } ->
  class { '::hive::install': } ->
  class { '::hive::config': } ->
  anchor { '::hive::end': }

}
