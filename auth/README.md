### Group Layout:

/kubernetes
    /cluster-admin
    /admin
    /developer


### Logging in:

```bash
kubectl oidc-login setup --oidc-issuer-url=https://auth.batk.me/realms/master --oidc-client-id=kubernetes --listen-address=localhost:18000 --oidc-client-secret=lsYqNBPUvSeR4xJYgAlY41kSgJlM1bvF
```

After OIDC login, run:
```bash
kubectl config set-cluster kubernetes --server=https://10.0.3.10:6443
```

