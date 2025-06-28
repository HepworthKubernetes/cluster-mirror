# Longhorn

```bash
# Label all worker nodes
kubectl label nodes jaina node-role.longhorn.io/worker=true
kubectl label nodes sylvana node-role.longhorn.io/worker=true
kubectl label nodes thrall node-role.longhorn.io/worker=true
kubectl label nodes warden node-role.longhorn.io/worker=true
```

```bash
# Configure nodes
# install and enable open-iscsi
sudo apt-get install -y open-iscsi
# Enable the service
sudo systemctl enable --now iscsid
```


```bash
# Install Longhorn with Helm
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm upgrade --install longhorn longhorn/longhorn \
  --namespace longhorn-system \
  --create-namespace \
  --values longhorn-values.yaml

```
