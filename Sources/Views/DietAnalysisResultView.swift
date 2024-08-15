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
            VStack(alignment: .leading, spacing: 20) {
                Text("식단 분석 결과")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                totalCaloriesView
                macroRatioView
                nutritionalAnalysisView
                recommendationsView
                precautionsView
                foodDetailsView
            }
            .padding()
        }
    }

    private var totalCaloriesView: some View {
        VStack(alignment: .leading) {
            Text("총 칼로리")
                .font(.headline)
            Text("\(result.totalCalories) kcal")
                .font(.title)
                .fontWeight(.bold)
        }
    }

    private var macroRatioView: some View {
        VStack(alignment: .leading) {
            Text("영양소 비율")
                .font(.headline)
            HStack {
                MacroRatioBar(label: "탄수화물", ratio: result.macroRatio.carbs, color: .blue)
                MacroRatioBar(label: "단백질", ratio: result.macroRatio.protein, color: .green)
                MacroRatioBar(label: "지방", ratio: result.macroRatio.fat, color: .red)
            }
        }
    }

    private var nutritionalAnalysisView: some View {
        VStack(alignment: .leading) {
            Text("영양 분석")
                .font(.headline)
            Text(result.nutritionalAnalysis)
        }
    }

    private var recommendationsView: some View {
        VStack(alignment: .leading) {
            Text("권장 사항")
                .font(.headline)
            Text(result.recommendations)
        }
    }

    private var precautionsView: some View {
        VStack(alignment: .leading) {
            Text("주의 사항")
                .font(.headline)
            Text(result.precautions)
        }
    }

    private var foodDetailsView: some View {
        VStack(alignment: .leading) {
            Text("식품 상세 정보")
                .font(.headline)
            ForEach(result.foodDetails) { food in
                VStack(alignment: .leading) {
                    Text(food.name ?? "알 수 없는 식품")
                        .font(.subheadline)
                    if let weight = food.weight {
                        Text("중량: \(weight)g")
                    }
                    if let macros = food.macros {
                        Text("탄수화물: \(Int(macros.carbs * 100))%, 단백질: \(Int(macros.protein * 100))%, 지방: \(Int(macros.fat * 100))%")
                    }
                }.padding(.bottom, 5)
            }
        }
    }
                             
}

struct MacroRatioBar: View {
    let label: String
    let ratio: Double
    let color: Color

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 30, height: 100)
                Rectangle()
                    .fill(color)
                    .frame(width: 30, height: CGFloat(ratio) * 100)
            }
            Text(label)
                .font(.caption)
            Text("\(Int(ratio * 100))%")
                .font(.caption2)
        }
    }
}
