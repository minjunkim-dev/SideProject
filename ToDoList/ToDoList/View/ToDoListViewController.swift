//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private let mainView = ToDoListView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "쇼핑"
    }
}
