#!/bin/bash

PROJECT_NAME=$(docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud config get-value project | tail -1)
CLEANED_PROJECT_NAME=${PROJECT_NAME//[$'\t\r\n']}

ACCOUNT=$(docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud config get-value account | tail -1)
CLEANED_ACCOUNT=${ACCOUNT//[$'\t\r\n']}

cat hack/grafana-provisioning-configs.tmpl.yml > services/grafana/provisioning-configs.yaml
sed -i "s/{{PROJECT_NAME}}/$CLEANED_PROJECT_NAME/g" services/grafana/provisioning-configs.yaml

cat hack/var.tmpl.tf > provisioning/var.tf
sed -i "s/{{PROJECT_NAME}}/$CLEANED_PROJECT_NAME/g" provisioning/var.tf
sed -i "s/{{USER_EMAIL}}/$CLEANED_ACCOUNT/g" provisioning/var.tf
