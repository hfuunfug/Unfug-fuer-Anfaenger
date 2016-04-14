#
#
#
# Variables
#
#
#

export MAKE_FLAGS=--no-print-directory

export OUT=$(shell pwd)/bin
export OUT_LATEX=$(OUT)/latex/
export OUT_HTML=$(OUT)/html/

export SCRIPTS=$(shell pwd)/scripts/

## Source directory
SRC_DIR=$(shell pwd)/src

## All markdown files in the working directory
export SOURCES=$(shell find $(SRC_DIR) -name "*.md" | sort)

## Templates
export TEMPLATE=$(shell pwd)/template

# target
export TARGET=$(OUT)/document.pdf

#
#
#
# Binary and argument construction
#
#
#

ECHO_CMD=$(shell which echo)
ECHO_ARG=-e
ECHO=$(ECHO_CMD) $(ECHO_ARG)
export ECHO

CP_CMD=$(shell which cp)
CP_ARG=-nr
CP=$(CP_CMD) $(CP_ARG)
export CP

MKDIR_CMD=$(shell which mkdir)
MKDIR_ARG=-p
MKDIR=$(MKDIR_CMD) $(MKDIR_ARG)
export MKDIR

RM_CMD=$(shell which rm)
RM_ARG=-fr
RM=$(RM_CMD) $(RM_ARG)
export RM

#
# Filters
#
export FILTER_SCRIPTS=$(shell find $(SCRIPTS) -name "*-filter.py")
export FILTERING_ARGS=$(foreach x, $(FILTER_SCRIPTS), --filter $x)

#
# CC
#
PANDOC_CC=$(shell which pandoc)
PANDOC_PARAMS=-r \
	markdown+simple_tables+table_captions+yaml_metadata_block+definition_lists+footnotes+inline_notes \
	--filter pandoc-crossref \
	--filter pandoc-citeproc \
	$(FILTERING_ARGS)

export PANDOC=$(PANDOC_CC) $(PANDOC_PARAMS)

#
# Settings
#

DOCUMENT_SETTINGS=\
	--latex-engine=xelatex \
	-V fontsize=12pt \
	-V documentclass:book \
	-V papersize:a4paper \
	-V classoption:openright \
	--chapters \
	--bibliography=papers.bib  \
	-H $(TEMPLATE)/preamble.tex \
	--csl=$(TEMPLATE)/csl/nature.csl

#
#
# Tasks
#
#

all: $(TARGET)
	@$(ECHO) "[READY ]"

$(TARGET): $(OUT)
	@$(ECHO) "[PANDOC]"
	$(PANDOC) $(DOCUMENT_SETTINGS) $(SOURCES) -o $(TARGET)

$(OUT):
	@$(ECHO) "[MKDIR ]"
	@$(MKDIR) $(OUT)

