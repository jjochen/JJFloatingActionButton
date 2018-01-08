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

#-- Bootstrap ----------------------------------------------------------------#

desc 'Initialize your working copy'
task :bootstrap do
  check_executable('bundler')
  install_gems
  install_cocoapods
end


begin
  require 'fileutils'

  task default: :test


  #-- Tests ------------------------------------------------------------------#

  desc 'Run tests'
  task :test do
    xcodebuild_test "platform=iOS Simulator,name=iPhone X"
  end
  
  desc 'Run tests for DESTINATION env'
  task :test_destination do
    Rake::Task[:print_debug_info].invoke
    xcodebuild_test ENV['DESTINATION']
  end
  
  desc 'Print debug info'
  task :print_debug_info do
    title 'Debug info'
    sh 'xcodebuild -version'
    sh 'xcodebuild -showsdks'
    sh 'instruments -s devices'
  end

  desc 'Lint swift'
  task :lint_swift do
    title 'Linting swift'
    check_executable('swiftlint')
    sh "swiftlint"
  end
  
  desc 'Lint podspec'
  task :lint_podspec do
    title 'Linting podspec'
    sh "bundle exec pod lib lint"
  end


  #-- Format -----------------------------------------------------------------#

  desc 'Format code'
  task :format do
    title 'Formating code'
    check_executable('swiftformat')
    sh "swiftformat Example/Tests Example/JJFloatingActionButton Sources"
  end

  desc 'Format and lint code'
  task :format_and_lint do
    Rake::Task[:format].invoke
    Rake::Task[:lint_swift].invoke
  end


  #-- Dependencies -----------------------------------------------------------#

  desc 'Install dependencies'
  task :install_dependencies do
    install_gems
    install_cocoapods
  end

  desc 'Update dependencies'
  task :update_dependencies do
    update_gems
    update_cocoapods
  end
  
  
  #-- Documentation ----------------------------------------------------------#

  desc 'Build documentation'
  task :build_documentation do
    generate_documentation
    test_documentation_coverage
  end

  desc 'Test documentation coverage'
  task :test_documentation_coverage do
    test_documentation_coverage
  end


  #-- Changelog --------------------------------------------------------------#

  desc 'Generate changelog'
  task :generate_changelog do
    generate_changelog ""
  end


  #-- Record Video -----------------------------------------------------------#
  
  desc 'Record video booted simulator and convert to gif'
  task :record_gif do
    title 'Recording video'
    check_executable('ffmpeg')

    mov_path='./Images/JJFloatingActionButton.mov'
    
    trap('SIGINT') { puts }
    %x{xcrun simctl io booted recordVideo #{mov_path}}
  
    title 'Convert to gif'
    
    gif_path='./Images/JJFloatingActionButton.gif'
    palette_path='./Images/palette.png'
    filters='fps=30,setpts=1*PTS,scale=250:-1:flags=lanczos'

    sh "ffmpeg -v warning -i #{mov_path} -vf '#{filters},palettegen' -y #{palette_path}"
    if File.exist? palette_path
      sh "ffmpeg -v warning -i #{mov_path} -i #{palette_path} -lavfi '#{filters} [x]; [x][1:v] paletteuse' -y #{gif_path}"
      File.delete palette_path
    end
  end
  
  
  #-- Release ----------------------------------------------------------------#

  desc 'Release version'
  task :release_version, :version do |task, args|
    ensure_clean_git_status
    update_version_in_podspec args.version
    update_version_in_example_project args.version
    generate_changelog args.version
    install_cocoapods
    generate_documentation
    create_release_branch_and_commit args.version
    open_pull_request args.version
  end
  
  desc 'Push podspec'
  task :push_podspec do
    title "Pushing podspec"
    sh 'bundle exec pod trunk push'
  end

rescue LoadError, NameError => e
  error_message 'Some Rake tasks haven been disabled because the environment' \
    ' couldn’t be loaded. Be sure to run `rake bootstrap` first.'
  $stderr.puts e.message
  $stderr.puts e.backtrace
  $stderr.puts
end


#-- Helpers ------------------------------------------------------------------#

private

def title(title)
  cyan_title = "\033[0;36m#{title}\033[0m"
  puts
  puts '-' * 80
  puts cyan_title
  puts '-' * 80
  puts
end

def error_message(message)
  red_message = "\033[0;31m[!] #{message}\e[0m"
  $stderr.puts
  $stderr.puts red_message
  $stderr.puts
end

def check_executable(executable)
  unless system("which #{executable}")
    error_message "Please install '#{executable}' manually."
    exit 1
  end
end

def check_parameter(parameter)
  if parameter.nil? || parameter.empty?
    error_message "parameter can't be empty."
    exit 1
  end
end

def install_gems
  title 'Installing gems'
  sh 'bundle install'
end

def install_cocoapods
  title 'Installing cocoapods'
  sh 'bundle exec pod install --project-directory=Example'
end

def update_gems
  title 'Updating gems'
  sh 'bundle update'
end

def update_cocoapods
  title 'Updating cocoapods'
  sh 'bundle exec pod update --project-directory=Example'
end

def xcodebuild_test(destination)
  title 'Running tests'
  check_parameter(destination)
  sh "xcodebuild clean build test" \
    "  -workspace Example/JJFloatingActionButton.xcworkspace" \
    "  -scheme JJFloatingActionButton_Example" \
    "  -sdk iphonesimulator" \
    "  -destination \"#{destination}\"" \
    "  -enableCodeCoverage YES" \
    "  CODE_SIGNING_REQUIRED=NO" \
    "  CODE_SIGN_IDENTITY=" \
    "  PROVISIONING_PROFILE=" \
    " | xcpretty --report junit && exit ${PIPESTATUS[0]}"
end

def ensure_clean_git_status
  title "Ensuring clean git status"
  unless `git diff --shortstat 2> /dev/null | tail -n1` == ''
    error_message "Uncommited changes. Commit first."
    exit 1
  end
end

def update_version_in_example_project(version)
  title "Updating version in example project"
  check_parameter(version)
  sh "/usr/libexec/PlistBuddy -c \"Set :CFBundleShortVersionString #{version}\" ./Example/JJFloatingActionButton/Info.plist"
end

def generate_changelog(version)
  title "Generating changelog"
  unless version.nil? || version.empty?
    sh "github_changelog_generator --future-release #{version}"
  else
    sh "github_changelog_generator"
  end  
end

def generate_documentation
  title 'Generating documentation'
  sh 'bundle exec jazzy'
end

def test_documentation_coverage
  title 'Checking documentation coverage'
  file_path = './docs/index.html'
  search_string = '100% documented'
  if File.foreach(file_path).grep(/#{Regexp.escape(search_string)}/).any?
    puts "'#{search_string}' found in #{file_path}"
    else
    error_message "'#{search_string}' not found in #{file_path}"
    exit 1
  end
end

def update_version_in_podspec(version)
  title "Updating version in podspec"
  check_parameter(version)
  file_name = 'JJFloatingActionButton.podspec'
  contents = File.read(file_name)
  new_contents = contents.gsub(/(spec\.version\s*=\s*)'.*'/, "\\1'#{version}'")
  puts new_contents
  File.open(file_name, "w") {|file| file.puts new_contents }
end

def create_release_branch_and_commit(version)
  title "Creating release branch and commit"
  check_parameter(version)
  release_branch = "release/#{version}"
  sh "git checkout -b #{release_branch}"
  sh "git add --all"
  sh "git commit -v -m 'Release #{version}'"
  sh "git push --set-upstream origin #{release_branch}"
end

def open_pull_request(version)
  title "Opening pull request"
  check_parameter(version)
  sh "open 'https://github.com/jjochen/JJFloatingActionButton/compare/release%2F#{version}?expand=1'"
end

