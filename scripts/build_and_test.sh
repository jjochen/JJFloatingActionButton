#!/bin/sh

set -e

xcodebuild -version

xcodebuild -showsdks

instruments -s devices

xcodebuild clean build test \
  -workspace Example/JJFloatingActionButton.xcworkspace \
  -scheme JJFloatingActionButton_Example \
  -sdk iphonesimulator \
  -destination "$DESTINATION" \
  -enableCodeCoverage YES \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  PROVISIONING_PROFILE=
