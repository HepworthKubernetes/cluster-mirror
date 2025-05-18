# Addition notes for config install

## Metrics server for OpenLens
```bash
# Add helm repo for metrics server
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/                                       
helm repo update                                                              
# Install metrics server to kube-system namespace
# Allow self-signed certificates with set args
helm install metrics-server metrics-server/metrics-server \
  --namespace kube-system \
  --create-namespace \
  --set args="{--kubelet-insecure-tls}"
```
## Prometheus install
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus prometheus-community/prometheus \
  --namespace monitoring \
  --create-namespace
```
