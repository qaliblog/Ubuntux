#!/bin/bash

echo "=== Fixing NDK Build Wrapper Script ==="

# Set the correct NDK path for Termux
NDK_PATH="/data/data/com.termux/files/home/android-sdk/ndk/25.2.9519653"
NDK_BUILD_WRAPPER="$NDK_PATH/ndk-build"
NDK_BUILD_ACTUAL="$NDK_PATH/build/ndk-build"

echo "NDK Path: $NDK_PATH"
echo "NDK Build Wrapper: $NDK_BUILD_WRAPPER"
echo "NDK Build Actual: $NDK_BUILD_ACTUAL"

# Check what's in the wrapper script
echo ""
echo "=== Checking wrapper script content ==="
if [ -f "$NDK_BUILD_WRAPPER" ]; then
    echo "Wrapper script exists, content:"
    cat "$NDK_BUILD_WRAPPER"
    echo ""
else
    echo "Wrapper script not found"
fi

# Check if the actual ndk-build exists
echo ""
echo "=== Checking actual ndk-build ==="
if [ -f "$NDK_BUILD_ACTUAL" ]; then
    echo "Actual ndk-build exists"
    ls -la "$NDK_BUILD_ACTUAL"
else
    echo "Actual ndk-build not found"
fi

# Try to find ndk-build in the build directory
echo ""
echo "=== Searching for ndk-build in build directory ==="
find "$NDK_PATH/build" -name "ndk-build" 2>/dev/null || echo "No ndk-build found in build directory"

# Check if we need to create a proper wrapper
echo ""
echo "=== Creating proper ndk-build wrapper ==="
if [ -f "$NDK_BUILD_ACTUAL" ]; then
    # Create a proper wrapper that points to the actual script
    cat > "$NDK_BUILD_WRAPPER" << 'EOF'
#!/bin/bash
# NDK Build wrapper script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/build/ndk-build" "$@"
EOF
    chmod +x "$NDK_BUILD_WRAPPER"
    echo "Created proper wrapper script"
    echo "New wrapper content:"
    cat "$NDK_BUILD_WRAPPER"
else
    echo "Cannot create wrapper - actual ndk-build not found"
fi

# Test the ndk-build script
echo ""
echo "=== Testing ndk-build ==="
if [ -f "$NDK_BUILD_WRAPPER" ] && [ -x "$NDK_BUILD_WRAPPER" ]; then
    echo "Testing wrapper script:"
    "$NDK_BUILD_WRAPPER" --version 2>&1 | head -3 || echo "Wrapper script failed"
else
    echo "Wrapper script not executable"
fi

# Alternative: try using an older NDK version
echo ""
echo "=== Checking alternative NDK versions ==="
for version in "23.1.7779620" "25.1.8937393"; do
    alt_ndk="$NDK_PATH/../$version"
    alt_build="$alt_ndk/build/ndk-build"
    echo "Checking $version:"
    if [ -f "$alt_build" ]; then
        echo "  ✅ Found ndk-build in $version"
        ls -la "$alt_build"
    else
        echo "  ❌ No ndk-build in $version"
    fi
done

echo ""
echo "=== Recommendation ==="
echo "If the above doesn't work, try using NDK version 23.1.7779620 instead:"
echo "Update gradle.properties: ndkVersion=23.1.7779620"