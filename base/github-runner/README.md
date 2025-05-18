# Creating and deploying the github runners

## Access Token

The deployment for the runner requires `ACCESS_TOKEN` to be set as a secret in namespace `github-runners`.

Create a personal access token with these scopes:
- `repo (all)`
- `workflow`
- `admin:repo_hook - read:repo_hook`
- `admin:public_key - read:public_key`
- `admin:org_hook`
- `notifications`

Copy to the clipboard(wayland) and add the secret to the namespace `github-runners`:
```bash
kubectl create secret generic github-runner \                                                  
    --from-literal=ACCESS_TOKEN=$(wl-paste) \
    -n github-runners
```

For the image, the dockerfile must also have an access token
- `repo (all)`
- `read:packages`
- `write:packages`
```bash
kubectl create secret docker-registry ghcr-creds \
--docker-server=ghcr.io \
--docker-username=travishepworth \
--docker-password=$(wl-paste) \
-n github-runners
```

## Deploying the runners
On a new cluster, or if the runners get deleted, they require a jumpstart by hand.
Take this filesystem:
```bash
├── base
│   └── github-runner
│       ├── deployment.yaml
│       ├── kustomization.yaml
│       └── README.md
├── cluster
│   ├── namespaces
│   │   ├── github-runners
│   │   │   ├── kustomization.yaml
│   │   │   ├── namespace.yaml
│   │   │   └── rbac
│   │   │       ├── deploy-sa.yaml
│   │   │       ├── kustomization.yaml
│   │   │       ├── runner-rb.yaml
│   │   │       └── runner-sa.yaml
│   │   └── terraria
│   │       └── kustomization.yaml
│   └── rbac
│       └── github-runner
│           ├── gh-runner-deploy-rb.yaml
│           └── kustomization.yaml
├── images
│   └── github-runner
│       └── Dockerfile
└── README.md
```
First, create the namespace:
```bash
kubectl apply -k cluster/namespaces/github-runners  
    namespace/github-runners created
    serviceaccount/gh-runner-deploy-sa created
    serviceaccount/gh-runner-sa created
    rolebinding.rbac.authorization.k8s.io/runner-rb configured
```
The following are created:
- `github-runners` namespace
- `gh-runner-deploy-sa` service account for deploy runner (kubectl)
- `gh-runner-sa` service account for the runner
- `runner-rb` role binding for the runner service account

We want runner deploy to have elevated permissions, and a normal runner for non cluster tasks.

Second, deploy the runner(s):
```bash
# Note: this requires a docker registry for controlling kubectl
# TODO: Create said dockumentation and link it
kubectl apply -k base/github-runner/runner-deploy
    deployment.apps/gh-runner-deploy created
kubectl apply -k base/github-runner/runner-normal               
    deployment.apps/gh-runner created
```

Third, create a namespace
```bash
kubectl apply -k cluster/namespaces/terraria      
    namespace/terraria unchanged
    rolebinding.rbac.authorization.k8s.io/github-runner-edit configured
```

This is important because the rolebinding for the deploy service account needs permissions to manage the namespace, the normal runner does not.

This leaves you with:
```bash
kubectl auth can-i create deployment \
  --as=system:serviceaccount:github-runners:gh-runner-sa \ 
  --namespace=terraria

no

kubectl auth can-i create deployment \
  --as=system:serviceaccount:github-runners:gh-runner-deploy-sa \
  --namespace=terraria

yes
```

Configure the tags in a way so you can use both of them where they are needed.
