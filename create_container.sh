#!/bin/bash
set +x
set -o errexit    # exit when a command fails
set -o nounset    # error when an undefined variable is referenced
set -o pipefail   # error if the input command to a pipe fails


readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
. $SCRIPT_DIR/cred.env


if [ "$#" -ne 1 ]; then
    echo "Error! Needs to pass storage container name"
    exit -1
fi

bucket=$1

terraform init
terraform apply -var bucket=$bucket -auto-approve