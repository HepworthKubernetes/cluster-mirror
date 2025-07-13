# Cloudflare Tunnel Setup

## Store Token from Cloudflare in kubernetes secret

```bash
kubectl create secret generic cloudflared-secret \
  --from-literal=TUNNEL_TOKEN="" \
  -n cloudflare-tunnel
```
