#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./upgrade-argocd.sh           # upgrades to latest chart
#   ./upgrade-argocd.sh --dry-run # preview only

NAMESPACE="argocd"
CHART="argo/argo-cd"
VALUES_FILE="./argocd-values.yaml"

EXTRA_FLAGS=""
if [[ "${1:-}" == "--dry-run" ]]; then
  EXTRA_FLAGS="--dry-run --debug"
fi

echo "==> Updating Helm repo"
helm repo add argo https://argoproj.github.io/argo-helm > /dev/null 2>&1 || true
helm repo update > /dev/null

echo "==> Upgrading Argo CD in namespace $NAMESPACE to the latest chart"
helm upgrade argocd "$CHART" \
  --namespace "$NAMESPACE" \
  -f "$VALUES_FILE" \
  --atomic --timeout 10m \
  $EXTRA_FLAGS

echo
if [[ -n "$EXTRA_FLAGS" ]]; then
  echo "✅ Dry run completed."
else
  echo "✅ Upgrade submitted. Check rollout status:"
  echo "   kubectl -n $NAMESPACE get pods"
fi

