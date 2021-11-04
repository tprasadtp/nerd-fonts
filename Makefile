SHELL := /bin/bash

GITHUB_RUN_NUMBER ?= NA

NERDFONT_VERSION := a192bff
CASCADIA_CODE_VERSION := 2110.31
UBUNTU_FONT_VERSION:= 0.83
FIRACODE_VERSION := 5.2
FANTASQUE_VERSION := v1.8.0
VERSION := 0.6.0


ROOT_DIR := $(strip $(patsubst %/, %, $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

.PHONY: help
help: ## This help message
	@printf "%-20s %s\n" "Target" "Help"
	@printf "%-20s %s\n" "-----" "-----"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: cascadia-regular cascadia-mono cascadia-italic fantasque firacode ubuntu-regular ubuntu-mono checksums release-notes  ## Patch all fonts

.PHONY: cascadia-regular
cascadia-regular: ## Patch CascadiaCode Regular
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
	echo -e "\033[1;34m‣ CascadiaCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/build/source-fonts/CascadiaCode.ttf"; \
	echo -e "\033[1;34m‣ CascadiaCode Build - Regular - Windows - $(GITHUB_RUN_NUMBER)\033[0m"; \
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

.PHONY: cascadia-mono
cascadia-mono: ## Patch Cascadia Mono
		@echo -e "\033[1;92m➜ $@ \033[0m"
		@mkdir -p "$(ROOT_DIR)/build"
		@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ CascadiaCode Build - Mono - $(GITHUB_RUN_NUMBER)\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Cascadia" \
			"${ROOT_DIR}/build/source-fonts/CascadiaMono.ttf"; \
		echo -e "\033[1;34m‣ CascadiaCode Build - Mono - Windows - $(GITHUB_RUN_NUMBER)\033[0m"; \
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
	echo -e "\033[1;34m‣ CascadiaCode Build - Italic - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/build/source-fonts/CascadiaCodeItalic.ttf"; \
	echo -e "\033[1;34m‣ CascadiaCode Build - Italic - Windows - $(GITHUB_RUN_NUMBER)\033[0m"; \
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
		echo -e "\033[1;34m‣ FantasqueSansMono [Windows]\033[0m"; \
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

.PHONY: firacode
firacode: ## Patch FiraCode
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ FiraCode Regular \033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/FiraCode" \
 		"${ROOT_DIR}/vendor/fonts/FiraCode/ttf/FiraCode-Regular.ttf"; \
		echo -e "\033[1;34m‣ FiraCode Regular [Windows]\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--windows \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/FiraCode" \
 		"${ROOT_DIR}/vendor/fonts/FiraCode/ttf/FiraCode-Regular.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi

.PHONY: ubuntu-regular
ubuntu-regular: ## Patch Ubuntu
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ Ubuntu \033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Ubuntu" \
 		"${ROOT_DIR}/vendor/fonts/Ubuntu/ubuntu-font-family-$(UBUNTU_FONT_VERSION)/Ubuntu-R.ttf"; \
		echo -e "\033[1;34m‣ Ubuntu [Windows]\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--windows \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Fantasque" \
 		"${ROOT_DIR}/vendor/fonts/Ubuntu/ubuntu-font-family-$(UBUNTU_FONT_VERSION)/Ubuntu-R.ttf"; \
		else \
			echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
			exit 1; \
		fi

.PHONY: ubuntu-mono
ubuntu-mono: ## Patch Ubuntu Mono
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
		echo -e "\033[1;34m‣ Ubuntu Mono Regular\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Ubuntu" \
 		"${ROOT_DIR}/vendor/fonts/Ubuntu/ubuntu-font-family-$(UBUNTU_FONT_VERSION)/UbuntuMono-R.ttf"; \
		echo -e "\033[1;34m‣ Ubuntu Mono Regular [Windows]\033[0m"; \
		fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
			--complete \
			--windows \
			--no-progressbars \
			--outputdir "${ROOT_DIR}/build/Ubuntu" \
 		"${ROOT_DIR}/vendor/fonts/Ubuntu/ubuntu-font-family-$(UBUNTU_FONT_VERSION)/UbuntuMono-R.ttf"; \
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

	@echo -e "\033[1;34m‣ Download Upstream [FiraCode]\033[0m"
	@mkdir -p vendor/fonts/FiraCode
	@curl -sSfL https://github.com/tonsky/FiraCode/releases/download/$(FIRACODE_VERSION)/Fira_Code_v$(FIRACODE_VERSION).zip \
		--output $(ROOT_DIR)/vendor/fonts/FiraCode.zip
	@echo -e "\033[1;34m‣ Uncompress FiraCode\033[0m"
	@unzip -o -d $(ROOT_DIR)/vendor/fonts/FiraCode $(ROOT_DIR)/vendor/fonts/FiraCode.zip

	@echo -e "\033[1;34m‣ Download Upstream [Ubuntu]\033[0m"
	@mkdir -p vendor/fonts/Ubuntu
	@curl -sSfL https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip \
		--output $(ROOT_DIR)/vendor/fonts/Ubuntu.zip
	@echo -e "\033[1;34m‣ Uncompress Ubuntu\033[0m"
	@unzip -o -d $(ROOT_DIR)/vendor/fonts/Ubuntu $(ROOT_DIR)/vendor/fonts/Ubuntu.zip

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
	cd $(ROOT_DIR)/build/Cascadia && sha256sum  *.ttf >  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/Fantasque && sha256sum *.ttf >>  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/FiraCode && sha256sum *.ttf >>  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/Ubuntu && sha256sum *.ttf >>  ../SHA256SUMS.txt


.PHONY: release-notes
release-notes: ## Generate release notes
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p $(ROOT_DIR)/build
	@echo "# Release Notes" > $(ROOT_DIR)/build/release-notes.md
	@echo "| Name | Upstream | Version |" >> $(ROOT_DIR)/build/release-notes.md
	@echo "|---|---|---|" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Caskaydia Cove | [Cascadia Code](https://github.com/microsoft/cascadia-code) | ![cascadia](https://img.shields.io/badge/version-v$(CASCADIA_CODE_VERSION)-blue?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Fantasque Sans Mono | [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans) | ![fantasque](https://img.shields.io/badge/version-$(FANTASQUE_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| FiraCode | [FiraCode](https://github.com/tonsky/FiraCode) | ![fira](https://img.shields.io/badge/version-$(FIRACODE_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Ubuntu | [Ubuntu](https://design.ubuntu.com/font/) | ![ubuntu](https://img.shields.io/badge/version-$(UBUNTU_FONT_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md

	@echo "" >> $(ROOT_DIR)/build/release-notes.md
	@echo "> - Generated by GitHub Build GH-$(GITHUB_RUN_NUMBER), using nerd fonts." >> $(ROOT_DIR)/build/release-notes.md
