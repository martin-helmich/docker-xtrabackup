FROM ubuntu:15.04
MAINTAINER Martin Helmich <m.helmich@mittwald.de>

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
RUN echo "deb http://repo.percona.com/apt vivid main" >> /etc/apt/sources.list && \
    apt-get update
RUN apt-get install -y percona-xtrabackup

VOLUME /var/backup/mysql

CMD xtrabackup --backup --datadir /var/lib/mysql --target-dir=/target && \
    xtrabackup --prepare --target-dir=/target && \
    xtrabackup --prepare --target-dir=/target
