//
//  UserDefaults+Extension.swift
//  ToDoList
//
//  Created by beneDev on 2022/04/01.
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
                    print("get에서 decoding 실패!")
                    return data as? T ?? defaultValue
                }
        
            } else {
                print("get에서 Data로 가져오기 실패!")
                return container.object(forKey: key) as? T ?? defaultValue
            }
      
        }
        set {
            
            var data: Data
                
            do {
                data = try encoder.encode(newValue)
                print("set에서 encoding 성공!")
                container.set(data, forKey: key)
            } catch {
                print("set에서 encoding 실패!")
                container.set(newValue, forKey: key)
            }
        }
    }
    
    var projectedValue: T {
        return defaultValue
    }
}

extension UserDefaults {
    
    @UserDefault(key: "pinnedData", defaultValue: [])
    static var pinnedData: [ToDo]
    
    @UserDefault(key: "unpinnedData", defaultValue: [])
    static var unpinnedData: [ToDo]

    // wrappedValue = projectedValue
    static func resetUserDefaults() {
        pinnedData = $pinnedData
        unpinnedData = $unpinnedData
    }
}

