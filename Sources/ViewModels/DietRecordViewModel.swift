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
    
    private let chatGPTService: ChatGPTService
    
    init(apiKey: String) {
        self.chatGPTService = ChatGPTService(apiKey: apiKey)
    }
    
    enum DietRecordError: Error {
        case analysisFailure(String)
        case dataLoadingFailure(String)
    }
    
    func addMeal(meal: Meal) {
        DispatchQueue.main.async {
            self.meals.append(meal)
        }
    }
    
    func analyzeDietWithImage(imageData: Data) async throws -> DietAnalysisResult {
        await MainActor.run {
            self.isAnalyzing = true
        }
        
        do {
            let analysisResult = try await chatGPTService.analyzeImage(imageData)
            await MainActor.run {
                self.isAnalyzing = false
                self.analysisResult = analysisResult
            }
            return analysisResult
        } catch {
            await MainActor.run {
                self.isAnalyzing = false
            }
            print("Failed to analyze diet with error: \(error.localizedDescription)")
            throw DietRecordError.analysisFailure("Failed to analyze diet: \(error.localizedDescription)")
        }
    }
    
    func getAnalysisResult(for meal: Meal?) async throws -> DietAnalysisResult {
        guard let unwrappedMeal = meal, let imageData = unwrappedMeal.imageData else {
            throw DietRecordError.analysisFailure("Meal is nil or has no image data")
        }
        if let existingResult = analysisResult, selectedMealForAnalysis == unwrappedMeal {
            return existingResult
        }
        return try await analyzeDietWithImage(imageData: imageData)
    }
    
    func loadMeals(for date: Date) async throws {
        let calendar = Calendar.current
        do {
            // 비동기 데이터 로딩 시뮬레이션
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let filteredMeals = meals.filter { calendar.isDate($0.date, inSameDayAs: date) }
            await MainActor.run {
                self.meals = filteredMeals
            }
        } catch {
            throw DietRecordError.dataLoadingFailure("Failed to load meals: \(error.localizedDescription)")
        }
    }
}
