#!/usr/bin/env bash
set -ex

# TODO: can we install without a user and then apply a config that contains that
#       user? for now we have a passwordless admin
curl -L https://tljh.jupyter.org/bootstrap.py |
    sudo python3 - \
        --admin tljhadmin
