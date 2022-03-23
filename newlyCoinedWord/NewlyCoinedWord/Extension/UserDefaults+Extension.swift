//
//  UserDefaults+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/23.
//

import UIKit

@propertyWrapper
struct UserDefault<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    private var container: UserDefaults = .standard
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
//            return container.object(forKey: key) as? T ?? defaultValue
            if let data = container.value(forKey: key) as? Data {
                do {
                    return try PropertyListDecoder().decode(T.self, from: data)
                } catch {
                    return defaultValue
                }
            } else {
                return defaultValue
            }
        }
        set {
            //            container.set(newValue, forKey: key)
            container.set(try? PropertyListEncoder().encode(newValue), forKey: key)
            
        }
    }
    
    var projectedValue: T {
        return defaultValue
    }
}

extension UserDefaults {
    
    @UserDefault(key: "wordList", defaultValue: [])
    static var wordList: [NewlyCoinedWord]
    
    // wrappedValue = projectedValue
    static func resetUserDefaults() {
        
        wordList = $wordList
    }
}
