#!/usr/bin/env bash
set -ex

# NOTE: This is here as a convenience for extension down the road. As of the
#       first release of the AMI we have no additional scripts.

AMI_SCRIPTS=/tmp/additional-scripts/"${AMI_PREFIX}"

if [ -d "${AMI_SCRIPTS}" ]; then
    for f in $(find "${AMI_SCRIPTS}" -maxdepth 1 -type f -name "*.sh" | sort -g); do
        echo "Executing ${f}"
        bash "$f"
    done
fi
