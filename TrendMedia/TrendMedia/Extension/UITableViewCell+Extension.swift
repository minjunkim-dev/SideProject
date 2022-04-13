//
//  UITableViewCell+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

extension UITableViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
