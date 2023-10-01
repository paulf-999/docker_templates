SHELL = /bin/sh

#================================================================
# Usage
#================================================================
# make installations	# install the package for the first time, managing dependencies & performing a housekeeping cleanup too
# make install		# perform the end-to-end install
# make clean		# perform a housekeeping cleanup

.EXPORT_ALL_VARIABLES:

CONFIG_FILE := config.yaml

# load variables from separate file
include config.mk

DOCKER_IMG_NAME := cicd_debugging:1.0

installations: install run clean

install:
	@echo "------------------------------------------------------------------"
	@echo "${YELLOW}Target: 'install'. Build the Docker image.${COLOUR_OFF}"
	@echo "------------------------------------------------------------------"
	docker build -t ${DOCKER_IMG_NAME} .

run:
	@echo "------------------------------------------------------------------"
	@echo "${YELLOW}Target: 'run'. Run the Docker image.${COLOUR_OFF}"
	@echo "------------------------------------------------------------------"
	docker container run -it ${DOCKER_IMG_NAME} /bin/bash

clean:
	@echo "------------------------------------------------------------------"
	@echo "${YELLOW}Target 'clean'. Remove any redundant files, e.g. downloads.${COLOUR_OFF}"
	@echo "------------------------------------------------------------------"

# Phony targets
.PHONY: all deps install installations test clean

# .PHONY tells Make that these targets don't represent files
# This prevents conflicts with any files named "all" or "clean"
