# ArgoCD setup

> NOTE: Currently using cert-manager with Let's Encrypt for TLS certificates
> Installed with Heml (using the official `argo/argo-cd` chart) for easier upgrades.

---

## First-Time Installation

This script:

- creates the argocd namespace if it doesn't exist
- creates the argocd and redis secrets if they don't exist
- installs Argo CD into the `argocd` namespace with values from argocd-values.yaml

```bash
./install-argocd.sh
```

## Access
- URL: https://argocd.batk.me
- Username: `admin`
- Password: Get with

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d
```

## Upgrades

Always update the repo and do a dry run before applying:

```bash
./upgrade-argocd.sh --dry-run
```

Then if it looks good, run the upgrade:

```bash
./upgrade-argocd.sh
```

## Checking Current Version

Helm release (chart + app version):

```bash
helm list -n argocd
```

Get ArgoCD image version:

```bash
kubectl -n argocd get deploy argocd-server -o=jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
```
