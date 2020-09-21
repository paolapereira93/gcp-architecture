#!/bin/bash

PROJECT_NAME=$(docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud config get-value project | tail -1)
CLEANED_PROJECT_NAME=${PROJECT_NAME//[$'\t\r\n']}

# create app engine
$1 gcloud app create --project=$CLEANED_PROJECT_NAME