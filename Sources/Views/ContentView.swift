//
//  ContentView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddMeal = false
    let chatGPTService = ChatGPTService(apiKey: AppConfig.chatGPTAPIKey)
    @StateObject private var viewModel = DietRecordViewModel(apiKey: AppConfig.chatGPTAPIKey)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("CheatDayMate")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    showingAddMeal = true
                }) {
                    Text("새로운 식사 추가")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("홈")
        }
        .sheet(isPresented: $showingAddMeal) {
                    AddMealView(viewModel: viewModel, isPresented: $showingAddMeal)
                }
    }
}


