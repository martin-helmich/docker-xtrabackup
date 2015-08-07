Dockerized XtraBackup
=====================

This Docker image contains an installation of [XtraBackup](https://github.com/percona/percona-xtrabackup)
that can be used to create backups of MySQL and MariaDB containers with minimal configuration.

Usage
-----

Create a MariaDB container to backup first:

    docker run -d --name my-database \
        -e MYSQL_ROOT_PASSWORD=test \
        -e MYSQL_USER=test \
        -e MYSQL_PASSWORD=test \
        -e MYSQL_DATABASE=test mariadb:latest

Now start the xtrabackup container. You can mount a directory into the container's `/target` directory.

    docker run --volumes-from my-database -v /var/backups/mysql:/target --rm martinhelmich/xtrabackup
