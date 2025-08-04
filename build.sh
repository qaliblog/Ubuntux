#!/bin/bash

# Build script for Termux Android app
# This script sets up the environment and builds the app

set -e

echo "Setting up Android SDK environment..."

# Set Android SDK environment variables
export ANDROID_HOME=$HOME/android-sdk
export ANDROID_SDK_ROOT=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# Check if NDK is installed
if [ ! -d "$ANDROID_HOME/ndk" ]; then
    echo "NDK not found. Installing NDK..."
    yes | sdkmanager "ndk;22.1.7171670"
fi

# Check if build tools are installed
if [ ! -d "$ANDROID_HOME/build-tools" ]; then
    echo "Build tools not found. Installing build tools..."
    yes | sdkmanager "build-tools;33.0.2"
fi

# Check if platform tools are installed
if [ ! -d "$ANDROID_HOME/platform-tools" ]; then
    echo "Platform tools not found. Installing platform tools..."
    yes | sdkmanager "platform-tools"
fi

# Check if platform is installed
if [ ! -d "$ANDROID_HOME/platforms/android-33" ]; then
    echo "Android platform 33 not found. Installing platform..."
    yes | sdkmanager "platforms;android-33"
fi

echo "Environment setup complete."
echo "Building Termux app..."

# Run the build
./gradlew assembleDebug

echo "Build complete!"