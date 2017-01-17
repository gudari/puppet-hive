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



}

