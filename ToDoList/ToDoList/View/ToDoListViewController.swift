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
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            
            let toDo = isPinnedMock[row]
            cell.configureCell(content: toDo.content)
            
            return cell
        } else {
            
            let toDo = isNotPinnedMock[row]
            cell.configureCell(content: toDo.content)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "고정된 할 일" : "할 일"
    }
    
    
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let sourceSection = sourceIndexPath.section
        let sourceRow = sourceIndexPath.row
        let destinationSection = destinationIndexPath.section
        let destinationRow = destinationIndexPath.row
       
        var data = sourceSection == 0 ? isPinnedMock.remove(at: sourceRow) : isNotPinnedMock.remove(at: sourceRow)
        data.isPinned.toggle()
        
        destinationSection == 0 ? isPinnedMock.insert(data, at: destinationRow) :  isNotPinnedMock.insert(data, at: destinationRow)
    
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        let dragItem = UIDragItem(itemProvider: NSItemProvider())

        let section = indexPath.section
        let row = indexPath.row
        section == 0 ? (dragItem.localObject = isPinnedMock[row]) : (dragItem.localObject = isNotPinnedMock[row])

        return [dragItem]
    }
    

    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        
        if editingStyle == .delete {
            section == 0 ? isPinnedMock.remove(at: row) : isNotPinnedMock.remove(at: row)
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
}
