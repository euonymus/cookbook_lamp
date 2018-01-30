name             'lamp'
maintainer       'euonymus'
maintainer_email 'euonymus0220@gmail.com'
license          'All rights reserved'
description      'Installs/Configures lamp'
long_description 'Installs/Configures lamp'
version          '0.1.0'


depends 'apache2'
depends 'mysql', '~> 8.0'
depends 'php'
depends 'database'
depends 'mysql2_chef_gem'
