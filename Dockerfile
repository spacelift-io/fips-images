ARG BASE_IMAGE=alpine:3.21

FROM ${BASE_IMAGE} AS base

ARG TARGETARCH

# OpenSSL Configuration
# 3.1.2 is the latest fips validated version (scroll down): https://openssl-library.org/source/
ARG OPENSSL_VERSION="3.1.2"
ARG OPENSSL_HASH="a0ce69b8b97ea6a35b96875235aa453b966ba3cba8af2de23657d8b6767d6539"
ENV OPENSSL_FIPS=1

# This FIPS installation follows the instructions from the official OpenSSL FIPS User Guide
# https://openssl-library.org/source/fips-doc/openssl-3.0.9-security-policy-2024-01-12.pdf

RUN echo "Enabling FIPS" &&  \
      # Install required packages
      apk add --no-cache --virtual .build-deps ca-certificates wget make gcc libgcc musl-dev linux-headers perl vim && \
      # Temporary build directory
      mkdir -p /ossl && \
      cd /ossl && \
      # Download and verify the FIPS module
      wget --quiet https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
      echo "$OPENSSL_HASH openssl-$OPENSSL_VERSION.tar.gz" | sha256sum -c - | grep OK && \
      tar -xzf openssl-$OPENSSL_VERSION.tar.gz && \
      # Build the fips modules
      cd openssl-$OPENSSL_VERSION && \
      ./Configure enable-fips --libdir=lib --prefix=/usr && \
      make && \
      # Install fips enabled openssl
      make install_fips && \
      # Update to relink binaries
      apk upgrade --no-cache -U && \
      # Cleanup
      rm -rf /tmp && \
      apk del .build-deps

COPY openssl.cnf /etc/ssl/openssl.cnf