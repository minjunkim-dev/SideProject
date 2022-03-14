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
}
