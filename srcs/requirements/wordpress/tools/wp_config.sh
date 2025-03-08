exec > /tmp/wp_log 2>&1

if [ ! -f /usr/local/bin/wp ]; then
    wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x /usr/local/bin/wp
fi


wp core download --allow-root --path=/var/www/html

wp config create \
    --allow-root \
    --path=/var/www/html \
    --dbname=${MDB_NAME} \
    --dbuser=${MDB_ADMIN} \
    --dbpass=${MDB_ADMIN_PW} \
    --dbhost=mariadb \
    --debug || echo "wp config create failed!"

wp core install \
    --allow-root \
    --path=/var/www/html \
    --url=${URL} \
    --title=${TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PW} \
    --admin_email=${WP_ADMIN_EMAIL} || echo "wp core install failed!"

wp --allow-root theme activate twentytwentyfour || echo "Theme activation failed!"

wp --allow-root user create "$WP_USER_NAME" "$WP_USER_EMAIL" --role=editor --user_pass=$WP_USER_PW

unset MDB_NAME MDB_ADMIN MDB_ADMIN_PW URL TITLE WP_ADMIN_USER WP_ADMIN_PW WP_ADMIN_EMAIL

exec php-fpm7.4 -F
