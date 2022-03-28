//
//  String+Extension.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import Foundation

extension String {
    
    func convertToGMT(format: String) -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first!)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        return formatter.date(from: self) ?? Date()
    }
}
