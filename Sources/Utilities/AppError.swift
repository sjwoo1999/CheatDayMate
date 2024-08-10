//
//  AppError.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

enum AppError: Error {
    case authError(String)
    case networkError(String)
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .authError(let message):
            return "Authentication Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        case .unknownError(let message):
            return "Unknown Error: \(message)"
        @unknown default:
            return "unknown error"
        }
    }
}
