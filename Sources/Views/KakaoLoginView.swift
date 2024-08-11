//
//  KakaoLoginView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct KakaoLoginView: View {
    @StateObject private var viewModel = KakaoLoginViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button("Login with Kakao") {
                    viewModel.loginWithKakao()
                }
                .padding()
                .background(Color.yellow)
                .foregroundColor(.black)
                .cornerRadius(10)
            }
            
            NavigationLink(value: "SuccessView"){
                Text("Go to Success View")
            }
            .navigationDestination(for: String.self) { value in
                if value == "HomeTabView" {
                    HomeTabView(authService: AuthService(), chatGPTService: ChatGPTService(apiKey: AppConfig.chatGPTAPIKey))
                }
            }
        }
    }
}
