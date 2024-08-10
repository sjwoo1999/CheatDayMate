//
//  String+Validation.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

extension String {
    var isValidUsername: Bool {
        // Username should be 3-20 characters, alphanumeric and underscores only
        let usernameRegex = "^[a-zA-Z0-9_]{3,20}$"
        return NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        // Simple phone number validation for Korea (010-XXXX-XXXX or 010XXXXXXXX)
        let phoneRegex = "^010([0-9]{4})([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: self)
    }
}
