#!/usr/bin/make -f

# Target
TARGET         := index

# Directories
STYLE_DIR      := style
SOURCE_DIR     := src
IMAGE_DIR      := image
BUILD_DIR      := build

# Source files
STYLE_FILES    := $(wildcard $(STYLE_DIR)/*.cls) \
                  $(wildcard $(STYLE_DIR)/*.sty) \
                  $(wildcard $(STYLE_DIR)/*.bst)
TEX_FILES      := $(wildcard $(SOURCE_DIR)/*.tex) $(TARGET).tex
BIB_FILES      := $(wildcard $(SOURCE_DIR)/*.bib)
SVG_FILES      := $(wildcard $(IMAGE_DIR)/*.svg)
CONVERT_FILES  := $(addprefix $(IMAGE_DIR)/,$(notdir $(SVG_FILES:%.svg=%.pdf)))
IMAGE_FILES    := $(wildcard $(IMAGE_DIR)/*.png) \
                  $(wildcard $(IMAGE_DIR)/*.pdf) \
                  $(wildcard $(IMAGE_DIR)/*.eps) \
                  $(wildcard $(IMAGE_DIR)/*.jpg) \
                  $(wildcard $(IMAGE_DIR)/*.jpeg) \
                  $(CONVERT_FILES)

.SUFFIXES:
.SUFFIXES: .pdf .ps .dvi .bbl .aux .png .eps .jpg .jpeg .tex .bib .cls .sty .bst .svg

# Tools
LATEX          := platex --shell-escape -halt-on-error -interaction=batchmode -output-directory=$(BUILD_DIR)
BIBTEX         := pbibtex -terse
MAKEINDEX      := mendex
DVIPDF         := dvipdfmx -o $(BUILD_DIR)/$(TARGET).pdf
DVIPS          := dvips -q -o $(BUILD_DIR)/$(TARGET).ps
PDF_VIEWER     := evince
PS_VIEWER      := evince
RM             := rm -rf
MKDIR          := mkdir -p
CAT            := cat
PREVIEW_MODE   := pdf # ps

# Commands
.PHONY: all
all: rebuild clean ## Rebuild all & Remove a part of generated files.

.PHONY: build
build: $(BUILD_DIR)/$(TARGET).pdf $(BUILD_DIR)/$(TARGET).ps  ## Build all

.PHONY: rebuild
rebuild: distclean build ## Rebuild all.

.PHONY: debug
debug: rebuild ## Print debug messages after building.
	$(CAT) $(BUILD_DIR)/$(TARGET).blg
	$(CAT) $(BUILD_DIR)/$(TARGET).log

.PHONY: preview
preview: build ## View PDF/PostScript file.
ifeq ("$(PREVIEW_MODE)", "ps")
	$(PDF_VIEWER) $(BUILD_DIR)/$(TARGET).ps &
else
	$(PS_VIEWER) $(BUILD_DIR)/$(TARGET).pdf &
endif

.PHONY: clean
clean:  ## Remove a part of generated files.
	$(RM) $(BUILD_DIR)/*.aux $(BUILD_DIR)/*.lof $(BUILD_DIR)/*.log \
        $(BUILD_DIR)/*.lot $(BUILD_DIR)/*.fls $(BUILD_DIR)/*.out \
        $(BUILD_DIR)/*.toc $(BUILD_DIR)/*.fmt $(BUILD_DIR)/*.fot \
        $(BUILD_DIR)/*.cb  $(BUILD_DIR)/*.cb2 $(BUILD_DIR)/*.lb  \
        $(BUILD_DIR)/*.dvi $(BUILD_DIR)/*.xdv $(BUILD_DIR)/*-converted-to.* \
        $(BUILD_DIR)/*.bbl $(BUILD_DIR)/*.bcf $(BUILD_DIR)/*.blg \
        $(BUILD_DIR)/*-blx.aux $(BUILD_DIR)/*-blx.bib $(BUILD_DIR)/*.run.xml \
        $(BUILD_DIR)/*.fdb_latexmk $(BUILD_DIR)/*.synctex \
        $(BUILD_DIR)/*.synctex.gz $(BUILD_DIR)/*.pdfsync \
        $(BUILD_DIR)/*.idx $(BUILD_DIR)/*.ilg $(BUILD_DIR)/*.ind

.PHONY: distclean
distclean: clean ## Remove all generated files.
	$(RM) $(BUILD_DIR)/*.pdf $(BUILD_DIR)/*.ps $(CONVERT_FILES)

.PHONY: help
help:  ## Print help.
	@printf "$$LOGO"
	@printf "\033[36m%-20s\033[0m %s\n" "[Command]" "[Description]"
	@grep -E '^[a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s \033[0m%s\n", $$1, $$2}'


# Dependency
$(BUILD_DIR)/$(TARGET).pdf: $(BUILD_DIR)/$(TARGET).dvi
	$(DVIPDF) $(BUILD_DIR)/$(TARGET).dvi

$(BUILD_DIR)/$(TARGET).ps: $(BUILD_DIR)/$(TARGET).dvi
	$(DVIPS) $(BUILD_DIR)/$(TARGET).dvi

$(BUILD_DIR)/$(TARGET).dvi: $(BUILD_DIR)/ $(TEX_FILES) $(BIB_FILES) $(STYLE_FILES) $(IMAGE_FILES)
ifneq ("$(BIB_FILES)", "")
	$(LATEX) $(TARGET).tex
	$(BIBTEX) $(BUILD_DIR)/$(TARGET).aux
endif
	$(LATEX) $(TARGET).tex
	$(LATEX) $(TARGET).tex

$(BUILD_DIR)/:
	$(MKDIR) $(BUILD_DIR)

# $(IMAGE_DIR)/%.pdf: $(IMAGE_DIR)/%.svg
# 	inkscape -z -D --file="$<" --export-pdf="$@"


# Appendix
export LOGO
define LOGO
\033[35m \033[35m-----------------------------------------------------\033[35m
\033[35m|\033[34m       _    _____                        _           \033[35m|
\033[35m|\033[34m      | |  |  ___|                      | |          \033[35m|
\033[35m|\033[34m      | | _|___ \ ______ _ __ ___   ___ | |_         \033[35m|
\033[35m|\033[34m      | |/ /   \ \______| '_ ` _ \ / _ \| __|        \033[35m|
\033[35m|\033[34m      |   </\__/ /      | | | | | | (_) | |_         \033[35m|
\033[35m|\033[34m      |_|\_\____/       |_| |_| |_|\___/ \__|        \033[35m|
\033[35m|\033[34m                                                     \033[35m|
\033[35m|\033[37m Copyright (c) 2020-2022 k5-mot All Rights Reserved. \033[35m|
\033[35m \033[35m-----------------------------------------------------\033[35m


endef
