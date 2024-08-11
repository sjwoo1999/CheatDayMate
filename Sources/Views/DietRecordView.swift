//
//  DietRecordView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct DietRecordView: View {
    @ObservedObject var viewModel: DietRecordViewModel
    @Binding var isPresented: Bool
    @State private var showingAddMeal = false
    @State private var selectedMeal: Meal?
    var showAddMealImmediately: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("날짜 선택", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                List {
                    ForEach(viewModel.meals) { meal in
                        MealRow(meal: meal)
                            .padding(.vertical, 8)
                            .onTapGesture {
                                selectedMeal = meal
                            }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteMeal(at: indexSet)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                toolbarItems
            }
        }
        .sheet(isPresented: $showingAddMeal) {
            AddMealView(viewModel: viewModel, isPresented: $showingAddMeal)
        }
        .sheet(item: $selectedMeal) { meal in
            if let analysis = viewModel.getAnalysisResult(for: meal) {
                MealAnalysisResultView(result: MealAnalysisResult(content: analysis))
            }
        }
        .onAppear {
            if showAddMealImmediately {
                showingAddMeal = true
            }
        }
    }
    
    private var navigationTitle: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: viewModel.selectedDate)
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("닫기") {
                    isPresented = false
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingAddMeal = true }) {
                    Image(systemName: "plus")
                        .font(.title)
                }
            }
        }
    }
}

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            if let imageData = meal.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(meal.calories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
