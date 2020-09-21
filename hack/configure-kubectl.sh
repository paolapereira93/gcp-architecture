#!/bin/bash

PROJECT_NAME=$(docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud config get-value project | tail -1)
CLEANED_PROJECT_NAME=${PROJECT_NAME//[$'\t\r\n']}
$1 gcloud container clusters get-credentials gke-cluster --zone us-central1-b --project $CLEANED_PROJECT_NAME
