#!/bin/bash

# Install Apche, PHP, MySQL client, and WordPress

# Update and install dependancies
apt-get update -y
apt-get install -y apache2 php php-mysql libapache2-mod-php mysql-client unzip curl

# Download and Set up WordPress
curl -O https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html

# Set permissions
chown -R www-data:www-data /var/www/html/
chown -R 775 /var/www/html/

# Configure Apache
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:${port}>
    DocumentRoot /var/www/html
    <Directory /var/www/html>
        AllowOverride All
    </Directory>
</VirtualHost>
EOF

# Localstack - Enables PHP to allow wordpress to connect to the correct database with the right credentials
# Real AWS ec2 - Generates wp-config.php with injected DB credentials from Terraform
cat > /var/www/html/wp-config.php <<EOF
<?php
define('DB_NAME', '${db_name}');
define('DB_USER', '${db_user}');
define('DB_PASSWORD', '${db_password}');
define('DB_HOST', '${db_host}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
?>
EOF

# Use this for localstack.
# Not needed for real AWS ec2 as this one will overwrite the first one. Defeating the purpose of terraform provided variables.
# cat <<EOF > /var/www/html/wp-config.php
# <?php
# define('DB_NAME', 'wordpress');
# define('DB_USER', 'admin');
# define('DB_PASSWORD', 'chelsea');
# define('DB_HOST', 'mysql');  # Container name in Docker network
# define('DB_CHARSET', 'utf8');
# define('DB_COLLATE', '');
# ?>
# EOF


# Enable Apache modules
a2enmod rewrite
# systemctl restart apache      ==> Already being done in the CMD section of the Dockerfile
