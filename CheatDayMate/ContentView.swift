//
//  ContentView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        Group {
            switch viewRouter.currentPage {
            case .onboarding:
                OnboardingView()
            case .home:
                HomeView()
            case .login:
                LoginView()
            case .signUp:
                SignUpView()
            }
        }
        .transition(.slide)
        .animation(.easeInOut, value: viewRouter.currentPage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(MainViewModel())
    }
}
