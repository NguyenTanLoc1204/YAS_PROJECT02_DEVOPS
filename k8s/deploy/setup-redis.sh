#!/usr/bin/env bash
set -x

read -rd '' REDIS_PASSWORD \
< <(yq -r '.redis.password' ./cluster-config.yaml)

helm upgrade --install redis \
  --set auth.password="$REDIS_PASSWORD" \
  --set replica.replicaCount=0 \
  oci://registry-1.docker.io/bitnamicharts/redis \
  -n redis --create-namespace