//
//  UserDefaults+Extension.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

@propertyWrapper
struct UserDefault<T> {
    private let key: String
    private let defaultValue: T
    
    private var container: UserDefaults = .standard
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set {
                container.set(newValue, forKey: key)
        }
    }
    
    var projectedValue: T {
        return defaultValue
    }
}

extension UserDefaults {
    
    @UserDefault(key: "LEDBoardText", defaultValue: "")
    static var text: String

    @UserDefault(key: "LEDBoardColor", defaultValue: UIColor.random.cgColor.components!)
    static var color: [CGFloat]
    
    // wrappedValue = projectedValue
    static func resetUserDefaults() {
        
        text = $text
        color = $color
    }
}
