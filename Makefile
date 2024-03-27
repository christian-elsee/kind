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
dist: os ?= Linux
dist: arch ?= x86_64
dist:
	: ## $@
	mkdir -p $@ $@/bin
	cp src/install.sh $@
	cp $(target) $@/config.yaml
	cp assets/kind-$(os)-$(arch) $@/bin/kind

publish: target ?= christian@lnk-lab1-134
publish:
	rsync -av --delete dist/ $(target):/tmp/kind
