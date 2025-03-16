PYTHON=python
PIP=pip
VENV_NAME=.venv
VENV_ACTIVATE=${VENV_NAME}/bin/activate

help: URL := github.com/drdv/makefile-doc/releases/latest/download/makefile-doc.awk
help: DIR := $(HOME)/.local/share/makefile-doc
help: SCR := $(DIR)/makefile-doc.awk
help: ## show this help
	@test -f $(SCR) || wget -q -P $(DIR) $(URL)
	@awk -f $(SCR) $(MAKEFILE_LIST)

## serve site locally
serve: build
	source ${VENV_ACTIVATE} && mkdocs serve

## build site
build: clean-site
	source ${VENV_ACTIVATE} && mkdocs build

##! deploy site
deploy: clean-site
	source ${VENV_ACTIVATE} && mkdocs gh-deploy

## setup venv
setup-venv:
	${PYTHON} -m venv ${VENV_NAME} && \
	. ${VENV_NAME}/bin/activate && \
	${PIP} install --upgrade pip && \
	${PIP} install -r .requirements.txt

## clean venv
clean-venv:
	rm -rf .venv

## clean
clean-site:
	rm -rf site
