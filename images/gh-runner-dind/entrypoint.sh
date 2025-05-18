#!/bin/bash
set -e

cd /runner

./config.sh --url "REPO_URL" \
           --token "ACCESS_TOKEN" \
           --labels "LABELS" \
           --unattended \
           --replace

echo "[DEBUG] Arguments: $@"

exec ./run.sh
