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
    
    func getFormat(calendar: Calendar = Calendar.autoupdatingCurrent) -> String {
    
        let isToday = calendar.isDateInToday(self)
        if isToday {
            return "a HH:mm"
        }
        
        let startDate = calendar.startOfWeek(for: self)!
        let endDate = calendar.endOfWeek(for: self)!
        return self.isBetween(startDate: startDate, endDate: endDate) ?
        "EEEE" :
        "yy/M/d"
    }
    
    func isBetween(startDate: Date, endDate: Date) -> Bool {
        return (startDate.compare(self) == .orderedAscending) &&
        (endDate.compare(self) == .orderedDescending)
    }
}
