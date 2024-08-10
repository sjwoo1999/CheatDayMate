//
//  DietRecordView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct DietRecordView: View {
    @StateObject private var viewModel = DietRecordViewModel()
    @Binding var isPresented: Bool
    @State private var showingAddMeal = false
    
    var body: some View {
        NavigationView {
            List {
                DatePicker("날짜 선택", selection: $viewModel.selectedDate, displayedComponents: .date)
                
                ForEach(viewModel.meals) { meal in
                    MealRow(meal: meal)
                }
                .onDelete(perform: viewModel.deleteMeal)
            }
            .navigationTitle("식단 기록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddMeal = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMeal) {
                AddMealView(viewModel: viewModel)
            }
        }
    }
}

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            Text(meal.name)
            Spacer()
            Text("\(meal.calories) kcal")
        }
    }
}
