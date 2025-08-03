#!/bin/bash

echo "=== UbuntuX Setup Verification ==="
echo ""

# Check if Ubuntu rootfs exists
echo "🔍 Checking Ubuntu ARM64 rootfs..."
if [ -f "app/src/main/assets/ubuntu-base-22.04-base-arm64.tar.gz" ]; then
    size=$(du -h app/src/main/assets/ubuntu-base-22.04-base-arm64.tar.gz | cut -f1)
    echo "✅ Ubuntu rootfs found: $size"
else
    echo "❌ Ubuntu rootfs not found at app/src/main/assets/ubuntu-base-22.04-base-arm64.tar.gz"
fi

echo ""
echo "🔍 Checking package name configuration..."
if grep -q "com.qali.ubuntux" app/build.gradle; then
    echo "✅ Package name correctly set to com.qali.ubuntux"
else
    echo "❌ Package name not configured correctly"
fi

echo ""
echo "🔍 Checking app name configuration..."
if grep -q "UbuntuX" app/src/main/res/values/strings.xml; then
    echo "✅ App name correctly set to UbuntuX"
else
    echo "❌ App name not configured correctly"
fi

echo ""
echo "🔍 Checking ubuntu-arm64 package variant..."
if grep -q "ubuntu-arm64" app/build.gradle; then
    echo "✅ Ubuntu ARM64 package variant configured"
else
    echo "❌ Ubuntu ARM64 package variant not found"
fi

echo ""
echo "🔍 Checking Android SDK setup..."
if [ -n "$ANDROID_HOME" ] && [ -d "$ANDROID_HOME" ]; then
    echo "✅ ANDROID_HOME is set: $ANDROID_HOME"
    
    if [ -f "$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager" ]; then
        echo "✅ SDK Manager found"
    else
        echo "⚠️  SDK Manager not found in expected location"
    fi
    
    if [ -d "$ANDROID_HOME/ndk" ]; then
        ndk_versions=$(ls -1 $ANDROID_HOME/ndk/ 2>/dev/null | wc -l)
        echo "✅ NDK directory found with $ndk_versions version(s)"
    else
        echo "⚠️  NDK directory not found"
    fi
else
    echo "❌ ANDROID_HOME not set or directory doesn't exist"
    echo "    Please follow the Android SDK setup instructions"
fi

echo ""
echo "📱 Build Instructions:"
echo "1. Install Android SDK and NDK (see setup instructions above)"
echo "2. Update local.properties with your Android SDK path"
echo "3. Run: ./gradlew assembleDebug"
echo ""
echo "🚀 Your UbuntuX app with custom Ubuntu ARM64 rootfs is ready to build!"