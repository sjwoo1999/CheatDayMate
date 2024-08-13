# 전역 플랫폼 버전 지정
platform :ios, '12.0'

# CocoaPods 설정
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'CheatDayMate' do
  # 동적 프레임워크 사용
  use_frameworks!

  # KakaoSDK 모듈 명시적 지정 및 버전 명시
  pod 'KakaoSDKCommon', '~> 2.11.0'  # 최신 버전으로 업데이트 필요
  pod 'KakaoSDKAuth', '~> 2.11.0'
  pod 'KakaoSDKUser', '~> 2.11.0'
  pod 'KakaoSDKTalk', '~> 2.11.0'  # 필요한 경우

  # 다른 pod들의 버전 명시
  pod 'OpenAISwift'  # 최신 버전으로 업데이트 필요
  pod 'Alamofire', '~> 5.6.0'

  # CheatDayMate 앱을 위한 Pods
  # 필요한 경우 여기에 추가 pod를 명시할 수 있습니다.

  target 'CheatDayMateTests' do
    inherit! :search_paths
    # 테스팅을 위한 Pods
  end

  target 'CheatDayMateUITests' do
    # UI 테스팅을 위한 Pods
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end