//
//  CustomConfiguration.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct CustomButtonStyleConfiguration {
    let label: AnyView
    let isPressed: Bool
    
    init<Label: View>(label: Label, isPressed: Bool) {
        self.label = AnyView(label)
        self.isPressed = isPressed
    }
}

extension ButtonStyle where Self == InputButtonStyle {
    static var custom: InputButtonStyle { InputButtonStyle() }
}
