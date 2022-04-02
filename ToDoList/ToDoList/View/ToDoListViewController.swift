//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private let mainView = ToDoListView()
    
    var pinnedData: [ToDo] = [] {
        didSet {
            let sections = IndexSet(integer: 0)
            mainView.tableView.reloadSections(sections, with: .automatic)
            savePinnedData()
        }
    }
    
    var unpinnedData: [ToDo] = [] {
        didSet {
            let sections = IndexSet(integer: 1)
            mainView.tableView.reloadSections(sections, with: .automatic)
            saveUnpinnedData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPinnedData()
        loadUnpinnedData()
        
        navigationItem.title = "쇼핑"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.dragDelegate = self
        mainView.tableView.dragInteractionEnabled = true
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.segmentControl.addTarget(self, action: #selector(segmentIndexChanged), for: .valueChanged)
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
    
    @objc private func segmentIndexChanged() {
        reloadData()
    }
    
    private func reloadData() {
        let range = 0..<mainView.tableView.numberOfSections
        let sections = IndexSet(integersIn: range)
        mainView.tableView.reloadSections(sections, with: .automatic)
    }
    
    @objc private func addButtonClicked() {
    
        guard let content = mainView.toDoTextField.text, !(content.isEmpty) else {
            return
        }
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        let data = ToDo(content: content, category: category)
        addData(data: data)
    }
    
    private func addData(data: ToDo) {
        
        data.isPinned ? pinnedData.insert(data, at: 0) : unpinnedData.insert(data, at: 0)
    }
}

extension ToDoListViewController: ToDoDelegate {
    
    func updateIsCompleted(isCompleted: Bool, indexPath: IndexPath?) {
        
        guard let indexPath = indexPath else { return }
        
        let (section, row) = (indexPath.section, indexPath.row)
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        var indices: [Int]
        switch category {
        case .business:
            indices = section == 0 ? pinnedData.enumerated().filter { $1.category == .business }.map { $0.offset } : unpinnedData.enumerated().filter { $1.category == .business }.map { $0.offset }
        case .personal:
            indices = section == 0 ? pinnedData.enumerated().filter { $1.category == .personal }.map { $0.offset } : unpinnedData.enumerated().filter { $1.category == .personal }.map { $0.offset }
        case .others:
            indices = section == 0 ? pinnedData.enumerated().filter { $1.category == .others }.map { $0.offset } : unpinnedData.enumerated().filter { $1.category == .others }.map { $0.offset }
        default:
            indices = section == 0 ? pinnedData.enumerated().map { $0.offset } :  unpinnedData.enumerated().map { $0.offset }
        }
        
        section == 0 ? (pinnedData[indices[row]].isCompleted = isCompleted) : (unpinnedData[indices[row]].isCompleted = isCompleted)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // isPinned, or not
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "고정된 할 일" : "할 일"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = .lightGray
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let (section, row) = (indexPath.section, indexPath.row)
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        var data: ToDo
        switch category {
        case .business:
            data = section == 0 ? pinnedData.filter { $0.category == .business }[row] : unpinnedData.filter { $0.category == .business }[row]
        case .personal:
            data = section == 0 ? pinnedData.filter { $0.category == .personal }[row] : unpinnedData.filter { $0.category == .personal }[row]
        case .others:
            data = section == 0 ? pinnedData.filter { $0.category == .others }[row] : unpinnedData.filter { $0.category == .others }[row]
        default:
            data = section == 0 ? pinnedData[row] :  unpinnedData[row]
        }
       
        cell.delegate = self
        cell.configureCell(data: data, indexPath: indexPath)
        
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let (sourceSection, sourceRow) = (sourceIndexPath.section, sourceIndexPath.row)
        let (destinationSection, destinationRow) = (destinationIndexPath.section, destinationIndexPath.row)
    
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
    
        var filteredSourceIndices: [Int]
        var filteredDestinationIndices: [Int]
        switch category {
        case .business:
            filteredSourceIndices = sourceSection == 0 ? pinnedData.enumerated().filter {
                $1.category == .business }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .business }.map { return $0.offset }
            
            filteredDestinationIndices = destinationSection == 0 ? pinnedData.enumerated().filter {
                $1.category == .business }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .business }.map { return $0.offset }
        case .personal:
            filteredSourceIndices = sourceSection == 0 ? pinnedData.enumerated().filter {
                $1.category == .personal }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .personal }.map { return $0.offset }
            
            filteredDestinationIndices = destinationSection == 0 ? pinnedData.enumerated().filter {
                $1.category == .personal }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .personal }.map { return $0.offset }
        case .others:
            filteredSourceIndices = sourceSection == 0 ? pinnedData.enumerated().filter {
                $1.category == .others }.map { return $0.offset }: unpinnedData.enumerated().filter {
                    $1.category == .others }.map { return $0.offset }
            
            filteredDestinationIndices = destinationSection == 0 ? pinnedData.enumerated().filter {
                $1.category == .others }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .others }.map { return $0.offset }
        default:
            filteredSourceIndices = sourceSection == 0 ? pinnedData.enumerated().map { return $0.offset } : unpinnedData.enumerated().map { return $0.offset }
            
            filteredDestinationIndices = destinationSection == 0 ? pinnedData.enumerated().map { return $0.offset } : unpinnedData.enumerated().map { return $0.offset }
        }
        
        var data = sourceSection == 0 ? pinnedData.remove(at: filteredSourceIndices[sourceRow]) : unpinnedData.remove(at: filteredSourceIndices[sourceRow])
        
        if destinationSection == 0 {
            data.isPinned = true
            
            if destinationRow == 0 {
                pinnedData.insert(data, at: 0)
            } else if destinationRow == filteredDestinationIndices.count {
                pinnedData.insert(data, at: filteredDestinationIndices.count)
            } else {
                pinnedData.insert(data, at: filteredDestinationIndices[destinationRow])
            }

        } else {
            data.isPinned = false
            
            if destinationRow == 0 {
                unpinnedData.insert(data, at: 0)
            } else if destinationRow == filteredDestinationIndices.count {
                unpinnedData.insert(data, at: filteredDestinationIndices.count)
            } else {
                unpinnedData.insert(data, at: filteredDestinationIndices[destinationRow])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        
        let (section, row) = (indexPath.section, indexPath.row)
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        var data: ToDo
        switch category {
        case .business:
            data = section == 0 ? pinnedData.filter { $0.category == .business }[row] : unpinnedData.filter { $0.category == .business}[row]
        case .personal:
            data = section == 0 ? pinnedData.filter { $0.category == .personal }[row] : unpinnedData.filter { $0.category == .personal}[row]
        case .others:
            data = section == 0 ? pinnedData.filter { $0.category == .others }[row] : unpinnedData.filter { $0.category == .others}[row]
        default:
            data = section == 0 ? pinnedData[row] : unpinnedData[row]
        }
        
        dragItem.localObject = data
        return [dragItem]
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        var filteredIndices: [Int]
        switch category {
        case .business:
            filteredIndices = section == 0 ? pinnedData.enumerated().filter {
                $1.category == .business }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .business }.map { return $0.offset }
        case .personal:
            filteredIndices = section == 0 ? pinnedData.enumerated().filter {
                $1.category == .personal }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .personal }.map { return $0.offset }
        case .others:
            filteredIndices = section == 0 ? pinnedData.enumerated().filter {
                $1.category == .others }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .others }.map { return $0.offset }
        default:
            filteredIndices = section == 0 ? pinnedData.enumerated().map { return $0.offset } : unpinnedData.enumerated().map { return $0.offset }
        }
        
        var data = section == 0 ? pinnedData[filteredIndices[row]] : unpinnedData[filteredIndices[row]]
        
        let pin = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            
            data.isPinned ? self.pinnedData.remove(at: filteredIndices[row]) : self.unpinnedData.remove(at: filteredIndices[row])
            data.isPinned.toggle()
            data.isPinned ? self.pinnedData.insert(data, at: 0) : self.unpinnedData.insert(data, at: 0)
        
            completion(true)
        }
        
        data.isPinned ? (pin.image = UIImage(systemName: "pin.slash.fill")) : (pin.image = UIImage(systemName: "pin.fill"))
        pin.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [pin])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        var filteredIndices: [Int]
        switch category {
        case .business:
            filteredIndices = section == 0 ? pinnedData.enumerated().filter {
                $1.category == .business }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .business }.map { return $0.offset }
        case .personal:
            filteredIndices = section == 0 ? pinnedData.enumerated().filter {
                $1.category == .personal }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .personal }.map { return $0.offset }
        case .others:
            filteredIndices = section == 0 ? pinnedData.enumerated().filter {
                $1.category == .others }.map { return $0.offset } : unpinnedData.enumerated().filter {
                    $1.category == .others }.map { return $0.offset }
        default:
            filteredIndices = section == 0 ? pinnedData.enumerated().map { return $0.offset } : unpinnedData.enumerated().map { return $0.offset }
        }
        
        let delete = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
            
            section == 0 ? self.pinnedData.remove(at: filteredIndices[row]) : self.unpinnedData.remove(at: filteredIndices[row])
            completion(true)
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
