//
//  SignUpValidator.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/12.
//

import Foundation

enum SignUpValidationType {
    
    /* identifier */
    case email
    case phoneNumber
    
    /* password */
    case password
    
    /* nickname */
    case nickname
    
    /* location */
    case location
    
    /* referral code */
    case referralCode
}


extension SignUpValidationType {
    
    var range: ClosedRange<Int> {
        switch self {
        case .email: return 6...30
        case .phoneNumber: return 11...11
        case .password: return 10...20
        case .nickname: return 1...10
        case .location: return 1...20
        case .referralCode: return 6...6
        }
    }
    
    var regex: String {
        switch self {
        case .email:
            return "[A-Za-z0-9._-]{1,25}+@[A-Za-z]{1,}+\\.[A-Za-z]{2,}" // 대소문자, 숫자, 특수문자를 포함한 6 ~ 30자
        case .phoneNumber:
            return "^010[0-9]{4}[0-9]{4}$" // 010 **** ****(010을 포함한 11자리)
        case .password:
            return "[A-Za-z0-9`~!@#$%^&*()-_=+;:,.<>/?]{10,20}" // 대소문자, 숫자, 특수문자를 포함한 10 ~ 20자
        case .nickname:
            return "[가-힣A-Za-z0-9]{1,10}" // 대소문자, 숫자를 포함한 1 ~ 10자
        case .location:
            return "[가-힣A-Za-z]{1,20}" // 대소문자를 포함한 1 ~ 20자
        case .referralCode:
            return "^\\d{6}$" // 숫자 6자리
        }
    }
    
    static func validate(value: String, regex: String) -> Bool {
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: value)
    }
}
