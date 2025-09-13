#!/usr/bin/env bash
set -euo pipefail

# Config (hard-coded for now; change later if you want)
NAMESPACE="argocd"
CHART="argo/argo-cd"
VALUES_FILE="./argocd-values.yaml"

echo "==> Adding/updating Helm repo"
helm repo add argo https://argoproj.github.io/argo-helm >/dev/null 2>&1 || true
helm repo update

echo "==> Installing Argo CD into namespace $NAMESPACE"
helm upgrade --install argocd "$CHART" \
  --namespace "$NAMESPACE" \
  --create-namespace \
  --values "$VALUES_FILE" \
  --set installCRDs=true

echo
echo "✅ Install kicked off. Check status:"
echo "  kubectl -n $NAMESPACE get pods,pvc,ingress"
echo
echo "🔐 Initial admin password (after pods are Ready):"
echo "  kubectl -n $NAMESPACE get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo"
echo
echo "🌐 UI (once Ingress is Ready):  https://argocd.batk.me"
