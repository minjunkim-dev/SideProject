//
//  UserDefaults+Extension.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/26.
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
    
    @UserDefault(key: Emotion.fun.description, defaultValue: 0)
    static var fun: Int
    
    @UserDefault(key: Emotion.happy.description, defaultValue: 0)
    static var happy: Int
    
    @UserDefault(key: Emotion.lovely.description, defaultValue: 0)
    static var lovely: Int
    
    @UserDefault(key: Emotion.angry.description, defaultValue: 0)
    static var angry: Int
    
    @UserDefault(key: Emotion.helpless.description, defaultValue: 0)
    static var helpless: Int
    
    @UserDefault(key: Emotion.tired.description, defaultValue: 0)
    static var tired: Int
    
    @UserDefault(key: Emotion.embarrassed.description, defaultValue: 0)
    static var perplexed: Int
    
    @UserDefault(key: Emotion.depressed.description, defaultValue: 0)
    static var depressed: Int
    
    @UserDefault(key: Emotion.upset.description, defaultValue: 0)
    static var upset: Int
    
    // wrappedValue = projectedValue
    static func resetUserDefaults() {
        fun = $fun
        happy = $happy
        lovely = $lovely
        angry = $angry
        helpless = $helpless
        tired = $tired
        perplexed = $perplexed
        depressed = $depressed
        upset = $upset
    }
}

enum Emotion: Int, CaseIterable {
    case fun
    case happy
    case lovely
    case angry
    case helpless
    case tired
    case embarrassed
    case depressed
    case upset
    
    var description: String {
        switch self {
        case .fun: return "emotion1".localized()
        case .happy: return "emotion2".localized()
        case .lovely: return "emotion3".localized()
        case .angry: return "emotion4".localized()
        case .helpless: return "emotion5".localized()
        case .tired: return "emotion6".localized()
        case .embarrassed: return "emotion7".localized()
        case .depressed: return "emotion8".localized()
        case .upset: return "emotion9".localized()
        }
    }
    
    var image: UIImage {
        switch self {
        case .fun: return Assets.fun.image
        case .happy: return Assets.happy.image
        case .lovely: return Assets.lovely.image
        case .angry: return Assets.angry.image
        case .helpless: return Assets.helpless.image
        case .tired: return Assets.tired.image
        case .embarrassed: return Assets.embarrassing.image
        case .depressed: return Assets.depressed.image
        case .upset: return Assets.upset.image
        }
    }
}
