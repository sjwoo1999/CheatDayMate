//
//  KakaoLoginViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import KakaoSDKAuth
import KakaoSDKUser

class KakaoLoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isLoggedIn = false
    
    func loginWithKakao() {
        isLoading = true
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                self.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                self.handleLoginResult(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    private func handleLoginResult(oauthToken: OAuthToken?, error: Error?) {
        DispatchQueue.main.async {
            self.isLoading = false
            if let error = error {
                print(error)
                self.isLoggedIn = false
            } else {
                self.isLoggedIn = true
            }
        }
    }
}
