#!/usr/bin/env bash
set -ex

# TODO: ISSUE #1
curl -L https://tljh.jupyter.org/bootstrap.py |
    sudo python3 - \
        --admin tljhadmin
