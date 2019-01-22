FROM python:3.5-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    libgeos-dev \
    libgdal-dev \
    curl \
    build-essential \
    jq

## cypress.io dependencies
RUN apt-get install -y \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb

# install node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs

# remove dependencies that were only required for other apt-get install operations
RUN apt-get autoremove -y

RUN npm install cypress --save-dev
RUN $(npm bin)/cypress verify

# AWS CLI dependencies
RUN pip install --upgrade pip
RUN pip install awscli==1.11.115 --upgrade

RUN node -v
RUN npm -v

# docker run -it --volume=$HOME/projects/arup/momo-webforms/:/momo-webforms --workdir="/momo-webforms" --memory=4g --memory-swap=4g --memory-swappiness=0 --entrypoint=/bin/bash mvinsight-webform-build-pipeline
