//
//  AuthService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation
import Combine

class AuthService: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    
    func handleKakaoLogin(success: Bool) {
        isUserLoggedIn = success
    }
}
