//
//  DietRecordView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct DietRecordView: View {
    @StateObject private var viewModel = DietRecordViewModel(apiKey: "YOUR_API_KEY_HERE")
    @State private var showingAddMealView = false
    @State private var selectedDate = Date()
    @State private var errorMessage: String?
    @State private var showingErrorAlert = false

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .padding()
                    .onChange(of: selectedDate) { newValue in
                        loadMeals(for: newValue)
                    }

                List {
                    ForEach(viewModel.meals) { meal in
                        MealRow(meal: meal, viewModel: viewModel)
                    }
                    .onDelete(perform: deleteMeal)
                }
                .listStyle(PlainListStyle())

                Button(action: { showingAddMealView = true }) {
                    Text("Add Meal")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Diet Record")
            .onAppear {
                loadMeals(for: selectedDate)
            }
            .sheet(isPresented: $showingAddMealView) {
                            AddMealView(viewModel: viewModel, isPresented: $showingAddMealView)
                        }
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage ?? "An unknown error occurred"), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func loadMeals(for date: Date) {
        Task {
            do {
                try await viewModel.loadMeals(for: date)
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to load meals: \(error.localizedDescription)"
                    showingErrorAlert = true
                }
            }
        }
    }

    private func deleteMeal(at offsets: IndexSet) {
        viewModel.meals.remove(atOffsets: offsets)
    }
}

struct MealRow: View {
    let meal: Meal
    @ObservedObject var viewModel: DietRecordViewModel
    @State private var showingAnalysisResult = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(meal.name)
                .font(.headline)
            Text("\(meal.calories) kcal")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .onTapGesture {
            viewModel.selectedMealForAnalysis = meal
            analyzeMeal()
        }
        .sheet(isPresented: $showingAnalysisResult) {
            if let result = viewModel.analysisResult {
                DietAnalysisResultView(result: result)
            } else {
                ProgressView("Analyzing...")
            }
        }
    }

    private func analyzeMeal() {
            Task {
                do {
                    if let imageData = meal.imageData {
                        let result = try await viewModel.analyzeDietWithImage(imageData: imageData)
                        await MainActor.run {
                            viewModel.analysisResult = result
                            showingAnalysisResult = true
                        }
                    }
                } catch {
                    print("Failed to analyze diet: \(error.localizedDescription)")
                    // 에러 처리 로직 추가
                }
            }
        }
}
