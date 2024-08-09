//
//  ViewRouter.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .onboarding

    enum Page {
        case onboarding
        case home
        case login
        case signUp
    }

    func navigateToHome() {
        currentPage = .home
    }
}
