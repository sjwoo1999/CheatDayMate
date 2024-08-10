//
//  AuthService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth

class AuthService {
    func loginWithKakao() async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    self.handleKakaoLogin(oauthToken: oauthToken, error: error, continuation: continuation)
                }
            } else {
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    self.handleKakaoLogin(oauthToken: oauthToken, error: error, continuation: continuation)
                }
            }
        }
    }

    private func handleKakaoLogin(oauthToken: OAuthToken?, error: Error?, continuation: CheckedContinuation<User, Error>) {
        if let error = error {
            continuation.resume(throwing: AppError.authError(error.localizedDescription))
            return
        }
        
        UserApi.shared.me() { (user, error) in
            if let error = error {
                continuation.resume(throwing: AppError.authError(error.localizedDescription))
            } else if let account = user?.kakaoAccount {
                let user = User(id: String(user?.id ?? 0),
                                username: account.profile?.nickname ?? "",
                                email: account.email ?? "")
                continuation.resume(returning: user)
            } else {
                continuation.resume(throwing: AppError.authError("Failed to get user information"))
            }
        }
    }
}
