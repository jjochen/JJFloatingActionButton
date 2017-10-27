Pod::Spec.new do |s|
  s.name         = "JJFloatingActionButton"
  s.version      = "0.0.1"
  s.summary      = "Floating Action Button for iOS"
  s.homepage     = "https://github.com/jjochen/JJFloatingActionButton"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "jjochen" => "git@jochen-pfeiffer.com" }
  s.source       = { :git => "https://github.com/jjochen/JJFloatingActionButton.git", :tag => s.version.to_s }
  s.platform     = :ios, '9.0'
  s.source_files = 'Sources/*.{swift}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.dependency 'SnapKit'
end
