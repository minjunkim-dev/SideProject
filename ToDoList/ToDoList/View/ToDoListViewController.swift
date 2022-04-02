//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private let mainView = ToDoListView()
    private let viewModel = ToDoListViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.loadPinnedData()
        viewModel.loadUnpinnedData()
        
        navigationItem.title = "쇼핑"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.dragDelegate = self
        mainView.tableView.dragInteractionEnabled = true
        
        mainView.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        mainView.segmentControl.addTarget(self, action: #selector(segmentIndexChanged), for: .valueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
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
            let message = "할 일을 입력해주셔야 해요😭"
            let okTitle = "확인"
            showAlert(message: message, okTitle: okTitle)
            return
        }
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        let data = ToDo(content: content, category: category)
        viewModel.addData(data: data) {
            self.mainView.toDoTextField.text = ""
            self.dismissKeyboard()
        }
    }
}

extension ToDoListViewController: ToDoDelegate {
    
    func reloadSection(section: Int) {
        let sections = IndexSet(integer: section)
        mainView.tableView.reloadSections(sections, with: .automatic)
        
        viewModel.loadData(section: section)
    }
    
    func updateIsCompleted(isCompleted: Bool, indexPath: IndexPath?) {
        
        guard let indexPath = indexPath else { return }
        
        let (section, row) = (indexPath.section, indexPath.row)
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        
        let indices = viewModel.searchIndices(section: section, category: category)
        let dataIndex = indices[row]
        viewModel.updateIsCompleted(section: section, index: dataIndex, isCompletion: isCompleted)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections // isPinned, or not
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = viewModel.headerViewTextColor[section]
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        return viewModel.numberOfRowsInSection(section: section, category: category)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.reuseIdentifier, for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let (section, row) = (indexPath.section, indexPath.row)
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        let data = viewModel.searchData(section: section, row: row, category: category)
       
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
    
        let filteredSourceIndices = viewModel.searchIndices(section: sourceSection, category: category)
        let filteredDestinationIndices = viewModel.searchIndices(section: destinationSection, category: category)
        
    
        let sourceIndex = filteredSourceIndices[sourceRow]
        let data = viewModel.removeData(section: sourceSection, index: sourceIndex)
        
        if destinationRow == 0 {
            viewModel.insertData(section: destinationSection, data: data, index: 0)
        } else if destinationRow == filteredDestinationIndices.count {
            viewModel.insertData(section: destinationSection, data: data, index: filteredDestinationIndices.count)
        } else {
            viewModel.insertData(section: destinationSection, data: data, index: filteredDestinationIndices[destinationRow])
        }

    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        
        let (section, row) = (indexPath.section, indexPath.row)
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        let data = viewModel.searchData(section: section, row: row, category: category)
        
        dragItem.localObject = data
        return [dragItem]
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        let index = mainView.segmentControl.selectedSegmentIndex
        let category = Category(rawValue: index)
        
        let filteredIndices = viewModel.searchIndices(section: section, category: category)
        
        let dataIndex = filteredIndices[row]
        var data = section == 0 ? viewModel.pinnedData[dataIndex] : viewModel.unpinnedData[dataIndex]
        
        let pin = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            
            data.isPinned ? self.viewModel.removeData(section: 0, index: dataIndex) : self.viewModel.removeData(section: 1, index: dataIndex)
            
            data.isPinned.toggle()
            
            data.isPinned ? self.viewModel.insertData(section: 0, data: data, index: 0) : self.viewModel.insertData(section: 1, data: data, index: 0)
        
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
        
        let filteredIndices = viewModel.searchIndices(section: section, category: category)
        
        let dataIndex = filteredIndices[row]
        let delete = UIContextualAction(style: .destructive, title: nil) { action, view, completion in
            
            self.viewModel.removeData(section: section, index: dataIndex)
            
            completion(true)
        }
        
        delete.image = UIImage(systemName: "trash.fill")
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
