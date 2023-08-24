# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
source 'https://github.com/CocoaPods/Specs.git'

#把这个加到podfile里
#壳与pod子工程都兼容到最小版本
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11'
  end
 end
end

target 'OKSwiftDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'AFNetworking'
  pod 'ReactiveCocoa'
  
  target 'OKSwiftDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OKSwiftDemoUITests' do
    # Pods for testing
  end

end
