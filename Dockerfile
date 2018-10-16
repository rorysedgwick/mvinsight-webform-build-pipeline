FROM python:3.5-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    libgeos-dev \
    libgdal-dev \
    curl \
    build-essential

## cypress.io dependencies
RUN apt-get install -y \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb

# potentially unnecessary python & node dependencies
# RUN apt-get install -y \
    # gcc \
    # g++ \
    # git-core \
    # make \
    # libffi-dev libssl-dev python3-dev libpq-dev libmemcached-dev \
    # libtiff5-dev libjpeg-dev libfreetype6-dev webp zlib1g-dev pcre++-dev

#liblcms2-dbg musl-dev
#for gevent support
# RUN apt-get install -y libev-dev

# RUN apt-get install -y wget
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs
RUN apt-get autoremove -y

# AWS CLI dependencies
RUN pip install --upgrade pip
RUN pip install virtualenv && \
    awscli==1.11.115

RUN node -v
RUN npm -v

RUN npm install cypress --save-dev
RUN $(npm bin)/cypress verify

# docker run -it --volume=/Users/rory.sedgwick/projects/arup/momo-webforms/:/momo-webforms --workdir="/momo-webforms" --memory=4g --memory-swap=4g --memory-swappiness=0 --entrypoint=/bin/bash mvinsight-webform-build-pipeline