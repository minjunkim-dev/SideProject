//
//  ToDoDelegate.swift
//  ToDoList
//
//  Created by beneDev on 2022/04/02.
//

import Foundation

protocol ToDoDelegate {
    func updateIsCompleted(isCompleted: Bool, indexPath: IndexPath?)
    func reloadSection(section: Int)
}
