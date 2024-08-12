//
//  DietAnalysisResult.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/12/24.
//

import Foundation

public struct MacroRatio: Codable {
    let carbs: Double
    let protein: Double
    let fat: Double
}

public struct FoodDetail: Codable, Identifiable {
    public var id = UUID()
    let name: String
    let weight: Double
    let macros: MacroRatio
}

public struct DietAnalysisResult: Codable {
    let totalCalories: Int
    let macroRatio: MacroRatio
    let foodDetails: [FoodDetail]
    let nutritionalAnalysis: String
    let recommendations: String
    let precautions: String
    
    var description: String {
        var desc = """
        총 칼로리: \(totalCalories) kcal
        영양소 비율:
          탄수화물: \(String(format: "%.1f", macroRatio.carbs * 100))%
          단백질: \(String(format: "%.1f", macroRatio.protein * 100))%
          지방: \(String(format: "%.1f", macroRatio.fat * 100))%
        음식 상세:
        """
        
        for food in foodDetails {
            desc += "\n  \(food.name) (\(String(format: "%.0f", food.weight))g)"
        }
        
        desc += """
        
        영양 분석: \(nutritionalAnalysis)
        권장 사항: \(recommendations)
        주의 사항: \(precautions)
        """
        
        return desc
    }
    
    enum CodingKeys: String, CodingKey {
            case totalCalories, macroRatio, foodDetails, nutritionalAnalysis, recommendations, precautions
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            totalCalories = try container.decode(Int.self, forKey: .totalCalories)
            macroRatio = try container.decode(MacroRatio.self, forKey: .macroRatio)
            foodDetails = try container.decode([FoodDetail].self, forKey: .foodDetails)
            nutritionalAnalysis = try container.decode(String.self, forKey: .nutritionalAnalysis)
            recommendations = try container.decode(String.self, forKey: .recommendations)
            precautions = try container.decode(String.self, forKey: .precautions)
        }

        // 기존의 커스텀 이니셜라이저도 유지
        public init(totalCalories: Int, macroRatio: MacroRatio, foodDetails: [FoodDetail], nutritionalAnalysis: String, recommendations: String, precautions: String) {
            self.totalCalories = totalCalories
            self.macroRatio = macroRatio
            self.foodDetails = foodDetails
            self.nutritionalAnalysis = nutritionalAnalysis
            self.recommendations = recommendations
            self.precautions = precautions
        }
}
    
extension DietAnalysisResult {
    static func mock() -> DietAnalysisResult {
        DietAnalysisResult(
            totalCalories: 2000,
            macroRatio: MacroRatio(carbs: 0.5, protein: 0.3, fat: 0.2),
            foodDetails: [
                FoodDetail(name: "사과", weight: 100, macros: MacroRatio(carbs: 0.95, protein: 0.03, fat: 0.02)),
                FoodDetail(name: "닭가슴살", weight: 150, macros: MacroRatio(carbs: 0, protein: 0.8, fat: 0.2))
            ],
            nutritionalAnalysis: "균형잡힌 식단입니다.",
            recommendations: "과일과 채소의 섭취를 조금 더 늘리세요.",
            precautions: "지방의 섭취량을 조금 줄이는 것이 좋습니다."
        )
    }
}
