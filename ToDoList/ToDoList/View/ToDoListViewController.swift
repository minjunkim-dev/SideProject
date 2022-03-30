//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private let mainView = ToDoListView()
    
    let isPinnedMock = [
        ToDo(content: "고정!!!", category: .personal, isCompleted: false, isPinned: true),
        ]
    
    let isNotPinnedMock = [
        ToDo(content: "고정 X!!\n\n하이", category: .others, isCompleted: true, isPinned: false),
        ToDo(content: "고정 X!", category: .business, isCompleted: false, isPinned: false),
    ]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "쇼핑"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
}
