//
//  Calendar+Extension.swift
//  ToDoList
//
//  Created by beneDev on 2022/04/01.
//

import Foundation

extension Calendar {
    
    func intervalOfWeek(for date: Date) -> DateInterval? {
        dateInterval(of: .weekOfYear, for: date)
    }

    func startOfWeek(for date: Date) -> Date? {
        intervalOfWeek(for: date)?.start
    }
    
    func endOfWeek(for date: Date) -> Date? {
        intervalOfWeek(for: date)?.end
    }
}
