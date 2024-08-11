//
//  CustomTabBarViewModel.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

class CustomTabBarViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    
    func selectTab(_ tab: Int) {
        selectedTab = tab
    }
}
