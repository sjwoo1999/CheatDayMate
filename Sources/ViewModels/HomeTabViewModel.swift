//
//  HomeTabViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class HomeTabViewModel: ObservableObject {
    @Published private(set) var currentCalories: Int
    @Published private(set) var goalCalories: Int
    @Published private(set) var catState: CatState
    @Published var tabBarViewModel = CustomTabBarViewModel()
    
    enum CatState {
        case slim, chubby
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }
    
    var progress: Double {
        Double(currentCalories) / Double(goalCalories)
    }
    
    var catMessage: String {
        switch catState {
        case .slim: return "지금 잘하고 있어요!\n이대로 쭉쭉 고고"
        case .chubby: return "너무 많이 먹었어요!\n조금만 줄여보세요"
        }
    }
    
    var catImage: String {
        switch catState {
        case .slim: return "SlimCat"
        case .chubby: return "ChubbyCat"
        }
    }
    
    // 수정된 init() 메서드
    init(currentCalories: Int = 130000, goalCalories: Int = 150000) {
        // 먼저 currentCalories와 goalCalories를 초기화
        self.currentCalories = currentCalories
        self.goalCalories = goalCalories
        
        // 프로퍼티 초기화 후 catState를 설정
        if Double(currentCalories) / Double(goalCalories) < 0.5 {
            self.catState = .slim
        } else {
            self.catState = .chubby
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
