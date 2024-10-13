#!/bin/bash

# Install Flutter
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Check if Flutter is installed correctly
flutter --version

# Get dependencies and build the web application
flutter pub get
flutter build web
