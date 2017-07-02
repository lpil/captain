help:
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


setup: ## Install dev tools
	stack install ghcid
.PHONY: setup


server: ## Run the development server
	ghcid --test "Captain.main"
.PHONY: server


test: ## Run the test watcher
	stack test --file-watch
.PHONY: test


test-once: ## Run the tests once
	stack test --file-watch
.PHONY: test-once
