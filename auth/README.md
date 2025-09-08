### Group Layout:

/kubernetes
    /cluster-admin
    /admin
    /developer

### Logging in:

To login, first install [krew](https://krew.sigs.k8s.io/docs/user-guide/setup/install) with you desired method

Then, install the oidc-login plugin:
```bash
kubectl krew install oidc-login
```

Copy the kubeconfig to your machine and login
```bash
cp <path-to-repo>/auth/config ~/.kube/config
kubectl config use-context oidc
kubectl get-pods # logs you in
```

### Manual Setup
```bash
kubectl oidc-login setup --oidc-issuer-url=https://auth.batk.me/realms/master --oidc-client-id=kubernetes --listen-address=localhost:18000 --oidc-client-secret=lsYqNBPUvSeR4xJYgAlY41kSgJlM1bvF
```

After OIDC login, run:
```bash
kubectl config set-cluster kubernetes --server=https://10.0.3.10:6443 --certificate-authority=./ca.crt
```

