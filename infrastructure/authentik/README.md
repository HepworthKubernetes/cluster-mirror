# Authentik

First, create namespace and secrets

```bash
kubectl apply -f infrastructure/authentik/namespace.yaml

kubectl create secret generic authentik-env \
  --from-literal=AUTHENTIK_SECRET_KEY="$(openssl rand -base64 48 | tr -d '\n' | tr -d '=+/')" \
  --from-literal=AUTHENTIK_POSTGRES__PASSWORD="$(openssl rand -base64 24 | tr -d '\n' | tr -d '=+/')" \
  --namespace authentik

# NOTE, these secrets are not automatically injected with values.yaml
# Add them to values.yaml, deploy it, and make sure to clear it before a commit

helm repo add authentik https://charts.goauthentik.io
helm repo update

# Patch the values to use secrets from kubernetes
helm upgrade --install authentik authentik/authentik \
  --namespace authentik --values authentik-values.yaml \
  --set authentik.secret_key=$(kubectl get secret authentik-env -n authentik -o jsonpath="{.data.AUTHENTIK_SECRET_KEY}" | base64 -d) \
  --set authentik.postgresql.password=$(kubectl get secret authentik-env -n authentik -o jsonpath="{.data.AUTHENTIK_POSTGRES__PASSWORD}" | base64 -d) \
  --set postgresql.auth.password=$(kubectl get secret authentik-env -n authentik -o jsonpath="{.data.AUTHENTIK_POSTGRES__PASSWORD}" | base64 -d)
```
