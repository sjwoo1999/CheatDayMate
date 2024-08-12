//
//  DietRecordViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

class DietRecordViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedDate: Date = Date()
    @Published var selectedMealForAnalysis: Meal?
    @Published var analysisResult: DietAnalysisResult?
    @Published var isAnalyzing: Bool = false
    
    enum DietRecordError: Error {
        case analysisFailure(String)
        case dataLoadingFailure(String)
    }
    
    func addMeal(meal: Meal) {
        DispatchQueue.main.async {
            self.meals.append(meal)
        }
    }
    
    func analyzeDiet(meal: Meal) async throws -> DietAnalysisResult {
        await MainActor.run {
            self.isAnalyzing = true
        }
        
        do {
            // Simulate API call
            try await Task.sleep(nanoseconds: 2_000_000_000)
            let result = DietAnalysisResult(
                totalCalories: meal.calories,
                macroRatio: MacroRatio(carbs: 0.5, protein: 0.3, fat: 0.2),
                foodDetails: [FoodDetail(name: meal.name, weight: 300, macros: MacroRatio(carbs: 0.6, protein: 0.2, fat: 0.2))],
                nutritionalAnalysis: "This meal is balanced but slightly high in carbohydrates.",
                recommendations: "Consider adding more vegetables to increase fiber intake.",
                precautions: "Watch out for added sugars in processed foods."
            )
            
            await MainActor.run {
                self.isAnalyzing = false
                self.analysisResult = result
            }
            
            return result
        } catch {
            await MainActor.run {
                self.isAnalyzing = false
            }
            throw DietRecordError.analysisFailure("Failed to analyze diet: \(error.localizedDescription)")
        }
    }
    
    func loadMeals(for date: Date) async throws {
        let calendar = Calendar.current
        do {
            // Simulate asynchronous data loading
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let filteredMeals = meals.filter { calendar.isDate($0.date, inSameDayAs: date) }
            await MainActor.run {
                self.meals = filteredMeals
            }
        } catch {
            throw DietRecordError.dataLoadingFailure("Failed to load meals: \(error.localizedDescription)")
        }
    }
    
    func getAnalysisResult(for meal: Meal?) async throws -> DietAnalysisResult {
        guard let unwrappedMeal = meal else {
            throw DietRecordError.analysisFailure("Meal is nil")
        }
        if let existingResult = analysisResult, selectedMealForAnalysis == unwrappedMeal {
            return existingResult
        }
        return try await analyzeDiet(meal: unwrappedMeal)
    }
}
