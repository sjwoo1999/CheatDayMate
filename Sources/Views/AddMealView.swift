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
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    inputSection
                    imageSection
                    addButton
                }
                .padding()
            }
            .navigationBarTitle("식사 추가", displayMode: .inline)
            .navigationBarItems(leading: cancelButton)
        }
        .accentColor(.white)
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
    
    private var inputSection: some View {
        VStack(spacing: 15) {
            TextField("식사 이름", text: $mealName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(15)
            
            TextField("칼로리", text: $calories)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(15)
        }
    }
    
    private var imageSection: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Text("식사 이미지 선택")
                    .foregroundColor(.orange)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
            }
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(15)
                    .padding(.top)
            }
        }
    }
    
    private var addButton: some View {
        Button(action: addMeal) {
            Text("추가")
                .font(.headline)
                .foregroundColor(.orange)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
        }
        .disabled(viewModel.isAnalyzing)
        .opacity(viewModel.isAnalyzing ? 0.5 : 1)
        .overlay(
            Group {
                if viewModel.isAnalyzing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
        )
    }
    
    private var cancelButton: some View {
        Button("취소") {
            isPresented = false
        }
        .foregroundColor(.white)
    }
    
    private func addMeal() {
        if let caloriesInt = Int(calories) {
            viewModel.addMeal(name: mealName, calories: caloriesInt, imageData: selectedImageData)
            isPresented = false
        }
    }
}
