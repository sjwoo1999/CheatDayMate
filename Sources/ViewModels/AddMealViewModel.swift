//
//  AddMealViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

class AddMealViewModel: ObservableObject {
    private let chatGPTService: ChatGPTService
    @Published var analysisResult: DietAnalysisResult?
    
    init(chatGPTService: ChatGPTService) {
        self.chatGPTService = chatGPTService
    }
    
    func analyzeDiet(imageData: Data) async throws -> DietAnalysisResult {
        do {
            let result = try await chatGPTService.analyzeImage(imageData)
            return result
        } catch {
            throw error
        }
    }
    
    func addMeal(meal: Meal) {
        // 여기에 meal을 저장하는 로직을 구현합니다.
        // 예: 데이터베이스에 저장하거나 배열에 추가하는 등의 작업
        print("Meal added: \(meal)")
    }
    
    func analyzeDietWithImage(meal: Meal) async throws -> DietAnalysisResult {
            guard let imageData = meal.imageData else {
                throw NSError(domain: "AddMealViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: "No image data available"])
            }
            return try await analyzeDiet(imageData: imageData)
        }
}
