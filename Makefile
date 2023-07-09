SHELL = /bin/sh

# Usage:
# make installations	# install the package for the first time, managing dependencies & performing a housekeeping cleanup too
# make install		# perform the end-to-end install
# make clean		# perform a housekeeping cleanup

# all: deps install [X, Y, Z...] clean

.EXPORT_ALL_VARIABLES:
.PHONY = installations install run clean

CONFIG_FILE := config.yaml
# the 2 vars below are just for formatting CLI message output
COLOUR_TXT_FMT_OPENING := \033[0;33m
COLOUR_TXT_FMT_CLOSING := \033[0m

DOCKER_IMG_NAME := cicd_debugging:1.0

installations: install run clean

install:
	@echo "------------------------------------------------------------------"
	@echo "${COLOUR_TXT_FMT_OPENING}Target: 'install'. Build the Docker image.${COLOUR_TXT_FMT_CLOSING}"
	@echo "------------------------------------------------------------------"
	docker build -t ${DOCKER_IMG_NAME} .

run:
	@echo "------------------------------------------------------------------"
	@echo "${COLOUR_TXT_FMT_OPENING}Target: 'run'. Run the Docker image.${COLOUR_TXT_FMT_CLOSING}"
	@echo "------------------------------------------------------------------"
	docker container run -it ${DOCKER_IMG_NAME} /bin/bash

clean:
	@echo "------------------------------------------------------------------"
	@echo "${COLOUR_TXT_FMT_OPENING}Target 'clean'. Remove any redundant files, e.g. downloads.${COLOUR_TXT_FMT_CLOSING}"
	@echo "------------------------------------------------------------------"
