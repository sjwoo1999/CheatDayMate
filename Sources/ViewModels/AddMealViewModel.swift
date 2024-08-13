//
//  AddMealViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

class AddMealViewModel: ObservableObject {
    private let chatGPTService: ChatGPTService
    @Published var analysisResult: String?
    
    init(chatGPTService: ChatGPTService) {
        self.chatGPTService = chatGPTService
    }
    
    func analyzeImage(_ imageData: Data) {
        Task {
            do {
                let result = try await chatGPTService.analyzeImage(imageData)
                DispatchQueue.main.async {
                    self.analysisResult = result.description
                }
            } catch {
                // 에러 처리
            }
        }
    }
    
    func analyzeDiet(name: String, calories: Int, imageData: Data?) async -> DietAnalysisResult? {
        // 실제 분석 로직 구현
        return DietAnalysisResult.mock() // 임시로 mock 데이터 반환
    }
}
