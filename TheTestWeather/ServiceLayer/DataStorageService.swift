//
//  DataStorageService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 13.12.23.
//

import UIKit

class DataStorageService {
    
    static let userKey = "User000"
    
    static func saveData(_ data: Any, forKey key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func loadData(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func removeData(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func hasData(forKey key: String) -> Bool {
           return UserDefaults.standard.object(forKey: key) != nil
       }
}



