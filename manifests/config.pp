class hive::config {

  file { "${hive::config_dir}/beeline-log4j.properties":
    ensure  => file,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    content => file('hive/config/beeline-log4j.properties.template'),
    require => File[ $hive::config_dir ],
  }

  file { "${hive::config_dir}/hive-env.sh":
    ensure  => file,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    content => file('hive/config/hive-env.sh.template'),
    require => File[ $hive::config_dir ],
  }

  file { "${hive::config_dir}/hive-log4j.properties":
    ensure  => file,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    content => file('hive/config/hive-log4j.properties.template'),
    require => File[ $hive::config_dir ],
  }

  file { "${hive::config_dir}/hive-default.xml":
    ensure  => file,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    content => file('hive/config/hive-default.xml.template'),
    require => File[ $hive::config_dir ],
  }

  file { "${hive::config_dir}/hive-exec-log4j.properties":
    ensure  => file,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    content => file('hive/config/hive-exec-log4j.properties.template'),
    require => File[ $hive::config_dir ],
  }

  file { "${hive::config_dir}/ivysettings.xml":
    ensure  => file,
    owner   => $hive::hive_user,
    group   => $hive::hive_group,
    content => file('hive/config/ivysettings.xml'),
    require => File[ $hive::config_dir ],
  }

}


