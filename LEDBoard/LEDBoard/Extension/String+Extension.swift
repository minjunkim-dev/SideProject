//
//  String+Extension.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/16.
//

import Foundation

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
