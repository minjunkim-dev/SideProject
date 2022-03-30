//
//  UITableViewCellRepresentable.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

@objc protocol UITableViewCellRepresentable {
    
    var numberOfRowsInSection: Int { get }
    
    @objc optional var numberOfSections: Int { get }
}
