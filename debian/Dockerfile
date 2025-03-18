FROM debian:latest

# OpenSSL Configuration
# 3.1.2 is the latest fips validated version (scroll down): https://openssl-library.org/source/
ARG OPENSSL_VERSION="3.1.2"
ARG OPENSSL_HASH="a0ce69b8b97ea6a35b96875235aa453b966ba3cba8af2de23657d8b6767d6539"
ENV OPENSSL_FIPS=1

# This FIPS installation follows the instructions from the official OpenSSL FIPS User Guide
# https://openssl-library.org/source/fips-doc/openssl-3.0.9-security-policy-2024-01-12.pdf

RUN echo "Enabling FIPS" &&  \
      # Install required packages \
      apt-get update && \
      apt-get install -y wget ca-certificates build-essential zlib1g-dev && \
      # Temporary build directory
      mkdir -p /tmp && \
      cd /tmp && \
      # Download and verify the FIPS module
      wget --quiet https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz && \
      echo "$OPENSSL_HASH openssl-$OPENSSL_VERSION.tar.gz" | sha256sum -c - | grep OK && \
      tar -xzf openssl-$OPENSSL_VERSION.tar.gz && \
      # Build the fips modules \
      cd openssl-$OPENSSL_VERSION && \
      ./Configure enable-fips --libdir=lib --prefix=/usr shared zlib && \
      make && \
      # Install fips enabled openssl
      make install_fips && \
      # Cleanup
      rm -rvf /tmp/* && \
      apt-get remove -y wget build-essential && \
      rm -rvf /var/lib/apt/lists/* && \
      apt-get clean

COPY openssl.cnf /etc/ssl/openssl.cnf