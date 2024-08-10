//
//  WelcomeViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    @Published var navigationDestination: String?
    
    func navigateToLogin() {
        navigationDestination = "LoginView"
    }
    
    func navigateToHome() {
        navigationDestination = "HomeTabView"
    }
}
