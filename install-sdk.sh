#!/bin/sh

# Install SDK
wget "http://dl.google.com/android/android-sdk_r${sdk_version}-linux.tgz"
tar zxf "android-sdk_r${sdk_version}-linux.tgz"
rm "android-sdk_r${sdk_version}-linux.tgz"

# Set environment variables
export ANDROID_HOME=${PWD}/android-sdk-linux
export ANDROID_BUILD_TOOLS="22.0.1"
export ANDROID_VERSION="4.4.2"
export ANDROID_PLATFORM_TOOLS="22.0.1"
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

type android || { echo "Path: $PATH"; echo 'Android not available after installation, terminating.'; exit 1; }

# Write environment variables to profile
echo "export ANDROID_HOME=\"${ANDROID_HOME}\"" | sudo tee -a /etc/profile.d/android.sh
echo "export ANDROID_SDK_VERSION=\"${sdk_version}\"" | sudo tee -a /etc/profile.d/android.sh
echo "export ANDROID_BUILD_TOOLS=\"${ANDROID_BUILD_TOOLS}\"" | sudo tee -a /etc/profile.d/android.sh
echo "export ANDROID_PLATFORM_TOOLS=\"${ANDROID_PLATFORM_TOOLS}\"" | sudo tee -a /etc/profile.d/android.sh
echo "export ANDROID_VERSION=\"${ANDROID_VERSION}\"" | sudo tee -a /etc/profile.d/android.sh
echo "export PATH=\"${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools\"" | sudo tee -a /etc/profile.d/android.sh

# Install android components
(while :
do
  echo 'y'
  sleep 2
done) | android update sdk -u -a -t 5,23,114,116
