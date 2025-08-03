# UbuntuX - Custom Ubuntu ARM64 Terminal App

UbuntuX is a customized terminal emulator app based on Termux that runs a full Ubuntu 22.04 ARM64 environment on Android devices.

## 🚀 Key Features

- **Custom Package Name**: `com.qali.ubuntux` (independent from Termux)
- **Ubuntu ARM64 Rootfs**: Full Ubuntu 22.04 base system (~27MB)
- **Native Ubuntu Environment**: Complete Ubuntu userland experience
- **ARM64 Optimized**: Specifically designed for ARM64 Android devices
- **Independent Installation**: Can coexist with Termux installations

## 📋 Prerequisites

### System Requirements
- Android 7.0+ (API level 21+)
- ARM64 (aarch64) device
- At least 2GB free storage space

### Development Requirements
- Android SDK API level 34
- Android NDK 25.1.8937393 (or latest)
- Java 11+ or OpenJDK
- Gradle 8.4+

## 🛠️ Android SDK Setup

1. **Download Android SDK Command Line Tools**
   ```bash
   mkdir -p ~/android-sdk/cmdline-tools
   cd ~/android-sdk/cmdline-tools
   wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
   unzip commandlinetools-linux-9477386_latest.zip
   mv cmdline-tools latest
   ```

2. **Set Environment Variables**
   ```bash
   export ANDROID_HOME=~/android-sdk
   export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools
   ```

3. **Install SDK Components**
   ```bash
   sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
   sdkmanager "ndk;25.1.8937393"
   ```

4. **Update local.properties**
   ```bash
   echo "sdk.dir=$HOME/android-sdk" > local.properties
   ```

## 🔧 Building UbuntuX

1. **Verify Setup**
   ```bash
   ./verify_ubuntu_setup.sh
   ```

2. **Build Debug APK**
   ```bash
   ./gradlew assembleDebug
   ```

3. **Build Release APK**
   ```bash
   ./gradlew assembleRelease
   ```

## 📦 What's Different from Termux

### Package Structure
- **Package Name**: Changed from `com.termux` to `com.qali.ubuntux`
- **App Name**: "UbuntuX" instead of "Termux"
- **Data Directory**: `/data/data/com.qali.ubuntux/files/usr`

### Root Filesystem
- **Base System**: Ubuntu 22.04 LTS ARM64
- **Package Manager**: APT (Ubuntu repositories)
- **Init System**: Ubuntu-style initialization
- **Default Shell**: Bash with Ubuntu configurations

### Installation Process
The app automatically extracts and sets up the Ubuntu rootfs on first launch:
1. Extracts `ubuntu-base-22.04-base-arm64.tar.gz` from assets
2. Sets up Ubuntu directory structure
3. Configures package manager and repositories
4. Initializes Ubuntu environment

## 🎯 Target Use Cases

- **Development Environment**: Full Ubuntu development stack on mobile
- **Server Administration**: Ubuntu tools and utilities
- **Learning Platform**: Native Ubuntu experience for education
- **Container Alternative**: Lightweight Ubuntu environment

## 🔍 Verification

Run the verification script to check your setup:
```bash
./verify_ubuntu_setup.sh
```

This checks:
- ✅ Ubuntu rootfs presence (27MB)
- ✅ Package name configuration
- ✅ App branding
- ✅ Ubuntu ARM64 variant setup
- ✅ Android SDK installation

## 📱 Installation on Device

1. **Enable Developer Options** on your Android device
2. **Enable USB Debugging**
3. **Install via ADB**:
   ```bash
   adb install app/build/outputs/apk/debug/ubuntux-app_ubuntu-arm64-debug_universal.apk
   ```

## 🐛 Troubleshooting

### Build Errors
- **NDK not found**: Install NDK with `sdkmanager "ndk;25.1.8937393"`
- **SDK not found**: Update `local.properties` with correct SDK path
- **Gradle errors**: Clean and rebuild with `./gradlew clean assembleDebug`

### Runtime Issues
- **App crashes on startup**: Check device architecture (ARM64 required)
- **Ubuntu packages not working**: Verify rootfs extraction completed
- **Permission errors**: Check app permissions in Android settings

## 📄 License

This project maintains the same license as the original Termux project. See LICENSE.md for details.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Test thoroughly on ARM64 devices
4. Submit pull request with detailed description

## 📞 Support

For Ubuntu-specific issues, check:
- Ubuntu ARM64 compatibility
- Package availability in ARM64 repositories
- Device-specific ARM64 limitations

---

**Note**: This is a custom build focused on Ubuntu ARM64 environments. For general Android terminal usage, consider the original Termux project.