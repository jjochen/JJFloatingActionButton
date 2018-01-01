#!/usr/bin/env bash

#
#  Copyright (c) 2017-Present Jochen Pfeiffer
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
#


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
    $0 release [version]    Release new version
    $0 documentation        Build documentation
    $0 video                Record video
    $0 help                 Print this help
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
  video)
    record_video
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

  ensure_git_status_clean
  update_podspec
  update_change_log
  install_example_pods
  update_example_version
  build_documentation
  commit_to_release_branch
  create_pull_request
}

function build_documentation
{
  fancy_echo "Build Documentation"
  bundle exec jazzy
}

function update_change_log
{
  fancy_echo "Update Change Log"
  github_changelog_generator --future-release ${version}
}

function ensure_git_status_clean
{
  fancy_echo "Ensure git status clean"
  if test -n "$(git status --porcelain)"
  then 
    echo "Uncommited changes. Commit first."
    git status
    exit 1
  else 
    echo "Clean"
  fi
}

function commit_to_release_branch
{
  fancy_echo "Commit to release branch"
  release_branch="release/${version}"
  git checkout -b ${release_branch}
  git add --all
  git commit -v -m "Release ${version}"
  git push --set-upstream origin ${release_branch}
}

function create_pull_request
{
  fancy_echo "Create Pull Request"
  open "https://github.com/jjochen/JJFloatingActionButton/compare/release%2F${version}?expand=1"
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

function record_video
{
  fancy_echo "Record video"
  
  mov_path="./Images/JJFloatingActionButton.mov"
  gif_path="./Images/JJFloatingActionButton.gif"
  
  xcrun simctl io booted recordVideo $mov_path

  fancy_echo "Create gif"
  
  palette="./Images/palette.png"
  filters="fps=30,setpts=1*PTS,scale=250:-1:flags=lanczos"

  ffmpeg -v warning -i $mov_path -vf "$filters,palettegen" -y $palette
  if [[ -f $palette ]]; then
    ffmpeg -v warning -i $mov_path -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $gif_path
    rm $palette
  fi
}


run_action $*
