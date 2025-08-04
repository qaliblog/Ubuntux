#!/bin/bash

echo "=== NDK Debug Information ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "HOME: $HOME"

echo ""
echo "=== Checking Android SDK locations ==="
echo "Checking $HOME/android-sdk:"
ls -la $HOME/android-sdk/ 2>/dev/null || echo "Not found"

echo ""
echo "Checking /data/data/com.termux/files/home/android-sdk:"
ls -la /data/data/com.termux/files/home/android-sdk/ 2>/dev/null || echo "Not found"

echo ""
echo "=== Checking NDK installations ==="
echo "Checking $HOME/android-sdk/ndk:"
ls -la $HOME/android-sdk/ndk/ 2>/dev/null || echo "Not found"

echo ""
echo "Checking /data/data/com.termux/files/home/android-sdk/ndk:"
ls -la /data/data/com.termux/files/home/android-sdk/ndk/ 2>/dev/null || echo "Not found"

echo ""
echo "=== Checking for ndk-build in PATH ==="
which ndk-build 2>/dev/null || echo "ndk-build not found in PATH"

echo ""
echo "=== Checking for NDK in system locations ==="
find /usr -name "ndk-build" 2>/dev/null | head -5 || echo "No ndk-build found in /usr"
find /data -name "ndk-build" 2>/dev/null | head -5 || echo "No ndk-build found in /data"

echo ""
echo "=== Checking Android SDK Manager ==="
which sdkmanager 2>/dev/null || echo "sdkmanager not found"

echo ""
echo "=== Available NDK versions via sdkmanager ==="
sdkmanager --list | grep ndk 2>/dev/null || echo "No NDK versions found via sdkmanager"