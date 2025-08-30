# Prometheus

## Setup

```bash
# First create a secret for the grafana admin password
kubectl create secret generic grafana-admin-password \
  --from-literal=admin-password=$(openssl rand -base64 32) \
  --namespace prometheus

# Then add the secret to the values file
kubectl get secret -n prometheus grafana-admin-password -o jsonpath="{.data.admin-password}" | base64 -d

# IMPORTANT: Make sure to replace to a placeholder before committing
# Install helm chart:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack \
  --namespace prometheus \
  --values infrastructure/prometheus/prometheus-values.yaml
```
