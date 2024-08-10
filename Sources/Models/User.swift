//
//  User.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let username: String
    let email: String
}

struct CheatDay: Codable, Identifiable {
    let id: String
    let date: Date
    var caloriesConsumed: Int
    var caloriesGoal: Int
}
