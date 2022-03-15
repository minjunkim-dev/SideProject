//
//  SignUpViewModel.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/10.
//

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
        
        let emailRegex = SignUpUserInfoValid.email.regex
        let phoneNumberRegex = SignUpUserInfoValid.phoneNumber.regex
        
        let passwordRegex = SignUpUserInfoValid.password.regex
        
        if !(SignUpUserInfoValid.validate(value: identifier.value, regex: emailRegex) || SignUpUserInfoValid.validate(value: identifier.value, regex: phoneNumberRegex)) {
            
            return (false, .identifierInvalid)
        }
        
        if !(SignUpUserInfoValid.validate(value: password.value, regex: passwordRegex)) {
    
            return (false, .passwordInvalid)
        }
        
        user.identifier = identifier.value
        user.password = password.value
        
        return (true, nil)
    }
    
    func validateAdditionalUserInfo() -> (Bool, SignUpAdditionalUserInfoInvalid?) {
        
        let nicknameRegex = SignUpUserInfoValid.nickname.regex
        let locationRegex = SignUpUserInfoValid.location.regex
        let referralRegex = SignUpUserInfoValid.referralCode.regex
        
        if let nickname = nickname.value, !(nickname.isEmpty) {
            if !(SignUpUserInfoValid.validate(value: nickname, regex: nicknameRegex)) {
                
                return (false, .nicknameInvalid)
            }
        }
       
        
        if let location = location.value, !(location.isEmpty) {
            if !(SignUpUserInfoValid.validate(value: location, regex: locationRegex)) {
          
                return (false, .locationInvalid)
            }
        }
        
        
        if let referralCode = referralCode.value, !(referralCode.isEmpty) {
            if !(SignUpUserInfoValid.validate(value: referralCode, regex: referralRegex)) {
                
          
                return (false, .refferalCodeInvalid)
            }
        }
        
        user.nickname = nickname.value
        user.location = location.value
        user.referralCode = referralCode.value
        
        return (true, nil)
    }
}
