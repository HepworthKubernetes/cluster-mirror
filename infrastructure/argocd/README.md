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

### Access

- URL: https://argocd.batk.me
- Username: `admin`
- Password: Get by running this command:

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 -d
```

### Remove initial admin password

The initial admin password is stored in plain text in the `argocd-initial-admin-secret` secret. After the first time install, test logging in with admin and the initial password. Save the password, then delete the secret by running this command:

```bash
kubectl -n argocd delete secret argocd-initial-admin-secret
```

## Checking Current Version

Run this script to check both the currently deployed and latest release from argocd:

```
./check-argocd-version.sh
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

## Individual Commands - **optional**

If you want to manually check the versions, you can run these commands (the above script does these also)

Helm release (chart + app version):

```bash
helm list -n argocd
```

Get ArgoCD image version:

```bash
kubectl -n argocd get deploy argocd-server -o=jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
```
