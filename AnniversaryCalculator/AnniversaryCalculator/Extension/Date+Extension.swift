//
//  Date+Extension.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
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
    
    func addDays(day: Int) -> Date {
        
        let secondsOfDay = 24 * 60 * 60 // 시, 분, 초
        return self.addingTimeInterval(TimeInterval(day * secondsOfDay))
    }
}
