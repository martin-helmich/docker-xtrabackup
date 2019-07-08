#!/usr/bin/env bash

[[ -n "${DEBUG}" ]] && set -x
set -e

XTRABACKUP="$(command -v xtrabackup)"
if [[ ! -x "${XTRABACKUP}" ]]; then
    echo "${XTRABACKUP} is not executable!"
    exit 1
fi

if [[ ! -d "${XTRABACKUP_SOURCE_DIR}" || ! "$(ls -A ${XTRABACKUP_SOURCE_DIR})" ]]; then
    echo "directory '${XTRABACKUP_SOURCE_DIR}' doesn't seem to contain a database"
    echo "check your env variable '\${XTRABACKUP_SOURCE_DIR}' please"
    exit 1
fi

if [[ -n "${@}" ]]; then
    # if custom cmd is provided, run xtrabackup with it
    ${XTRABACKUP} ${@}
else
    # run default backup routine
    ${XTRABACKUP} --backup --datadir ${XTRABACKUP_SOURCE_DIR} --target-dir=${XTRABACKUP_TARGET_DIR}
    ${XTRABACKUP} --prepare --target-dir=${XTRABACKUP_TARGET_DIR}
fi

exit 0