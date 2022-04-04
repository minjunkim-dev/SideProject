//
//  String+Extension.swift
//  ToDoList
//
//  Created by beneDev on 2022/04/04.
//

import Foundation

extension String {
    
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
