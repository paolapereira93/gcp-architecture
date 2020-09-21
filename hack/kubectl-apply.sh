#!/bin/bash

# deploy who am i app
$1 kubectl apply -f /tmp/whoami/whoami.yaml

# deploy grafana
$1 kubectl apply -f /tmp/grafana/provisioning-configs.yaml
$1 kubectl apply -f /tmp/grafana/deployment.yaml
$1 kubectl apply -f /tmp/grafana/service.yaml

$1 kubectl get services
# $CMD ls /tmp