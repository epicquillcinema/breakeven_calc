FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install dependencies for Flutter, Android, web, and Linux development
RUN apt-get update && apt-get install -y \
    clang \
    curl \
    git \
    git-lfs \
    gh \
    cmake \
    gnupg \
    libgtk-3-dev \
    liblzma-dev \
    unzip \
    wget \
    ninja-build \
    openjdk-17-jdk \
    pkg-config \
    lib32stdc++6 \
    lib32z1 \
    && rm -rf /var/lib/apt/lists/*

# Install Google Chrome for Flutter web support
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | \
    gpg --dearmor -o /usr/share/keyrings/google-linux-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# Install Flutter and Android SDK as vscode user
USER vscode
WORKDIR /home/vscode

RUN git clone https://github.com/flutter/flutter.git -b stable && \
    /home/vscode/flutter/bin/flutter --version && \
    /home/vscode/flutter/bin/flutter config --no-analytics

ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
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
    "platforms;android-36" \
    "build-tools;36.0.0" \
    "build-tools;28.0.3"

# Add Flutter to PATH
ENV PATH="/home/vscode/flutter/bin:$PATH"

WORKDIR /workspaces/breakeven_calc
