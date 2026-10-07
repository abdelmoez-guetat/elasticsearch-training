#!/bin/bash
set -e

# Start SSH daemon as root using sudo
sudo /usr/sbin/sshd

# Execute Elasticsearch entrypoint / command
exec /usr/local/bin/docker-entrypoint.sh "$@"
