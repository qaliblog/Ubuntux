#!/bin/bash

# Set up environment variables for build
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

# Verify Java installation
if [ ! -d "$JAVA_HOME" ]; then
    echo "ERROR: JAVA_HOME directory does not exist: $JAVA_HOME"
    echo "Available Java installations:"
    ls -la /usr/lib/jvm/ 2>/dev/null || echo "No Java installations found in /usr/lib/jvm/"
    exit 1
fi

# Verify Android SDK
if [ ! -d "$ANDROID_HOME" ]; then
    echo "ERROR: ANDROID_HOME directory does not exist: $ANDROID_HOME"
    exit 1
fi

# Verify NDK
if [ ! -d "$ANDROID_HOME/ndk/21.4.7075529" ]; then
    echo "ERROR: NDK directory does not exist: $ANDROID_HOME/ndk/21.4.7075529"
    echo "Available NDK versions:"
    ls -la $ANDROID_HOME/ndk/ 2>/dev/null || echo "No NDK installations found"
    exit 1
fi

echo "Environment setup:"
echo "JAVA_HOME: $JAVA_HOME"
echo "ANDROID_HOME: $ANDROID_HOME"
echo "Java version: $(java -version 2>&1 | head -1)"

# Run the build
echo "Starting build..."
bash gradlew assembleDebug "$@"