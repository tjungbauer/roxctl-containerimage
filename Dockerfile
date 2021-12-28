FROM registry.access.redhat.com/ubi8/ubi:8.5-214

LABEL com.redhat.component="ubi8-container" \
      name="ubi8" \
      version="8.4"

RUN yum --disableplugin=subscription-manager -y update \
  && yum --disableplugin=subscription-manager -y install curl \
  && yum --disableplugin=subscription-manager clean all

# The ACS Version
ARG VERSION=3.67.1

RUN curl -O https://mirror.openshift.com/pub/rhacs/assets/${VERSION}/bin/Linux/roxctl \
  && chmod +x roxctl \
  && mv roxctl /usr/local/bin/

RUN useradd -ms /bin/bash stackrox
USER stackrox
