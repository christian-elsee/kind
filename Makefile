export NAME := $(shell basename "$$PWD" )
export ORG := christianelsee
export SHA := $(shell git rev-parse --short HEAD)
export TS  := $(shell date +%s)
export PATH := ./bin:$(PATH)

.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: distclean dist build check

distclean: ;: ## distclean
	rm -rf dist
clean:
	cd dist
	kind delete cluster --name kind

dist: ;: ## dist
	mkdir $@
	rsync -av config.yaml bin $@
	cp assets/kind-darwin-amd64 $@/bin/kind

install:
	cd dist
	kind create cluster --config config.yaml
	kind get kubeconfig --name kind \
		| tee kubeconfig

check:
	cd dist
	kubectl get nodes

install:
	mkdir -p ~/.kube
	cp dist/kubeconfig ~/.kube/config
