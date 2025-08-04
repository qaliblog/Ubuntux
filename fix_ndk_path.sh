#!/bin/bash

echo "=== Fixing NDK Path and Permissions ==="

# Set the correct NDK path
NDK_PATH="/data/data/com.termux/files/home/android-sdk/ndk/25.2.9519653"
NDK_BUILD="$NDK_PATH/ndk-build"
NDK_BUILD_BUILD="$NDK_PATH/build/ndk-build"

echo "NDK Path: $NDK_PATH"
echo "NDK Build (root): $NDK_BUILD"
echo "NDK Build (build dir): $NDK_BUILD_BUILD"

# Check if ndk-build exists and is executable
if [ -f "$NDK_BUILD" ]; then
    echo "✅ ndk-build found in root directory"
    ls -la "$NDK_BUILD"
else
    echo "❌ ndk-build not found in root directory"
fi

if [ -f "$NDK_BUILD_BUILD" ]; then
    echo "✅ ndk-build found in build directory"
    ls -la "$NDK_BUILD_BUILD"
else
    echo "❌ ndk-build not found in build directory"
fi

# Make sure ndk-build is executable
echo ""
echo "=== Making ndk-build executable ==="
if [ -f "$NDK_BUILD" ]; then
    chmod +x "$NDK_BUILD"
    echo "Made $NDK_BUILD executable"
fi

if [ -f "$NDK_BUILD_BUILD" ]; then
    chmod +x "$NDK_BUILD_BUILD"
    echo "Made $NDK_BUILD_BUILD executable"
fi

# Test if ndk-build can be executed
echo ""
echo "=== Testing ndk-build execution ==="
if [ -f "$NDK_BUILD" ] && [ -x "$NDK_BUILD" ]; then
    echo "Testing $NDK_BUILD --version:"
    "$NDK_BUILD" --version 2>&1 | head -3 || echo "Failed to execute ndk-build"
else
    echo "ndk-build not executable at $NDK_BUILD"
fi

if [ -f "$NDK_BUILD_BUILD" ] && [ -x "$NDK_BUILD_BUILD" ]; then
    echo "Testing $NDK_BUILD_BUILD --version:"
    "$NDK_BUILD_BUILD" --version 2>&1 | head -3 || echo "Failed to execute build/ndk-build"
else
    echo "ndk-build not executable at $NDK_BUILD_BUILD"
fi

# Create a symlink to make ndk-build accessible from PATH
echo ""
echo "=== Creating symlink for ndk-build ==="
LOCAL_BIN="$HOME/.local/bin"
mkdir -p "$LOCAL_BIN"

if [ -f "$NDK_BUILD" ]; then
    ln -sf "$NDK_BUILD" "$LOCAL_BIN/ndk-build"
    echo "Created symlink: $LOCAL_BIN/ndk-build -> $NDK_BUILD"
elif [ -f "$NDK_BUILD_BUILD" ]; then
    ln -sf "$NDK_BUILD_BUILD" "$LOCAL_BIN/ndk-build"
    echo "Created symlink: $LOCAL_BIN/ndk-build -> $NDK_BUILD_BUILD"
else
    echo "No ndk-build found to create symlink"
fi

# Add to PATH if not already there
if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >> "$HOME/.bashrc"
    echo "Added $LOCAL_BIN to PATH in .bashrc"
    export PATH="$LOCAL_BIN:$PATH"
    echo "Added $LOCAL_BIN to current PATH"
fi

echo ""
echo "=== Final check ==="
which ndk-build 2>/dev/null || echo "ndk-build still not found in PATH"