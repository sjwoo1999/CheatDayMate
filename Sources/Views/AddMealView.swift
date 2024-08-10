//
//  AddMealView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct AddMealView: View {
    @ObservedObject var viewModel: DietRecordViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var mealName = ""
    @State private var mealTime = Date()
    @State private var calories = 0
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("식사 이름", text: $mealName)
                DatePicker("시간", selection: $mealTime, displayedComponents: .hourAndMinute)
                Stepper("칼로리: \(calories)", value: $calories, in: 0...5000)
                
                Button("사진 추가") {
                    // 이미지 피커 로직 구현
                }
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
            }
            .navigationBarTitle("식사 추가", displayMode: .inline)
            .navigationBarItems(
                leading: Button("취소") { presentationMode.wrappedValue.dismiss() },
                trailing: Button("저장") {
                    let newMeal = Meal(name: mealName, time: mealTime, calories: calories, imageData: image?.pngData())
                    viewModel.addMeal(newMeal)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
