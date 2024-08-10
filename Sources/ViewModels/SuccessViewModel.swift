//
//  SuccessViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class SuccessViewModel: ObservableObject {
    @Published var shouldNavigateToHome = false
    
    func navigateToHome() {
        shouldNavigateToHome = true
    }
}
