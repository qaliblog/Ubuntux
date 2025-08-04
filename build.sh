#!/bin/bash

echo "=== Build Environment Detection ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "HOME: $HOME"

# Auto-detect Java installation
echo "Detecting Java installation..."
JAVA_PATH=$(which java 2>/dev/null)
if [ -n "$JAVA_PATH" ]; then
    echo "Java found at: $JAVA_PATH"
    # Get the directory containing java binary
    JAVA_BIN_DIR=$(dirname "$JAVA_PATH")
    # Get the parent directory (should be the Java installation root)
    JAVA_HOME=$(dirname "$JAVA_BIN_DIR")
    echo "Detected JAVA_HOME: $JAVA_HOME"
else
    echo "ERROR: Java not found in PATH"
    echo "PATH: $PATH"
    exit 1
fi

# Set up environment variables for build
export JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools

echo "=== Environment Verification ==="

# Verify Java installation
echo "Verifying Java installation..."
if [ ! -d "$JAVA_HOME" ]; then
    echo "ERROR: JAVA_HOME directory does not exist: $JAVA_HOME"
    echo "Java binary location: $JAVA_PATH"
    echo "Available Java installations:"
    ls -la /usr/lib/jvm/ 2>/dev/null || echo "No Java installations found in /usr/lib/jvm/"
    ls -la /data/data/com.termux/files/usr/lib/jvm/ 2>/dev/null || echo "No Java installations found in Termux path"
    exit 1
fi

# Verify Android SDK
echo "Verifying Android SDK..."
if [ ! -d "$ANDROID_HOME" ]; then
    echo "ERROR: ANDROID_HOME directory does not exist: $ANDROID_HOME"
    exit 1
fi

# Verify NDK
echo "Verifying NDK..."
if [ ! -d "$ANDROID_HOME/ndk/21.4.7075529" ]; then
    echo "ERROR: NDK directory does not exist: $ANDROID_HOME/ndk/21.4.7075529"
    echo "Available NDK versions:"
    ls -la $ANDROID_HOME/ndk/ 2>/dev/null || echo "No NDK installations found"
    exit 1
fi

echo "=== Final Environment Setup ==="
echo "JAVA_HOME: $JAVA_HOME"
echo "ANDROID_HOME: $ANDROID_HOME"
echo "Java version: $(java -version 2>&1 | head -1)"

# Run the build
echo "=== Starting Build ==="
bash gradlew assembleDebug "$@"