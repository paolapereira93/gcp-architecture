#!/bin/bash

PROJECT_NAME=$(docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud config get-value project | tail -1)
CLEANED_PROJECT_NAME=${PROJECT_NAME//[$'\t\r\n']}

# creating service account

$1 gcloud iam service-accounts create terraform \
	--display-name "Terraform admin account"

# creating key
CREDENTIALS_CONTENT=$($1 echo ""> /tmp/credentials.json;gcloud iam service-accounts keys create /tmp/credentials.json \
	--iam-account terraform@${CLEANED_PROJECT_NAME}.iam.gserviceaccount.com; cat /tmp/credentials.json)

echo $CREDENTIALS_CONTENT > $GOOGLE_APPLICATION_CREDENTIALS

# grant project level permissions

$1 gcloud projects add-iam-policy-binding ${CLEANED_PROJECT_NAME} \
  --member serviceAccount:terraform@${CLEANED_PROJECT_NAME}.iam.gserviceaccount.com \
  --role roles/owner

$1 gcloud projects add-iam-policy-binding ${CLEANED_PROJECT_NAME} \
  --member serviceAccount:terraform@${CLEANED_PROJECT_NAME}.iam.gserviceaccount.com \
  --role roles/iam.securityAdmin


# create app engine
$1 gcloud app create --project=$CLEANED_PROJECT_NAME