exec { "apt-update":
  command => "/usr/bin/sudo /usr/bin/apt-get update"
}

# Ensure apt-get update has been run before installing any packages
Exec["apt-update"] -> Package <| |>

package {
  "pypy":
    ensure => installed;
  "curl":
    ensure => installed;
  "redis": # for example
    provider => pip,
    require => Exec['pypy pip'],
    ensure => installed;
}

exec { "distribute_setup":
  command => "/usr/bin/curl -O http://python-distribute.org/distribute_setup.py && pypy distribute_setup.py",
  cwd => "/home/vagrant",
  require => Package['pypy']
}

exec {"pypy pip":
  command => "/usr/bin/curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py && pypy get-pip.py",
  cwd => "/home/vagrant",
  require => Exec['distribute_setup']
}




