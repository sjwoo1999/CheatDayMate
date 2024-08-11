//
//  CheatDayMateApp.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

@main
struct CheatDayMateApp: App {
    @StateObject private var authService = AuthService()
    @StateObject private var chatGPTService = ChatGPTService(apiKey: AppConfig.chatGPTAPIKey)

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(authService)
                .environmentObject(chatGPTService)
        }
    }
}
