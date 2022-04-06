//
//  UserInfoValidation.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import Foundation

enum UserInfoValidation {
    
    case nickname
    case height
    case weight
    case intake
}

extension UserInfoValidation {
    
    var range: ClosedRange<Int> {
        switch self {
        case .nickname: return 1...10
        case .height, .weight: return 2...3
        case .intake: return 2...4
        }
    }
    
    var regex: String {
        switch self {
        case .nickname:
            return "[가-힣A-Za-z0-9]{1,10}" // 대소문자, 숫자를 포함한 1 ~ 10자
        case .height, .weight:
            return "[1-9]{1}[0-9]{1,2}"
        case .intake:
            return "[1-9]{1}[0-9]{1,3}"
        }
    }
}
