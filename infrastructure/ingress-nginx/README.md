# Ingress-nginx

## Installation

```bash
# install with helm
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --values ingress-nginx-values.yaml
```

## Local DNS Resolution

When at home, to get to any subdomain of batk.me without going external, in Firefox:

1. navigate to `about:security#privacy`
2. scroll to the DNS over HTTPS section
3. click `Manage Exceptions`
4. add `batk.me` and Save

Now for any DNS requests to `batk.me` they will first hit UniFi DNS, then Cloudflare second

## Adding Local DNS Entry

To add a local DNS entry, at [https://unifi.ui.com](https://unifi.ui.com) navigate to Settings -> Policy Engine -> DNS
Add an A record, i.e. `code.batk.me` pointing to `10.0.3.52` (the nginx ingress IP)
