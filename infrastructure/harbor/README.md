# Harbor setup

NOTE: Currently using a self signed certificate for dns

install with helm due to the compexities of harbor

## Secrets
Per usual we need to create the secrets for harbor
Put the HARBOR_ADMIN_PASSWORD and DATABASE_PASSWORD into .env or export them
Run script to create necessary secrets
```bash
source .env
export HARBOR_ADMIN_PASSWORD
export DATABASE_PASSWORD
./create-secrets.sh
```

```bash
# Add Harbor repository
helm repo add harbor https://helm.goharbor.io
helm repo update

# Install Harbor
helm install harbor harbor/harbor \
  --namespace harbor \
  --values harbor-values.yaml \
  --version 1.13.0
```
