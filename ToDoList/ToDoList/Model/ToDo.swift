//
//  ToDo.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//



import Foundation

struct ToDo: Codable {
    var content: String
    var category: Category?
    var isCompleted: Bool = false
    var isPinned: Bool = false
    var date: Date = Date()
}

//extension ToDo: Equatable {
//
//    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
//        return (lhs.content == rhs.content) &&
//        (lhs.category == rhs.category) &&
//        (lhs.isCompleted == rhs.isCompleted) &&
//        (lhs.isPinned == rhs.isPinned)
//    }
//}

enum Category: Int, CaseIterable, Codable {
    
    case business = 1
    case personal
    case others
    
    var description: String {
        switch self {
        case .business:
            return "segment2".localized()
        case .personal:
            return "segment3".localized()
        case .others:
            return "segment4".localized()
        }
    }
}
