//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by beneDev on 2022/04/02.
//

import UIKit

final class ToDoListViewModel {
    
    var delegate: ToDoDelegate?
    
    var pinnedData: [ToDo] = [] {
        didSet {
            savePinnedData()
            delegate?.reloadSection(section: 0)
        }
    }

    var unpinnedData: [ToDo] = [] {
        didSet {
            saveUnpinnedData()
            delegate?.reloadSection(section: 1)
        }
    }

    private func loadPinnedData() {
        pinnedData = UserDefaults.pinnedData
    }

    private func loadUnpinnedData() {
        unpinnedData = UserDefaults.unpinnedData
    }

    private func savePinnedData() {
        UserDefaults.pinnedData = pinnedData
    }

    private func saveUnpinnedData() {
        UserDefaults.unpinnedData = unpinnedData
    }
    
    func addData(data: ToDo, completion: @escaping () -> Void) {
        data.isPinned ? pinnedData.insert(data, at: 0) : unpinnedData.insert(data, at: 0)
        completion()
    }
    
    func updateIsCompleted(section: Int, index: Int, isCompletion: Bool) {
        section == 0 ? (pinnedData[index].isCompleted = isCompletion) : (unpinnedData[index].isCompleted = isCompletion)
    }
    
    func loadData(section: Int) {
        
        section == 0 ? loadPinnedData() : loadUnpinnedData()
    }
}

extension ToDoListViewModel {
    
    var numberOfSections: Int {
        return 2
    }
    
    var titleForHeaderInSection: [String] {
        return ["고정된 할 일", "할 일"]
    }
    
    var headerViewTextColor: [UIColor] {
        return [.lightGray, .lightGray]
    }
    
    func numberOfRowsInSection(section: Int, category: Category?) -> Int {
        
        switch category {
        case .business:
            return section == 0 ? pinnedData.filter { $0.category == .business }.count : unpinnedData.filter { $0.category == .business }.count
        case .personal:
            return section == 0 ? pinnedData.filter { $0.category == .personal }.count : unpinnedData.filter { $0.category == .personal }.count
        case .others:
            return section == 0 ? pinnedData.filter { $0.category == .others }.count : unpinnedData.filter { $0.category == .others }.count
        default:
            return section == 0 ? pinnedData.count : unpinnedData.count
        }
    }
    
    func searchData(section: Int, row: Int, category: Category?) -> ToDo {
        
        switch category {
        case .business:
            return section == 0 ? pinnedData.filter { $0.category == .business }[row] : unpinnedData.filter { $0.category == .business }[row]
        case .personal:
            return section == 0 ? pinnedData.filter { $0.category == .personal }[row] : unpinnedData.filter { $0.category == .personal }[row]
        case .others:
            return section == 0 ? pinnedData.filter { $0.category == .others }[row] : unpinnedData.filter { $0.category == .others }[row]
        default:
            return section == 0 ? pinnedData[row] : unpinnedData[row]
        }
        
    }
    
    func searchIndices(section: Int, category: Category?) -> [Int] {
        
        switch category {
        case .business:
            return section == 0 ? pinnedData.enumerated().filter {
                $1.category == .business }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .business }.map { return $0.offset }
    
        case .personal:
            return section == 0 ? pinnedData.enumerated().filter {
                $1.category == .personal }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .personal }.map { return $0.offset }
            
        case .others:
            return section == 0 ? pinnedData.enumerated().filter {
                $1.category == .others }.map { return $0.offset }: unpinnedData.enumerated().filter {
                    $1.category == .others }.map { return $0.offset }
        
        default:
            return section == 0 ? pinnedData.enumerated().map { return $0.offset } : unpinnedData.enumerated().map { return $0.offset }
            
        }
    }
    
    func removeData(section: Int, index: Int) -> ToDo {
        
        return section == 0 ? pinnedData.remove(at: index) : unpinnedData.remove(at: index)
    }
    
    func insertData(section: Int, data: ToDo, index: Int) {
        
        var newData = data
        
        section == 0 ? (newData.isPinned = true) : (newData.isPinned = false)
        
        section == 0 ? pinnedData.insert(data, at: index) : unpinnedData.insert(data, at: index)
    }
}
