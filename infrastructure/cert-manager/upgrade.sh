#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
echo "Updating cert-manager helm deployment..."
helm upgrade --install cert-manager \
  --namespace cert-manager \
  --version v1.18.0 \
  --set crds.enabled=true \
  jetstack/cert-manager
