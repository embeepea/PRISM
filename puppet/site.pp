exec { disable_selinux_sysconfig:
    command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config',
    unless => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
}

package { 'emacs-nox':
  ensure => installed
}

package { 'man':
  ensure => installed
}

package { 'wget':
  ensure => installed
}

package { 'git':
  ensure => installed
}

package { 'netcdf4-python':
  ensure => installed
}

package { 'gdal-python':
  ensure => installed
}

file { "/etc/ld.so.conf.d/hdf5-mpich2.conf":
  content => "/usr/lib/mpich2/lib",
}

exec { ldlibcfg:
    command => "/sbin/ldconfig",
    subscribe => File["/etc/ld.so.conf.d/hdf5-mpich2.conf"],
    refreshonly => true
}
