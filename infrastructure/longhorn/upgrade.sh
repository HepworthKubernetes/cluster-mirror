#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
echo "Updating longhorn helm deployment..."
helm upgrade --install longhorn longhorn/longhorn \
  --namespace longhorn-system \
  --values longhorn-values.yaml
