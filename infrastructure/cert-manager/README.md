# Cert Manager

```bash
# apply crds and namespace
kubectl apply -f cert-manager.crds.yaml

# install cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager \
  --namespace cert-manager \
  --version v1.18.0 \
  --create-namespace \
  --set crds.enabled=true \
  jetstack/cert-manager

# start cluster issuer
kubectl apply -k infrascructure/cert-manager/cluster-issuers
```
