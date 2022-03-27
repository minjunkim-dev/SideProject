//
//  String+Extension.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/27.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
