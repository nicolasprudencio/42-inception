FROM debian:oldstable

ARG MDB_NAME
ARG MDB_ADMIN
ARG MDB_ADMIN_PW

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y mariadb-server

COPY tools/mdb_config.sh /tmp/mdb_config.sh
COPY conf/mariadb.cnf /etc/mysql/mariadb.cnf

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod -R 755 /var/run/mysqld
RUN chmod +x /tmp/mdb_config.sh 
RUN bash /tmp/mdb_config.sh