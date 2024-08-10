//
//  AppDelegate.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import UIKit
import KakaoSDKCommon

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: "YOUR_KAKAO_APP_KEY")
        return true
    }
}
