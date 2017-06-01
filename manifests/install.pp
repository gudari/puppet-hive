class hive::install {

  file { $hive::download_dir:
    ensure  => directory,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    require => [
      Group[ $hive::hive_group ],
      User[ $hive::hive_user ],
    ],
  }

  file { $hive::extract_dir:
    ensure  => directory,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    require => [
      Group[ $hive::hive_group ],
      User[ $hive::hive_user ],
    ],
  }

  file { $hive::log_dir:
    ensure  => directory,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    require => [
      Group[ $hive::hive_group ],
      User[ $hive::hive_user ],
    ],
  }

  file { $hive::pid_dir:
    ensure  => directory,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    require => [
      Group[ $hive::hive_group ],
      User[ $hive::hive_user ],
    ],
  }

   if $hive::package_name == undef {
     include '::archive'

     archive { "${hive::download_dir}/${hive::basefilename}":
       ensure          => present,
       extract         => true,
       extract_command => 'tar xfz %s --strip-components=1',
       extract_path    => $hive::extract_dir,
       source          => $hive::package_url,
       creates         => "${hive::extract_dir}/bin",
       cleanup         => true,
       user            => $hive::hive_user,
       group           => $hive::hive_group,
       require         => [
         File[ $hive::download_dir ],
         File[ $hive::extract_dir ],
         Group[ $hive::hive_group ],
         User[ $hive::hive_user ],
       ],
       before          => File[ $hive::install_dir ],
     }
  } else {
    package { $hive::package_name:
      ensure => $hive::package_ensure,
      before => File[ $hive::install_dir ],
    }
  }

  file { $hive::install_dir:
    ensure  => link,
    target  => $hive::extract_dir,
    require => File[ $hive::extract_dir ],
  }

  file { $hive::config_dir:
    ensure  => directory,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    require => [
      Group[ $hive::hive_group ],
      User[ $hive::hive_user ],
    ],
  }
}

