//
//  KakaoLoginViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class KakaoLoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isLoggedIn = false
    
    func loginWithKakao() {
        isLoading = true
        // 카카오 로그인 로직 구현
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
            self.isLoggedIn = true
        }
    }
}
