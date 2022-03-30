//
//  UITableViewCell+Extension.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

extension UITableViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

