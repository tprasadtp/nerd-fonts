SHELL := /bin/bash

CASCADIA_CODE_VERSION := "v1911.21"

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

.PHONY: fonts
fonts: ## Make all fonts
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@if [ -f src/meta/.prepared ]; then \
	echo -e "\033[1;34m‣ StarshipCode\033[0m"; \
	fontforge -script src/font-patcher -sL --complete --no-progressbars src/cascadia/Cascadia.ttf; \
	fontforge sripts/rename-font --input "Cascadia Code Nerd Font Complete.ttf" \
                                 --output "StarshipCode Nerd Font.ttf" \
                                 --name "StarshipCode" \
                                 --version "$(CASCADIA_CODE_VERSION)"; \
	echo -e "\033[1;34m‣ StarshipCodeMono\033[0m"; \
	fontforge -script src/font-patcher -sL --complete --no-progressbars src/cascadia/CascadiaMono.ttf; \
	fontforge sripts/rename-font --input "Cascadia Mono Regular Nerd Font Complete.ttf" \
                                 --output "StarshipCodeMono.ttf" \
                                 --name "StarshipCodeMono" \
                                 --version "$(CASCADIA_CODE_VERSION)"; \
	else \
		echo -e "\033[1;93m✖ Did you run 'make prepare' before running this?\033[0m"; \
		exit 1; \
	fi

.PHONY: prepare
prepare: ## Download external assets required
	@echo -e "\033[1;92m➜ $@ \033[0m"

	@echo -e "\033[1;34m‣ Downloading Cascadia Fonts...\033[0m"
	@mkdir -p src/cascadia
	@curl -sL https://github.com/microsoft/cascadia-code/releases/download/$(CASCADIA_CODE_VERSION)/Cascadia.ttf  --output 'src/cascadia/Cascadia.ttf'
	@curl -sL https://github.com/microsoft/cascadia-code/releases/download/$(CASCADIA_CODE_VERSION)/CascadiaMono.ttf  --output 'src/cascadia/CascadiaMono.ttf'

	@echo -e "\033[1;34m‣ Download source glyphs...\033[0m"
	@mkdir -p src/glyphs
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/devicons.ttf?raw=true --output src/glyphs/devicons.ttf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/font-awesome-extension.ttf?raw=true --output src/glyphs/font-awesome-extension.ttf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/font-sLogos.ttf?raw=true --output src/glyphs/font-sLogos.ttf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/FontAwesome.otf?raw=true --output src/glyphs/FontAwesome.otf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/materialdesignicons-webfont.ttf?raw=true --output src/glyphs/materialdesignicons-webfont.ttf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/octicons.ttf?raw=true --output src/glyphs/octicons.ttf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/original-source.otf?raw=true --output src/glyphs/original-source.otf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Pomicons.otf?raw=true --output src/glyphs/Pomicons.otf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/PowerlineExtraSymbols.otf?raw=true --output src/glyphs/PowerlineExtraSymbols.otf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/PowerlineSymbols.otf?raw=true --output src/glyphs/PowerlineSymbols.otf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-1000-em%20Nerd%20Font%20Complete.ttf?raw=true --output "src/glyphs/Symbols-1000-em Nerd Font Complete.ttf"
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf?raw=true --output "src/glyphs/Symbols-2048-em Nerd Font Complete.ttf"
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols%20Template%201000%20em.ttf?raw=true --output "src/glyphs/Symbols Template 1000 em.ttf"
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols%20Template%202048%20em.ttf?raw=true --output "src/glyphs/Symbols Template 2048 em.ttf"
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Unicode_IEC_symbol_font.otf?raw=true --output src/glyphs//Unicode_IEC_symbol_font.otf
	@curl -sL https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/weathericons-regular-webfont.ttf?raw=true --output src/glyphs/weathericons-regular-webfont.ttf
	@curl -sL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/src/glyphs/NerdFontsSymbols%201000%20EM%20Nerd%20Font%20Complete%20Blank.sfd --output "src/glyphs/NerdFontsSymbols 1000 EM Nerd Font Complete Blank.sfd"
	@curl -sL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/src/glyphs/NerdFontsSymbols%202048%20EM%20Nerd%20Font%20Complete%20Blank.sfd --output "src/glyphs/NerdFontsSymbols 2048 EM Nerd Font Complete Blank.sfd"

	@echo -e "\033[1;34m‣ Download patcher...\033[0m"
	@mkdir -p src/patcher
	@curl -sL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/font-patcher --output 'src/patcher/font-patcher'

	@mkdir -p src/meta
	@touch src/meta/.prepared

.PHONY: clean
clean: ## Clean build artifacts
	@echo -e "\033[1;92m➜ $@ \033[0m"
	@echo -e "\033[1;34m‣ Removing generated fonts...\033[0m"
	@rm -f build/*.* build/*
	@echo -e "\033[1;34m‣ Removing downloaded files...\033[0m"
	@rm -rf src
