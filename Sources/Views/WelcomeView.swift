//
//  WelcomeView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "house.fill") // Placeholder for CheatDayMateLogo
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                Text("Welcome to Cheat Day Mate")
                    .font(.title)
                
                Text("This is a MVP version of Cheat Day Mate.")
                    .font(.subheadline)
                
                Text("Hope you enjoy it :)")
                    .font(.subheadline)
                
                NavigationLink(destination: LoginView(), isActive: Binding(
                    get: { viewModel.navigationDestination == "LoginView" },
                    set: { isActive in
                        if !isActive {
                            viewModel.navigationDestination = nil
                        }
                    }
                )) {
                    Button("Get started") {
                        viewModel.navigateToLogin()
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: HomeTabView(authService: AuthService(), chatGPTService: ChatGPTService(apiKey: AppConfig.chatGPTAPIKey)), isActive: Binding(
                    get: { viewModel.navigationDestination == "HomeTabView" },
                    set: { isActive in
                        if !isActive {
                            viewModel.navigationDestination = nil
                        }
                    }
                )) {
                    Button("Go to Home") {
                        viewModel.navigateToHome()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
