//
//  ToDo.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//



import Foundation

struct ToDo {
    var content: String
    var category: Category
}

enum Category: CaseIterable {
    
    case all
    case business
    case personal
    case others
    
    var description: String {
        switch self {
        case .all:
            return "전체"
        case .business:
            return "업무"
        case .personal:
            return "개인"
        case .others:
            return "기타"
        }
    }
}
