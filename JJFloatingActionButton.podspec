Pod::Spec.new do |spec|
  spec.name     = 'JJFloatingActionButton'
  spec.version  = '0.0.1'
  spec.author   = { 'jjochen' => 'pod@jochen-pfeiffer.com' }
  spec.license  = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage = 'https://github.com/jjochen/JJFloatingActionButton'
  spec.source   = { :git => 'https://github.com/jjochen/JJFloatingActionButton.git', :tag => spec.version.to_s }
  spec.summary  = 'Floating Action Button for iOS'
  
  spec.platform = :ios, '9.0'
  
  spec.dependency 'SnapKit', '~> 4.0'
  spec.requires_arc = true
  spec.frameworks   = 'UIKit', 'Foundation'
  
  spec.source_files = 'Sources/*.swift'
  spec.ios.resource_bundle = { 'JJFloatingActionButton' => 'Resources/*.xcassets' }
end
