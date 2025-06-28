# Metallb

Install with helm:
```bash
helm repo add metallb https://metallb.github.io/metallb
helm repo update
helm install metallb metallb/metallb --namespace metallb-system --create-namespace
```

# Configure metallb
Create a configmap with the IP address range you want to use:
```yaml
---
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: home-pool
  namespace: metallb-system
spec:
  addresses:
    - 10.0.3.50-10.0.3.254  # Adjust to an unused range on your home LAN
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: home-advert
  namespace: metallb-system
```

Apply the configmap:
```bash
kubectl apply -f metallb-config.yaml
```
