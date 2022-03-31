//
//  Date+Extension.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/31.
//

import Foundation

extension Date {

    func convertToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone(identifier: TimeZone.autoupdatingCurrent.identifier)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
