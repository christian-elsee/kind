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
	cp assets/kind-$(shell uname)-$(shell uname -m) $@/bin/kind

publish: target ?= christian@lnk-lab1-134
publish:
	rsync -av --delete dist/ $(target):/tmp/kind
