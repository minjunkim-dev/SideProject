//
//  Emotion.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/29.
//

import UIKit

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
