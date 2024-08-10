//
//  ViewModelProtocol.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype InputType
    associatedtype OutputType
    
    func transform(input: InputType) -> OutputType
}

extension ViewModelProtocol {
    func callAsFunction(_ input: InputType) -> OutputType {
        transform(input: input)
    }
}
