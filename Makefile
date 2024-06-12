include .bingo/Variables.mk

BIN_DIR ?= $(shell pwd)/tmp/bin
OS ?= $(shell uname -s | tr '[A-Z]' '[a-z]')
ARCH ?= $(shell uname -m)
SHELLCHECK ?= $(BIN_DIR)/shellcheck

define require_clean_work_tree
	@git update-index -q --ignore-submodules --refresh

	@if ! git diff-files --quiet --ignore-submodules --; then \
		echo >&2 "cannot $1: you have unstaged changes."; \
		git diff -r --ignore-submodules -- >&2; \
		echo >&2 "Please commit or stash them."; \
		exit 1; \
	fi

	@if ! git diff-index --cached --quiet HEAD --ignore-submodules --; then \
		echo >&2 "cannot $1: your index contains uncommitted changes."; \
		git diff --cached -r --ignore-submodules HEAD -- >&2; \
		echo >&2 "Please commit or stash them."; \
		exit 1; \
	fi

endef

.PHONY: shell-lint
shell-lint: ## Runs static analysis against our shell scripts.
shell-lint: $(SHELLCHECK)
	@echo ">> linting all of the shell script files"
	@$(SHELLCHECK) --severity=error -o all -s bash $(shell find . -type f -name "*.sh" -not -path "*vendor*" -not -path "tmp/*" -not -path "*node_modules*")

.PHONY: shell-format
shell-format: ## Formats all shell scripts.
shell-format: $(SHFMT)
	@echo ">> formatting shell scripts"
	@$(SHFMT) -i 2 -ci -w -s $(shell find . -type f -name "*.sh" -not -path "*vendor*" -not -path "tmp/*")

.PHONY: fmtlint
fmtlint: shell-format shell-lint
	$(call require_clean_work_tree,'detected changes, run make lint and commit changes')

.PHONY: objstore
objstore: ## Deploys an instance of Minio Objstore for testing
	@./scripts/objstore.sh --deploy

.PHONY: block-data
block-data: ## Deploys a thanosbench blockgen job to generate blocks in Minio objstore with profile in .env.
	@./scripts/data.sh --deploy

.PHONY: teardown
teardown: ## Tears down all infra in a particular namespace. 
	@./scripts/teardown.sh

.PHONY: storegw-stress
storegw-stress:
	@./scripts/bench.sh --storegw-stress-deploy

.PHONY: query-store
query-store:
	@./scripts/bench.sh --query-store-deploy

.PHONY: receive-ingest
receive-ingest:
	@./scripts/bench.sh --receive-ingest-deploy

.PHONY: query-receive
query-receive:
	@./scripts/bench.sh --query-receive-deploy

.PHONY: receive-stress
receive-stress:
	@./scripts/bench.sh --receive-stress-deploy
   
# non-phony targets
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(SHELLCHECK): $(BIN_DIR)
	@echo "Downloading Shellcheck"
	curl -sNL "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.$(OS).$(ARCH).tar.xz" | tar --strip-components=1 -xJf - -C $(BIN_DIR)