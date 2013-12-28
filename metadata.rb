name             "webserver"
maintainer       "Andriy Samilyak"
maintainer_email "samilyak@gmail.com"
license          "All rights reserved"
description      "Installs/Configures webserver"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

depends 'nginx'
depends 'htpasswd'
depends 'php-fpm'
depends 'apache2'
depends 'mysql'
