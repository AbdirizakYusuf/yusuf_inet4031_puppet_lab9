# Apache/PHP Packages
package { 'apache2':
  ensure => installed,
}

package { ['php', 'libapache2-mod-php', 'php-cli', 'php-mysql']:
  ensure  => installed,
  notify  => Service['apache2'],
  require => Package['apache2'],
}

# MySQL Package
package { 'mariadb-server':
  ensure => installed,
}

# Services
service { 'apache2':
  ensure    => running,
  enable    => true,
  require   => [Package['apache2'], Package['php']],
}

service { 'mariadb':
  ensure    => running,
  enable    => true,
  require   => Package['mariadb-server'],
}

# PHP Test File
file { '/var/www/html/phpinfo.php':
  ensure    => present,
  content   => '<?php phpinfo(); ?>',
  mode      => '0644',
  notify    => Service['apache2'],
  require   => Package['apache2'],
}
