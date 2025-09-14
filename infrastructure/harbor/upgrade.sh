#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "$0")"
echo "Updating Harbor helm deployment..."
helm upgrade --install harbor harbor/harbor \
  --namespace harbor \
  --values ./harbor-values.yaml
