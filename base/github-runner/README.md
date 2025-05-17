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


