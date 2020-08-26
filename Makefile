SHELL := /bin/bash

GITHUB_RUN_NUMBER ?= 00

NERDFONT_VERSION := a192bff0b09f4b1616c472a18d6b3946e7148405
CASCADIA_CODE_VERSION := 2007.01
STARSHIP_VERSION := 2007.01

ROOT_DIR := $(strip $(patsubst %/, %, $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

.PHONY: help
help: ## This help dialog.
	@IFS=$$'\n' ; \
    help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
    printf "%-30s %s\n" "--------" "------------" ; \
	printf "%-30s %s\n" " Target " "    Help " ; \
    printf "%-30s %s\n" "--------" "------------" ; \
    for help_line in $${help_lines[@]}; do \
        IFS=$$':' ; \
        help_split=($$help_line) ; \
        help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
        help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
        printf '\033[92m'; \
        printf "%-30s %s" $$help_command ; \
        printf '\033[0m'; \
        printf "%s\n" $$help_info; \
    done

.PHONY: cascadia
cascadia: ## Make Starship Cascade from Cascadia Code
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
	echo -e "\033[1;34m‣ StarshipCode Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge --script "$(ROOT_DIR)/vendor/font-patcher" -l --quiet --complete --no-progressbars "$(ROOT_DIR)/build/source-fonts/CascadiaCode.ttf"; \
	echo " # Renaming Font..."; \
	fontforge -quiet --script "$(ROOT_DIR)/scripts/rename-font" --input "$(ROOT_DIR)/Cascadia Code Regular Nerd Font Complete.ttf" \
                                 --output "$(ROOT_DIR)/build/StarshipCode.ttf" \
                                 --name "StarshipCode" \
								 --type "Regular" \
                                 --version "$(STARSHIP_VERSION)-GH$(GITHUB_RUN_NUMBER)"; \
	echo -e "\033[1;34m‣ StarshipMono Build - Mono - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge --script "$(ROOT_DIR)/vendor/font-patcher" -l --quiet --complete --no-progressbars "$(ROOT_DIR)/build/source-fonts/CascadiaMono.ttf"; \
	echo " # Renaming Font..."; \
	fontforge -quiet --script "$(ROOT_DIR)/scripts/rename-font" --input "$(ROOT_DIR)/Cascadia Mono Regular Nerd Font Complete.ttf" \
                                 --output "$(ROOT_DIR)/build/StarshipMono.ttf" \
                                 --name "StarshipMono" \
								 --type "Mono" \
                                 --version "$(STARSHIP_VERSION)-GH$(GITHUB_RUN_NUMBER)"; \
	else \
		echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
		exit 1; \
	fi


.PHONY: cascadia-win
cascadia-win: ## Make Starship Cascade from Cascadia Code for Windows
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p "$(ROOT_DIR)/build"
	@if [ -f $(ROOT_DIR)/build/.prepared ]; then \
	echo -e "\033[1;34m‣ StarshipCode Windows Build - Regular - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/vendor/font-patcher" -l --windows --quiet --complete --no-progressbars "$(ROOT_DIR)/build/source-fonts/CascadiaCode.ttf"; \
	echo " # Renaming Font..."; \
	fontforge --script "$(ROOT_DIR)/scripts/rename-font" --input "$(ROOT_DIR)/Cascadia Code Regular Nerd Font Complete Windows Compatible.ttf" \
                                 --output "$(ROOT_DIR)/build/StarshipCode-Windows.ttf" \
                                 --name "StarshipCode" \
								 --type "Regular" \
                                 --version "$(STARSHIP_VERSION)-GH$(GITHUB_RUN_NUMBER)"; \
	echo -e "\033[1;34m‣ StarshipCode Windows Build - Mono - $(GITHUB_RUN_NUMBER)\033[0m"; \
	fontforge -quiet --script "$(ROOT_DIR)/vendor/font-patcher" -l --quiet --windows --complete --no-progressbars "$(ROOT_DIR)/build/source-fonts/CascadiaMono.ttf"; \
	echo " # Renaming Font..."; \
	fontforge -quiet --script "$(ROOT_DIR)/scripts/rename-font" --input "$(ROOT_DIR)/Cascadia Mono Regular Nerd Font Complete Windows Compatible.ttf" \
                                 --output "$(ROOT_DIR)/build/StarshipMono-Windows.ttf" \
                                 --name "StarshipCode" \
								 --type "Mono" \
                                 --version "$(STARSHIP_VERSION)-GH$(GITHUB_RUN_NUMBER)"; \
	else \
		echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
		exit 1; \
	fi




.PHONY: prepare
prepare: ## Download external assets required
	@echo -e "\033[1;92m➜ $@ \033[0m"

	@echo -e "\033[1;34m‣ Download Upstream [Cascadia Code]\033[0m"
	@mkdir -p vendor/fonts/Cascadia
	#curl -sfL https://github.com/microsoft/cascadia-code/releases/download/v$(CASCADIA_CODE_VERSION)/CascadiaCode-$(CASCADIA_CODE_VERSION).zip --output $(ROOT_DIR)/vendor/fonts/Cascadia/CascadiaCode.zip
	@echo -e "\033[1;34m‣ Uncompress Cascadia Code\033[0m"
	unzip -d $(ROOT_DIR)/vendor/fonts/Cascadia $(ROOT_DIR)/vendor/fonts/Cascadia/CascadiaCode.zip

	# @echo -e "\033[1;34m‣ Open and close font files because FF is buggy\033[0m"
	# @mkdir -p $(ROOT_DIR)/build/source-fonts
	# @fontforge --script $(ROOT_DIR)/scripts/prepare-font --input $(ROOT_DIR)/vendor/fonts/Cascadia/ttf/CascadiaCode.ttf   --output $(ROOT_DIR)/build/source-fonts/CascadiaCode.ttf
	# @fontforge --script $(ROOT_DIR)/scripts/prepare-font --input $(ROOT_DIR)/vendor/fonts/Cascadia/ttf/CascadiaMono.ttf --output $(ROOT_DIR)/build/source-fonts/CascadiaMono.ttf

	@echo -e "\033[1;34m‣ Download Font Patcher\033[0m"
	curl -sfL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/$(NERDFONT_VERSION)/font-patcher --output "$(ROOT_DIR)/vendor/font-patcher"

	@echo -e "\033[1;34m‣ Download source glyphs...\033[0m"
	@mkdir -p "$(ROOT_DIR)/vendor/src/glyphs"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/devicons.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/devicons.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/font-awesome-extension.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/font-awesome-extension.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/font-logos.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/font-logos.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/FontAwesome.otf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/FontAwesome.otf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/materialdesignicons-webfont.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/materialdesignicons-webfont.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/octicons.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/original-source.otf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/original-source.otf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Pomicons.otf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/Pomicons.otf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/PowerlineExtraSymbols.otf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/PowerlineExtraSymbols.otf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/PowerlineSymbols.otf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/PowerlineSymbols.otf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-1000-em%20Nerd%20Font%20Complete.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/Symbols-1000-em Nerd Font Complete.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/Symbols-2048-em Nerd Font Complete.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols%20Template%201000%20em.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/Symbols Template 1000 em.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols%20Template%202048%20em.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/Symbols Template 2048 em.ttf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Unicode_IEC_symbol_font.otf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs//Unicode_IEC_symbol_font.otf"
	curl -sfL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/weathericons-regular-webfont.ttf?raw=true --output "$(ROOT_DIR)/vendor/src/glyphs/weathericons-regular-webfont.ttf"
	curl -sfL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/src/glyphs/NerdFontsSymbols%201000%20EM%20Nerd%20Font%20Complete%20Blank.sfd --output "$(ROOT_DIR)/vendor/src/glyphs/NerdFontsSymbols 1000 EM Nerd Font Complete Blank.sfd"
	curl -sfL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/src/glyphs/NerdFontsSymbols%202048%20EM%20Nerd%20Font%20Complete%20Blank.sfd --output "$(ROOT_DIR)/vendor/src/glyphs/NerdFontsSymbols 2048 EM Nerd Font Complete Blank.sfd"

	@touch "$(ROOT_DIR)/build/.prepared"

.PHONY: clean
clean: ## Clean build artifacts
	@echo -e "\033[1;92m➜ $@ \033[0m"
	rm -rf $(ROOT_DIR)/vendor
	rm -rf $(ROOT_DIR)/build

.PHONY: release-notes
release-notes: ## Prepare release notes
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@mkdir -p $(ROOT_DIR)/build
	@echo "# Release Notes" > $(ROOT_DIR)/build/release-notes.md
	@echo "| Type | Version |" >> $(ROOT_DIR)/build/release-notes.md
	@echo "|---|---|" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| [Upstream](https://github.com/microsoft/cascadia-code/releases/) | ![cascadia](https://img.shields.io/github/v/release/microsoft/cascadia-code?label=upstream&labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Starship | ![starship](https://img.shields.io/badge/starship--code-$(STARSHIP_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "" >> $(ROOT_DIR)/build/release-notes.md
	@echo "> Generated by GitHub Build GH-$(GITHUB_RUN_NUMBER), using nerd font patcher [$(NERDFONT_VERSION)](https://github.com/ryanoasis/nerd-fonts/blob/$(NERDFONT_VERSION)/font-patcher) and Cascadia Code version $(CASCADIA_CODE_VERSION)." >> $(ROOT_DIR)/build/release-notes.md
