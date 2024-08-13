//
//  WelcomeView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct WelcomeView: View {
    @State private var path = NavigationPath()
    @State private var isPresented = false
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack(path: $path) {
                welcomeContent
            }
        } else {
            NavigationView {
                welcomeContent
            }
        }
    }
    
    @ViewBuilder
    var welcomeContent: some View {
        VStack(spacing: 20) {
            Text("CheatDayMate에 오신 것을 환영합니다!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("건강한 식단 관리를 시작해보세요.")
                .font(.subheadline)
            
            if #available(iOS 16.0, *) {
                NavigationLink("식단 기록", value: "dietRecord")
                NavigationLink("식사 추가", value: "addMeal")
            } else {
                NavigationLink(destination: DietRecordView()) {
                    Text("식단 기록")
                }
                NavigationLink(destination: AddMealView(viewModel: DietRecordViewModel(apiKey: AppConfig.chatGPTAPIKey), isPresented: $isPresented)) {
                    Text("식사 추가")
                }
            }
        }
        .padding()
        .navigationDestination(for: String.self) { value in
            switch value {
            case "dietRecord":
                DietRecordView()
            case "addMeal":
                AddMealView(viewModel: DietRecordViewModel(apiKey: AppConfig.chatGPTAPIKey), isPresented: $isPresented)
            default:
                EmptyView()
            }
        }
    }
}
