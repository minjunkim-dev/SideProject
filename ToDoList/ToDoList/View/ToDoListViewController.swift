//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private let mainView = ToDoListView()
    
    var isPinnedMock = [
        ToDo(content: "고정 1", category: .personal, isCompleted: false, isPinned: true),
        ]
    
    var isNotPinnedMock = [
        ToDo(content: "고정 X 1", category: .others, isCompleted: true, isPinned: false),
        ToDo(content: "고정 X 2", category: .business, isCompleted: false, isPinned: false),
        ToDo(content: "고정 X 3", category: .business, isCompleted: false, isPinned: false),
    ]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "쇼핑"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.dragDelegate = self
        mainView.tableView.dragInteractionEnabled = true

    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // isPinned, or not
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? isPinnedMock.count : isNotPinnedMock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        let toDo = section == 0 ? isPinnedMock[row] :  isNotPinnedMock[row]
        cell.configureCell(toDo: toDo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "고정된 할 일" : "할 일"
    }
    
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let (sourceSection, sourceRow) = (sourceIndexPath.section, sourceIndexPath.row)
        let (destinationSection, destinationRow) = (destinationIndexPath.section, destinationIndexPath.row)
       
        var data = sourceSection == 0 ? isPinnedMock.remove(at: sourceRow) : isNotPinnedMock.remove(at: sourceRow)
        data.isPinned.toggle()
        
        destinationSection == 0 ? isPinnedMock.insert(data, at: destinationRow) :  isNotPinnedMock.insert(data, at: destinationRow)
    
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        let dragItem = UIDragItem(itemProvider: NSItemProvider())

        let (section, row) = (indexPath.section, indexPath.row)
        
        section == 0 ? (dragItem.localObject = isPinnedMock[row]) : (dragItem.localObject = isNotPinnedMock[row])

        return [dragItem]
    }
    

    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        var data = section == 0 ? isPinnedMock[row] : isNotPinnedMock[row]
        
        let pin = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            
            data.isPinned ? self.isPinnedMock.remove(at: row) : self.isNotPinnedMock.remove(at: row)
            data.isPinned.toggle()
            data.isPinned ? self.isPinnedMock.insert(data, at: 0) : self.isNotPinnedMock.insert(data, at: 0)
        
            let range = 0..<tableView.numberOfSections
            tableView.reloadSections(IndexSet(integersIn: range), with: .automatic)
            completion(true)
        }
        
        data.isPinned ? (pin.image = UIImage(systemName: "pin.slash.fill")) : (pin.image = UIImage(systemName: "pin.fill"))
        pin.backgroundColor = .orange
            
        return UISwipeActionsConfiguration(actions: [pin])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let (section, row) = (indexPath.section, indexPath.row)
    
        let delete = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
            
            section == 0 ? self.isPinnedMock.remove(at: row) : self.isNotPinnedMock.remove(at: row)
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
            completion(true)
        }
            
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
