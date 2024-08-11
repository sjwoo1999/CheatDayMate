//
//  ChatGPTService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation
import Combine

class ChatGPTService: ObservableObject {
    private let apiKey: String
    private let endpoint = "https://api.openai.com/v1/chat/completions"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func analyzeImage(_ imageData: Data) async throws -> String {
        let base64Image = imageData.base64EncodedString()
        
        let body: [String: Any] = [
            "model": "gpt-4o",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": "이 음식 이미지를 분석해주세요. 칼로리 추정치와 영양 정보를 제공해주세요."
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
            "max_tokens": 300
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
        return result.choices.first?.message.content ?? "응답을 파싱할 수 없습니다."
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
