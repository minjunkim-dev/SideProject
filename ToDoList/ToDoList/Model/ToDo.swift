//
//  ToDo.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//



import Foundation

struct ToDo {
    var content: String
    var category: Category?
    var isCompleted: Bool = false
    var isPinned: Bool = false
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

enum Category: Int, CaseIterable {
    
    case business = 1
    case personal
    case others
    
    var description: String {
        switch self {
        case .business:
            return "업무"
        case .personal:
            return "개인"
        case .others:
            return "기타"
        }
    }
}
