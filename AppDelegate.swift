//
//  AppDelegate.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import UIKit
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let authService = AuthService()
    let chatGPTService = ChatGPTService(apiKey: AppConfig.chatGPTAPIKey)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let contentView = SplashScreenView()
        window?.rootViewController = UIHostingController(rootView: contentView)
        
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
