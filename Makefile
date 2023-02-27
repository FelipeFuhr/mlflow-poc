.DEFAULT_GOAL = help
.PHONY = help
help:
	@echo "Commands:"
	@echo "- build						: builds container images ."
	@echo "- kube						: runs kubernetes resources ."	
	@echo "- clean						: cleans side effects from commands ."

.PHONY = build
build:
	docker build -f ./container/mlflow-base/mlflow-base.Dockerfile -t mlflow-base ./container/mlflow-base
	docker build -f ./container/mlflow-user/mlflow-user.Dockerfile -t mlflow-user ./container/mlflow-user
	docker build -f ./container/mlflow-server/mlflow-server.Dockerfile -t mlflow-server ./container/mlflow-server
	docker build -f ./container/metadata-storage/metadata-storage.Dockerfile -t metadata-storage ./container/metadata-storage
	docker build -f ./container/metadata-storage/metadata-storage-console.Dockerfile -t metadata-storage-console ./container/metadata-storage
	docker build -f ./container/artifacts-storage/artifacts-storage.Dockerfile -t artifacts-storage ./container/artifacts-storage
	docker build -f ./container/artifacts-storage/make-bucket.Dockerfile -t make-bucket ./container/artifacts-storage
	docker build -f ./container/mlflow-application/mlflow-application.Dockerfile -t mlflow-application .

.PHONY = apply
apply:
	kubectl apply -f ./kube/namespace/mlflow-namespace.yaml
	kubectl apply -f ./kube/serviceaccount/mlflow-serviceaccount.yaml
	kubectl apply -f ./kube/secret/metadata-storage-secret.yaml
	kubectl apply -f ./kube/deployment/metadata-storage-deployment.yaml
	kubectl apply -f ./kube/service/metadata-storage-service.yaml
	kubectl apply -f ./kube/secret/metadata-storage-console-secret.yaml
	kubectl apply -f ./kube/deployment/metadata-storage-console-deployment.yaml
	kubectl apply -f ./kube/service/metadata-storage-console-service.yaml
	kubectl apply -f ./kube/secret/artifacts-storage-secret.yaml
	kubectl apply -f ./kube/deployment/artifacts-storage-deployment.yaml
	kubectl apply -f ./kube/service/artifacts-storage-service.yaml
	kubectl apply -f ./kube/service/artifacts-storage-console-service.yaml
	kubectl apply -f ./kube/secret/access-cloud-secret.yaml
	kubectl apply -f ./kube/configmap/mlflow-artifacts-server-configmap.yaml
	kubectl apply -f ./kube/secret/mlflow-artifacts-server-secret.yaml
	kubectl apply -f ./kube/deployment/mlflow-artifacts-server-deployment.yaml
	kubectl apply -f ./kube/service/mlflow-artifacts-server-service.yaml
	kubectl apply -f ./kube/secret/mlflow-tracking-server-secret.yaml
	kubectl apply -f ./kube/configmap/mlflow-tracking-server-configmap.yaml
	kubectl apply -f ./kube/deployment/mlflow-tracking-server-deployment.yaml
	kubectl apply -f ./kube/service/mlflow-tracking-server-service.yaml
	kubectl apply -f ./kube/job/make-bucket.yaml

.PHONY = run
run:
	kubectl apply -f ./kube/deployment/mlflow-application.yaml

.PHONY = clean-kube
clean-kube:
	kubectl delete all --all -n mlflow --force --grace-period 0

.PHONY = clean
clean: clean-kube
	docker image prune -a -f
