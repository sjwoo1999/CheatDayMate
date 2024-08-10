//
//  Meal.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation
import SwiftUI

public struct Meal: Identifiable, Codable {
    public let id: UUID
    public var name: String
    public var time: Date
    public var calories: Int
    public var imageData: Data?
    
    public init(id: UUID = UUID(), name: String, time: Date, calories: Int, imageData: Data? = nil) {
        self.id = id
        self.name = name
        self.time = time
        self.calories = calories
        self.imageData = imageData
    }
    
    public var image: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension Meal {
    public static var sampleMeals: [Meal] {
        [
            Meal(name: "아침", time: Date().addingTimeInterval(-3600*8), calories: 500),
            Meal(name: "점심", time: Date().addingTimeInterval(-3600*4), calories: 700),
            Meal(name: "저녁", time: Date(), calories: 600)
        ]
    }
}
