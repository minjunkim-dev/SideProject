//
//  String+Extension.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/14.
//

import Foundation

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
