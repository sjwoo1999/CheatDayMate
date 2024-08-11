//
//  Meal.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let id: UUID
    let name: String
    let calories: Int
    let date: Date
    let imageData: Data? // 이미지 데이터를 위한 속성 추가
    
    init(id: UUID = UUID(), name: String, calories: Int, date: Date, imageData: Data? = nil) {
        self.id = id
        self.name = name
        self.calories = calories
        self.date = date
        self.imageData = imageData // 초기화 추가
    }
}
