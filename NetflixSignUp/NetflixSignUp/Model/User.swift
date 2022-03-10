//
//  User.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/10.
//

import Foundation

struct User {
    /* 필수정보 */
    var identifier: String
    var password: String
    /* 추가정보 */
    var nickname: String?
    var location: String?
    var referralCode: String?
    
    init(identifier: String = "", password: String = "", nickname: String?, location: String?, referralCode: String?) {
        self.identifier = identifier
        self.password = password
        self.nickname = nickname
        self.location = location
        self.referralCode = referralCode
    }
}
