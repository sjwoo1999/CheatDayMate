//
//  Meal.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct Meal: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let calories: Int
    let date: Date
    let imageData: Data?
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.calories == rhs.calories &&
               lhs.date == rhs.date &&
               lhs.imageData == rhs.imageData
    }
}
