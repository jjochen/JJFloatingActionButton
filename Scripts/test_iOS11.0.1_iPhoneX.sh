#!/bin/sh

xcodebuild -version

xcodebuild -showsdks

xcodebuild clean build test  \
  workspace "Example/JJFloatingActionButton.xcworkspace" \
  -scheme "JJFloatingActionButton_Example" \
  -sdk iphonesimulator \
  -destination "OS=11.0.1,name=iPhone X" \
  -configuration Debug \
  -enableCodeCoverage YES \
  ONLY_ACTIVE_ARCH=YES \
  ENABLE_TESTABILITY=YES \
  CODE_SIGNING_REQUIRED=NO
