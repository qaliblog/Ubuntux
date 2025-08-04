#!/bin/bash

echo "=== Checking NDK Structure ==="
NDK_BASE="/data/data/com.termux/files/home/android-sdk/ndk"

echo "Available NDK versions:"
ls -la $NDK_BASE/

echo ""
echo "=== Checking NDK 25.2.9519653 structure ==="
NDK_PATH="$NDK_BASE/25.2.9519653"
if [ -d "$NDK_PATH" ]; then
    echo "NDK directory exists: $NDK_PATH"
    echo "Contents:"
    ls -la "$NDK_PATH/"
    
    echo ""
    echo "=== Looking for ndk-build ==="
    find "$NDK_PATH" -name "ndk-build" 2>/dev/null || echo "ndk-build not found"
    
    echo ""
    echo "=== Looking for build directory ==="
    find "$NDK_PATH" -name "build" -type d 2>/dev/null || echo "build directory not found"
    
    echo ""
    echo "=== Checking for alternative build scripts ==="
    find "$NDK_PATH" -name "*build*" -type f 2>/dev/null | head -10 || echo "No build scripts found"
    
    echo ""
    echo "=== Checking for toolchains ==="
    ls -la "$NDK_PATH/toolchains/" 2>/dev/null || echo "toolchains directory not found"
    
else
    echo "NDK directory does not exist: $NDK_PATH"
fi

echo ""
echo "=== Checking NDK 23.1.7779620 structure ==="
NDK_PATH="$NDK_BASE/23.1.7779620"
if [ -d "$NDK_PATH" ]; then
    echo "NDK directory exists: $NDK_PATH"
    echo "Looking for ndk-build:"
    find "$NDK_PATH" -name "ndk-build" 2>/dev/null || echo "ndk-build not found"
else
    echo "NDK directory does not exist: $NDK_PATH"
fi