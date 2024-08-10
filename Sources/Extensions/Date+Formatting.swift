//
//  Date+Formatting.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd (E)"
        return formatter.string(from: self)
    }
}
