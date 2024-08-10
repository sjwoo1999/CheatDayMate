//
//  DataPersistenceService.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import Foundation

class DataPersistenceService {
    private let userDefaults = UserDefaults.standard
    
    func save<T: Encodable>(_ object: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(object)
        userDefaults.set(data, forKey: key)
    }
    
    func load<T: Decodable>(forKey key: String) throws -> T {
        guard let data = userDefaults.data(forKey: key) else {
            throw PersistenceError.dataNotFound
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum PersistenceError: Error {
    case dataNotFound
}
