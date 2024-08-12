//
//  Meal.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

struct Meal: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let name: String
    let calories: Int
    let date: Date
    let imageData: Data?
    
    init(id: UUID = UUID(), name: String, calories: Int, date: Date, imageData: Data? = nil) {
        self.id = id
        self.name = name
        self.calories = calories
        self.date = date
        self.imageData = imageData
    }
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
