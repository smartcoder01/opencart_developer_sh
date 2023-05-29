#!/bin/bash

# Create 'releases' directory if it doesn't exist
mkdir -p releases

# Set write permissions for 'releases' directory
chmod -R 777 releases

# Function to download OpenCart release
download_releases() {
  local RELEASE_NAME="$1"
  local DOWNLOAD_LINK="$2"
  local UNZIP_FOLDER="$3"

  mkdir -p "./releases/$RELEASE_NAME"

  ZIP_FILE="./releases/${RELEASE_NAME}_opencart.zip"
  if [ ! -f "$ZIP_FILE" ]; then
    wget -O "$ZIP_FILE" "$DOWNLOAD_LINK"
  fi

  unzip "$ZIP_FILE" -d "./releases/$RELEASE_NAME"
  cp -rf "./releases/$RELEASE_NAME/$UNZIP_FOLDER/"* "./releases/$RELEASE_NAME"

  # Rename config files
  mv "./releases/$RELEASE_NAME/config-dist.php" "./releases/$RELEASE_NAME/config.php"
  mv "./releases/$RELEASE_NAME/admin/config-dist.php" "./releases/$RELEASE_NAME/admin/config.php"
}

copy_releases() {
  local SOURCE_FOLDER="$1"
  local DESTINATION_FOLDER="$2"
  mkdir -p "./$DESTINATION_FOLDER"
  cp -rf "./releases/$SOURCE_FOLDER/"* "./$DESTINATION_FOLDER/"
}

# Download and install OpenCart releases
download_releases "1.5.6.4" "https://github.com/opencart/opencart/archive/refs/tags/1.5.6.4.zip" "opencart-1.5.6.4/upload"
download_releases "2.3.0.2" "https://github.com/opencart/opencart/releases/download/2.3.0.2/2.3.0.2-compiled.zip" "upload"
download_releases "3.0.3.8" "https://github.com/opencart/opencart/releases/download/3.0.3.8/opencart-3.0.3.8.zip" "upload"
download_releases "4.0.2.1" "https://github.com/opencart/opencart/releases/download/4.0.2.1/opencart-4.0.2.1.zip" "opencart-4.0.2.1/upload"
#

# Copy releases to developing
copy_releases "1.5.6.4" "dev15"
copy_releases "2.3.0.2" "dev23"
copy_releases "3.0.3.8" "dev30"
copy_releases "4.0.2.1" "dev40"

# Copy releases to demonstration
copy_releases "1.5.6.4" "demo15"
copy_releases "2.3.0.2" "demo23"
copy_releases "3.0.3.8" "demo30"
copy_releases "4.0.2.1" "demo40"