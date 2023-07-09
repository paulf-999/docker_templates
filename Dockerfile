# Base image
FROM ubuntu:20.04

# Set the working directory inside the container
WORKDIR /app

LABEL name="baseline_ubuntu_image"
LABEL desc="Baseline Ubuntu Docker image"
LABEL version="1.0"

ENV APT_GET_INSTALL_CMD="apt-get -y install --no-install-recommends"

# Install dependencies (if applicable)
RUN apt-get -y update --no-install-recommends \
    && $APT_GET_INSTALL_CMD build-essential=12.8ubuntu1.1 \
    && $APT_GET_INSTALL_CMD git=1:2.25.1-1ubuntu3.11 \
    && $APT_GET_INSTALL_CMD python3-pip=20.0.2-5ubuntu1.9 \
    && $APT_GET_INSTALL_CMD vim \
    && rm -rf /var/lib/apt/lists/*
# the last command is used to clean up the apt cache & helps to keep the image size down

# Copy the project files into the container
COPY requirements.txt /app

# Make sure we are using latest pip
RUN pip install --upgrade pip==23.1.2 --no-cache-dir \
    && pip install -r requirements.txt --no-cache-dir

# Expose any necessary ports
EXPOSE 80/tcp
