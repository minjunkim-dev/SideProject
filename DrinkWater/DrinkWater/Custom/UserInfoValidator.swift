//
//  UserInfoValidator.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import Foundation

enum UserInfo: Int {
    case nickname
    case height
    case weight
    case intake
}

extension UserInfo {
    
    var title: String? {
        switch self {
        case .nickname:
            return "닉네임을 설정해주세요"
        case .height:
            return "키(cm)를 설정해주세요"
        case .weight:
            return "몸무게(kg)를 설정해주세요"
        case .intake:
            return nil
        }
    }
}

final class UserInfoValidator {
    
    static let shared = UserInfoValidator()
    
    private init() {}
    
    func range(info: UserInfo) -> ClosedRange<Int> {
        switch info {
        case .nickname: return 1...10
        case .height, .weight: return 2...3
        case .intake: return 2...4
        }
    }
    
    func regex(info: UserInfo) -> String {
        switch info {
        case .nickname:
            return "[가-힣A-Za-z0-9]{1,10}" // 대소문자, 숫자를 포함한 1 ~ 10자
        case .height, .weight:
            return "[1-9]{1}[0-9]{1,2}"
        case .intake:
            return "[1-9]{1}[0-9]{1,3}"
        }
    }
    
    func validate(target: String, regex: String) -> Bool {
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: target)
    }
}
