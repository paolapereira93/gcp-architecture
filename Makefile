IMAGE_NAME=nw/challenge
BASE_GCLOUD_RUN=docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk
pwd=$(shell pwd)
BASE_GCLOUD_RUN_WITH_VOL=docker run --rm -ti --volumes-from gcloud-config -v $(pwd)/services:/tmp google/cloud-sdk

install-gcs-sdk:
	docker pull google/cloud-sdk:304.0.0

gcloud-init: install-gcs-sdk
	docker run -ti --name gcloud-config google/cloud-sdk gcloud init

start-project: gcloud-init
	./hack/format-templates.sh

enable-apis:
	$(BASE_GCLOUD_RUN) gcloud services enable cloudresourcemanager.googleapis.com
	$(BASE_GCLOUD_RUN) gcloud services enable iam.googleapis.com
	$(BASE_GCLOUD_RUN) gcloud services enable compute.googleapis.com
	$(BASE_GCLOUD_RUN) gcloud services enable appengine.googleapis.com
	$(BASE_GCLOUD_RUN) gcloud services enable container.googleapis.com
	$(BASE_GCLOUD_RUN) gcloud services enable cloudscheduler.googleapis.com

create-app-engine:
	./hack/create-app-engine.sh "$(BASE_GCLOUD_RUN)"

create-terraform-account:
	./hack/create-terraform-sa.sh "$(BASE_GCLOUD_RUN)"

login-bastion:
	$(BASE_GCLOUD_RUN) gcloud compute ssh bastion --zone $(zone)

configure-kubectl:
	./hack/configure-kubectl.sh "${BASE_GCLOUD_RUN}"

kubectl-apply:
	./hack/kubectl-apply.sh "${BASE_GCLOUD_RUN_WITH_VOL}"

kubectl-get-services:
	$(BASE_GCLOUD_RUN) kubectl get services

