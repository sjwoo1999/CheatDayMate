//
//  DietRecordViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import Foundation
import Combine

class DietRecordViewModel: ObservableObject {
    @Published var meals: [CheatDayMate.Meal] = []
    @Published var selectedDate: Date = Date()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMeals()
        
        $selectedDate
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.loadMeals()
            }
            .store(in: &cancellables)
    }
    
    func loadMeals() {
        // 실제 앱에서는 여기서 데이터베이스나 API에서 식사 데이터를 로드합니다.
        meals = CheatDayMate.Meal.sampleMeals.filter { Calendar.current.isDate($0.time, inSameDayAs: selectedDate) }
    }
    
    func addMeal(_ meal: CheatDayMate.Meal) {
        meals.append(meal)
        // 실제 앱에서는 여기서 데이터를 저장합니다.
    }
    
    func deleteMeal(at offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
        // 실제 앱에서는 여기서 데이터를 삭제합니다.
    }
}
