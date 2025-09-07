#!/usr/bin/env bash
# check-argocd-version.sh
# Usage: ./check-argocd-version.sh [RELEASE] [NAMESPACE]
# Defaults: RELEASE=argocd, NAMESPACE=argocd

set -euo pipefail

RELEASE="${1:-argocd}"
NS="${2:-argocd}"

require_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "Error: '$1' not found in PATH." >&2; exit 2; }; }
require_cmd helm
require_cmd awk

# Get current running app version from the Helm release
if ! helm -n "$NS" ls --filter "^${RELEASE}$" >/dev/null 2>&1; then
  echo "Error: Could not find Helm release '$RELEASE' in namespace '$NS'." >&2
  exit 2
fi

current_app_version="$(helm -n "$NS" ls --filter "^${RELEASE}$" \
  | awk 'NR==2 {print $NF}')"

if [[ -z "${current_app_version:-}" ]]; then
  echo "Error: Could not determine current Argo CD app version from Helm release '$RELEASE'." >&2
  exit 2
fi

# Ensure the Argo Helm repo exists; add if missing
if ! helm repo list | awk '{print $1}' | grep -qx "argo"; then
  helm repo add argo https://argoproj.github.io/argo-helm >/dev/null
fi

echo "Updating helm repo"
helm repo update

echo "Checking installed version and latest version"

# Fetch latest app version from the argo/argo-cd chart
latest_app_version="$(helm search repo argo/argo-cd --versions|head -2|tail -1|awk {'print $3'})"

if [[ -z "${latest_app_version:-}" ]]; then
  echo "Error: Could not determine latest stable Argo CD version from Helm repo." >&2
  exit 3
fi

echo "Current (cluster):  ${current_app_version}"
echo "Latest  (stable):   ${latest_app_version}"

if [[ "$current_app_version" == "$latest_app_version" ]]; then
  echo "✅ Up to date."
  exit 0
else
  echo "⬆️  Upgrade available."
  exit 1
fi
