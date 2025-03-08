service mariadb start

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MDB_NAME};"

mariadb -u root -e "CREATE USER IF NOT EXISTS '${MDB_ADMIN}'@'%' IDENTIFIED BY '${MDB_ADMIN_PW}';"

mariadb -u root -e "GRANT ALL PRIVILEGES ON ${MDB_NAME}.* TO '${MDB_ADMIN}'@'%' IDENTIFIED BY '${MDB_ADMIN_PW}';"

mariadb -u root -e "FLUSH PRIVILEGES;"
