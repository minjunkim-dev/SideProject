//
//  Date+Extension.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import Foundation

extension Date {

    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone(identifier: TimeZone.autoupdatingCurrent.identifier)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
