# Termux Android App Build Instructions

This document explains how to build the Termux Android app with the updated configuration.

## Prerequisites

- Ubuntu/Debian Linux system
- Java 8 or higher
- Internet connection for downloading dependencies

## Quick Build

The easiest way to build the app is to use the provided build script:

```bash
./build.sh
```

This script will:
1. Set up the Android SDK environment
2. Install the required NDK (25.2.9519653)
3. Install build tools and platform tools
4. Run the Gradle build

## Manual Build Setup

If you prefer to set up the build environment manually:

### 1. Install Android SDK Command Line Tools

```bash
mkdir -p $HOME/android-sdk
cd $HOME/android-sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
unzip commandlinetools-linux-11076708_latest.zip
mkdir -p cmdline-tools/latest
mv cmdline-tools/bin cmdline-tools/lib cmdline-tools/source.properties cmdline-tools/NOTICE.txt cmdline-tools/latest/
```

### 2. Set Environment Variables

```bash
export ANDROID_HOME=$HOME/android-sdk
export ANDROID_SDK_ROOT=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
```

### 3. Accept Licenses

```bash
yes | sdkmanager --licenses
```

### 4. Install Required Components

```bash
# Install NDK
sdkmanager "ndk;25.2.9519653"

# Install build tools
sdkmanager "build-tools;33.0.2"

# Install platform tools
sdkmanager "platform-tools"

# Install Android platform
sdkmanager "platforms;android-33"
```

### 5. Build the App

```bash
cd /path/to/termux-app
./gradlew assembleDebug
```

## Configuration Changes Made

The following changes were made to fix the build issues:

### Updated Dependencies
- Android Gradle Plugin: 4.2.2 → 7.4.2
- Gradle: 7.2 → 7.6.1
- NDK: 22.1.7171670 → 25.2.9519653
- compileSdkVersion: 30 → 33
- targetSdkVersion: 28 → 33
- Updated all AndroidX dependencies to latest compatible versions

### Plugin Syntax Updates
- Updated all modules to use the new `plugins {}` block syntax
- Updated test instrumentation runner to use AndroidX

### Local Configuration
- Created `local.properties` file pointing to the Android SDK location
- Added build script for automated setup

## Troubleshooting

### NDK Build Issues
If you encounter NDK build issues:
1. Ensure the NDK is properly installed: `ls $ANDROID_HOME/ndk`
2. Check that the NDK version matches the one specified in `gradle.properties`
3. Verify that the Android SDK path is correct in `local.properties`

### Gradle Issues
If you encounter Gradle issues:
1. Clean the project: `./gradlew clean`
2. Delete the `.gradle` cache directory
3. Re-run the build

### Memory Issues
If you encounter memory issues during build:
1. Increase Gradle memory in `gradle.properties`:
   ```
   org.gradle.jvmargs=-Xmx4096M
   ```

## Build Output

The build will generate APK files in:
- `app/build/outputs/apk/debug/` - Debug APKs for each architecture
- `app/build/outputs/apk/release/` - Release APKs (if built)

The APK files will be named according to the pattern:
`termux-app_apt-android-7-debug_[architecture].apk`