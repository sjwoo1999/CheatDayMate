# 전역 플랫폼 버전 지정
platform :ios, '14.0'

# CocoaPods 설정
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

target 'CheatDayMate' do
  # 동적 프레임워크 사용
  use_frameworks!

  # KakaoSDK 통합 pod 사용
  pod 'KakaoSDK'

  pod 'OpenAISwift'

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