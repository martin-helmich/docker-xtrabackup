FROM    debian:stretch-slim

LABEL   MAINTAINER="Martin Helmich <m.helmich@mittwald.de>"

ARG     XTRABACKUP_VERSION="8.0.6-1"
ENV     XTRABACKUP_TARGET_DIR="/target" \
        XTRABACKUP_SOURCE_DIR="/var/lib/mysql"

RUN     set -x && \
        apt-get -qq update && \
        apt-get -qq install wget && \
        # do some sick versioning stuff because percona has a very "special" versioning
        ## '8.0.6-1' to '8.0-6'
        XTRABACKUP_VERSION_DASH="$(echo "${XTRABACKUP_VERSION%-*}" | sed -E "s/(.*)\./\1-/")" && \
        ## '8.0.6-1' to '80'
        XTRABACKUP_VERSION_MINOR="$(echo "${XTRABACKUP_VERSION%.*}" | sed "s#\.##g")" && \
        wget -q -O /tmp/xtrabackup.deb \
            "https://www.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-${XTRABACKUP_VERSION_DASH}/binary/debian/stretch/x86_64/percona-xtrabackup-${XTRABACKUP_VERSION_MINOR}_${XTRABACKUP_VERSION}.stretch_amd64.deb" && \
        apt-get -qq -f install /tmp/xtrabackup.deb && \
        apt-get -qq purge wget && \
        apt-get -qq autoclean && apt-get -qq autoremove && rm -rf /tmp/* /var/cache/apt/* /var/cache/depconf/*

COPY    entrypoint.sh /entrypoint.sh
VOLUME  /var/backup/mysql

ENTRYPOINT [ "/entrypoint.sh" ]