SHELL := /bin/bash

CASCADIA_CODE_VERSION := v2111.01
FIRACODE_VERSION := 5.2
FANTASQUE_VERSION := v1.8.0
UBUNTU_FONT_VERSION := 0.83

ROOT_DIR := $(strip $(patsubst %/, %, $(dir $(realpath $(firstword $(MAKEFILE_LIST))))))

.PHONY: help
help: ## This help message
	@printf "%-30s %s\n" "Target" "Help"
	@printf "%-30s %s\n" "-----" "-----"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: vendor
vendor: vendor-cascadia vendor-fantasque vendor-ubuntu ## Vendor all fonts

.PHONY: vendor-cascadia
vendor-cascadia: ## Download and vendor Cascadia code
	@echo "--> Download Cascadia Code"
	@mkdir -p $(ROOT_DIR)/build/download
	@mkdir -p $(ROOT_DIR)/vendor/Cascadia
	curl -sSfL https://github.com/microsoft/cascadia-code/releases/download/$(CASCADIA_CODE_VERSION)/CascadiaCode-$(CASCADIA_CODE_VERSION:v%=%).zip \
		--output $(ROOT_DIR)/build/download/CascadiaCode.zip
	@echo "--> Download Cascadia Code (LICENSE)"
	curl -sSfL https://raw.githubusercontent.com/microsoft/cascadia-code/$(CASCADIA_CODE_VERSION)/LICENSE \
		--output $(ROOT_DIR)/vendor/Cascadia/LICENSE
	@echo "--> Vendor Cascadia Code"
	unzip -j -o \
		-d $(ROOT_DIR)/vendor/Cascadia/ \
		$(ROOT_DIR)/build/download/CascadiaCode.zip \
		ttf/CascadiaCode.ttf \
		ttf/CascadiaCodeItalic.ttf \
		ttf/CascadiaMono.ttf \
		ttf/CascadiaMonoItalic.ttf

	mv -f $(ROOT_DIR)/vendor/Cascadia/CascadiaCode.ttf $(ROOT_DIR)/vendor/Cascadia/CascadiaCode-Regular.ttf
	mv -f $(ROOT_DIR)/vendor/Cascadia/CascadiaMono.ttf $(ROOT_DIR)/vendor/Cascadia/CascadiaMono-Regular.ttf

	mv -f $(ROOT_DIR)/vendor/Cascadia/CascadiaCodeItalic.ttf $(ROOT_DIR)/vendor/Cascadia/CascadiaCode-Italic.ttf
	mv -f $(ROOT_DIR)/vendor/Cascadia/CascadiaMonoItalic.ttf $(ROOT_DIR)/vendor/Cascadia/CascadiaMono-Italic.ttf

	@echo "$(CASCADIA_CODE_VERSION)" > $(ROOT_DIR)/vendor/Cascadia/VERSION.txt


.PHONY: vendor-fantasque
vendor-fantasque: ## Download and vendor FantasqueSans
	@echo "--> Download FantasqueSans"
	@mkdir -p $(ROOT_DIR)/build/download/FantasqueSans
	@mkdir -p $(ROOT_DIR)/vendor/FantasqueSans
	curl -sSfL https://github.com/belluzj/fantasque-sans/releases/download/$(FANTASQUE_VERSION)/FantasqueSansMono-NoLoopK.zip \
		--output $(ROOT_DIR)/build/download/FantasqueSansMono.zip

	@echo "--> Vendor FantasqueSans"
	unzip -j -o \
		-d $(ROOT_DIR)/vendor/FantasqueSans/ \
		$(ROOT_DIR)/build/download/FantasqueSansMono.zip \
		TTF/FantasqueSansMono-Regular.ttf \
		TTF/FantasqueSansMono-Italic.ttf \
		LICENSE.txt
	@echo "$(FANTASQUE_VERSION)" > $(ROOT_DIR)/vendor/FantasqueSans/VERSION.txt


.PHONY: vendor-ubuntu
vendor-ubuntu: ## Download and vendor FantasqueSans
	@echo "--> Download Ubuntu"
	@mkdir -p $(ROOT_DIR)/build/download
	curl -sSfL https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip \
		--output $(ROOT_DIR)/build/download/Ubuntu.zip

	@echo "--> Vendor Ubuntu"
	@mkdir -p $(ROOT_DIR)/vendor/Ubuntu
	unzip -j -o \
		-d $(ROOT_DIR)/vendor/Ubuntu/ \
		$(ROOT_DIR)/build/download/Ubuntu.zip \
		ubuntu-font-family-0.83/Ubuntu-R.ttf \
		ubuntu-font-family-0.83/Ubuntu-RI.ttf \
		ubuntu-font-family-0.83/Ubuntu-L.ttf \
		ubuntu-font-family-0.83/Ubuntu-LI.ttf \
		ubuntu-font-family-0.83/Ubuntu-M.ttf \
		ubuntu-font-family-0.83/Ubuntu-MI.ttf \
		ubuntu-font-family-0.83/UbuntuMono-R.ttf \
		ubuntu-font-family-0.83/UbuntuMono-RI.ttf \
		ubuntu-font-family-0.83/LICENCE.txt \
		ubuntu-font-family-0.83/TRADEMARKS.txt
	mv -f $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-R.ttf $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-Regular.ttf
	mv -f $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-RI.ttf $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-Regular-Italic.ttf

	mv -f $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-L.ttf $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-Light-Italic.ttf
	mv -f $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-LI.ttf $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-Light-Italic.ttf

	mv -f $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-M.ttf $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-Medium.ttf
	mv -f $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-MI.ttf $(ROOT_DIR)/vendor/Ubuntu/Ubuntu-Medium-Italic.ttf

	mv -f $(ROOT_DIR)/vendor/Ubuntu/UbuntuMono-R.ttf $(ROOT_DIR)/vendor/Ubuntu/UbuntuMono-Regular.ttf
	mv -f $(ROOT_DIR)/vendor/Ubuntu/UbuntuMono-RI.ttf $(ROOT_DIR)/vendor/Ubuntu/UbuntuMono-Regular-Italic.ttf

	@echo "0.83" > $(ROOT_DIR)/vendor/FantasqueSans/VERSION.txt

.PHONY: release-notes
release-notes: ## Generate release notes
	@echo "-> Release Notes"
	@mkdir -p $(ROOT_DIR)/build
	@echo "# Release Notes" > $(ROOT_DIR)/build/release-notes.md
	@echo "| Name | Upstream | Version |" >> $(ROOT_DIR)/build/release-notes.md
	@echo "|---|---|---|" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Caskaydia Cove | [Cascadia Code](https://github.com/microsoft/cascadia-code) | ![cascadia](https://img.shields.io/badge/version-$(CASCADIA_CODE_VERSION)-blue?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Fantasque Sans Mono | [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans) | ![fantasque](https://img.shields.io/badge/version-$(FANTASQUE_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "| Ubuntu | [Ubuntu](https://design.ubuntu.com/font/) | ![ubuntu](https://img.shields.io/badge/version-$(UBUNTU_FONT_VERSION)-brightgreen?labelColor=313131)" >> $(ROOT_DIR)/build/release-notes.md
	@echo "" >> $(ROOT_DIR)/build/release-notes.md

.PHONY: cascadiacode-regular
cascadiacode-regular: ## CascadiaCode Regular
	@echo "-> CascadiaCode - Regular"
	@mkdir -p "$(ROOT_DIR)/build/Cascadia"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaCode-Regular.ttf"
	@echo "-> CascadiaCode - Regular (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaCode-Regular.ttf"

.PHONY: cascadiacode-italic
cascadiacode-italic: ## CascadiaCode Italic
	@echo "-> CascadiaCode - Italic"
	@mkdir -p "$(ROOT_DIR)/build/Cascadia"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaCode-Italic.ttf"
	@echo "-> CascadiaCode - Italic (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaCode-Italic.ttf"

.PHONY: cascadiamono-regular
cascadiamono-regular: ## CascadiaMono Regular
	@echo "-> CascadiaCode - Italic"
	@mkdir -p "$(ROOT_DIR)/build/Cascadia"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaMono-Regular.ttf"
	@echo "-> CascadiaCode - Italic (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaMono-Regular.ttf"

.PHONY: cascadiamono-italic
cascadiamono-italic: ## CascadiaMono Italic
	@echo "-> CascadiaCode - Italic"
	@mkdir -p "$(ROOT_DIR)/build/Cascadia"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaMono-Italic.ttf"
	@echo "-> CascadiaCode - Italic (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Cascadia" \
		"${ROOT_DIR}/vendor/Cascadia/CascadiaMono-Italic.ttf"

.PHONY: cascadia
cascadia: cascadiacode-regular cascadiacode-italic cascadiamono-regular cascadiamono-italic ## Build Cascadia (All)

.PHONY: fantasque-regular
fantasque-regular: ## FantasqueSansMono Regular
	@echo "-> FantasqueSansMono - Regular"
	@mkdir -p "$(ROOT_DIR)/build/FantasqueSans"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/FantasqueSans" \
		"${ROOT_DIR}/vendor/FantasqueSans/FantasqueSansMono-Regular.ttf"
	@echo "-> FantasqueSansMono - Regular (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/FantasqueSans" \
		"${ROOT_DIR}/vendor/FantasqueSans/FantasqueSansMono-Regular.ttf"

.PHONY: fantasque-italic
fantasque-italic: ## FantasqueSansMono Italic
	@echo "-> FantasqueSansMono - Italic"
	@mkdir -p "$(ROOT_DIR)/build/FantasqueSans"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/FantasqueSans" \
		"${ROOT_DIR}/vendor/FantasqueSans/FantasqueSansMono-Italic.ttf"
	@echo "-> FantasqueSansMono - Italic (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/FantasqueSans" \
		"${ROOT_DIR}/vendor/FantasqueSans/FantasqueSansMono-Italic.ttf"

.PHONY: fantasque
fantasque: fantasque-regular fantasque-italic ## Build FantasqueSansMono (All)

.PHONY: ubuntu-regular
ubuntu-regular: ## Ubuntu Regular
	@echo "-> Ubuntu - Regular"
	@mkdir -p "$(ROOT_DIR)/build/Ubuntu"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/Ubuntu-Regular.ttf"
	@echo "-> Ubuntu - Regular (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/Ubuntu-Regular.ttf"

.PHONY: ubuntu-regular-italic
ubuntu-regular-italic: ## Ubuntu Regular Italic
	@echo "-> Ubuntu - Regular Italic"
	@mkdir -p "$(ROOT_DIR)/build/Ubuntu"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/Ubuntu-Regular-Italic.ttf"
	@echo "-> Ubuntu - Regular Italic (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/Ubuntu-Regular-Italic.ttf"

.PHONY: ubuntumono-regular
ubuntumono-regular: ## UbuntuMono Regular
	@echo "-> UbuntuMono - Regular"
	@mkdir -p "$(ROOT_DIR)/build/Ubuntu"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/UbuntuMono-Regular.ttf"
	@echo "-> UbuntuMono - Regular (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/UbuntuMono-Regular.ttf"

.PHONY: ubuntumono-regular-italic
ubuntumono-regular-italic: ## UbuntuMono Regular Italic
	@echo "-> UbuntuMono - Regular Italic"
	@mkdir -p "$(ROOT_DIR)/build/Ubuntu"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/UbuntuMono-Regular-Italic.ttf"
	@echo "-> UbuntuMono - Regular Italic (Windows)"
	fontforge -quiet --script "$(ROOT_DIR)/font-patcher" \
		--complete \
		--windows \
		--no-progressbars \
		--outputdir "${ROOT_DIR}/build/Ubuntu" \
		"${ROOT_DIR}/vendor/Ubuntu/UbuntuMono-Regular-Italic.ttf"

.PHONY: ubuntu
ubuntu: ubuntu-regular ubuntu-regular-italic ubuntumono-regular ubuntumono-regular-italic ## Build Ubuntu (All)

.PHONY: clean
clean: ## Clean build artifacts
	rm -rf $(ROOT_DIR)/build

.PHONY: checksums
checksums: ## Generate SHA256 checksums for artifacts
	cd $(ROOT_DIR)/build/Cascadia && sha256sum  *.ttf >  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/FantasqueSans && sha256sum *.ttf >>  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/FiraCode && sha256sum *.ttf >>  ../SHA256SUMS.txt
	cd $(ROOT_DIR)/build/Ubuntu && sha256sum *.ttf >>  ../SHA256SUMS.txt

.PHONY: all
all: clean cascadia fantasque ubuntu release-notes checksums ## Build all fonts
