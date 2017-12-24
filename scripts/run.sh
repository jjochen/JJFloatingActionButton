#!/usr/bin/env bash

set -e

function fancy_echo
{
  echo ""
  echo $1
}

function usage
{
cat << EOF
usage:
    $0 tests [destination]  Run tests for given destination
    $0 release [version]   Release new version
    $0 documentation       Build documentation
    $0 help                Print this help
EOF
}

function run_action
{
  action=$1; shift
  case ${action} in
  tests)
    run_tests $*
    ;;
  release)
    release_version $*
    ;;
  documentation)
    build_documentation
    ;;
  *)
    usage
    exit
    ;;
  esac 
}

function run_tests
{
  destination=$*
  if [[ -z ${destination} ]]
  then
    fancy_echo "ERROR: Destination has to be specified"
    usage
    exit 1
  fi

  fancy_echo "Run Tests (${destination})"
  
  xcodebuild -version
  xcodebuild -showsdks
  instruments -s devices

  xcodebuild clean build test \
    -workspace Example/JJFloatingActionButton.xcworkspace \
    -scheme JJFloatingActionButton_Example \
    -sdk iphonesimulator \
    -destination "${destination}" \
    -enableCodeCoverage YES \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGN_IDENTITY= \
    PROVISIONING_PROFILE=
}

function release_version
{
  version=$*
  if [[ -z ${version} ]]
  then
    fancy_echo "ERROR: Version number has to be specified"
    usage
    exit 1
  fi
  
  fancy_echo "Release Version (${version})"

  update_podspec
  update_change_log
  install_example_pods
  update_example_version
  build_documentation
}

function build_documentation
{
  fancy_echo "Build Documentation"
  bundle exec jazzy --podspec JJFloatingActionButton.podspec
}

function update_change_log
{
  fancy_echo "Update Change Log"
  github_changelog_generator --future-release ${version}
}

function update_podspec
{
  fancy_echo "Update Pod Spec"
  sed -i "" -e "s/\(spec\.version.*\)'.*'/\1'${version}'/" JJFloatingActionButton.podspec
}

function install_example_pods
{
  fancy_echo "Install cocoapods in Example"
  bundle exec pod install --project-directory=Example
}

function update_example_version
{
  fancy_echo "Update Version in Example"
  /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${version}" Example/JJFloatingActionButton/Info.plist
}

run_action $*
