#!/bin/bash

# Start Postgresql & Apache services.
/etc/init.d/postgresql start
/etc/init.d/apache2 start

# Create database user for Moodle, and database for PHPUnit.
sudo -u postgres /usr/bin/psql -c "CREATE USER moodleuser WITH ENCRYPTED PASSWORD 'm00dl3us3r!'"
sudo -u postgres /usr/bin/psql -c "CREATE DATABASE moodledb WITH OWNER moodleuser ENCODING 'UTF8' TEMPLATE template0"
sudo -u postgres /usr/bin/psql -c "CREATE DATABASE mdl_phpunit_db WITH OWNER moodleuser ENCODING 'UTF8' TEMPLATE template0"

# Install Moodle.
/usr/bin/php /var/www/html/moodle/admin/cli/install.php \
    --lang=EN \
    --wwwroot=http://localhost:${MOODLE_PORT}/moodle \
    --dataroot=/var/moodledata/ \
    --dbtype=pgsql \
    --dbhost=localhost \
    --dbname=moodledb \
    --dbuser=moodleuser \
    --dbpass=m00dl3us3r! \
    --dbport=5432 \
    --prefix=mdl_ \
    --fullname=Dockerized_Moodle \
    --shortname=moodle \
    --adminuser=admin \
    --adminpass=adminpass \
    --non-interactive \
    --agree-license

chmod 755 -R /var/www/html/moodle/

# Install PHPUnit for Moodle.
/usr/bin/php /var/www/html/moodle/admin/tool/phpunit/cli/init.php

# Never ending command for maintaining container alive.
tail -F -n0 /dev/null
