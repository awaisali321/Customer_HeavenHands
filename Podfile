# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'HeavenlyHands-2' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HeavenlyHands-2

  target 'HeavenlyHands-2Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'HeavenlyHands-2UITests' do
    # Pods for testing
  end
pod 'SideMenuController'
pod 'WKWebViewController'
pod 'Alamofire'

pod 'Kingfisher', '~> 7.0'
pod 'OTPFieldView'
pod 'SwiftFlags'
pod 'UBottomSheet'
pod 'EzPopup'
pod 'Firebase/Messaging'
pod 'Moya', '~> 13.0'
pod 'FirebaseAuth'
pod 'JGProgressHUD'
pod 'SignalRSwift', '~> 2.0.2'
pod 'SwiftyJSON'
pod 'Presentr'
pod 'IQKeyboardManagerSwift', '6.5.0'
pod "SwiftSignatureView"
pod 'Firebase'
pod 'Firebase/Messaging'
pod 'Firebase/Auth'
end
post_install do |pi|
 pi.pods_project.targets.each do |t|
  t.build_configurations.each do |config|
   config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
 end
end
