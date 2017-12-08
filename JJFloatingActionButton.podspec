Pod::Spec.new do |spec|
  spec.name     = 'JJFloatingActionButton'
  spec.version  = '0.4.0'
  spec.author   = { 'Jochen Pfeiffer' => 'pod@jochen-pfeiffer.com' }
  spec.license  = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage = 'https://github.com/jjochen/JJFloatingActionButton'
  spec.source   = { :git => 'https://github.com/jjochen/JJFloatingActionButton.git', :tag => spec.version.to_s }
  spec.summary  = 'Floating Action Button for iOS'

  spec.platform = :ios
  spec.ios.deployment_target = '9.0'

  spec.requires_arc = true
  spec.frameworks   = 'UIKit'

  spec.source_files = 'JJFloatingActionButton/Classes/**/*'
  spec.resource_bundles = {
    'Assets' => ['JJFloatingActionButton/Assets/*.xcassets']
  }
end
