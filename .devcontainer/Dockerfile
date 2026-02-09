FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install dependencies for Flutter and Android development
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter as vscode user
USER vscode
WORKDIR /home/vscode

RUN git clone https://github.com/flutter/flutter.git -b stable && \
    /home/vscode/flutter/bin/flutter --version && \
    /home/vscode/flutter/bin/flutter config --no-analytics

# Add Flutter to PATH
ENV PATH="/home/vscode/flutter/bin:$PATH"

WORKDIR /workspaces/breakeven_calc
