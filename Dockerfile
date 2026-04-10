FROM --platform=linux/amd64 registry.access.redhat.com/ubi10/ubi-minimal:latest@sha256:7bd3d2e7f5c507aebd1575d0f2fab9fe3e882e25fee54fa07f7970aa8bbc5fab

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
