SHELL := /bin/bash

GITHUB_RUN_NUMBER ?= NA

NERDFONT_VERSION := a192bff
CASCADIA_CODE_VERSION := 2105.24
FANTASQUE_VERSION := v1.8.0
VERSION := 0.6.0


ROOT_DIR := $(strip $(patsubst %/, %, $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

.PHONY: help
help: ## This help message
	@printf "%-20s %s\n" "Target" "Help"
	@printf "%-20s %s\n" "-----" "-----"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: cascadia cascadia-mono cascadia-italic cascadia-win cascadia-italic-win cascadia-mono-win fantasque fantasque-win release-notes  ## Patch all fonts

.PHONY: cascadia
cascadia: ## Patch CascadiaCode Regular
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
	echo -e "\033[1;34m‣ CascadiaCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/build/source-fonts/CascadiaCode.ttf"; \
	else \
		echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
		exit 1; \
	fi

.PHONY: cascadia-mono
cascadia-mono: ## Patch CascadiaCode mono font
		@echo -e "\033[1;92m➜ $@ \033[0m"
		@mkdir -p "$(ROOT_DIR)/build"
		@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ CascadiaCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Cascadia" \
			"${ROOT_DIR}/build/source-fonts/CascadiaMono.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi

.PHONY: fantasque
fantasque: ## Patch FantasqueSansMono
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ FantasqueSansMono \033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Fantasque" \
 		"${ROOT_DIR}/vendor/fonts/Fantasque/TTF/FantasqueSansMono-Regular.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi

# windows

.PHONY: cascadia-win
cascadia-win: ## Patch CascadiaCode Regular (windows)
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
	echo -e "\033[1;34m‣ CascadiaCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/build/source-fonts/CascadiaCode.ttf"; \
	else \
		echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
		exit 1; \
	fi

.PHONY: cascadia-mono-win
cascadia-mono-win: ## Patch CascadiaCode mono font (windows)
		@echo -e "\033[1;92m➜ $@ \033[0m"
		@mkdir -p "$(ROOT_DIR)/build"
		@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ CascadiaCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--windows \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Cascadia" \
			"${ROOT_DIR}/build/source-fonts/CascadiaMono.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi

.PHONY: cascadia-italic
cascadia-italic: ## Patch CascadiaCode Italic
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
	echo -e "\033[1;34m‣ CascadiaCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/build/source-fonts/CascadiaCodeItalic.ttf"; \
	else \
		echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
		exit 1; \
	fi

.PHONY: cascadia-italic-win
cascadia-italic-win: ## Patch CascadiaCode Italic (windows)
		@echo -e "\033[1;92m➜ $@ \033[0m"
		@mkdir -p "$(ROOT_DIR)/build"
		@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ CascadiaCode Build - Italic - $(GITHUB_RUN_NUMBER)\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--windows \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Cascadia" \
			"${ROOT_DIR}/build/source-fonts/CascadiaCodeItalic.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi


.PHONY: fantasque-win
fantasque-win: ## Patch FantasqueSansMono (windows)
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ FantasqueSansMono \033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--windows \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Fantasque" \
 		"${ROOT_DIR}/vendor/fonts/Fantasque/TTF/FantasqueSansMono-Regular.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi


.PHONY: prepare
prepare: ## Download external assets required
	@echo -e "\033[1;92m➜ $@ \033[0m"

	@echo -e "\033[1;34m‣ Download Upstream [Cascadia Code]\033[0m"
	@mkdir -p vendor/fonts/Cascadia
	@curl -sSfL https://github.com/microsoft/cascadia-code/releases/download/v$(CASCADIA_CODE_VERSION)/CascadiaCode-$(CASCADIA_CODE_VERSION).zip --output $(ROOT_DIR)/vendor/fonts/CascadiaCode.zip
	@echo -e "\033[1;34m‣ Uncompress Cascadia Code\033[0m"
	@unzip -o -d $(ROOT_DIR)/vendor/fonts/Cascadia $(ROOT_DIR)/vendor/fonts/CascadiaCode.zip

	@echo -e "\033[1;34m‣ Open and close font files because FF is buggy\033[0m"
	@mkdir -p $(ROOT_DIR)/build/source-fonts
	@fontforge -quiet --script $(ROOT_DIR)/scripts/prepare-font --input $(ROOT_DIR)/vendor/fonts/Cascadia/ttf/CascadiaCode.ttf   --output $(ROOT_DIR)/build/source-fonts/CascadiaCode.ttf
	@fontforge -quiet --script $(ROOT_DIR)/scripts/prepare-font --input $(ROOT_DIR)/vendor/fonts/Cascadia/ttf/CascadiaMono.ttf --output $(ROOT_DIR)/build/source-fonts/CascadiaMono.ttf
	@fontforge -quiet --script $(ROOT_DIR)/scripts/prepare-font --input $(ROOT_DIR)/vendor/fonts/Cascadia/ttf/CascadiaCodeItalic.ttf --output $(ROOT_DIR)/build/source-fonts/CascadiaCodeItalic.ttf


	@echo -e "\033[1;34m‣ Download Upstream [FantasqueSansMono]\033[0m"
	@mkdir -p vendor/fonts/Fantasque
	@curl -sSfL https://github.com/belluzj/fantasque-sans/releases/download/$(FANTASQUE_VERSION)/FantasqueSansMono-NoLoopK.tar.gz --output $(ROOT_DIR)/vendor/fonts/FantasqueSansMono.tar.gz

	@echo -e "\033[1;34m‣ Uncompress\033[0m"
	@tar -xvf $(ROOT_DIR)/vendor/fonts/FantasqueSansMono.tar.gz -C $(ROOT_DIR)/vendor/fonts/Fantasque/

	@mkdir -p build
	@touch "$(ROOT_DIR)/build/.prepared"



.PHONY: clean
clean: ## Clean build artifacts
	@echo -e "\033[1;92m➜ $@ \033[0m"
	rm -rf $(ROOT_DIR)/vendor
	rm -rf $(ROOT_DIR)/build

.PHONY: checksums
checksums: ## Generate SHA256 checksums for artifacts
	@echo -e "\033[1;92m➜ $@ \033[0m"
	cd $(ROOT_DIR)/build/Cascadia && sha256sum  ./*.ttf >  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/Fantasque && sha256sum ./*.ttf >>  ../SHA256SUMS.txt


.PHONY: release-notes
release-notes: ## Prepare release notes
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p $(ROOT_DIR)/build
	@echo "# Release Notes" > $(ROOT_DIR)/build/release-notes.md
	@echo "| Name | Upstream Name | Version |" >> $(ROOT_DIR)/build/release-notes.md
	@echo "|---|---|---|" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Caskaydia Cove | [Cascadia Code](https://github.com/microsoft/cascadia-code) | ![cascadia](https://img.shields.io/badge/version-$(CASCADIA_CODE_VERSION)-blue?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Fantasque Sans Mono | [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans) | ![fantasque](https://img.shields.io/badge/version-$(FANTASQUE_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "" >> $(ROOT_DIR)/build/release-notes.md
	@echo "> - Icons sourced from https://simpleicons.com." >> $(ROOT_DIR)/build/release-notes.md
	@echo "> - Generated by GitHub Build GH-$(GITHUB_RUN_NUMBER), using nerd fonts." >> $(ROOT_DIR)/build/release-notes.md
