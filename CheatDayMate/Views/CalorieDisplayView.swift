//
//  CalorieDisplayView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct CalorieDisplayView: View {
    let current: Int
    let goal: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)))
                .frame(width: CGFloat(current) / CGFloat(goal) * UIScreen.main.bounds.width - 40, height: 20)
        }
        .overlay(
            Text("\(current) / \(goal) kcal")
                .font(.caption)
                .foregroundColor(.white)
        )
    }
}

struct CalorieDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieDisplayView(current: 1500, goal: 2000)
    }
}
