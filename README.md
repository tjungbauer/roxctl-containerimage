# roxctl Container Image

[![Build](https://github.com/tjungbauer/roxctl-containerimage/actions/workflows/ci.yml/badge.svg)](https://github.com/tjungbauer/roxctl-containerimage/actions/workflows/ci.yml)

A minimal container image packaging the **roxctl** CLI for Red Hat Advanced Cluster Security (RHACS/Stackrox).

## Pull

```bash
podman pull quay.io/tjungbau/roxctl-bin-container:latest
```

## Usage

```bash
# Show help
podman run --rm quay.io/tjungbau/roxctl-bin-container:latest --help

# Check connection to Central
podman run --rm \
  -e ROX_API_TOKEN=<your-token> \
  quay.io/tjungbau/roxctl-bin-container:latest \
  central whoami --insecure-skip-tls-verify -e https://central.example.com:443

# Image check
podman run --rm \
  -e ROX_API_TOKEN=<your-token> \
  quay.io/tjungbau/roxctl-bin-container:latest \
  image check --image=nginx:latest -e https://central.example.com:443
```

## Build Locally

```bash
# Build with default roxctl version
podman build -t roxctl .

# Build with specific version
podman build --build-arg VERSION=4.5.4 -t roxctl:4.5.4 .
```

## Image Details

| Property | Value |
|----------|-------|
| Base Image | UBI 10 Minimal |
| Platform | linux/amd64 |
| User | stackrox (non-root) |
| Entrypoint | `roxctl` |
