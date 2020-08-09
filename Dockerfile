ARG UBUNTU_VERSION
FROM ubuntu:$UBUNTU_VERSION
MAINTAINER Dimm <tirri@yandex.ru>
ARG DEBIAN_FRONTEND=noninteractive
ARG UBUNTU_VERSION
ENV UBUNTU_VERSION=$UBUNTU_VERSION
ENV TEST=0

COPY ./utils/* /usr/local/bin/
RUN  /usr/local/bin/apt-step-1.sh

RUN locale-gen en_US.UTF-8

ENV LANG en US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV LC_TYPE=en_US.UTF-8

RUN apt-get install -y --no-install-recommends \
    libfcgi0ldbl \
    iputils-ping \
# for use add-apt-repository
    software-properties-common \
    && add-apt-repository -y ppa:ondrej/php \
    && /usr/local/bin/apt-step-2.sh \
    && apt-get -y update \
    && apt-get install -y --no-install-recommends tzdata \
# reduce image size
    && apt-get purge -y software-properties-common \
# clean
    && apt-get -y autoremove \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]