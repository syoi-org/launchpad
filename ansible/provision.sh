#!/bin/sh

set -e

# Parse arguments with getopts
ARGS=$(getopt -n $0 -o "" -l "extra-vars:" -- "$@")
eval set -- "$ARGS"

extra_vars=''
while true; do
case $1 in
--extra-vars)
    # append the extra vars to the existing ones
    shift
    extra_vars=$extra_vars" --extra-vars $1"
    ;;
--)
    shift
    break;;
esac
shift
done

# Check SSH connection
echo "[*] waiting SSH connection $1..."
while ! ssh -o StrictHostKeyChecking=accept-new $1 echo '[*] successfully connected to remote.'; do
    sleep 1
done

# Build ansible inventory
ansible_inventory=$(mktemp)
cat > $ansible_inventory << EOF
[remote]
$1
EOF

# Run ansible playbook
ansible-playbook -i $ansible_inventory $extra_vars playbook.yml
