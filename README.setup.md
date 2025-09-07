# Setup information

## Auth

Auth was added to the k3s as a flag in `/etc/systemd/system/k3s.service`
```bash
ExecStart=/usr/local/bin/k3s \
    server \
	'--disable=traefik' \
	'--disable=servicelb' \
	'--disable=metrics-server' \
	'--disable=local-storage' \
	'--node-taint=CriticalAddonsOnly=true:NoExecute' \
	'--kube-apiserver-arg=oidc-issuer-url=https://auth.batk.me/realms/master' \     #new
	'--kube-apiserver-arg=oidc-client-id=kubernetes' \                              #new
	'--kube-apiserver-arg=oidc-groups-claim=groups' \                               #new
```

