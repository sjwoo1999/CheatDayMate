//
//  AddMealView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct AddMealView: View {
    @ObservedObject var viewModel: DietRecordViewModel
    @Binding var isPresented: Bool
    @State private var mealName: String = ""
    @State private var calories: String = ""
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("식사 정보")) {
                    TextField("식사 이름", text: $mealName)
                    TextField("칼로리", text: $calories)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("사진")) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("사진 선택")
                    }
                }
                
                Section {
                    Button("식사 추가") {
                        if let imageData = selectedImage?.jpegData(compressionQuality: 0.8),
                           let caloriesInt = Int(calories) {
                            let newMeal = Meal(name: mealName, calories: caloriesInt, date: Date(), imageData: imageData)
                            viewModel.addMeal(meal: newMeal)
                            
                            Task {
                                do {
                                    let analysisResult = try await viewModel.analyzeDietWithImage(imageData: imageData)
                                    print("Analysis result: \(analysisResult)")
                                } catch {
                                    print("Failed to analyze diet: \(error)")
                                }
                            }
                            
                            isPresented = false
                        }
                    }
                    .disabled(mealName.isEmpty || calories.isEmpty || selectedImage == nil)
                }
            }
            .navigationBarTitle("새로운 식사 추가")
            .navigationBarItems(trailing: Button("취소") {
                isPresented = false
            })
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}
