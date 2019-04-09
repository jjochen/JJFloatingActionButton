Pod::Spec.new do |spec|
  spec.name     = 'JJFloatingActionButton'
  spec.version  = '2.0.0'
  spec.swift_version = '5.0'
  spec.author   = { 'Jochen Pfeiffer' => 'pod@jochen-pfeiffer.com' }
  spec.license  = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage = 'https://github.com/jjochen/JJFloatingActionButton'
  spec.source   = { :git => 'https://github.com/jjochen/JJFloatingActionButton.git', :tag => spec.version.to_s }
  spec.summary  = 'Floating Action Button for iOS'

  spec.screenshot        = 'https://raw.githubusercontent.com/jjochen/JJFloatingActionButton/master/Images/JJFloatingActionButton.gif'
  spec.documentation_url = 'https://jjochen.github.io/JJFloatingActionButton'

  spec.platform = :ios
  spec.ios.deployment_target = '9.0'

  spec.requires_arc = true
  spec.frameworks   = 'UIKit'

  spec.source_files = 'Sources/**/*'
end
