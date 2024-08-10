//
//  DateFormatter.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

extension DateFormatter {
    static let cheatDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
