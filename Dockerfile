FROM registry.access.redhat.com/ubi9/ubi:9.0.0-1468.1655190709

LABEL com.redhat.component="ubi8-container" \
      name="ubi8" \
      version="8.4"

RUN yum --disableplugin=subscription-manager -y update \
#  && yum --disableplugin=subscription-manager -y install curl \
  && yum --disableplugin=subscription-manager clean all

# The ACS Version
ARG VERSION=3.70.1
#ARG VERSION=latest

RUN curl -O https://mirror.openshift.com/pub/rhacs/assets/${VERSION}/bin/Linux/roxctl \
  && chmod +x roxctl \
  && mv roxctl /usr/local/bin/

RUN useradd -ms /bin/bash stackrox
USER stackrox