//
//  MealAnalysisResultView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct MealAnalysisResult: Identifiable {
    let id = UUID()
    let content: String
    
    var description: String {
        return content
    }
}

struct MealAnalysisResultView: View {
    let result: MealAnalysisResult
    
    var body: some View {
        ScrollView {
            Text(result.description)
                .padding()
        }
        .navigationTitle("분석 결과")
    }
}
