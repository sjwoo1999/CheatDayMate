//
//  LoginView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Image("CheatDayMateLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("Login or sign up")
                .font(.title)
            
            Button("카카오로 시작하기") {
                viewModel.loginWithKakao()
            }
            .padding()
            .background(Color.yellow)
            .foregroundColor(.black)
            .cornerRadius(10)
            
            Button("Continue with Phone") {
                viewModel.loginWithPhone()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            HStack {
                Image("GoogleLogo")
                Image("AppleLogo")
            }
            
            Text("Terms & Conditions and Privacy Policy will apply.")
                .font(.caption)
            
            NavigationLink(value: "KakaoLoginView"){
               Text("Go to Kakao Login View")
            }
            .navigationDestination(for: String.self) { value in
                if value == "KakaoLoginView" {
                    KakaoLoginView()
                }
            }
        }
        .padding()
    }
}
