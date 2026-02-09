FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install dependencies for Flutter and Android development
RUN apt-get update && apt-get install -y \
    curl \
    git \
    git-lfs \
    unzip \
    wget \
    openjdk-11-jdk \
    lib32stdc++6 \
    lib32z1 \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter and Android SDK as vscode user
USER vscode
WORKDIR /home/vscode

RUN git clone https://github.com/flutter/flutter.git -b stable && \
    /home/vscode/flutter/bin/flutter --version && \
    /home/vscode/flutter/bin/flutter config --no-analytics

ENV ANDROID_SDK_ROOT="/home/vscode/android-sdk"
ENV PATH="/home/vscode/android-sdk/cmdline-tools/latest/bin:/home/vscode/android-sdk/platform-tools:${PATH}"

RUN mkdir -p /home/vscode/android-sdk/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdline-tools.zip && \
    unzip -q /tmp/cmdline-tools.zip -d /home/vscode/android-sdk/cmdline-tools && \
    mv /home/vscode/android-sdk/cmdline-tools/cmdline-tools /home/vscode/android-sdk/cmdline-tools/latest && \
    rm /tmp/cmdline-tools.zip && \
    yes | /home/vscode/android-sdk/cmdline-tools/latest/bin/sdkmanager --licenses > /dev/null

RUN /home/vscode/android-sdk/cmdline-tools/latest/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-34" \
    "build-tools;34.0.0"

# Add Flutter to PATH
ENV PATH="/home/vscode/flutter/bin:$PATH"

WORKDIR /workspaces/breakeven_calc
