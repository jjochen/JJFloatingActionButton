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
usage: $0 options

OPTIONS:
    -h      Show this message
    -v      Version
EOF
}

function check_arguments
{    
    while getopts "hv:" OPTION
    do
        case ${OPTION} in
            h)
                usage
                exit
                ;;
            v)
                version=${OPTARG}
                echo "Version number: ${version}"
                ;;
            ?)
                usage
                exit
                ;;
        esac
    done

    if [[ -z ${version} ]]
    then
        fancy_echo "ERROR: Version number (-v) has to be specified"
        usage
        exit 1
    fi
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
    # sed -i -E "s/\(spec\.version\s*=\s*\)'.*'/\1'${version}'/" JJFloatingActionButton.podspec
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


check_arguments $*
update_podspec
update_change_log
install_example_pods
update_example_version

