# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
source 'https://github.com/CocoaPods/Specs.git'



target 'OSSwiftDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
#  use_frameworks!
  pod 'AFNetworking'
  pod 'ReactiveCocoa'#Rac
  pod 'SDWebImage'#类似于rxjava
  pod 'SnapKit'#自动布局
  pod 'RxSwift'#类似于rxjava
  pod 'RxCocoa'#类似于rxjava
  pod 'Alamofire'
  pod 'Toaster'

    
  target 'OSSwiftDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OSSwiftDemoUITests' do
    # Pods for testing
  end
end


#把这个加到podfile里
#壳与pod子工程都兼容到最小版本
post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13'
  end
 end
end
