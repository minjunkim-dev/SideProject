//
//  UserDefaults+Extension.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/05.
//

import UIKit

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    private var container: UserDefaults = .standard
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        
        get {
            
            if let data = container.object(forKey: key) as? Data {
        
                do {
                    return try decoder.decode(T.self, from: data)
                } catch{
                    return data as? T ?? defaultValue
                }
        
            } else {
                return container.object(forKey: key) as? T ?? defaultValue
            }
      
        }
        set {
            
            var data: Data
                
            do {
                data = try encoder.encode(newValue)
                container.set(data, forKey: key)
            } catch {
                container.set(newValue, forKey: key)
            }
        }
    }
    
    var projectedValue: T {
        return defaultValue
    }
}

extension UserDefaults {
    
    @UserDefault(key: "nickname", defaultValue: "")
    static var nickname: String
    
    @UserDefault(key: "height", defaultValue: 160)
    static var height: Int // cm
    
    @UserDefault(key: "weight", defaultValue: 50)
    static var weight: Int // cm
    
    @UserDefault(key: "todayIntake", defaultValue: 1200)
    static var todayIntake: Int // ml
    
    @UserDefault(key: "lastIntake", defaultValue: 500)
    static var lastIntake: Int // ml
    
    // wrappedValue = projectedValue
    static func resetUserDefaults() {
        nickname = $nickname
        height = $height
        weight = $weight
        todayIntake = $todayIntake
        lastIntake = $lastIntake
    }
}
