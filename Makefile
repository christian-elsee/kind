## env
export PATH := ./bin:$(PATH)

## settings
.DEFAULT_GOAL := @goal
.ONESHELL:
.POSIX:

## workflow
@goal: distclean dist

distclean:
	: ## $@
	rm -rf dist
clean:
	: ## $@
	cd dist
	kind delete cluster --name kind

dist: target ?= manifest/master.yaml
dist:
	: ## $@
	mkdir -p $@ $@/bin
	cp src/install.sh $@
	cp $(target) $@/config.yaml
	cp assets/kind-linux-arm64 $@/bin/kind

publish:
	rsync -av dist ubuntu@master:/tmp
