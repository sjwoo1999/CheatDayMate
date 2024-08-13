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
            print("CHATGPT_API_KEY not found, using default key.")
            return "default-api-key" // 기본값 (안전하지 않음)
        }
    }()
    
    static let kakaoAPIKey: String = {
        if let apiKey = ProcessInfo.processInfo.environment["KAKAO_API_KEY"] {
            return apiKey
        } else {
            print("KAKAO_API_KEY not found, using default key.")
            return "default-kakao-api-key" // 기본값 (안전하지 않음)
        }
    }()
}
