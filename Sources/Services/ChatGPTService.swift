//
//  ChatGPTService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation

class ChatGPTService: ObservableObject {
    private let apiKey: String
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func analyzeImage(_ imageData: Data) async throws -> DietAnalysisResult {
        let base64Image = imageData.base64EncodedString()
        
        let body: [String: Any] = [
            "model": "gpt-4o",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": "이 음식 이미지를 분석해주세요. 메뉴 항목, 칼로리 추정치, 영양 정보, 권장 사항, 주의 사항을 포함하여 분석 결과를 제공해주세요."
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)"
                            ]
                        ]
                    ]
                ]
            ],
            "max_tokens": 500
        ]
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "ChatGPTService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }
        
        let result = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
        return parseAnalysisResult(from: result.choices.first?.message.content ?? "")
    }
    
    private func parseAnalysisResult(from response: String) -> DietAnalysisResult {
        // 이 부분에서 GPT-4의 응답을 파싱하여 DietAnalysisResult로 변환합니다.
        // 실제로는 정규식을 사용하거나 문자열을 분석하여 각 값을 추출하는 로직을 구현해야 합니다.
        // 예시로서 임시 파싱 로직을 아래와 같이 구현합니다.

        let totalCalories = extractValue(from: response, with: "Total Calories:")
        let carbs = extractMacro(from: response, with: "Carbs:")
        let protein = extractMacro(from: response, with: "Protein:")
        let fat = extractMacro(from: response, with: "Fat:")
        let nutritionalAnalysis = extractSection(from: response, with: "Nutritional Analysis:")
        let recommendations = extractSection(from: response, with: "Recommendations:")
        let precautions = extractSection(from: response, with: "Precautions:")

        return DietAnalysisResult(
            totalCalories: Int(totalCalories) ?? 0,
            macroRatio: MacroRatio(carbs: carbs, protein: protein, fat: fat),
            foodDetails: [], // 필요하다면 추가 정보를 파싱하여 사용
            nutritionalAnalysis: nutritionalAnalysis,
            recommendations: recommendations,
            precautions: precautions
        )
    }
    
    private func extractValue(from response: String, with prefix: String) -> String {
        // Prefix에 해당하는 값을 추출하는 로직 구현
        // 예: "Total Calories: 250 kcal"에서 250을 추출
        return "250" // 예시 값, 실제 구현 필요
    }
    
    private func extractMacro(from response: String, with prefix: String) -> Double {
        // Prefix에 해당하는 매크로 값을 추출하여 Double로 변환하는 로직
        return 0.5 // 예시 값, 실제 구현 필요
    }
    
    private func extractSection(from response: String, with prefix: String) -> String {
        // Prefix에 해당하는 섹션을 추출하는 로직 구현
        return "This is an example analysis." // 예시 값, 실제 구현 필요
    }
}

struct ChatGPTResponse: Codable {
    let choices: [Choice]
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content: String
}
