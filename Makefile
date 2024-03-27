## env
export PATH := ./bin:$(PATH)

target ?= lnk-lab1-134
topology ?= manifest/single.yaml

## settings
.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: distclean dist build

distclean:
	: ## $@
	rm -rf dist
clean:
	: ## $@
	cd dist
	kind delete cluster --name kind

dist: os ?= Linux
dist: arch ?= x86_64
dist:
	: ## $@
	mkdir -p $@ $@/bin
	cp -rf manifest src/install.sh $@
	cp assets/kind-$(os)-$(arch) $@/bin/kind

build: export IP := $(shell echo $(target) | xargs dig +short)
build:
	chmod +x dist/bin/kind
	<dist/$(topology) envsubst | tee dist/config.yaml


publish:
	rsync -av --delete dist/ $(HOST):/tmp/kind
