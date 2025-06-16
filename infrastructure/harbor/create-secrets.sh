#!/usr/bin/env bash

# Set your namespace (adjust if different)
NAMESPACE="harbor"
# make sure database and admin passwords are set
if [ -z "$HARBOR_ADMIN_PASSWORD" ]; then
  echo "Error: HARBOR_ADMIN_PASSWORD is not set."
  exit 1
fi
if [ -z "$DATABASE_PASSWORD" ]; then
  echo "Error: DATABASE_PASSWORD is not set."
  exit 1
fi

# clear all existing secrets in the namespace
kubectl delete secret harbor-admin-secret \
  harbor-database-secret \
  harbor-redis-secret \
  harbor-core-secret \
  harbor-jobservice-secret \
  harbor-registry-secret \
  --namespace=$NAMESPACE

# Generate random secrets (or replace with your own values)
REDIS_PASSWORD=$(openssl rand -base64 32)
CORE_SECRET=$(openssl rand -base64 32)
JOBSERVICE_SECRET=$(openssl rand -base64 32)
REGISTRY_SECRET=$(openssl rand -base64 32)

echo "Creating Harbor secrets..."

# Harbor Admin Password Secret
kubectl create secret generic harbor-admin-secret \
  --from-literal=password="$HARBOR_ADMIN_PASSWORD" \
  --namespace=$NAMESPACE

# Database Password Secret
kubectl create secret generic harbor-database-secret \
  --from-literal=password="$DATABASE_PASSWORD" \
  --namespace=$NAMESPACE

# Redis Password Secret
kubectl create secret generic harbor-redis-secret \
  --from-literal=password="$REDIS_PASSWORD" \
  --namespace=$NAMESPACE

# Core Secret
kubectl create secret generic harbor-core-secret \
  --from-literal=secret="$CORE_SECRET" \
  --namespace=$NAMESPACE

# JobService Secret
kubectl create secret generic harbor-jobservice-secret \
  --from-literal=secret="$JOBSERVICE_SECRET" \
  --namespace=$NAMESPACE

# Registry Secret
kubectl create secret generic harbor-registry-secret \
  --from-literal=secret="$REGISTRY_SECRET" \
  --namespace=$NAMESPACE

echo "All Harbor secrets created successfully!"
echo ""
echo "Secret Summary:"
echo "- harbor-admin-secret: Harbor admin password"
echo "- harbor-database-secret: PostgreSQL password"
echo "- harbor-redis-secret: Redis password"
echo "- harbor-core-secret: Core service secret"
echo "- harbor-jobservice-secret: JobService secret"
echo "- harbor-registry-secret: Registry secret"
echo ""
echo "To view secrets:"
echo "kubectl get secrets -n $NAMESPACE"
