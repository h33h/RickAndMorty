platform :ios, '15.0'
inhibit_all_warnings!
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end

target 'RickAndMorty' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RickAndMorty

pod 'RxSwift'
pod 'RxCocoa'
pod 'RxGesture'
pod 'Swinject'
pod 'Moya/RxSwift'
pod 'ObjectMapper'
pod 'SnapKit'
pod 'SwiftLint'
pod 'SwiftGen'

  target 'RickAndMortyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RickAndMortyUITests' do
    # Pods for testing
  end

end
