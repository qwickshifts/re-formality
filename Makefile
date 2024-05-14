project_name = re-formality

DUNE = opam exec -- dune

.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: nuke
nuke: ## Delete all artifacts including the local switch
	rm -rf node_modules
	rm -rf _opam
	rm -rf _build
	rm -f $(project_name).opam
	
.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . -y --deps-only --no-install --packages=dune,ocamlformat,ocaml-lsp-server,ocaml-base-compiler

.PHONY: init
init: create-switch install ## Configure everything to develop this repository in local

.PHONY: install
install: ## Install development dependencies
	$(DUNE) build $(project_name).opam
	yarn install ## install JavaScript packages that the project might depend on, like `react` or `react-dom`
	opam update ## make sure that opam has the latest information about published libraries in the opam repository https://opam.ocaml.org/packages/
	opam install -y . --deps-only --with-test ## install the Melange and OCaml dependencies
	opam exec opam-check-npm-deps ## check that the versions of the JavaScript packages installed match the requirements defined by Melange libraries

.PHONY: build
build: ## Build the project
	$(DUNE) build

.PHONY: watch
watch: ## Watch for the filesystem and rebuild on every change
	$(DUNE) build --watch

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	$(DUNE) clean

.PHONY: test
test:
	yarn test

.PHONY: test-coverage
test-coverage:
	yarn test --coverage

.PHONY: format
format: ## Format the codebase with ocamlformat
	$(DUNE) build @fmt --auto-promote

.PHONY: format-check
format-check: ## Checks if format is correct
	$(DUNE) build @fmt
