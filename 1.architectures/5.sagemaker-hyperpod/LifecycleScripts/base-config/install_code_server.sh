#!/bin/bash

# does not need sudo. expected to run on a controller or login node.
# unless you want code server on a compute node
# USAGE: install_code_server.sh <USER>
# - Where USER is your Linux user

set -ex

DEFAULT_PASSWORD="password" # very secure
USER=($1)

main() {
    curl -fsSL https://code-server.dev/install.sh | sh
    sudo systemctl enable --now code-server@$1

    CONFIG_FILE="/home/$1/.config/code-server/config.yaml"

    sleep 5


    sed -r "s/^(\s*)(password: ).*/\1password: $DEFAULT_PASSWORD/" $CONFIG_FILE > $CONFIG_FILE

    cat /home/$1/.config/code-server/config.yaml
}

main "$@"