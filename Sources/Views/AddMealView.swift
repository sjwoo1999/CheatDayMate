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
    @State private var isAnalyzing = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    inputSection
                    imageSection
                    analyzeDietButton
                    addMealButton
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
        .sheet(isPresented: $showingAnalysisResult) {
            if let result = viewModel.analysisResult {
                DietAnalysisResultView(result: result)
            } else {
                ProgressView("분석 중...")
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("알림"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
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
    
    private var cancelButton: some View {
        Button("취소") {
            isPresented = false
        }
        .foregroundColor(.white)
    }
    
    private var analyzeDietButton: some View {
        Button(action: {
            analyzeDiet()
        }) {
            Text("식단 분석하기")
                .font(.headline)
                .foregroundColor(.orange)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(15)
        }
        .disabled(isAnalyzing)
        .opacity(isAnalyzing ? 0.5 : 1)
        .overlay(
            Group {
                if isAnalyzing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                }
            }
        )
    }
    
    private var addMealButton: some View {
        Button(action: addMeal) {
            Text("식사 추가하기")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(15)
        }
    }
    
    private func analyzeDiet() {
        guard let caloriesInt = Int(calories), !isAnalyzing else { return }
        guard !mealName.isEmpty else {
            showAlert(message: "식사 이름을 입력해주세요.")
            return
        }
        
        isAnalyzing = true
        
        let newMeal = Meal(name: mealName, calories: caloriesInt, date: Date(), imageData: selectedImageData)
        
        Task {
            do {
                _ = try await viewModel.analyzeDiet(meal: newMeal)
                await MainActor.run {
                    self.showingAnalysisResult = true
                    self.isAnalyzing = false
                    // 여기서 result를 사용할 수 있습니다. 예를 들어:
                    // self.analysisResult = result
                }
            } catch {
                await MainActor.run {
                    self.isAnalyzing = false
                    showAlert(message: "식단 분석에 실패했습니다: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func addMeal() {
        guard let caloriesInt = Int(calories) else {
            showAlert(message: "올바른 칼로리 값을 입력해주세요.")
            return
        }
        guard !mealName.isEmpty else {
            showAlert(message: "식사 이름을 입력해주세요.")
            return
        }
        
        viewModel.addMeal(meal: Meal(name: mealName, calories: caloriesInt, date: Date(), imageData: selectedImageData))
        isPresented = false
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showingAlert = true
    }
}
