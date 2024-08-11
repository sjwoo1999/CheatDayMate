//
//  AppConfig.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

struct AppConfig {
    static let chatGPTAPIKey: String = {
        if let apiKey = ProcessInfo.processInfo.environment["CHATGPT_API_KEY"] {
            return apiKey
        } else {
            // 기본값 사용 또는 로그 출력
            print("CHATGPT_API_KEY not found, using default key.")
            return "default-api-key" // 기본값 (안전하지 않음)
        }
    }()
}
