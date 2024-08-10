//
//  LoginViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var shouldNavigateToKakaoLogin = false
    
    func loginWithKakao() {
        shouldNavigateToKakaoLogin = true
    }
    
    func loginWithPhone() {
        // Implement phone login logic
    }
}
