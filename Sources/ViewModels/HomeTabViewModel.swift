//
//  HomeTabViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class HomeTabViewModel: ObservableObject {
    @Published private(set) var currentCalories = 0
    @Published private(set) var goalCalories = 27920
    @Published private(set) var catState: CatState = .slim
    @Published var tabBarViewModel = CustomTabBarViewModel()
    
    enum CatState {
        case slim, chubby
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.(E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: Date())
    }
    
    var progress: Double {
        Double(currentCalories) / Double(goalCalories)
    }
    
    var catMessage: String {
        switch catState {
        case .slim: return "배고파요!"
        case .chubby: return "과식했어요!"
        }
    }
    
    var catAdvice: String {
        switch catState {
        case .slim: return "조금 더 먹어도 돼요."
        case .chubby: return "운동을 해보는 건 어떨까요?"
        }
    }
    
    var catImage: String {
        switch catState {
        case .slim: return "SlimCat"
        case .chubby: return "ChubbyCat"
        }
    }
    
    func addCalories(_ amount: Int) {
        currentCalories = max(0, min(currentCalories + amount, goalCalories))
        updateCatState()
    }
    
    private func updateCatState() {
        catState = progress < 0.5 ? .slim : .chubby
    }
}
