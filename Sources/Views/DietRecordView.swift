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
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    DatePicker("날짜 선택", selection: $viewModel.selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.meals) { meal in
                                MealRow(meal: meal)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        selectedMeal = meal
                                    }
                            }
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    Button(action: { showingAddMeal = true }) {
                        Text("식사 추가")
                            .font(.headline)
                            .foregroundColor(.orange)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    .padding()
                }
            }
            .navigationBarTitle(navigationTitle, displayMode: .inline)
            .navigationBarItems(leading: dismissButton, trailing: addButton)
        }
        .accentColor(.white)
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
    
    private var dismissButton: some View {
        Button("닫기") {
            isPresented = false
        }
        .foregroundColor(.white)
    }
    
    private var addButton: some View {
        Button(action: { showingAddMeal = true }) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(.white)
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
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(meal.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text("\(meal.calories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}
