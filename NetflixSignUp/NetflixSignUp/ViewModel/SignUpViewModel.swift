//
//  SignUpViewModel.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/10.
//

enum SignUpRequiredUserInfoInvalid {
    case notEnteredIDorPassword
    case identifierInvalid
    case passwordInvalid
}

enum SignUpAdditionalUserInfoInvalid {
    case nicknameInvalid
    case locationInvalid
    case refferalCodeInvalid
}

import Foundation

final class SignUpViewModel {
    
    var user = User()
    
    var identifier: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var nickname: Observable<String?> = Observable(nil)
    var location: Observable<String?> = Observable(nil)
    var referralCode: Observable<String?> = Observable(nil)
    
    func validateRequiredUserInfo() -> (Bool, SignUpRequiredUserInfoInvalid?) {
        
        /* 아이디와 비밀번호는 필수 기입 */
        guard !(identifier.value.isEmpty),
              !(password.value.isEmpty) else {
        
            return (false, .notEnteredIDorPassword)
        }
        
        let emailRegex = SignUpValidationType.email.regex
        let phoneNumberRegex = SignUpValidationType.phoneNumber.regex
        
        let passwordRegex = SignUpValidationType.password.regex
        
        if !(SignUpValidationType.validate(value: identifier.value, regex: emailRegex) || SignUpValidationType.validate(value: identifier.value, regex: phoneNumberRegex)) {
            
            return (false, .identifierInvalid)
        }
        
        if !(SignUpValidationType.validate(value: password.value, regex: passwordRegex)) {
    
            return (false, .passwordInvalid)
        }
        
        user.identifier = identifier.value
        user.password = password.value
        
        return (true, nil)
    }
    
    func validateAdditionalUserInfo() -> (Bool, SignUpAdditionalUserInfoInvalid?) {
        
        let nicknameRegex = SignUpValidationType.nickname.regex
        let locationRegex = SignUpValidationType.location.regex
        let referralRegex = SignUpValidationType.referralCode.regex
        
        if let nickname = nickname.value, !(nickname.isEmpty) {
            if !(SignUpValidationType.validate(value: nickname, regex: nicknameRegex)) {
                
                return (false, .nicknameInvalid)
            }
        }
       
        
        if let location = location.value, !(location.isEmpty) {
            if !(SignUpValidationType.validate(value: location, regex: locationRegex)) {
          
                return (false, .locationInvalid)
            }
        }
        
        
        if let referralCode = referralCode.value, !(referralCode.isEmpty) {
            if !(SignUpValidationType.validate(value: referralCode, regex: referralRegex)) {
                
          
                return (false, .refferalCodeInvalid)
            }
        }
        
        user.nickname = nickname.value
        user.location = location.value
        user.referralCode = referralCode.value
        
        return (true, nil)
    }
}
