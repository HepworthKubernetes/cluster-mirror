#!/usr/bin/env bash

# Set your namespace (adjust if different)
NAMESPACE="argocd"

# Create namespace if it doesn't exist
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Clear all existing secrets in the namespace
kubectl delete secret argocd-server-secret \
  argocd-redis-secret \
  --namespace=$NAMESPACE 2>/dev/null || true

# Generate random secrets (or replace with your own values)
SERVER_SECRET=$(openssl rand -base64 32)
REDIS_PASSWORD=$(openssl rand -base64 32)

echo "Creating ArgoCD secrets..."

# Server Secret Key
kubectl create secret generic argocd-server-secret \
  --from-literal=server.secretkey="$SERVER_SECRET" \
  --namespace=$NAMESPACE

# Redis Password Secret
kubectl create secret generic argocd-redis-secret \
  --from-literal=password="$REDIS_PASSWORD" \
  --namespace=$NAMESPACE

echo "ArgoCD secrets created successfully!"
echo ""
echo "Secret Summary:"
echo "- argocd-server-secret: Server secret key for JWT tokens"
echo "- argocd-redis-secret: Redis password"
echo ""
echo "Note: ArgoCD will auto-generate the admin password during installation."
echo ""
echo "To view secrets:"
echo "kubectl get secrets -n $NAMESPACE"
echo ""
echo "To get the admin password after installation:"
echo "kubectl get secret argocd-initial-admin-secret -n $NAMESPACE -o jsonpath='{.data.password}' | base64 -d"
