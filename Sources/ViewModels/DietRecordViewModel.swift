//
//  DietRecordViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation
import Combine

class DietRecordViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isAnalyzing: Bool = false
    @Published var error: String?
    @Published var analysisResults: [UUID: String] = [:]
    @Published var selectedDate: Date = Date()
    
    private let chatGPTService: ChatGPTService
    
    init(chatGPTService: ChatGPTService) {
        self.chatGPTService = chatGPTService
    }
    
    func addMeal(name: String, calories: Int, imageData: Data?) {
        let newMeal = Meal(id: UUID(), name: name, calories: calories, date: selectedDate)
        meals.append(newMeal)
        
        if let imageData = imageData {
            analyzeMealImage(mealId: newMeal.id, imageData: imageData)
        }
    }
    
    func deleteMeal(at offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
    }
    
    private func analyzeMealImage(mealId: UUID, imageData: Data) {
        isAnalyzing = true
        error = nil
        
        Task {
            do {
                let analysis = try await chatGPTService.analyzeImage(imageData)
                DispatchQueue.main.async {
                    self.analysisResults[mealId] = analysis
                    self.isAnalyzing = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.error = error.localizedDescription
                    self.isAnalyzing = false
                }
            }
        }
    }
    
    func getAnalysisResult(for meal: Meal) -> String? {
        return analysisResults[meal.id]
    }
    
    func loadMeals(for date: Date) {
        // TODO: Implement loading meals for a specific date
        // This could involve fetching from a local database or an API
    }
}
