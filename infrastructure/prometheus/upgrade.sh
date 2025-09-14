#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
echo "Updating prometheus helm deployment..."
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  --namespace prometheus \
  --values prometheus-values.yaml
