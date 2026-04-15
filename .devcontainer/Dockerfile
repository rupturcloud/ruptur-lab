FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    jq \
    make \
    openssh-client \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
