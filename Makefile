.DEFAULT_GOAL := help

# ── Help ──────────────────────────────────────────────────────────────────────

.PHONY: help
help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*##"}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' \
		| sort

# ── Setup ─────────────────────────────────────────────────────────────────────

.PHONY: hooks
hooks: ## Install pre-commit hooks
	@command -v uv >/dev/null 2>&1 \
		&& uv tool install pre-commit --quiet \
		|| pip install --quiet pre-commit
	pre-commit install --config .config/.pre-commit-config.yaml
	@git config --local commit.template .config/.commit-message-template
	@echo "✓ pre-commit hooks installed"

# ── CLAUDE ─────────────────────────────────────────────────────────────────────

.PHONY: claude
claude: ## Reinstall this repo as a Claude plugin (local scope) — safe to re-run
	@claude plugin uninstall claimkit >/dev/null 2>&1 || true
	@claude plugin marketplace add $(PWD) >/dev/null
	@claude plugin marketplace update claimkit-marketplace >/dev/null
	claude plugin install claimkit@claimkit-marketplace

# ── Validation ────────────────────────────────────────────────────────────────

.PHONY: check
check: ## Run pre-commit checks on all files
	pre-commit run --all-files --config .config/.pre-commit-config.yaml

.PHONY: check-json
check-json: ## Validate all JSON files (plugin manifests)
	pre-commit run check-json --all-files --config .config/.pre-commit-config.yaml

.PHONY: check-toml
check-toml: ## Validate all TOML files (pyproject)
	pre-commit run check-toml --all-files --config .config/.pre-commit-config.yaml

.PHONY: check-yaml
check-yaml: ## Validate all YAML files (pre-commit config, frontmatter)
	pre-commit run check-yaml --all-files --config .config/.pre-commit-config.yaml

# ── Cleanup ───────────────────────────────────────────────────────────────────

.PHONY: clean
clean: ## Remove pre-commit cache
	pre-commit clean --config .config/.pre-commit-config.yaml
	@echo "✓ pre-commit cache cleared"
