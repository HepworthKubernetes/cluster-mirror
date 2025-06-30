# ArgoCD setup

NOTE: Currently using cert-manager with Let's Encrypt for TLS certificates

Install with helm due to the complexities of ArgoCD configuration

## Secrets
Create the necessary secrets for ArgoCD (server and redis secrets)
Run script to create necessary secrets

```bash
./create-secrets.sh
```

## Installation

```bash
# Add ArgoCD repository
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Install ArgoCD
helm upgrade --install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  --values argocd-values.yaml
```

## Access
- URL: https://argocd.batk.me
- Username: `admin`
- Password: Get with `kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d`
