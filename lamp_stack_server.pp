# LAMP stack role manifest

# Apache and PHP packages
package { 'apache2':
  ensure => installed,
}

package { 'php':
  ensure  => installed,
  require => Package['apache2'],
  notify  => Service['apache2'],
}

package { 'libapache2-mod-php':
  ensure  => installed,
  require => [Package['apache2'], Package['php']],
  notify  => Service['apache2'],
}

package { 'php-cli':
  ensure  => installed,
  require => Package['php'],
}

package { 'php-mysql':
  ensure  => installed,
  require => Package['php'],
}

# phpinfo test page
file { '/var/www/html/phpinfo.php':
  ensure  => file,
  source  => '/home/nuur/jimale_inet4031_puppet_lab9/phpinfo.php',
  require => Package['apache2'],
  notify  => Service['apache2'],
}

# Apache service
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => [Package['apache2'], Package['php']],
}

# MariaDB server (MySQL)
package { 'mariadb-server':
  ensure => installed,
}

service { 'mariadb':
  ensure  => running,
  enable  => true,
  require => Package['mariadb-server'],
}
