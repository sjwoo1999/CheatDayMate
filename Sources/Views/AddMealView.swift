//
//  AddMealView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI
import PhotosUI

struct AddMealView: View {
    @ObservedObject var viewModel: DietRecordViewModel
    @Binding var isPresented: Bool
    @State private var mealName = ""
    @State private var calories = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var showingAnalysisResult = false
    @State private var newMealAnalysis: String?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("식사 정보").font(.title2).padding(.bottom, 5)) {
                    TextField("식사 이름", text: $mealName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    TextField("칼로리", text: $calories)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                Section {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("식사 이미지 선택")
                            .foregroundColor(.blue)
                            .padding()
                    }
                    
                    if let selectedImageData,
                       let uiImage = UIImage(data: selectedImageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.top)
                    }
                }
                
                Section {
                    Button(action: {
                        if let caloriesInt = Int(calories) {
                            viewModel.addMeal(name: mealName, calories: caloriesInt, imageData: selectedImageData)
                            isPresented = false
                        }
                    }) {
                        Text("추가")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isAnalyzing)
                    
                    if viewModel.isAnalyzing {
                        ProgressView("분석 중...")
                    }

                    if let error = viewModel.error {
                        Text("오류: \(error)")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("식사 추가")
            .navigationBarItems(leading: Button("취소") {
                isPresented = false
            })
        }
        .onChange(of: selectedItem) { _ in
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
        .onChange(of: viewModel.isAnalyzing) { isAnalyzing in
            if !isAnalyzing, viewModel.error == nil {
                if let lastMeal = viewModel.meals.last,
                   let analysis = viewModel.getAnalysisResult(for: lastMeal) {
                    newMealAnalysis = analysis
                    showingAnalysisResult = true
                }
            }
        }
        .sheet(isPresented: $showingAnalysisResult) {
            if let analysis = newMealAnalysis {
                MealAnalysisResultView(result: MealAnalysisResult(content: analysis))
            }
        }
    }
}
