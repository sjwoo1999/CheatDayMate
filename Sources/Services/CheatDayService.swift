//
//  CheatDayService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class CheatDayService {
    func getCheatDays(for user: User) async throws -> [CheatDay] {
        // Implement logic to fetch cheat days
        // This is a placeholder implementation
        return [
            CheatDay(id: "1", date: Date(), caloriesConsumed: 0, caloriesGoal: 27920)
        ]
    }
    
    func addCalories(_ calories: Int, to cheatDay: CheatDay) async throws -> CheatDay {
        // Implement logic to update cheat day
        var updatedCheatDay = cheatDay
        updatedCheatDay.caloriesConsumed += calories
        return updatedCheatDay
    }
}
