//
//  DietAnalysisResultView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/13/24.
//

import SwiftUI

struct DietAnalysisResultView: View {
    let result: DietAnalysisResult

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Diet Analysis Result")
                    .font(.title)
                    .padding(.bottom)

                Text("Total Calories: \(result.totalCalories) kcal")
                    .font(.headline)

                Text("Macro Ratio:")
                    .font(.headline)
                Text("Carbs: \(Int(result.macroRatio.carbs * 100))%")
                Text("Protein: \(Int(result.macroRatio.protein * 100))%")
                Text("Fat: \(Int(result.macroRatio.fat * 100))%")

                Text("Nutritional Analysis:")
                    .font(.headline)
                    .padding(.top)
                Text(result.nutritionalAnalysis)

                Text("Recommendations:")
                    .font(.headline)
                    .padding(.top)
                Text(result.recommendations)

                Text("Precautions:")
                    .font(.headline)
                    .padding(.top)
                Text(result.precautions)
                
                if !result.foodDetails.isEmpty {
                    Text("Food Details:")
                        .font(.headline)
                        .padding(.top)
                    ForEach(result.foodDetails) { food in
                        VStack(alignment: .leading) {
                            Text(food.name ?? "Unknown Food")
                                .font(.subheadline)
                            if let weight = food.weight {
                                Text("Weight: \(weight)g")
                            }
                            if let macros = food.macros {
                                Text("Carbs: \(Int(macros.carbs * 100))%, Protein: \(Int(macros.protein * 100))%, Fat: \(Int(macros.fat * 100))%")
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
            .padding()
        }
    }
}
