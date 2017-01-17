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

  $version        = $hive::params::version,
  $install_dir    = $hive::params::install_dir,
  $config_dir     = "${install_dir}/etc/hadoop",
  $mirror_url     = $hive::params::mirror_url,
  $download_dir   = $hive::params::download_dir,
  $log_dir        = $hive::params::log_dir,
  $pid_dir        = $hive::params::pid_dir,

  $package_name   = $hive::params::package_name,
  $package_ensure = $hive::params::package_ensure,

  $install_java   = $hive::params::install_java,
  $java_version   = $hive::params::java_version,








) inherits hive::params
{
  $basefilename = "apache-hive-${version}-bin.tar.gz"
  $package_url  = "${mirror_url}/hive/hive-${version}/${basefilename}"
  $extract_dir  = "/opt/hadoop-${version}"

  if $install_java {
    java::oracle { 'jdk8':
      ensure  => 'present',
      version => $java_version,
      java_se => 'jdk',
      before  =>  Archive[ "${download_dir}/${basefilename}" ]
    }
  }

  class { '::hive::install': }

}
