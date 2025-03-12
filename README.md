# Alpine FIPS Base Image

This repository builds an Alpine Based Docker image with FIPS enabled.

To use it in your Dockerfile, add the following lines:
```dockerfile
FROM ghcr.io/spacelift-io/alpine-fips:base-latest

FROM ghcr.io/spacelift-io/alpine-fips:gcp-latest
```