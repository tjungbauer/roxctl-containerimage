FROM --platform=linux/amd64 registry.access.redhat.com/ubi10/ubi-minimal:latest@sha256:f8c05e3c6d15fea32e59635477c0f690e6d4b88a81924e8619f369e57306b701

# The ACS/RHACS Version to download
ARG VERSION=4.5.4

LABEL com.redhat.component="roxctl-container" \
      name="roxctl" \
      version="${VERSION}" \
      summary="Red Hat Advanced Cluster Security roxctl CLI" \
      description="Container image providing the roxctl CLI tool for RHACS/Stackrox" \
      maintainer="tjungbau"

RUN microdnf update -y \
    && microdnf install -y shadow-utils \
    && microdnf clean all \
    && rm -rf /var/cache/yum \
    && curl -fsSL -o /usr/local/bin/roxctl \
       "https://mirror.openshift.com/pub/rhacs/assets/${VERSION}/bin/Linux/roxctl" \
    && chmod +x /usr/local/bin/roxctl \
    && useradd -ms /bin/sh stackrox

WORKDIR /home/stackrox

USER stackrox

ENTRYPOINT ["roxctl"]
CMD ["--help"]
