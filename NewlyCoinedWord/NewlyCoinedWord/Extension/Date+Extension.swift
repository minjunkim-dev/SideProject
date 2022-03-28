//
//  Date+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/25.
//

import Foundation

extension Date { // Date는 TimeZone을 바꾸더라도 항상 UTC 기준임을 명심!
    
    static func isFirstDayOfMonth(date: Date = Date()) -> Bool {
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: Locale.preferredLanguages.first!)
        calendar.timeZone = TimeZone(identifier: TimeZone.autoupdatingCurrent.identifier)!

//        print(toString(format: "yyyy-MM-dd", date: date))
        
        let components = calendar.dateComponents([.day], from: date)
        if let day = components.day, day == 1 {
            return true
        } else {
            return false
        }
    }
    
    static func printLocaleIdList() {
        print(Locale.availableIdentifiers)
    }
    
    static func printTimeZoneIdList() {
        print(TimeZone.knownTimeZoneIdentifiers)
    }
    
    static func printTimeZoneAbbrDict() {
        print(TimeZone.abbreviationDictionary)
    }
    
    static func toString(format: String, date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: Locale.autoupdatingCurrent.identifier)
        formatter.timeZone = TimeZone(identifier: TimeZone.autoupdatingCurrent.identifier)
        return formatter.string(from: date)
    }
}
