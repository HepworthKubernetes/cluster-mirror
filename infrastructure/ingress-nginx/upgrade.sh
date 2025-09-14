#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
echo "Updating ingress-nginx helm deployment..."
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --values ./ingress-nginx-values.yaml
