//
//  DataStorageService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 13.12.23.
//

import UIKit

final class DataStorageService {
    
    static let shared = DataStorageService()
    private let userDefaults = UserDefaults.standard
    static let userKey = "User01"
    
    private init() {}
    
    func saveData(with key: String, value: Weather) {
        if let encoded = try? JSONEncoder().encode(value) {
            userDefaults.set(encoded, forKey: key)
        }
         userDefaults.synchronize()
    }
    
    func loadData(with key: String, completion: @escaping (Weather?) -> Void) {
        DispatchQueue.global().async {
            if let data = self.userDefaults.object(forKey: key) as? Data,
               let weather = try? JSONDecoder().decode(Weather.self, from: data) {
                DispatchQueue.main.async {
                    completion(weather)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    
    func removeData(with key: String) {
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
}
