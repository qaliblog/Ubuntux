#!/bin/bash

echo "=== Direct NDK Build Fix ==="

# Set the correct NDK path for Termux
NDK_PATH="/data/data/com.termux/files/home/android-sdk/ndk/25.2.9519653"
NDK_BUILD_WRAPPER="$NDK_PATH/ndk-build"

echo "Fixing NDK wrapper at: $NDK_BUILD_WRAPPER"

# Create a proper wrapper script
cat > "$NDK_BUILD_WRAPPER" << 'EOF'
#!/bin/bash
# NDK Build wrapper script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/build/ndk-build" "$@"
EOF

chmod +x "$NDK_BUILD_WRAPPER"

echo "✅ Created new wrapper script"
echo "New wrapper content:"
cat "$NDK_BUILD_WRAPPER"

echo ""
echo "Testing ndk-build:"
"$NDK_BUILD_WRAPPER" --version 2>&1 | head -3 || echo "Test failed, but script was created"

echo ""
echo "🎯 Ready to try build again!"