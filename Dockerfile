FROM ubuntu:15.04
MAINTAINER Martin Helmich <m.helmich@mittwald.de>

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
RUN echo "deb http://repo.percona.com/apt vivid main" >> /etc/apt/sources.list && \
    apt-get update
RUN apt-get install -y percona-xtrabackup

VOLUME /var/backup/mysql

CMD mkdir -p /var/backups/mysql/$(date +%Y%m%d) && \
    xtrabackup --backup --datadir /var/lib/mysql --target-dir=/var/backups/mysql/$(date +%Y%m%d) && \
    xtrabackup --prepare --target-dir=/var/backups/mysql/$(date +%Y%m%d) && \
    xtrabackup --prepare --target-dir=/var/backups/mysql/$(date +%Y%m%d)
