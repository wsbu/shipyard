#!/usr/bin/env bash

if [ "${uid}" -a "${gid}" ] ; then
    set -e
    user_name=$(basename ${HOME})
    groupadd --gid ${gid} ${user_name}
    useradd \
        --home-dir "$HOME" \
        --uid ${uid} \
        --gid ${gid} \
        --groups sudo \
        ${user_name}
    chown ${uid}:${gid} $HOME
    chown ${uid}:${gid} $HOME/.ssh
    su_cmd="sudo --preserve-env --user ${user_name}"
    set +e
fi

if (( $# == 0 )); then
    set sdf-e
	${su_cmd} /bin/bash
else
    set -e
	${su_cmd} "$@"
fi
